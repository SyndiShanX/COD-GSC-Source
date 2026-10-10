/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_35ee5e2cef30eea2.gsc
*************************************************/

#using script_32d93a194074fa6a;
#using script_3f8889c16399185c;
#using scripts\mp\flags;
#using scripts\mp\gametypes\br_circle_util;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\utility\player;
#namespace ftue_player;

function function_67d00e6b876c5ee2(position, angles) {
  assert(isDefined(position));
  self setOrigin(position);

  if(isDefined(angles)) {
    self setplayerangles(angles);
  }
}

function function_a074c3f0d66ba8e0() {
  self endon("game_ended");
  self endon("clip_limited");

  while(true) {
    equippedweapon = self getcurrentweapon();

    if(self getweaponammoclip(equippedweapon) <= 10) {
      self setweaponammoclip(equippedweapon, 20);
    }

    wait 0.3;
  }
}

function function_f83c33a014ee22fe() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");

  while(true) {
    equippedweapon = self getcurrentweapon();

    if(self getweaponammostock(equippedweapon) <= 30) {
      self setweaponammostock(equippedweapon, 60);
    }

    wait 1;
  }
}

function function_bbd25202175d7f6f(player, ally) {
  return isDefined(player) && isDefined(ally) && isalliedsentient(player, ally) && (istrue(ally.jailed) || istrue(ally.gulagarena));
}

function function_78d176299d2e0714(player, var_e8f714bab38b613c) {
  ascenders = getentitylessscriptablearray(undefined, undefined, player.origin, var_e8f714bab38b613c, "ascender");
  return ascenders.size > 0;
}

function function_42f2ff6e724030d0(params) {
  assert(isDefined(params));
  assert(isDefined(params.var_71e5a20019ec7f70));
  dist = params.var_71e5a20019ec7f70;
  return function_78d176299d2e0714(self, dist);
}

function function_866b54331a9baec7(player, var_e8f714bab38b613c) {
  return getentitylessscriptablearray(undefined, undefined, player.origin, var_e8f714bab38b613c, "ascender");
}

function function_e09fe43dabd5e4cf(player, ascenders) {
  if(ascenders.size > 0) {
    mindistance = distancesquared(ascenders[0].origin, player.origin);
    nearestzipline = ascenders[0];

    for(i = 0; i < ascenders.size; i++) {
      ziplinedistance = distancesquared(ascenders[i].origin, player.origin);

      if(ziplinedistance < mindistance) {
        mindistance = ziplinedistance;
        nearestzipline = ascenders[i];
      }
    }

    return nearestzipline;
  }

  return undefined;
}

function function_bf0a1f8b03ea5c18(player) {
  return player.usingascender;
}

function function_d97f26cd24750946() {
  usezipline = function_bf0a1f8b03ea5c18(self);

  if(isDefined(usezipline)) {
    return usezipline;
  }

  return 0;
}

function function_331e465c203522e0(positivecallback) {
  self endon("disconnect");
  assert(isDefined(self));

  while(true) {
    self waittill("luinotifyserver", message, value);

    if(isDefined(message) && message == "ftue_minimap_opened") {
      self[[positivecallback]]();
      break;
    }
  }
}

function function_152b922c52a79e9e(player) {
  player.var_6ab0fd4589f5aea5 = 1;
  function_7fd621b8ba80e652();
}

function function_506621f96f8313a5(positivecallback) {
  function_c6c53ea9225f6fc2(positivecallback);
}

function function_c6c53ea9225f6fc2(positivecallback) {
  self endon("disconnect");
  assert(isDefined(self));

  while(true) {
    self waittill("luinotifyserver", message, value);

    if(isDefined(message) && message == "ftue_minimap_closed") {
      self[[positivecallback]]();
      break;
    }
  }
}

function function_f3fdf43101042f63(tipref) {
  if(isDefined(tipref) && tipref == "gasMiniMapCloseTip") {
    self.var_64a66c71d00e6f50 = 1;
  }
}

function function_b804651ee5f4e495(positivecallback) {
  self endon("disconnect");
  assert(isDefined(self));

  while(true) {
    self waittill("luinotifyserver", message, value);

    if(isDefined(message) && message == "scoreboard_open") {
      self[[positivecallback]]();
      break;
    }
  }
}

function function_2c280502c93dcdf4(positivecallback) {
  self endon("disconnect");
  assert(isDefined(self));

  while(true) {
    self waittill("luinotifyserver", message, value);

    if(isDefined(message) && message == "scoreboard_close") {
      self[[positivecallback]]();
      break;
    }
  }
}

function function_6fc17f2a58009875() {
  return isDefined(self.br_infil_type) && self.br_infil_type == "c130" && scripts\mp\flags::gameflag("br_ready_to_jump");
}

function function_d1518ce894dd64e7(params) {
  assert(isDefined(params));
  assert(isDefined(params.var_be502a4377111804));
  return function_6fc17f2a58009875() == params.var_be502a4377111804;
}

