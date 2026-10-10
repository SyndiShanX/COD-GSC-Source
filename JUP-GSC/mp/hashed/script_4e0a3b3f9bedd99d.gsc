/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4e0a3b3f9bedd99d.gsc
*************************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\soldier\melee;
#using scripts\asm\soldier\throwgrenade;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\cp_mp\ent_manager;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\equipment\gas_grenade;
#using scripts\mp\equipment\molotov;
#using scripts\mp\equipment\smoke_grenade;
#using scripts\mp\shellshock;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\outline;
#namespace smokebomb;

function function_7e28b2b514a15cd3(statename, var_5edf43a8a1497a41, var_a4b7ac07eebb559f) {
  function_1daaaf7667f1282e();
  self attach(getweaponmodel(self.grenadeweapon), "TAG_ACCESSORY_LEFT");
  self.var_80ef2f6717602cbf = 1;
  thread grenadethrow(statename, var_5edf43a8a1497a41, var_a4b7ac07eebb559f);
}

function function_48c8acf993dae2cc(asmname, statename, params) {
  self endon(statename + "_finished");
  self function_36c9cc1aacacc4a8();
  function_7e28b2b514a15cd3(statename, params[0], params[1]);
  asm_playanimstate(asmname, statename, params);
}

function function_1daaaf7667f1282e() {
  if(istrue(self.var_80ef2f6717602cbf)) {
    self detach(getweaponmodel(self.grenadeweapon), "TAG_ACCESSORY_LEFT");
    self.var_80ef2f6717602cbf = 0;
  }
}

function grenadethrow(statename, var_5edf43a8a1497a41, var_a4b7ac07eebb559f) {
  self endon("death");
  self endon(statename + "_finished");
  var_9930afea4de87021 = 0;

  while(!var_9930afea4de87021) {
    self waittill(statename, notes);

    if(!isarray(notes)) {
      notes = [notes];
    }

    foreach(notetrack in notes) {
      if(notetrack == "grenade_throw" || notetrack == "grenade throw") {
        var_9930afea4de87021 = 1;
        continue;
      }

      assert(notetrack != "<dev string:x1c>");

      if(notetrack == "end") {
        if(isDefined(self.var_a3441d87a95e9040) && isPlayer(self.var_a3441d87a95e9040)) {
          self.var_a3441d87a95e9040 function_a33073d6fd58e58e();
        }

        self notify("dont_reduce_giptp_on_killanimscript");
        var_9930afea4de87021 = 1;
      }
    }
  }

  function_1daaaf7667f1282e();
  self notify("rusher_smokebomb_cleanup");
  self notify("rusher_smoke_bomb_thrown");

  if(issubstr(self.grenadeweapon.basename, "smoke")) {
    vectotarget = anglesToForward(self.origin);

    if(isDefined(self.enemy)) {
      vectotarget = self.enemy.origin - self.origin;
    }

    throwdistance = randomfloatrange(var_5edf43a8a1497a41, var_a4b7ac07eebb559f);
    throwvector = rotatevector(vectotarget, (0, randomfloatrange(-5, 5), 0));
    throwvector = throwdistance * vectorNormalize(throwvector);
    newgrenade = self magicgrenademanual(self.origin + throwvector + (0, 0, 10), (0, 0, 15), 0.5);
  } else {
    armoffset = (12.9077, 17.6221, 28.1187);
    throwtime = randomfloatrange(1, 1.5);
    throwvel = self checkgrenadethrowpos(armoffset, self.enemy.origin, 0, "min time", "min energy");

    if(!isDefined(throwvel)) {
      vectotarget = anglesToForward(self.origin);

      if(isDefined(self.enemy)) {
        vectotarget = self.enemy.origin - self.origin;
      }

      throwdistance = length(vectotarget) * randomfloatrange(0.95, 1.05);
      throwvector = rotatevector(vectotarget, (0, randomfloatrange(-5, 5), 0));
      throwvel = throwdistance / throwtime * vectorNormalize(throwvector) + (0, 0, 200);
    }

    newgrenade = self magicgrenademanual(self.origin + armoffset, throwvel, throwtime);
  }

  newgrenade.owner = self;
  newgrenade.weapon_name = self.grenadeweapon.basename;
  var_3251b898a0907271 = getdesiredgrenadetimervalue();
  setgrenadetimer(min(gettime() + 3000, var_3251b898a0907271));
  throwingat = self.enemy;

  if(isDefined(throwingat) && isPlayer(throwingat) && usingplayergrenadetimer()) {
    assert(throwingat == self.var_a3441d87a95e9040);
    throwingat function_e89f2bdb307f137e();
    thread reducegiptponkillanimscript(statename, throwingat);

    if(self.var_cc183df556f63da0 == "lethal") {
      if(throwingat function_4c108309dc0d7fd2() <= 1) {
        throwingat function_ff4aa047884e7a14(gettime());
      }
    }
  }

  if(self.grenadeweapon.basename == "smoke_bomb_rusher_mp") {
    function_d93415244e99e763(newgrenade.origin, newgrenade.angles, getdvarint(@ "hash_5d839447a2947c11", 1) == 1);
    return;
  }

  if(issubstr(self.grenadeweapon.basename, "molotov")) {
    newgrenade thread scripts\mp\shellshock::grenade_earthquake();
    thread scripts\mp\equipment\molotov::molotov_used(newgrenade);
  }
}

