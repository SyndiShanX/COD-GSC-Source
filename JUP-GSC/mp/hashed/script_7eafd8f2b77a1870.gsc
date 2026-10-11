/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7eafd8f2b77a1870.gsc
*************************************************/

#using script_24fbedba9a7a1ef4;
#using script_5bab271917698dc4;
#using scripts\anim\battlechatter;
#using scripts\asm\asm;
#using scripts\asm\cap;
#using scripts\common\cap;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\gametypes\br_ai_gulag;
#using scripts\mp\gametypes\br_analytics;
#using scripts\mp\gametypes\br_gulag;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\hud_message;
#using scripts\mp\utility\player;
#using scripts\mp\utility\points;
#namespace namespace_ddb3cfd00698dfab;

function function_5675a69bbcea259() {
  if(!getdvarint(@ "hash_4a544835c8ae64f3", 0)) {
    return;
  }

  if(!istrue(level.usegulag)) {
    return;
  }

  var_622d21932c1bcf3a = spawnStruct();
  var_622d21932c1bcf3a.primaryweapon = getDvar(@ "hash_c15ab5c0d62f602c", "ar");
  var_622d21932c1bcf3a.tier = getdvarint(@ "hash_d3274d9a629743fe", 1);
  var_622d21932c1bcf3a.totalhealth = getdvarint(@ "hash_e5060acbd5afa93e", 300);
  var_622d21932c1bcf3a.damagedefault = getdvarint(@ "hash_c010d711979f5114", 15);
  var_622d21932c1bcf3a.damagestunned = getdvarint(@ "hash_373c93b98e7d3c92", 30);
  var_622d21932c1bcf3a.thresholdstun = getdvarint(@ "hash_2ca665603bf97065", 1);
  var_622d21932c1bcf3a.var_e325731aea80b77f = getdvarint(@ "hash_9cf27803596fff40", 1);
  var_622d21932c1bcf3a.var_12fb21dc8751c2ce = getdvarint(@ "hash_dafa44a595367d1d", 2);
  var_622d21932c1bcf3a.var_f4f16b39bfe10c37 = getdvarfloat(@ "hash_65e3ecba47524376", 2);
  var_622d21932c1bcf3a.var_f5147939c00772b9 = getdvarfloat(@ "hash_6606deba47786c64", 2.5);
  var_622d21932c1bcf3a.spawnmin = getdvarint(@ "hash_a3586cc38781ff97", 3);
  var_622d21932c1bcf3a.spawnmax = getdvarint(@ "hash_a37b7ac387a86619", 4);
  level.var_622d21932c1bcf3a = var_622d21932c1bcf3a;

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  foreach(arena in level.gulag.arenas) {
    arena.var_e33e5f2072a1db86 = [];
    arenastructs = getStructArray(arena.target, "targetname");

    foreach(arenastruct in arenastructs) {
      if(arenastruct.script_noteworthy == "gulag_twotwo_catwalk_ai_spawn") {
        if(isDefined(arenastruct.target)) {
          arenastruct.patrolstart = getStruct(arenastruct.target, "targetname");

          if(isDefined(arenastruct.patrolstart)) {
            arenastruct.patrolpath = function_9edcf99159abb0b(arenastruct.patrolstart);
          }
        }

        arena.var_e33e5f2072a1db86[arena.var_e33e5f2072a1db86.size] = arenastruct;
      }
    }
  }

  level waittill("prematch_done");
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("loot_key_spectator_gulag", &function_6b2a6e0fc1611a0b);
  function_b896efd72719fc99();

  foreach(arena in level.gulag.arenas) {
    function_71240cfca27fc4dd(arena);
  }
}

function function_b896efd72719fc99() {
  category = "gulag_catwalk";
  function_ba4022744dce59f6(category);
}

function function_71240cfca27fc4dd(arena) {
  if(isDefined(arena.secondchancekey)) {
    arena.secondchancekey scripts\mp\gametypes\br_pickups::deletescriptableinstance(1);
  }

  tospawn = randomintrange(level.var_622d21932c1bcf3a.spawnmin, level.var_622d21932c1bcf3a.spawnmax + 1);
  arena.var_31839e5dd0b28150 = [];
  arena.var_9068c2300fc69810 = [];

  if(!isDefined(arena.var_60af67bcaac1aa55)) {
    arena.var_60af67bcaac1aa55 = 0;
  }

  if(!isDefined(arena.riotscompleted)) {
    arena.riotscompleted = 0;
  }

  arena.var_e33e5f2072a1db86 = array_randomize(arena.var_e33e5f2072a1db86);

  for(i = 0; i < tospawn; i++) {
    function_8a7784fe4a8d91b2(arena, arena.var_e33e5f2072a1db86[i], level.var_622d21932c1bcf3a.primaryweapon, level.var_622d21932c1bcf3a.tier);
  }
}

