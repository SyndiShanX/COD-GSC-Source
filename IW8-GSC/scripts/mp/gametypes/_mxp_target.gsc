/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\_mxp_target.gsc
************************************************/

function prestreaminglocation(var0) {
  var1 = var0 - self.origin;
  var2 = vectorNormalize((var1[0], var1[1], 0));

  if(lengthsquared(var2) < 0.5) {
    return 1;
  }

  var3 = (0, self.angles[1], 0);
  var4 = anglesToForward(var3);
  return clamp(vectordot(var2, vectorNormalize(var4)), -1, 1);
}

function reaper_missile_reload_end_time(var0, var1) {
  var2 = [];
  var3 = getentarrayinradius("player", "classname", self.origin, var1);

  foreach(var5 in var3) {
    if(isalive(var5)) {
      var6 = randomize_stealth_broken_music_array(var5, var0, var1);
      var2 = [var5, var6];
    }
  }

  var8 = tablesort(self.origin, var1);

  foreach(var10 in var8) {
    if(!isDefined(var10)) {
      continue;
    }

    if(isDefined(var10.healthbuffer) && var10.health < var10.healthbuffer) {
      continue;
    }

    if(var10.health <= 0) {
      continue;
    }

    var6 = randomize_stealth_broken_music_array(var10, var0, var1, 1);
    var2 = [var10, var6];
  }

  return scripts\engine\utility::array_sort_with_func(var2, &ref_12f07);
}

function quarry2_ambient_sound_load(var0) {
  var1 = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
    var2 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();

    if(var2) {
      var3 = scripts\mp\gametypes\br_public::round_enemies_fallback_logic(var0);

      for(var4 = 0; var4 < var3.size; var4++) {
        var5 = var3[var4];
        scripts\engine\utility::array_add(var1, level.squaddata[var0][var5].players);
      }
    }
  }

  if(var1.size == 0) {
    var1 = scripts\mp\utility\teams::getteamdata(var0, "players");
  }

  if(var1.size) {
    var6 = [];

    foreach(var8 in var1) {
      if(isalive(var8) && distance2d(var8.origin, self.origin) < level.ref_11e18.playerredeploy) {
        var6 = var8;
      }
    }

    var1 = var6;
  }

  return var1;
}

function printspawnmessage(var0, var1, var2) {
  var3 = [];
  var4 = getentarrayinradius("player", "classname", self.origin, var1);
  var5 = undefined;
  var6 = undefined;

  if(isDefined(var2)) {
    var5 = var2.team;
    var6 = var2 getsquadindex();
  }

  foreach(var8 in var4) {
    if(isPlayer(var8) && isalive(var8)) {
      if(isDefined(var5) && var5 == var8.team && var8 getsquadindex() == var6) {
        continue;
      }

      var9 = randomize_stealth_broken_music_array(var8, var0, var1);
      var3 = [var8, var9];
    }
  }

  if(var3.size == 0) {
    return undefined;
  }

  var11 = scripts\engine\utility::array_sort_with_func(var3, &ref_12f07);
  return var11[0][0];
}

function pristinestatehealthadd(var0, var1) {
  var2 = [];
  var3 = tablesort(self.origin, var1);

  foreach(var5 in var3) {
    if(!isDefined(var5)) {
      return 0;
    }

    if(isDefined(var5.healthbuffer) && var5.health < var5.healthbuffer) {
      continue;
    }

    if(var5.health <= 0) {
      continue;
    }

    var6 = randomize_stealth_broken_music_array(var5, var0, var1, 1);
    var2 = [var5, var6];
  }

  if(var2.size == 0) {
    return undefined;
  }

  var8 = scripts\engine\utility::array_sort_with_func(var2, &ref_12f07);
  return var8[0][0];
}

function shiftbar(var0) {
  var1 = undefined;

  if(isDefined(level.ref_11e18) && isDefined(level.ref_11e18.ref_12f3f) && isDefined(level.ref_11e18.ref_12f3f.owner) && distance2d(level.ref_11e18.ref_12f3f.owner.origin, self.origin) < level.ref_11e18.playerredeploy) {
    var1 = level.ref_11e18.ref_12f3f.owner;
  }

  return var1;
}

function play_players_arrive_at_extraction(var0) {
  var1 = (0, 0, 0);
  var2 = getentarrayinradius("player", "classname", self.origin, var0);

  foreach(var4 in var2) {
    var1 += var4.origin;
  }

  var6 = tablesort(self.origin, var0);

  foreach(var4 in var6) {
    var1 += var4.origin;
  }

  var9 = var2.size + var6.size;

  if(var9 > 0) {
    var1 /= var9;

    if(distance2d(var1, self.origin) < var0) {
      return var1;
    }

    if(var2.size > 0) {
      return var2[0].origin;
    }

    return var6[0].origin;
  }

  var10 = (0, self.angles[1], 0);
  var11 = anglesToForward(var10);
  return self.origin + var11 * randomintrange(1000, 4000);
}

function ref_12f07(var0, var1) {
  return var0[1] > var1[1];
}

function randomize_stealth_broken_music_array(var0, var1, var2, var3) {
  var4 = distance2d(self.origin, var0.origin);

  if(var4 < var1) {
    var4 = var1 + 10 * squared(var1 - var4);
  }

  if(var4 > var2) {
    return 0;
  }

  if(getdvarint("scr_br_mxp_attack_closest", 0)) {
    return (var2 - var4);
  }

  var5 = prestreaminglocation(var0.origin);

  if(var5 < 0) {
    return 0;
  }

  var6 = acos(var5);
  var7 = (var2 - var4) / var2;
  var8 = var5 * squared(var7);

  if(isDefined(level.ref_11e18.ref_12f14)) {
    var8 = self[[level.ref_11e18.ref_12f14]](var8, var0, var1, var2, var3);
  }

  return var8;
}

function recharge_equipment_init(var0) {
  var1 = [];

  foreach(var3 in level.teamnamelist) {
    if(isDefined(level.ref_13aaa[var3])) {
      var1 = [var3, level.ref_13aaa[var3]];
    }
  }

  if(var1.size == 0) {
    return undefined;
  }

  var5 = scripts\engine\utility::array_sort_with_func(var1, &ref_12f07);

  if(var5.size == 1) {
    return var5[0][0];
  }

  if(var0) {
    var6 = 1;

    while(var6 < var5.size) {
      if(var5[0][1] > var5[var6][1]) {
        break;
      }

      var6 += 1;
    }

    var7 = randomint(var6);
    return var5[var7][0];
  }

  var8 = scripts\engine\utility::ter_op(var7.size > 4, 4, var7.size);
  var7 = randomint(var8);
  var9 = var7;

  while(var9 > 0 && var7[var9 - 1][1] == var7[var9][1]) {
    var9 -= 1;
  }

  var10 = var7;

  while(var10 < var7.size && var7[var7][1] == var7[var10][1]) {
    var10 += 1;
  }

  if(var9 < var10) {
    var7 = randomintrange(var9, var10);
  }

  return var7[var7][0];
}