function function_18fcd72dfea6cac1() {
  if(!self.var_ca031fd3734a1c62) {
    function_52974897ad9887a8();
  }
}

function function_52974897ad9887a8() {
  self endon("disconnect");
  assert(isDefined(self));

  while(!self.var_ca031fd3734a1c62) {
    waitframe();
  }
}

function function_5c6c946f52be9a50(tipref) {
  self.var_ca031fd3734a1c62 = 1;
}

function function_914e9d5e71cc6efb() {
  self endon("disconnect");
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");

  while(!self function_3c6bb30ae7106b7a()) {
    waitframe();
  }
}

function function_8584a8a9b5fa0463() {
  return scripts\mp\gametypes\br_circle_util::function_a465e3c1371d7dab(self.origin);
}

function function_2f3ee72261187d51() {
  return scripts\mp\gametypes\br_circle_util::ispointindangercircle(self.origin);
}

function function_671c7049215ebc9c() {
  var_6cb069d7b1dfaae0 = function_8584a8a9b5fa0463();

  if(!isDefined(var_6cb069d7b1dfaae0)) {
    return 0;
  }

  return var_6cb069d7b1dfaae0;
}

function function_256eaa0074efa7c2(params) {
  returnvalue = function_2f3ee72261187d51();

  if(isDefined(params) && isDefined(params.expectedvalue)) {
    return (returnvalue == params.expectedvalue);
  }

  return returnvalue;
}

function function_4c16f440b2c0b804(minheight, maxheight) {
  return self.origin[2] < minheight || self.origin[2] > maxheight;
}

function function_2fde996b20d64205(params) {
  assert(isDefined(params));
  assert(isDefined(params.var_71dd2a61430c603f));
  assert(isDefined(params.minheight));
  assert(isDefined(params.maxheight));

  if(function_4c16f440b2c0b804(params.minheight, params.maxheight)) {
    return false;
  }

  var_71dd2a61430c603f = function_8eb62efbab104b05();

  if(isDefined(var_71dd2a61430c603f)) {
    return (var_71dd2a61430c603f < params.var_71dd2a61430c603f);
  }

  return false;
}

function function_725b52f601c21a7a(maxdistance, mindistance) {
  var_71dd2a61430c603f = function_8eb62efbab104b05();

  if(isDefined(var_71dd2a61430c603f)) {
    return (var_71dd2a61430c603f < maxdistance && var_71dd2a61430c603f > mindistance);
  }

  return false;
}

function function_8eb62efbab104b05() {
  dangercircleent = level.br_circle.dangercircleent;

  if(isDefined(dangercircleent)) {
    dangercircleorigin = (dangercircleent.origin[0], dangercircleent.origin[1], 0);
    dangercircleradius = dangercircleent.origin[2];

    if(isDefined(dangercircleorigin) && isDefined(dangercircleradius)) {
      var_e28b0fbabce791f1 = distance2d(self.origin, dangercircleorigin);
      return (dangercircleradius - var_e28b0fbabce791f1);
    }
  }

  return undefined;
}

function function_92a5f74f5acc64d9(callback) {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("last_stand_start");
  self[[callback]]();
}

function function_af7551bf62570371(callback) {
  level endon("game_ended");
  self endon("disconnect");
  downed = undefined;

  while(downed == undefined) {
    foreach(player in level.players) {
      if(isalliedsentient(self, player) && !scripts\mp\utility\player::isreallyalive(player)) {
        downed = player;
        break;
      }
    }

    waitframe();
  }

  [[callback]](downed);
}

function function_ba481c5cd3c4f5b4(var_8cdf4ff04b7775ec, initcallback) {
  thread function_c6cc9d3a7adfda0f(var_8cdf4ff04b7775ec, initcallback);
}

function function_c6cc9d3a7adfda0f(var_8cdf4ff04b7775ec, initcallback) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("currentContextualTipCompleted");
  self endon("currentContextualTipAborted");
  assert(isDefined(self));
  assert(isDefined(var_8cdf4ff04b7775ec));

  if(isDefined(initcallback)) {
    self[[initcallback]]();
  }

  while(!self isskydiving()) {
    waitframe();
  }

  self[[var_8cdf4ff04b7775ec]]();
}

function function_8c217f41a2b69bfe(var_a7bc06075641900e, anglediffgoal, var_8cdf4ff04b7775ec, initcallback) {
  thread function_632855e1721d2685(var_a7bc06075641900e, anglediffgoal, var_8cdf4ff04b7775ec, initcallback);
}