function function_8a7784fe4a8d91b2(arena, aispawn, basetype, tiernum, nationality) {
  aitype = "enemy_mp_baton_base";

  if(getdvarint(@ "hash_13bdd9641f2e3308", 0)) {
    if(!isDefined(basetype)) {
      basetype = "smg";
    }

    aitype = function_7f1a2e2ebe0c1693(basetype, tiernum, nationality);
  }

  spawnlocation = aispawn.origin;

  if(!getdvarint(@ "hash_b3d7a9483362813e", 0)) {
    spawnlocation = getclosestpointonnavmesh(aispawn.origin + (0, 0, 30));
  }

  agent = ai_mp_requestspawnagent(aitype, spawnlocation, aispawn.angles, "absolute", "gulag_catwalk", undefined, undefined, undefined, undefined, undefined, 1, undefined, 0);

  if(isagent(agent)) {
    agent function_7c45ebd8f87cbec2(arena);
    agent.arena = arena;
    agent.callbackdamaged = &function_a970772ff3c57929;
    agent.fnshouldplaypainanim = &function_2362b21ebe35f2dd;
    agent.handledamagefeedback = &function_d92fbfd19f555324;
    agent.health = level.var_622d21932c1bcf3a.totalhealth;
    agent.maxhealth = level.var_622d21932c1bcf3a.totalhealth;
    agent.meleechargedistvsplayer = 120;
    agent.pathenemyfightdist = 0;
    agent.var_a6ec133a74de3b = 1;
    agent.var_185f1efd0ec920d3 = 90;
    agent.var_e6b3eb176dda8abc = 70;
    agent.var_f88c7e674f2b356e = 60;
    agent.var_2d2cd9dac58c3455 = 0;
    agent.rockhits = 0;
    agent.var_4e94c508dbe088a2 = 0;
    agent.var_725248d464d15738 = 0;
    agent.ballowexecutions = 0;
    agent.var_214ec6c7283a65c6 = 0;
    agent.disablerunpain = 1;
    agent function_d493e7fe15e5eaf4("default");
    agent notify("endLootDropThread");
    agent attach("misc_wm_baton", "tag_accessory_right");

    if(getdvarint(@ "hash_b3d7a9483362813e", 0)) {
      agent forceteleport(spawnlocation, aispawn.angles);
      agent setgoalpos(agent.origin, 16);
      agent clearpath();
      agent.fixednode = 1;
      agent thread function_b11c1964f528574b(agent, 1, agent.origin);
    } else if(getdvarint(@ "hash_1bed526f1079e5da", 0) && isDefined(aispawn.patrolpath)) {
      agent.pacifist = 1;
      agent aisetdesiredspeed(80);
      level thread function_d68be668e6e95bb(agent, aispawn.patrolpath, undefined, 64);
      agent utility::demeanor_override("patrol");
      agent thread function_93b11e4da88bf536();
      agent thread function_f02c2688fad36430();
      agent thread function_f4270b365e95d937();
    } else {
      level thread function_b11c1964f528574b(agent);
    }

    agent setplayerghost(1);
    agent setperk("specialty_gpsjammer", 1);
    agent thread function_7ae9ebb1a232528(arena);
  }
}

function function_7c45ebd8f87cbec2(arena) {
  if(!isDefined(arena.var_6099a8d8ce7de8de)) {
    arena.var_6099a8d8ce7de8de = [];
  }

  arena.var_6099a8d8ce7de8de = array_add(arena.var_6099a8d8ce7de8de, self);
}

