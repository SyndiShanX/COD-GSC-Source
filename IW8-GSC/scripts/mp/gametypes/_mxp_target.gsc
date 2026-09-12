/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\_mxp_target.gsc
************************************************/

function prestreaminglocation(var_0) {
  var_1 = var_0 - self.origin;
  var_2 = vectorNormalize((var_1[0], var_1[1], 0));

  if(lengthsquared(var_2) < 0.5) {
    return 1;
  }

  var_3 = (0, self.angles[1], 0);
  var_4 = anglesToForward(var_3);
  return clamp(vectordot(var_2, vectorNormalize(var_4)), -1, 1);
}

function reaper_missile_reload_end_time(var_0, var_1) {
  var_2 = [];
  var_3 = getentarrayinradius("player", "classname", self.origin, var_1);

  foreach(var_5 in var_3) {
    if(isalive(var_5)) {
      var_6 = randomize_stealth_broken_music_array(var_5, var_0, var_1);
      var_2 = [var_5, var_6];
    }
  }

  var_8 = tablesort(self.origin, var_1);

  foreach(var_10 in var_8) {
    if(!isDefined(var_10)) {
      continue;
    }

    if(isDefined(var_10.healthbuffer) && var_10.health < var_10.healthbuffer) {
      continue;
    }

    if(var_10.health <= 0) {
      continue;
    }

    var_6 = randomize_stealth_broken_music_array(var_10, var_0, var_1, 1);
    var_2 = [var_10, var_6];
  }

  return scripts\engine\utility::array_sort_with_func(var_2, &ref_12F07);
}

function quarry2_ambient_sound_load(var_0) {
  var_1 = [];

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "squadAsTeamEnabled")) {
    var_2 = level[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "squadAsTeamEnabled")]]();

    if(var_2) {
      var_3 = scripts\mp\gametypes\br_public::round_enemies_fallback_logic(var_0);

      for(var_4 = 0; var_4 < var_3.size; var_4++) {
        var_5 = var_3[var_4];
        scripts\engine\utility::array_add(var_1, level.squaddata[var_0][var_5].players);
      }
    }
  }

  if(var_1.size == 0) {
    var_1 = scripts\mp\utility\teams::getteamdata(var_0, "players");
  }

  if(var_1.size) {
    var_6 = [];

    foreach(var_8 in var_1) {
      if(isalive(var_8) && distance2d(var_8.origin, self.origin) < level.ref_11E18.playerredeploy) {
        var_6 = var_8;
      }
    }

    var_1 = var_6;
  }

  return var_1;
}

function printspawnmessage(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = getentarrayinradius("player", "classname", self.origin, var_1);
  var_5 = undefined;
  var_6 = undefined;

  if(isDefined(var_2)) {
    var_5 = var_2.team;
    var_6 = var_2 getsquadindex();
  }

  foreach(var_8 in var_4) {
    if(isPlayer(var_8) && isalive(var_8)) {
      if(isDefined(var_5) && var_5 == var_8.team && var_8 getsquadindex() == var_6) {
        continue;
      }

      var_9 = randomize_stealth_broken_music_array(var_8, var_0, var_1);
      var_3 = [var_8, var_9];
    }
  }

  if(var_3.size == 0) {
    return undefined;
  }

  var_11 = scripts\engine\utility::array_sort_with_func(var_3, &ref_12F07);
  return var_11[0][0];
}

function pristinestatehealthadd(var_0, var_1) {
  var_2 = [];
  var_3 = tablesort(self.origin, var_1);

  foreach(var_5 in var_3) {
    if(!isDefined(var_5)) {
      return 0;
    }

    if(isDefined(var_5.healthbuffer) && var_5.health < var_5.healthbuffer) {
      continue;
    }

    if(var_5.health <= 0) {
      continue;
    }

    var_6 = randomize_stealth_broken_music_array(var_5, var_0, var_1, 1);
    var_2 = [var_5, var_6];
  }

  if(var_2.size == 0) {
    return undefined;
  }

  var_8 = scripts\engine\utility::array_sort_with_func(var_2, &ref_12F07);
  return var_8[0][0];
}

