/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_77d26f8871d4a2e1.gsc
*****************************************************/

#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\math;
#using scripts\engine\utility;
#using scripts\stealth\manager;
#namespace namespace_fce05a08f6b93b9f;

function private autoexec __init__system__() {
  system::register(#"hash_ad922ea0e7a6c6ca", undefined, undefined, &post_main);
}

function private post_main() {
  if(!(isDefined(level.gamemodebundle) && isDefined(level.gamemodebundle.stealthbundle))) {
    return;
  }

  stealthbundle = getscriptbundle("\xd0\xfeq\xff+\b\xac\xcb{\xfaD[\xd5K" + level.gamemodebundle.stealthbundle);

  if(!(isDefined(stealthbundle.threatsightwidget) && isDefined(stealthbundle) && isDefined(stealthbundle.threatsightanchor))) {
    return;
  }

  setsaveddvar(@ "hash_7af445124b2a7094", 0);
  setsaveddvar(@ "hash_5a24307862453e37", 1);

  setdvarifuninitialized(@ "hash_82f9621733535c5c", 0);
  setdvarifuninitialized(@ "hash_8ff4f865ba57762a", 0);
  setdvarifuninitialized(@ "hash_4f768e3873fe79da", "<dev string:x24>");
  setdvarifuninitialized(@ "hash_6651037eca599785", 0);

  level.var_e2ad5a0824322265 = &generic_entity_threat_sight;
  ui::lui_registercallback("D\xf26\x83s\x96\xc69\xdf\x16\x04\xec\xe8\xcd\xd5\xc2\xb0l\x11\\\xb92\xb0\xf1t\xeav\xe1\xa5", &function_25495f98f582ddb9);
  thread function_c497d8dd5a1d6523();

  thread function_7e914cb1041c95a();
}

function private function_25495f98f582ddb9(entnum) {
  player = level.player;

  if(isDefined(player.var_9846878b6e719559.active[entnum])) {
    player function_63fdffaf1735110a(player.var_9846878b6e719559.active[entnum]);
  }
}

function private function_c497d8dd5a1d6523() {
  utility::flag_wait("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");

  foreach(player in level.players) {
    player.var_9846878b6e719559 = spawnStruct();
    player.var_9846878b6e719559.active = [];
    player.var_9846878b6e719559.activesorted = undefined;
    player.var_9846878b6e719559.sorttime = undefined;
    player.var_9846878b6e719559.furthestsq = undefined;
    player.var_9846878b6e719559.var_c2b2e56ba0949da8 = [];
  }

  if(isDefined(level.stealth)) {
    var_24a4538229ba96fd = level.stealth.fninitenemygame;
    level.stealth.fninitenemygame = &function_c50a6b22863ac0d9;

    if(var_24a4538229ba96fd != level.stealth.fninitenemygame) {
      enemies = getaiarray("?\xb1\xc0\x9a", "\x8c\x1b\xab)\xd1");

      foreach(enemy in enemies) {
        enemy thread[[level.stealth.fninitenemygame]]();
      }
    }
  }
}

function generic_entity_threat_sight(sightedfunc, visionfov, visionrange, sightrate) {
  thread generic_entity_threat_sight_thread(sightedfunc, visionfov, visionrange, sightrate);
}

function private generic_entity_threat_sight_thread(sightedfunc, visionfov, visionrange, sightrate) {
  entity = self;
  entity notify("\xec\x95nY\xc9\xb46\xeb\xb2\xcdt-\xd1\xe5\xf5t\x1aNe\x85:\xd7\x9b\xd2\xce\x1a\x8e\xf5\xa34\x93\xacX\xc8");
  entity endon("\xec\x95nY\xc9\xb46\xeb\xb2\xcdt-\xd1\xe5\xf5t\x1aNe\x85:\xd7\x9b\xd2\xce\x1a\x8e\xf5\xa34\x93\xacX\xc8");
  level thread generic_entity_sight_service();

  if(!isDefined(entity.var_9846878b6e719559)) {
    entity.var_9846878b6e719559 = spawnStruct();
    entity.var_9846878b6e719559.sight = 0;
    entity.var_9846878b6e719559.visible = 0;
    entity.var_9846878b6e719559.fovcosine = cos(visionfov);
    entity.var_9846878b6e719559.rangesq = visionrange * visionrange;
    entity.var_9846878b6e719559.rate = sightrate;
  }

  calledfunc = 0;

  while(isent(entity)) {
    entity generic_entity_sight_service_queue();

    if(istrue(entity.var_9846878b6e719559.visible)) {
      entity.var_9846878b6e719559.sight += entity.var_9846878b6e719559.rate * level.framedurationseconds;

      if(!calledfunc && entity.var_9846878b6e719559.sight >= 1) {
        if(isDefined(sightedfunc)) {
          entity thread[[sightedfunc]](entity.var_9846878b6e719559.sightee);
        }

        calledfunc = 1;
      }
    } else {
      entity.var_9846878b6e719559.sight -= entity.var_9846878b6e719559.rate * level.framedurationseconds * 2;
      calledfunc = 0;
    }

    entity.var_9846878b6e719559.sight = clamp(entity.var_9846878b6e719559.sight, 0, 1);
    entity function_42077bb16c52ffd5(entity.var_9846878b6e719559);
    waitframe();
  }
}

function private generic_entity_sight_service() {
  level notify("\x8e\xe0rJ\xea-i=\xc1|[|HM\xd0\xff\xf7\xe9D\n\xbf\x18\x9c\xbd)\x99gk");
  level endon("\x8e\xe0rJ\xea-i=\xc1|[|HM\xd0\xff\xf7\xe9D\n\xbf\x18\x9c\xbd)\x99gk");

  if(!isDefined(level.var_3f25a2bcd01102f2)) {
    level.var_3f25a2bcd01102f2 = spawnStruct();
  }

  while(true) {
    traced = 0;

    while(isDefined(level.var_3f25a2bcd01102f2.head)) {
      entity = level.var_3f25a2bcd01102f2 utility::function_1aa221df87e39667();

      if(!isDefined(entity)) {
        continue;
      }

      entity.var_9846878b6e719559.visible = 0;
      entity.var_9846878b6e719559.sightee = undefined;
      entity.var_9846878b6e719559.state = "\xff\xdb\xba\xa7\xd5\x8d\xe1";

      foreach(player in level.players) {
        playereye = player getEye();
        delta = playereye - entity.origin;

        if(lengthsquared(delta) < entity.var_9846878b6e719559.rangesq) {
          dot = vectordot(vectorNormalize(delta), anglesToForward(entity.angles));

          if(dot > entity.var_9846878b6e719559.fovcosine) {
            traced = 1;

            if(sighttracepassed(entity.origin, playereye, 0, entity, player)) {
              entity.var_9846878b6e719559.visible = 1;

              if(!isDefined(entity.var_9846878b6e719559.sightee) || distancesquared(entity.var_9846878b6e719559.sightee.origin, entity.origin) > distancesquared(player.origin, entity.origin)) {
                entity.var_9846878b6e719559.sightee = player;
              }
            }
          }
        }
      }

      entity.var_9846878b6e719559.pending = undefined;

      if(traced) {
        break;
      }
    }

    waitframe();

    if(!isDefined(level.var_3f25a2bcd01102f2.head)) {
      level waittill("\x0fH\x18\f\x12\f\xf4\xa6\xa6\xca\xb5l\x03S\xdf\xd1\x88\xfaZ\xd2\xae;\x1c\a\x05\xfc\xd8\x18W9COmg");
    }
  }
}

function private generic_entity_sight_service_queue() {
  entity = self;

  if(istrue(entity.var_9846878b6e719559.pending)) {
    return;
  }

  level.var_3f25a2bcd01102f2 utility::function_f19f86e70b141efb(entity);
  entity.var_9846878b6e719559.pending = 1;
  level notify("\x0fH\x18\f\x12\f\xf4\xa6\xa6\xca\xb5l\x03S\xdf\xd1\x88\xfaZ\xd2\xae;\x1c\a\x05\xfc\xd8\x18W9COmg");
}

function private function_c50a6b22863ac0d9() {
  if(!isai(self)) {
    return;
  }

  ai = self;
  ai.var_58249ff494ad0171 = 0;
  ai thread ai_threat_sight_sw_thread();
  ai thread function_55577b8e51d7bdf1();
}

function private function_55577b8e51d7bdf1() {
  while(!isDefined(self.stealth.funcs)) {
    waitframe();
  }

  self.stealth.funcs["\x1f\x93?pK+\x9c"] = &function_eb6bd74a3073249b;
}

function private ai_threat_sight_sw_thread() {
  assert(isai(self));
  ai = self;
  ai notify("X\xfa\x82\xa54f\x83d\xffC\xa7)T5\x12 u\xa5\x13\x04\x1f\xd0\xe6[\x91");
  ai endon("X\xfa\x82\xa54f\x83d\xffC\xa7)T5\x12 u\xa5\x13\x04\x1f\xd0\xe6[\x91");
  ai endon("\x1e\xfd\xd1\xa2\a");
  ai childthread function_95a4105cc023dd91();
  ai childthread function_fa0033564cfcff9b();

  ai childthread function_a020909614c1ff8f();

  while(isalive(ai)) {
    ai waittill("?\x1eU\xfe^\x951\xe3\xfe\xce\xf9\xfeost\xa9", sight, visible, combat, sightee);

    if(!isDefined(ai.var_9846878b6e719559)) {
      ai.var_9846878b6e719559 = spawnStruct();
    }

    if(!isDefined(ai.var_9846878b6e719559.sight)) {
      ai.var_9846878b6e719559.sight = 0;
    }

    if(sight > 0 && (!isDefined(ai.var_9846878b6e719559.sight) || ai.var_9846878b6e719559.sight == 0)) {
      sightee notify("u\x1a\xae2C$\xd6", ai);
    }

    if(visible && sight >= 0.5 && ai.var_9846878b6e719559.sight < 0.5) {
      ai notify("N\t\x91>0\x05\xaa\xc5\xc4e-\xa0x\xe9\x91");
    }

    valueschanged = !(visible === ai.var_9846878b6e719559.visible && sight === ai.var_9846878b6e719559.sight && sightee === ai.var_9846878b6e719559.sightee);

    if(valueschanged) {
      ai.var_9846878b6e719559.sight = sight;
      ai.var_9846878b6e719559.visible = visible;
      ai.var_9846878b6e719559.sightee = sightee;

      if(!isDefined(ai.var_9846878b6e719559.state)) {
        ai.var_9846878b6e719559.state = "\xff\xdb\xba\xa7\xd5\x8d\xe1";
      }

      ai function_42077bb16c52ffd5(ai.var_9846878b6e719559);
    }
  }
}

function private function_fa0033564cfcff9b() {
  if(!isDefined(level.takedowns)) {
    return;
  }

  ai = self;
  ai waittill("3\xdcu\xe6|\xecw\xf3 \x88m\x81\x95\xeb");
  ai function_42077bb16c52ffd5(ai.var_9846878b6e719559);
}

function private function_95a4105cc023dd91() {
  assert(isai(self));
  ai = self;

  while(isalive(ai)) {
    ai waittill("\x935Z\xacd\xdb\x12\x90\xa1\x0f\x82\xf7\xcb\xba\xc1AZb\xf7\xb4", currentstate, previousstate);
    utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");

    if(!isDefined(ai.var_9846878b6e719559)) {
      ai.var_9846878b6e719559 = spawnStruct();
    }

    ai.var_9846878b6e719559.state = function_4c557fd131181fef(currentstate);

    if(ai.var_9846878b6e719559.state == "\xe3\xd0\xc3e\x85h") {
      function_eb6bd74a3073249b();
      continue;
    }

    ai function_42077bb16c52ffd5(ai.var_9846878b6e719559);
  }
}

function private function_eb6bd74a3073249b() {
  foreach(player in level.players) {
    player.var_9846878b6e719559.var_c2b2e56ba0949da8[self getentitynumber()] = self;
    player thread function_5f0606f054533191();
  }
}

function private function_5f0606f054533191() {
  self notify("\xad\x85\xa130\xabK\x04\x0ec\xaf{\xa9\xbf\x99\x06");
  self endon("\xad\x85\xa130\xabK\x04\x0ec\xaf{\xa9\xbf\x99\x06");
  player = self;
  wasincombat = player stealth_manager::anyone_in_combat();

  if(wasincombat) {
    wasincombat = 0;
    ais = getaiunittypearray("\x9a\x1f\x83\x1bs=\x13\xf8", "\xc0\xc6J");

    foreach(guy in ais) {
      if(guy.bisincombat && !isDefined(player.var_9846878b6e719559.var_c2b2e56ba0949da8[guy getentitynumber()])) {
        wasincombat = 1;
        break;
      }
    }
  }

  waitframe();

  if(!wasincombat) {
    bestai = undefined;
    sorted = sortbydistance(player.var_9846878b6e719559.var_c2b2e56ba0949da8, player.origin);

    foreach(ai in sorted) {
      if(isalive(ai)) {
        if(!isDefined(bestai)) {
          bestai = ai;
        }

        if(player math::point_in_fov(ai.origin)) {
          bestai = ai;
          break;
        }
      }
    }

    if(isDefined(bestai)) {
      if(!isDefined(bestai.var_9846878b6e719559)) {
        bestai.var_9846878b6e719559 = spawnStruct();
      }

      utility::callsharedfunc(#"analytics", #"playerspotted", player, bestai);
      self notify("\x1f\x93?pK+\x9c", bestai);
      bestai.var_9846878b6e719559.var_2b9f6adad9a286c0 = gettime() + 1000;
      bestai.var_9846878b6e719559.state = "\xe3\xd0\xc3e\x85h";
      bestai function_42077bb16c52ffd5(bestai.var_9846878b6e719559);
    }
  }

  player.var_9846878b6e719559.var_c2b2e56ba0949da8 = [];
}

function private function_42077bb16c52ffd5(var_9846878b6e719559) {
  if(!(isDefined(level.stealth.threatsightwidget) && isDefined(level.stealth.threatsightanchor))) {
    return;
  }

  assert(!isPlayer(self));
  entity = self;
  refname = "'\xf3\x92\x93x\xc7\x80\xdc\x93(\xbb\xfaa3XH\xa7\xe3\xb9\xd3;\xe6.j";

  foreach(player in level.players) {
    if(isDefined(var_9846878b6e719559.sightee) && player != var_9846878b6e719559.sightee) {
      continue;
    }

    if(!isDefined(var_9846878b6e719559.sight)) {
      var_9846878b6e719559.sight = 0;
    }

    if(!isDefined(var_9846878b6e719559.visible)) {
      var_9846878b6e719559.visible = 0;
    }

    if(!isDefined(var_9846878b6e719559.state)) {
      var_9846878b6e719559.state = "\xff\xdb\xba\xa7\xd5\x8d\xe1";
    }

    entity thread function_6d3f1891c1c523f5(var_9846878b6e719559);

    var_62fafc6c1eb9bdbc = player val::get("\x7f\xf0M( G\xc3\xd1Y\xaa\xb3c\xb1d^\xe9\xc3c\xb6xp{");
    takedown = isDefined(player.takedown) && player.takedown.attempt_victim === entity;
    enabled = 0;

    if(var_62fafc6c1eb9bdbc && (!isai(self) || isalive(self)) && !takedown) {
      if(isDefined(var_9846878b6e719559.var_2b9f6adad9a286c0) && var_9846878b6e719559.var_2b9f6adad9a286c0 > gettime()) {
        enabled = 1;
      } else {
        incombat = player stealth_manager::anyone_in_combat();

        if(!incombat && var_9846878b6e719559.sight > 0) {
          enabled = 1;
        } else if(!incombat && var_9846878b6e719559.state == "\xc2\x99.K\xdd\x9fBw>]\x8e") {
          enabled = 1;
        } else {
          enabled = !incombat && var_9846878b6e719559.sight > 0 || isDefined(var_9846878b6e719559.combatremovetime);
        }
      }
    }

    isactive = player hud_management::function_4ffc48758feae6cf(entity, refname);

    if(istrue(enabled)) {
      player function_a5994fd605cb7823(entity);
      continue;
    }

    player function_63fdffaf1735110a(entity);
  }
}

function private function_a5994fd605cb7823(ai) {
  assert(isPlayer(self));
  player = self;
  aientnum = ai getentitynumber();
  refname = "'\xf3\x92\x93x\xc7\x80\xdc\x93(\xbb\xfaa3XH\xa7\xe3\xb9\xd3;\xe6.j";
  isactive = player hud_management::function_4ffc48758feae6cf(ai, refname);

  if(!isactive) {
    if(player.var_9846878b6e719559.active.size >= 10) {
      player function_fcb49992b2e8fbb8(ai);
    } else {
      player hud_management::function_f084d4c0fc5a8b4b(ai, refname, level.stealth.threatsightwidget, level.stealth.threatsightanchor);
    }
  }

  var_58249ff494ad0171 = isDefined(ai.shadowarmor) && ai.shadowarmor > 0;

  if(istrue(ai.var_58249ff494ad0171) != var_58249ff494ad0171) {
    ai.var_58249ff494ad0171 = var_58249ff494ad0171;

    if(var_58249ff494ad0171) {
      player hud_management::function_583d46528b2c47a(ai, refname, "z\x03v\xb4:\x10^TO\xca\xc6\xbd\xab\x91\xe7P");
      waitframe();
    }
  }

  if(ai.var_9846878b6e719559.state == "\xe3\xd0\xc3e\x85h") {
    player hud_management::function_8a9fa4d97c8852f3(ai, refname, ai.var_9846878b6e719559.sight, 1);
    player hud_management::function_583d46528b2c47a(ai, refname, ai.var_9846878b6e719559.state);
  } else {
    player hud_management::function_8a9fa4d97c8852f3(ai, refname, ai.var_9846878b6e719559.sight, ai.var_9846878b6e719559.visible);

    if(isDefined(ai.var_9846878b6e719559.sight) && ai.var_9846878b6e719559.sight > 0) {
      if(ai.var_9846878b6e719559.sight == 1) {
        player hud_management::function_583d46528b2c47a(ai, refname, "\x8e\xb5\xa4Jtt\xa7");
      } else if(ai.var_9846878b6e719559.state == "\xc2\x99.K\xdd\x9fBw>]\x8e") {
        displaystate = "\xa8o}\x15V\x1a\x90";
        player hud_management::function_583d46528b2c47a(ai, refname, displaystate);
      } else {
        player hud_management::function_583d46528b2c47a(ai, refname, "\xff\xdb\xba\xa7\xd5\x8d\xe1");
      }
    } else if(ai.var_9846878b6e719559.state == "\xc2\x99.K\xdd\x9fBw>]\x8e") {
      displaystate = "\xa8o}\x15V\x1a\x90";
      player hud_management::function_583d46528b2c47a(ai, refname, displaystate);
    }
  }

  ai.var_9846878b6e719559.laststate = ai.var_9846878b6e719559.state;
  player.var_9846878b6e719559.active[aientnum] = ai;
}

function private function_63fdffaf1735110a(ai) {
  assert(isPlayer(self));
  player = self;
  aientnum = ai getentitynumber();
  refname = "'\xf3\x92\x93x\xc7\x80\xdc\x93(\xbb\xfaa3XH\xa7\xe3\xb9\xd3;\xe6.j";
  isactive = player hud_management::function_4ffc48758feae6cf(ai, refname);

  if(isactive) {
    player hud_management::function_5e19eeec60f33c1e(ai, refname);
  }

  player.var_9846878b6e719559.active[aientnum] = undefined;

  ai notify("<dev string:x28>");
}

function private function_fcb49992b2e8fbb8(ai) {
  assert(isPlayer(self));
  player = self;

  if(!isDefined(player.var_9846878b6e719559.activesorted) || player.var_9846878b6e719559.sorttime < gettime()) {
    player function_9aae41bb205819ae();
  }

  aidistsq = distancesquared(player.origin, ai.origin);

  if(!isDefined(player.var_9846878b6e719559.furthestsq) || aidistsq < player.var_9846878b6e719559.furthestsq) {
    for(furthestdefined = player.var_9846878b6e719559.activesorted.size - 1; furthestdefined >= 0 && !isDefined(player.var_9846878b6e719559.activesorted[furthestdefined]); furthestdefined--) {}

    if(furthestdefined >= 0) {
      furthestai = player.var_9846878b6e719559.activesorted[furthestdefined];
      player function_63fdffaf1735110a(furthestai);
    }

    player function_9aae41bb205819ae();
  }
}

function private function_9aae41bb205819ae() {
  assert(isPlayer(self));
  player = self;
  player.var_9846878b6e719559.sorttime = gettime();
  player.var_9846878b6e719559.active = utility::function_9b645290bcb05f87(player.var_9846878b6e719559.active, 1);
  player.var_9846878b6e719559.activesorted = sortbydistance(player.var_9846878b6e719559.active, player.origin);

  if(player.var_9846878b6e719559.activesorted.size > 0) {
    furthestai = player.var_9846878b6e719559.activesorted[player.var_9846878b6e719559.activesorted.size - 1];
    player.var_9846878b6e719559.furthestsq = distancesquared(player.origin, furthestai.origin);
    return;
  }

  player.var_9846878b6e719559.furthestsq = undefined;
}

function private function_4c557fd131181fef(state) {
  if(state == 3) {
    return "\xe3\xd0\xc3e\x85h";
  } else if(state == 2) {
    return "\xa8o}\x15V\x1a\x90";
  } else if(state == 1) {
    return "\xc2\x99.K\xdd\x9fBw>]\x8e";
  }

  return "\xff\xdb\xba\xa7\xd5\x8d\xe1";
}

function function_7057bb5ce1aa6c5a() {
  ai = self;

  if(!isDefined(ai.var_9846878b6e719559)) {
    ai.var_9846878b6e719559 = spawnStruct();
  }

  ai.var_9846878b6e719559.sight = 0;
  ai.var_9846878b6e719559.visible = 1;
  ai.var_9846878b6e719559.state = "\xe3\xd0\xc3e\x85h";

  foreach(player in level.players) {
    player function_a5994fd605cb7823(ai);
  }
}

function private function_6d3f1891c1c523f5(var_9846878b6e719559) {
  assert(!isPlayer(self));
  entity = self;
  entity notify("<dev string:x28>");
  entity endon("<dev string:x28>");
  entity endon("<dev string:x48>");

  while(getdvarint(@ "hash_82f9621733535c5c", 0)) {
    if(getdvarint(@ "hash_82f9621733535c5c", 0) > 1) {
      var_9846878b6e719559.sight = getdvarfloat(@ "hash_8ff4f865ba57762a", 0) / 100;
      var_9846878b6e719559.state = getDvar(@ "hash_4f768e3873fe79da", "<dev string:x24>");
      var_9846878b6e719559.visible = getdvarint(@ "hash_6651037eca599785", 0);

      if(var_9846878b6e719559.state == "<dev string:x24>") {
        var_9846878b6e719559.state = "<dev string:x51>";
      }
    }

    print3d(entity.origin + (0, 0, 70), "<dev string:x5c>" + var_9846878b6e719559.sight, (1, 1, 1), 1, 0.25, 1, 1);
    print3d(entity.origin + (0, 0, 65), "<dev string:x68>" + var_9846878b6e719559.visible, (1, 1, 1), 1, 0.25, 1, 1);
    print3d(entity.origin + (0, 0, 60), "<dev string:x74>" + var_9846878b6e719559.state, (1, 1, 1), 1, 0.25, 1, 1);
    waitframe();
  }
}

function private function_7e914cb1041c95a() {
  while(true) {
    if(getdvarint(@ "hash_82f9621733535c5c", 0) > 1) {
      foreach(ai in getaiarray("<dev string:x7f>")) {
        if(!isDefined(ai.var_9846878b6e719559)) {
          ai.var_9846878b6e719559 = spawnStruct();
        }

        ai thread function_42077bb16c52ffd5(ai.var_9846878b6e719559);
      }
    }

    wait 1;
  }
}

function private function_a020909614c1ff8f() {
  if(getdvarint(@ "hash_9036f679297821bb", 0) > 0) {
    ai = self;

    while(true) {
      if(isDefined(ai.var_9846878b6e719559.state) && isDefined(ai.var_9846878b6e719559.sight)) {
        var_9846878b6e719559 = ai.var_9846878b6e719559;
        print3d(ai.origin + (20, 0, 50), var_9846878b6e719559.state + "<dev string:x87>" + var_9846878b6e719559.sight, (0, 0, 1));
      }

      dist = distance2d(level.player.origin, ai.origin);
      print3d(ai.origin + (20, 0, 40), "<dev string:x24>" + dist, (1, 0, 0));
      waitframe();
    }
  }
}

# /