function function_7ae9ebb1a232528(arena) {
  level endon("game_ended");
  self waittill("death", killer);

  if(isDefined(arena.var_6099a8d8ce7de8de)) {
    arena.var_6099a8d8ce7de8de = array_remove(arena.var_6099a8d8ce7de8de, self);

    if(isagent(self)) {
      if(isalive(self)) {
        self.nocorpse = 1;
        self kill();
      }
    }

    if(!isDefined(arena.var_7174e40427faeae2)) {
      arena.var_7174e40427faeae2 = [];
    }

    body = self getcorpseentity();

    if(isDefined(body)) {
      arena.var_7174e40427faeae2 = array_add(arena.var_7174e40427faeae2, body);
    }

    if(isPlayer(killer)) {
      arena thread function_28d2431aa45d5df8();

      if(arena.var_6099a8d8ce7de8de.size <= 0) {
        if(!isDefined(arena.secondchancekey)) {
          dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
          scripts\mp\gametypes\br_pickups::function_a10adec57ad9e3a4(dropstruct, arena, killer);
        }
      }
    }

    if(!isDefined(arena.riotinprogress)) {
      arena.riotinprogress = 1;
      arena.var_60af67bcaac1aa55 += 1;

      foreach(jailedplayer in arena.jailedplayers) {
        jailedplayer thread scripts\mp\hud_message::showsplash("br_gulag_prison_riot_in_progress");
      }
    }
  }
}