function shiftbar(var_0) {
  var_1 = undefined;

  if(isDefined(level.ref_11E18) && isDefined(level.ref_11E18.ref_12F3F) && isDefined(level.ref_11E18.ref_12F3F.owner) && distance2d(level.ref_11E18.ref_12F3F.owner.origin, self.origin) < level.ref_11E18.playerredeploy) {
    var_1 = level.ref_11E18.ref_12F3F.owner;
  }

  return var_1;
}

function play_players_arrive_at_extraction(var_0) {
  var_1 = (0, 0, 0);
  var_2 = getentarrayinradius("player", "classname", self.origin, var_0);

  foreach(var_4 in var_2) {
    var_1 += var_4.origin;
  }

  var_6 = tablesort(self.origin, var_0);

  foreach(var_4 in var_6) {
    var_1 += var_4.origin;
  }

  var_9 = var_2.size + var_6.size;

  if(var_9 > 0) {
    var_1 /= var_9;

    if(distance2d(var_1, self.origin) < var_0) {
      return var_1;
    }

    if(var_2.size > 0) {
      return var_2[0].origin;
    }

    return var_6[0].origin;
  }

  var_10 = (0, self.angles[1], 0);
  var_11 = anglesToForward(var_10);
  return self.origin + var_11 * randomintrange(1000, 4000);
}

function ref_12F07(var_0, var_1) {
  return var_0[1] > var_1[1];
}

function randomize_stealth_broken_music_array(var_0, var_1, var_2, var_3) {
  var_4 = distance2d(self.origin, var_0.origin);

  if(var_4 < var_1) {
    var_4 = var_1 + 10 * squared(var_1 - var_4);
  }

  if(var_4 > var_2) {
    return 0;
  }

  if(getdvarint("scr_br_mxp_attack_closest", 0)) {
    return (var_2 - var_4);
  }

  var_5 = prestreaminglocation(var_0.origin);

  if(var_5 < 0) {
    return 0;
  }

  var_6 = acos(var_5);
  var_7 = (var_2 - var_4) / var_2;
  var_8 = var_5 * squared(var_7);

  if(isDefined(level.ref_11E18.ref_12F14)) {
    var_8 = self[[level.ref_11E18.ref_12F14]](var_8, var_0, var_1, var_2, var_3);
  }

  return var_8;
}

function recharge_equipment_init(var_0) {
  var_1 = [];

  foreach(var_3 in level.teamnamelist) {
    if(isDefined(level.ref_13AAA[var_3])) {
      var_1 = [var_3, level.ref_13AAA[var_3]];
    }
  }

  if(var_1.size == 0) {
    return undefined;
  }

  var_5 = scripts\engine\utility::array_sort_with_func(var_1, &ref_12F07);

  if(var_5.size == 1) {
    return var_5[0][0];
  }

  if(var_0) {
    var_6 = 1;

    while(var_6 < var_5.size) {
      if(var_5[0][1] > var_5[var_6][1]) {
        break;
      }

      var_6 += 1;
    }

    var_7 = randomint(var_6);
    return var_5[var_7][0];
  }

  var_8 = scripts\engine\utility::ter_op(var_7.size > 4, 4, var_7.size);
  var_7 = randomint(var_8);
  var_9 = var_7;

  while(var_9 > 0 && var_7[var_9 - 1][1] == var_7[var_9][1]) {
    var_9 -= 1;
  }

  var_10 = var_7;

  while(var_10 < var_7.size && var_7[var_7][1] == var_7[var_10][1]) {
    var_10 += 1;
  }

  if(var_9 < var_10) {
    var_7 = randomintrange(var_9, var_10);
  }

  return var_7[var_7][0];
}