function function_d93415244e99e763(position, angles, var_ba447df20dbbbf8a, justspawned) {
  if(!istrue(justspawned)) {
    wait 0.5;
  }

  if(getdvarint(@ "hash_f784bdc2ab0eedde", 0) == 1) {
    if(getdvarint(@ "hash_abe45e35ef030a56") == 1) {
      function_8a09c0e5fa78a48c(position);
    } else {
      thread scripts\mp\bots\bots::create_smoke_occluder(position);
    }
  }

  thread function_160d327d81ff0cce(position);
  smokegrenadesfx = spawnscriptable("grenade_smoke_v0_rusher_mp_fx", position, angles);
  smokegrenadesfx thread function_9eaeff99bbe830e7(self);

  if(var_ba447df20dbbbf8a) {
    thread function_fa704b58059a64b6(position, self, self.team, 4.5, 0.25);
  }
}

function function_ca247899dbbcf9a4(position) {
  playFX(self.smokefx, position, anglestoup((0, 90, 0)));
}

function function_9eaeff99bbe830e7(owner) {
  self setscriptablepartstate("sfx_smoke_bomb", "sfx_expl");
  wait 0.25;
  self setscriptablepartstate("sfx_smoke_bomb", "sfx_smoke_fade_out");
  wait 4;
  self freescriptable();
}

function function_160d327d81ff0cce(position) {
  level endon("game_ended");
  wait 1;
  id = addoutlineoccluder(position, 64);
  wait 5.1;
  removeoutlineoccluder(id);
}

function function_fa704b58059a64b6(position, owner, team, duration, scale) {
  if(!isDefined(duration)) {
    duration = 4.5;
  }

  if(!isDefined(scale)) {
    scale = 1;
  }

  trigger = spawn("trigger_radius", position + (0, 0, int(-57.75 * scale)), 0, int(256 * scale), int(175 * scale));
  trigger scripts\cp_mp\ent_manager::registerspawn(1, &scripts\mp\equipment\gas_grenade::sweepgas);
  trigger endon("death");
  trigger.owner = owner;
  trigger.team = team;
  trigger.playersintrigger = [];
  trigger.var_aeeca2bc23f59ea4 = [];
  trigger thread gas_watchtriggerenter();
  trigger thread scripts\mp\equipment\gas_grenade::gas_watchtriggerexit();
  wait duration;
  trigger thread scripts\mp\equipment\gas_grenade::gas_destroytrigger();
}

function gas_watchtriggerenter() {
  self endon("death");

  while(true) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      if(isagent(player)) {
        if(player != self.owner && player.team != self.team) {
          if(!array_contains(self.var_aeeca2bc23f59ea4, player) || isDefined(player.flashendtime) && player.flashendtime < gettime()) {
            self.var_aeeca2bc23f59ea4[self.var_aeeca2bc23f59ea4.size] = player;

            if(isDefined(player.radimmune) && player.radimmune) {
              continue;
            }

            player notify("flashbang", player.origin, 1, 1, self.owner, self.team, 9);
          }
        }
      }

      continue;
    }

    if(player scripts\mp\utility\killstreak::isjuggernaut()) {
      continue;
    }

    if(scripts\mp\equipment\gas_grenade::function_da8a31143b88e833(player)) {
      continue;
    }

    if(!player scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }

    if(isDefined(self.playersintrigger[player getentitynumber()])) {
      continue;
    }

    if(level.teambased) {
      if(isDefined(self.owner) && isalive(self.owner)) {
        if(player != self.owner && !scripts\cp_mp\utility\player_utility::playersareenemies(player, self.owner)) {
          continue;
        }
      } else if(scripts\cp_mp\utility\player_utility::isfriendly(self.team, player)) {
        continue;
      }
    }

    self.playersintrigger[player getentitynumber()] = player;
    player thread scripts\mp\equipment\gas_grenade::gas_onentertrigger(self);
  }
}

function function_b4bd334ecec6c6c8(asmname, statename, params) {
  self.var_f44c9cede4fb20d6 = 0;
  scripts\asm\soldier\melee::playmeleechargesound();
  self.var_5185accfc2476d43 = 1;
  self.var_1f91d3da0786a2 = 1;
  scripts\asm\soldier\melee::playmeleeanim_vsplayer(asmname, statename, params);
}