function function_632855e1721d2685(var_a7bc06075641900e, anglediffgoal, var_8cdf4ff04b7775ec, initcallback) {
  self endon("disconnect");
  level endon("game_ended");
  assert(isDefined(self));
  assert(isDefined(var_8cdf4ff04b7775ec));
  var_d49294f78a5bd8b0 = 0;
  init_pos = self.origin;
  init_angles = self getplayerangles();

  while(!self function_3c6bb30ae7106b7a()) {
    waitframe();
  }

  if(isDefined(initcallback)) {
    self[[initcallback]]();
  }

  while(self isparachuting()) {
    diff_pos = distance((self.origin[0], self.origin[1], 0), (init_pos[0], init_pos[1], 0));
    diff_angles = distance(self getplayerangles(), init_angles);

    if(diff_angles >= anglediffgoal && diff_pos * 10 > var_a7bc06075641900e) {
      var_d49294f78a5bd8b0 = 1;
      break;
    }

    waitframe();
  }

  self[[var_8cdf4ff04b7775ec]](var_d49294f78a5bd8b0);
}

function function_6c19fa9b1a676fe5() {
  function_2ab50ae603bc51cc();
}

function function_2ab50ae603bc51cc() {
  self endon("disconnect");
  level endon("game_ended");
  assert(isDefined(self));

  while(self function_3c6bb30ae7106b7a()) {
    waitframe();
  }
}

function function_ff62c3aabf4c0ba8(var_7ea2637582571067, initcallback) {
  self endon("entitydeleted");
  level endon("game_ended");
  self endon("disconnect");

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon);

    if(attacker != self && isDefined(var_7ea2637582571067)) {
      self[[var_7ea2637582571067]]();
      return;
    }
  }
}

function function_217fab64becd170a() {
  xp = self getplayerdata("common", "mpProgression", "playerLevel", "xp");
  return getrankforxp(xp);
}

function function_1e7a02ef17d58a96() {
  if(self function_e69d7896fa6e5d23()) {
    return true;
  }

  return false;
}

function function_c3ff6825172b7e02(positivecallback) {
  thread function_dc30e2f1a162d751(positivecallback);
}

function function_dc30e2f1a162d751(positivecallback) {
  self endon("disconnect");
  assert(isDefined(self));

  while(true) {
    self waittill("luinotifyserver", message, value);

    if(isDefined(message) && message == "ftue_redeploy_button_clicked") {
      self[[positivecallback]]();
      break;
    }
  }
}

function function_f0027ce50e5ef437(callback) {
  function_f47edda71b7a6492(callback);
}

function function_f47edda71b7a6492(callback) {
  self endon("death");
  self endon("disconnect");

  while(true) {
    self waittill("luinotifyserver", channel, class);

    if(channel == "ftue_show_revive_ally_button") {
      self[[callback]]();
      return;
    }
  }
}

function function_79ff3ea7e538a94a(teammate, callback) {
  function_952f091badfcdd5d(teammate, callback);
}

function function_952f091badfcdd5d(teammate, callback) {
  self endon("death");
  self endon("disconnect");

  while(!isDefined(teammate.inlaststand)) {
    waitframe();
  }

  originalstate = teammate.inlaststand;

  while(true) {
    if(!isreallyalive(teammate)) {
      self[[callback]](0);
      return;
    }

    currentvalue = teammate.inlaststand;

    if(originalstate != currentvalue) {
      self[[callback]](1);
      return;
    }

    waitframe();
  }
}

function function_9b8f4317c9bee442(positivecallback) {
  thread function_cbf5df364d883f3d(positivecallback);
}

function function_cbf5df364d883f3d(positivecallback) {
  assert(isDefined(self));
  self endon("disconnect");

  while(true) {
    self waittill("calloutmarkerping_notifyhandled", message, value, optionalvalue);

    if(isDefined(message) && message == "calloutmarkerping_added") {
      self[[positivecallback]]();
      break;
    }
  }
}

function function_ebaaac95a9dd6() {
  return self.health > 0;
}

function function_c104680edea6cf97() {
  return !function_ebaaac95a9dd6();
}

function function_a44b57cf475cf6c1(value) {
  if(istrue(value)) {
    level.modifyplayerdamage = &function_210da883891acd05;
    return;
  }

  level.modifyplayerdamage = undefined;
}

function function_fafeefcc0da64ee2() {
  return self isonground();
}

function function_f07edbf622eeb7d9() {
  return scripts\mp\gametypes\br_public::hasselfrevivetoken();
}

function function_210da883891acd05(einflictor, victim, eattacker, idamage, smeansofdeath, objweapon, vpoint, vdir, shitloc, idflags, var_be4285b26ed99ab1) {
  if(!isbot(victim) || victim.team == level.player.team) {
    idamage *= victim.health / 200;

    if(victim.health - idamage <= 0) {
      idamage = 0;
    }
  } else if(isbot(einflictor) && einflictor.team == level.player.team && smeansofdeath != "MOD_EXECUTION" && smeansofdeath != "MOD_MELEE_TAKEDOWN") {
    idamage = 0;
  }

  return idamage;
}

function function_bb62ba82affdd5c7() {
  self endon("disconnect");

  while(!self ismantling()) {
    waitframe();
  }
}