function function_6b2a6e0fc1611a0b(instance, part, state, player, bautouse, usestring) {
  level endon("game_ended");
  arena = player.arena;

  if(isDefined(arena.secondchancekey)) {
    arena.secondchancekey scripts\mp\gametypes\br_pickups::deletescriptableinstance(1);
    player thread scripts\mp\gametypes\br_pickups::playerplaypickupanim();
  }

  if(isDefined(player)) {
    player scripts\mp\utility\points::doscoreevent(#"hash_7f475510f9f5698d");
  }

  wait 1.17;

  foreach(participant in arena.var_31839e5dd0b28150) {
    if(isDefined(participant)) {
      participant scripts\mp\utility\points::doscoreevent(#"hash_dd106359bca2b84");
    }
  }

  torespawn = array_combine(arena.jailedplayers, arena.arenaplayers);
  arena thread function_4a9dbce4369f1bba();
  arena thread function_3391003fe051704();
  level notify("gulag_break");

  if(isDefined(arena)) {
    if(isDefined(arena.riotscompleted)) {
      arena.riotscompleted += 1;
    }
  }

  scripts\mp\gametypes\br_analytics::function_5098ee655afed5d(arena.id, level.br_circle.circleindex, 1, arena.var_31839e5dd0b28150.size, 0, torespawn.size);
  arena thread function_ec93ae254484ba9d(5);
}

function function_3391003fe051704() {
  level endon("game_ended");
  self endon("fight_over");
  self endon("matchEnded");

  if(istrue(self.fightover)) {
    return;
  }

  foreach(player in self.arenaplayers) {
    player setclientomnvar("ui_br_gulag_lethal_delay", 0);
    player val::reset_all("watchLethalDelayPlayer");

    if(!isbot(player) && isPlayer(player)) {
      player notifyonplayercommandremove("lethal_attempt_gulag", "+frag");
      player notifyonplayercommandremove("lethal_attempt_gulag", "+smoke");
    }

    player thread gulagbreak_playerrespawn(1);
  }
}

function function_4a9dbce4369f1bba() {
  foreach(player in self.jailedplayers) {
    if(!player isinexecutionvictim()) {
      if(player namespace_8bfdb6eb5a3df67a::playeriscinematiclayeron()) {
        player stopcinematicforplayer(1, 1);
      }

      player thread gulagbreak_playerrespawn(0);
    }
  }
}

function gulagbreak_playerrespawn(var_15a419e19e435f2b) {
  if(!isDefined(self)) {
    return;
  }

  isingulag = isalive(self) && isDefined(level.gulag) && !istrue(level.gulag.shutdown) && scripts\mp\gametypes\br_public::isplayerinorgoingtogulag();

  if(var_15a419e19e435f2b) {
    if(namespace_8bfdb6eb5a3df67a::playeriscinematiclayeron()) {
      namespace_8bfdb6eb5a3df67a::function_e68e4bb4f65f5fe4();
    }
  }

  _freezecontrols(1, 0, "gulagBreak");
  thread scripts\mp\hud_message::showsplash("br_gulagbreak_active");

  if(isingulag) {
    gulagvictory(self.arena, self, 1, 0, undefined, undefined, undefined, undefined, undefined, 1);
    return;
  }

  thread scripts\mp\gametypes\br_gulag::playergulagautowin("gulagbreak_playerRespawn", undefined, undefined, 1, 0, undefined, 1);
}

function function_a970772ff3c57929(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  if(isDefined(eattacker) && array_contains(self.arena.arenaplayers, eattacker)) {
    return;
  }

  if(isDefined(self.arena) && !array_contains(self.arena.var_31839e5dd0b28150, eattacker)) {
    self.arena.var_31839e5dd0b28150 = array_add(self.arena.var_31839e5dd0b28150, eattacker);
  }

  if(isPlayer(eattacker)) {
    if(isDefined(self.arena)) {
      if(isDefined(self.arena.var_9068c2300fc69810) && !array_contains(self.arena.var_9068c2300fc69810, self)) {
        self.arena.var_9068c2300fc69810 = array_add(self.arena.var_9068c2300fc69810, self);

        if(isDefined(self.arena.var_19fe32f41a41c7ff)) {
          self.arena.var_19fe32f41a41c7ff += 1;
        } else {
          self.arena.var_19fe32f41a41c7ff = 1;
        }
      }
    }
  }

  alreadyflashed = isDefined(self.flashendtime);

  if(smeansofdeath == "MOD_IMPACT") {
    if(distance2dsquared(einflictor.origin, eattacker.origin) < 640000) {
      if(partname == t "hash_51bd95aa" || partname == t "j_head") {
        thread scripts\cp_mp\utility\debug_utility::drawsphere(vpoint, 2, 1, (0, 1, 0));

        idamage = level.var_622d21932c1bcf3a.damagestunned;
        self.var_2d2cd9dac58c3455++;

        if(!alreadyflashed && isDefined(self.var_2d2cd9dac58c3455) && self.var_2d2cd9dac58c3455 >= level.var_622d21932c1bcf3a.thresholdstun) {
          self.var_cf96019be76d9636 = eattacker;
          function_bb4122a38672185(1);
          stunduration = randomfloatrange(level.var_622d21932c1bcf3a.var_f4f16b39bfe10c37, level.var_622d21932c1bcf3a.var_f5147939c00772b9);

          if(self.asmname != self.defaultasm) {
            scripts\asm\cap::function_db8201ba3a4a894d();
          }

          self shellshock("flashbang_mp", stunduration);

          if(!isDefined(self.flashendtime)) {
            self.flashendtime = int(stunduration * 1000);
            scripts\asm\asm::asm_setstate("pain_flashed_transition");
          }

          self.var_2d2cd9dac58c3455 = 0;
          self.var_77f17252937f40cd = 1;
          thread function_d663d609f9113305();
          scripts\anim\battlechatter::function_d54e84a9513b0e45("guard_damage_reaction_head", "react_multi", 0, 0, 3);
        }
      } else {
        thread scripts\cp_mp\utility\debug_utility::drawsphere(vpoint, 2, 1, (1, 0, 0));

        self.rockhits++;

        if(self.rockhits >= level.var_622d21932c1bcf3a.var_e325731aea80b77f) {
          self.rockhits = 0;

          if(!self.var_725248d464d15738) {
            self.shouldpain = 1;
            var_823867e4d6972ea8 = vectorNormalize(anglesToForward(self.angles));
            attackvector = vectorNormalize(vdir);
            dotproduct = vectordot(attackvector, var_823867e4d6972ea8);

            if(dotproduct > 0.35) {
              thread scripts\cp_mp\utility\debug_utility::drawsphere(vpoint, 4, 1, (1, 0, 0));

              scripts\anim\battlechatter::function_d54e84a9513b0e45("guard_damage_reaction_body", "react_unaware", 0, 0, 4);
            } else {
              thread scripts\cp_mp\utility\debug_utility::drawsphere(vpoint, 4, 1, (0, 1, 0));

              scripts\anim\battlechatter::function_d54e84a9513b0e45("guard_damage_reaction_body", "react_aware", 0, 0, 4);
            }
          }
        }
      }

      self.var_cf96019be76d9636 = eattacker;
      function_bb4122a38672185(1);
    }
  } else if(smeansofdeath == "MOD_MELEE") {
    if(!self.var_725248d464d15738) {
      if(!alreadyflashed) {
        self.shouldpain = 1;
        scripts\anim\battlechatter::function_d54e84a9513b0e45("guard_melee_reaction", "react_aware", 0, 0, 3);
      }

      self.var_cf96019be76d9636 = eattacker;
      function_bb4122a38672185(1);
    }

    if(isDefined(self.flashendtime) && self.flashendtime > 0) {
      idamage = level.var_622d21932c1bcf3a.damagestunned;
    } else {
      idamage = level.var_622d21932c1bcf3a.damagedefault;
    }
  }

  if(idamage > self.health) {
    self detach("misc_wm_baton", "tag_accessory_right");
  }

  namespace_daa149ca485fd50a::function_dffac413ed66bcd0(einflictor, eattacker, int(idamage), idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon);
}

function function_d663d609f9113305() {
  self endon("death");

  while(isDefined(self.flashendtime)) {
    waitframe();
  }

  self.var_77f17252937f40cd = 0;
}

function function_2362b21ebe35f2dd() {
  var_392782e59863c89f = 64;

  if(istrue(self.shouldpain)) {
    self.shouldpain = 0;
    return true;
  }

  if(self.a.disablepain) {
    return false;
  }

  if(isDefined(self.allowpain) && self.allowpain == 0) {
    return false;
  }

  if(istrue(self.var_a1db58c75f381a55)) {
    return false;
  }

  if(isDefined(self.pathgoalpos) && self pathdisttogoal(1) < var_392782e59863c89f) {
    return false;
  }

  if(isDefined(self.damageweapon)) {
    basename = getweaponbasename(self.damageweapon);
    isfist = issubstr(basename, "fists");

    if(isfist) {
      return false;
    }
  }

  return true;
}

function function_28d2431aa45d5df8() {
  level notify("spectator_ai_death");
  level endon("spectator_ai_death");
  level endon("gulag_break");

  while(true) {
    players = array_remove_array(self.jailedplayers, self.arenaplayers);

    if(players.size <= 0) {
      thread function_ec93ae254484ba9d(5);
      scripts\mp\gametypes\br_analytics::function_5098ee655afed5d(self.id, level.br_circle.circleindex, 0, self.var_31839e5dd0b28150.size, self.var_6099a8d8ce7de8de.size, 0);
      break;
    }

    wait 1;
  }
}

function function_ec93ae254484ba9d(delay) {
  level endon("game_ended");

  if(isDefined(delay)) {
    wait delay;
  }

  if(isDefined(self.var_6099a8d8ce7de8de)) {
    foreach(agent in self.var_6099a8d8ce7de8de) {
      if(isDefined(agent) && isagent(agent)) {
        if(isalive(agent)) {
          agent.nocorpse = 1;
          agent kill();
        }

        body = agent getcorpseentity();

        if(isDefined(body)) {
          body delete();
        }
      }
    }
  }

  if(isDefined(self.var_7174e40427faeae2)) {
    foreach(body in self.var_7174e40427faeae2) {
      if(isDefined(body)) {
        body delete();
      }
    }
  }

  function_71240cfca27fc4dd(self);
}

function function_d92fbfd19f555324(einflictor, eattacker, victim, idamage, smeansofdeath, objweapon, shitloc, idflags, lightarmordamage, heavyarmordamage, iskillstreakweapon) {
  if(isDefined(eattacker) && isDefined(eattacker.owner)) {
    damager = eattacker.owner;
  } else {
    damager = eattacker;
  }

  if(isDefined(damager) && damager != victim && idamage + lightarmordamage + heavyarmordamage > 0 && (!isDefined(shitloc) || shitloc != "shield")) {
    waskilled = !victim scripts\cp_mp\utility\player_utility::_isalive() || isagent(victim) && idamage >= victim.health;
    headshot = scripts\cp_mp\utility\damage_utility::isheadshot(shitloc, smeansofdeath, eattacker);
    suppressaudio = smeansofdeath == "MOD_MELEE";
    victimentnum = "" + victim getentitynumber();

    if(waskilled && isDefined(victim.body)) {
      var_249fca7089cd498f = victim.body getentitynumber();
    } else {
      var_249fca7089cd498f = victim getentitynumber();
    }

    if(isDefined(self.var_36de30612482e8cf) && [[self.var_36de30612482e8cf]]()) {
      damager scripts\cp_mp\damagefeedback::updatedamagefeedback("hitarmorheavybreak", waskilled, headshot, undefined, suppressaudio, undefined, var_249fca7089cd498f, undefined);
      return;
    }

    if(idamage >= level.var_622d21932c1bcf3a.damagestunned) {
      damager scripts\cp_mp\damagefeedback::updatedamagefeedback("standard", waskilled, headshot, undefined, suppressaudio, undefined, var_249fca7089cd498f, undefined);
      return;
    }

    if(idamage >= level.var_622d21932c1bcf3a.damagedefault) {
      damager scripts\cp_mp\damagefeedback::updatedamagefeedback("hitarmorheavy", waskilled, headshot, undefined, suppressaudio, undefined, var_249fca7089cd498f, undefined);
    }
  }
}

function function_bb4122a38672185(aggressive) {
  self.pacifist = !aggressive;
  self.var_c833409fb72d15fb = !aggressive;

  if(aggressive) {
    var_4e599476dcf4d61e = getdvarint(@ "hash_b511af5ef96f1167", 0);

    if(var_4e599476dcf4d61e > 0) {
      return;
    }

    self function_1c339daaba3f71db(1);
    self.var_725248d464d15738 = 1;
    self.var_214ec6c7283a65c6 = 1;
    self.goalradius = 8000;
    utility::demeanor_override("cqb");
    self.allowstrafe = 0;

    if(isDefined(self.var_cf96019be76d9636)) {
      player = self.var_cf96019be76d9636;
      self agentsetfavoriteenemy(player);
      self setlookatentity(player);

      if(!isDefined(player.var_e1590a93eca5e264)) {
        player.var_e1590a93eca5e264 = [];
      }

      player.var_e1590a93eca5e264 = array_add(player.var_e1590a93eca5e264, self);
    }

    return;
  }

  self.var_725248d464d15738 = 0;
  self.var_214ec6c7283a65c6 = 0;
  self agentsetfavoriteenemy(undefined);
  self setlookatentity();
  self aisetdesiredspeed(80);
  self.goalradius = 64;
  demeanor_override("patrol");
  player = self.var_cf96019be76d9636;

  if(isDefined(player) && isDefined(player.var_e1590a93eca5e264)) {
    player.var_e1590a93eca5e264 = array_remove(player.var_e1590a93eca5e264, self);
    self.var_cf96019be76d9636 = undefined;
  }

  if(self.var_4e94c508dbe088a2 >= level.var_622d21932c1bcf3a.var_12fb21dc8751c2ce) {
    self.var_4e94c508dbe088a2 = 0;
  }
}

function function_f02c2688fad36430() {
  level endon("game_ended");
  self endon("death");

  while(true) {
    if(istrue(self.var_725248d464d15738)) {
      var_4e599476dcf4d61e = getdvarint(@ "hash_b511af5ef96f1167", 0);

      if(var_4e599476dcf4d61e > 0) {
        function_bb4122a38672185(0);
      }

      var_35b984525605169b = self.var_cf96019be76d9636;
      targetinlaststand = scripts\mp\utility\player::isinlaststand(var_35b984525605169b);
      var_f134ad0a55f3963 = var_35b984525605169b isinexecutionvictim() && !self isinexecutionattack();
      var_ea03686b0edf04e2 = array_contains(self.arena.arenaplayers, var_35b984525605169b);

      if(!isDefined(var_35b984525605169b) || !isalive(var_35b984525605169b) || targetinlaststand || var_f134ad0a55f3963 || var_ea03686b0edf04e2 || distance2dsquared(self.origin, var_35b984525605169b.origin) > 640000) {
        function_bb4122a38672185(0);
      }
    }

    wait 0.1;
  }
}

function function_f4270b365e95d937() {
  level endon("game_ended");
  self endon("death");
  self.var_16304b6ccaa4b8bd = 0;

  while(true) {
    self waittill("object_whizby", org, player);

    if(!istrue(self.var_725248d464d15738) && isDefined(player)) {
      self.var_4e94c508dbe088a2++;

      if(!self.var_16304b6ccaa4b8bd) {
        if(self.var_4e94c508dbe088a2 >= level.var_622d21932c1bcf3a.var_12fb21dc8751c2ce && distance2dsquared(self.origin, player.origin) < 640000) {
          self.var_cf96019be76d9636 = player;
          function_bb4122a38672185(1);
          function_1a7204646a84bc7a(player);
        } else {
          self.var_16304b6ccaa4b8bd = 1;
          thread function_f107289c7060de31(player);
        }
      }
    }

    wait 0.1;
  }
}

function function_f107289c7060de31(player) {
  level endon("game_ended");
  self endon("death");
  capname = "cap_jailer_warnoff";
  capanimset = "caps/common/cap_jailer_warnoff";
  self function_1c339daaba3f71db(1);
  self setlookatentity(player);
  self.var_6ea17fd821a76b9f = player;
  self function_105c123cd778717a(player);
  scripts\common\cap::cap_start(capname, capanimset);
  self waittill("cap_exit_completed");
  self function_105c123cd778717a();
  self setlookatentity();
  self.var_6ea17fd821a76b9f = undefined;

  if(self.var_4e94c508dbe088a2 >= level.var_622d21932c1bcf3a.var_12fb21dc8751c2ce && distance2dsquared(self.origin, player.origin) < 640000) {
    self.var_cf96019be76d9636 = player;
    self asmsetstate(self.asmname, "patrol_idle");
    function_bb4122a38672185(1);
  }

  self.var_16304b6ccaa4b8bd = 0;
}

function function_1a7204646a84bc7a(player) {
  if(self.asmname == self.defaultasm) {
    self.var_1c9ed4a46d13edc9 = player.origin;
    self.var_fd01ad49b4e38ae8 = "med";
    scripts\anim\battlechatter::function_d54e84a9513b0e45("guard_player_spotted", "warn_spotted", 0, 0, 3);
    animindex = self asmgetanim(self.asmname, "patrol_move_react_aim");
    reactanim = scripts\asm\asm::asm_getxanim("patrol_move_react_aim", animindex);
    animtime = getanimlength(reactanim);
    self motionwarpcancel();
    self animmode("zonly_physics");
    self orientmode("face enemy");
    self function_105c123cd778717a(player);
    self aisetanim("patrol_move_react_aim", animindex, 1);
    wait animtime;

    if(self.asmname == self.defaultasm) {
      self function_105c123cd778717a();
      self asmsetstate(self.asmname, "patrol_move");
    }
  }
}

function function_3231b59578bffe2f(alias) {
  level endon("game_ended");
  self endon("death");
  sequence = [];

  switch (alias) {
    case #"hash_9afce1b0ecac4374":
      sequence = ["warn_getBack"];
      break;
    case #"hash_5812880e67a2c623":
      sequence = ["warn_getBackNow"];
      break;
    case #"hash_3ea1f1426c9b770d":
      sequence = ["warn_getOut"];
      break;
    case #"hash_f67d317d2f97f09c":
      sequence = ["warn_curse"];
      break;
    case #"hash_6f85aaf2e7841904":
      sequence = ["warn_curse"];
      break;
  }

  scripts\anim\battlechatter::function_d54e84a9513b0e45("guard_player_warning", sequence, 0, 0, 1);
}

function function_3032d7f191ce6b69() {
  level endon("game_ended");
  self endon("death");
  wait 2.7;
  sequence = [];

  if(percent_chance(25)) {
    if(percent_chance(25)) {
      sequence = ["warn_getBack", 1, "warn_getOut", 0.4, "warn_curse"];
    } else {
      sequence = ["warn_getBack", 1, "warn_getOut"];
    }
  } else if(percent_chance(25)) {
    if(percent_chance(25)) {
      sequence = ["warn_getBackNow", 1, "warn_getOut", 0.4, "warn_curse"];
    } else {
      sequence = ["warn_getBackNow", 1, "warn_getOut"];
    }
  } else if(percent_chance(25)) {
    if(percent_chance(25)) {
      sequence = ["warn_getOut", 1, "warn_getBack", 0.4, "warn_curse"];
    } else {
      sequence = ["warn_getOut", 1, "warn_getBack"];
    }
  } else if(percent_chance(25)) {
    sequence = ["warn_getOut", 1, "warn_getBackNow", 0.4, "warn_curse"];
  } else {
    sequence = ["warn_getOut", 1, "warn_getBackNow"];
  }

  scripts\anim\battlechatter::function_d54e84a9513b0e45("guard_player_warning", sequence, 0, 0, 1);
}

function function_93b11e4da88bf536() {
  level endon("game_ended");
  self endon("death");
  shouldattack = 0;

  while(true) {
    if(self.var_725248d464d15738) {
      self.var_214ec6c7283a65c6 = 1;
      wait 0.1;
      continue;
    }

    assert(isDefined(self.arena));
    playersnearby = function_dff80119c7ccac6a(self.arena, self.origin, 180);

    if(playersnearby.size > 0) {
      playersnearby = sortbydistance(playersnearby, self.origin);

      foreach(player in playersnearby) {
        if(player.ignoreme || scripts\mp\utility\player::isinlaststand(player) || player isinexecutionvictim()) {
          continue;
        }

        var_a75a06ee98df814 = distance2d(self.origin, player.origin) <= 80;

        if((self cansee(player) || var_a75a06ee98df814) && !shouldattack) {
          if(isDefined(player.var_e1590a93eca5e264) && player.var_e1590a93eca5e264.size > 0) {
            shouldattack = 1;
            self.var_214ec6c7283a65c6 = shouldattack;
            self.var_cf96019be76d9636 = player;
            function_1a7204646a84bc7a(player);
            scripts\anim\battlechatter::function_d54e84a9513b0e45("guard_warn_attack", "warn_attack", 0, 0, 3);
            function_bb4122a38672185(1);
            break;
          }

          if(self.var_1420c6f292149589) {
            shouldattack = 1;
            self.var_214ec6c7283a65c6 = shouldattack;
            self.var_cf96019be76d9636 = player;
            scripts\anim\battlechatter::function_d54e84a9513b0e45("guard_warn_attack", "warn_attack", 0, 0, 3);
            function_bb4122a38672185(1);
            break;
          }

          if(var_a75a06ee98df814) {
            self.var_1420c6f292149589 = 1;
            self.pausepatrol = 1;
            self setgoalpos(self.origin);

            if(!self.var_725248d464d15738) {
              capname = "cap_jailer_warnoff";
              capanimset = "caps/common/cap_jailer_warnoff";
              self function_1c339daaba3f71db(1);
              self setlookatentity(player);
              self.var_6ea17fd821a76b9f = player;
              self function_105c123cd778717a(player);
              thread function_3032d7f191ce6b69();
              scripts\common\cap::cap_start(capname, capanimset);
              self waittill("cap_exit_completed");
              self function_105c123cd778717a();
              self setlookatentity();
              self.var_6ea17fd821a76b9f = undefined;
            }

            break;
          }
        }
      }
    } else {
      self.pausepatrol = 0;
      self.var_1420c6f292149589 = 0;
      shouldattack = 0;
      self.var_214ec6c7283a65c6 = shouldattack;
    }

    if(!shouldattack && !self.var_214ec6c7283a65c6 && self.var_4e94c508dbe088a2 < level.var_622d21932c1bcf3a.var_12fb21dc8751c2ce) {
      function_bb4122a38672185(0);
      self.var_a02447b50de44bcc = undefined;
    }

    wait 0.1;
  }
}

function function_d68be668e6e95bb(agent, pathstruct, startindex, goalradiusoverride, idletimeoverride) {
  if(!isDefined(agent)) {
    return;
  }

  level endon("game_ended");
  var_a1d5907e01730345 = 0;
  behaviorpackage = function_f0c78111ce0cdc0a(agent);

  if(!isDefined(behaviorpackage) || behaviorpackage.behavior != "patrol") {
    function_4561fe6bfc76f8ec(agent, [agent], pathstruct);
  }

  if(isagent(agent)) {
    agent endon("death");
    var_a1d5907e01730345 = 1;
  }

  if(!var_a1d5907e01730345) {
    return;
  }

  path = pathstruct.path;
  pathstruct.claimed = 1;
  index = 1;
  forwarddirection = 1;

  if(isDefined(startindex)) {
    index = startindex;
    index = int(min(index, path.size - 1));
    index = int(max(index, 0));
  }

  function_1670c315976c767b();
  wait 1;

  while(true) {
    shouldpatrol = !agent.var_214ec6c7283a65c6 && !istrue(agent.pausepatrol);

    if(shouldpatrol) {
      if(isvector(path[index])) {
        point = path[index];
      } else {
        point = path[index].origin;
      }

      random_x = randomfloatrange(10, 11) * scripts\engine\utility::ter_op(cointoss(), 1, -1);
      random_y = randomfloatrange(10, 11) * scripts\engine\utility::ter_op(cointoss(), 1, -1);
      point = (point[0] + random_x, point[1] + random_y, point[2]);
      agent _setgoalpos(point, 32);
      wait randomfloatrange(1.5, 2.5);
      waitframe();
      agent waittill("goal");
    }

    if(istrue(agent.var_cf430336d17e3afe)) {
      wait 0.5;
    } else {
      wait default_to(idletimeoverride, 5);
    }

    shouldpatrol = !agent.var_214ec6c7283a65c6 && !istrue(agent.pausepatrol);

    if(shouldpatrol) {
      if(forwarddirection) {
        index++;
      } else {
        index--;
      }

      if(!isDefined(path[index])) {
        if(!pathstruct.var_4437e81f60b6b5a0) {
          index = 0;
          continue;
        }

        if(forwarddirection) {
          index = path.size - 2;
          forwarddirection = 0;
          continue;
        }

        index = 1;
        forwarddirection = 1;
      }
    }
  }
}

function function_dff80119c7ccac6a(arena, pos, radius) {
  players = [];

  foreach(player in arena.jailedplayers) {
    if(isDefined(player)) {
      if(distance2d(pos, player.origin) <= radius) {
        players = array_add(players, player);
      }
    }
  }

  return players;
}