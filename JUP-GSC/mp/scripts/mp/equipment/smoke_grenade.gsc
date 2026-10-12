/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment\smoke_grenade.gsc
**************************************************/

#using script_74b851b7aa1ef32d;
#using scripts\common\ae_utility;
#using scripts\common\ai;
#using scripts\common\callbacks;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\ent_manager;
#using scripts\engine\utility;
#using scripts\mp\bots\bots;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\print;
#using scripts\mp\utility\script;
#namespace smoke_grenade;

function smokegrenadeused(isgl) {
  thread notifyafterframeend("death", "end_explode");
  self endon("end_explode");
  thread function_e4f6e856495dbafb(self.bundle);

  if(istrue(isgl)) {
    self waittill("missile_stuck", stuckto, hitent, surfacetype, velocity, position, normal);
    thread smokeglvfx(position);

    if(getdvarint(@ "hash_abe45e35ef030a56") == 0) {
      thread scripts\mp\bots\bots::create_smoke_occluder(position);
    }
  } else {
    self waittill("explode", position);
  }

  bundle = self.bundle;
  assert(isDefined(bundle), "<dev string:x1c>");
  thread smokegrenadeexplode(position, self.owner, bundle);
  thread sfx_smoke_grenade_smoke(position, bundle);

  if(isDefined(self) && isDefined(self.owner)) {
    self.owner thread monitorsmokeactive(bundle);
  }

  scripts\cp_mp\challenges::function_b0f754c8a379154e("equip_smoke", self.owner, undefined, function_e2ff8f4b4e94f723(#"hash_83a2d67994d7e295", #"use"));
}

function sfx_smoke_grenade_smoke(position, bundle) {
  wait 0.2;
  soundorg = spawn("script_origin", position);
  soundorg playLoopSound("smoke_grenade_smoke_lp");
  soundorg scripts\cp_mp\ent_manager::registerspawncount(1);
  waittime = bundle.smokeduration - 4;

  if(waittime > 0) {
    wait waittime;
  }

  thread play_sound_in_space("smoke_grenade_smoke_tail", position);
  wait 0.3;

  if(isDefined(soundorg)) {
    soundorg stoploopsound();
  }

  soundorg scripts\cp_mp\ent_manager::deregisterspawn();
  soundorg delete();
}

function private function_e4f6e856495dbafb(bundle) {
  self endon("explode");
  self endon("death");
  self waittill("missile_water_impact", impactdata);
  self notify("end_explode");
  thread function_9e58baa59719d027(bundle);
}

function private function_9e58baa59719d027(bundle) {
  self endon("explode");
  self endon("death");
  self waittill("missile_stuck", stuckdata);
  position = self.origin;
  thread smokegrenadeexplode(position, undefined, bundle);
  thread sfx_smoke_grenade_smoke(position, bundle);

  if(isDefined(self) && isDefined(self.owner)) {
    self.owner thread monitorsmokeactive(self.bundle);
  }
}

function smokegrenadeexplode(position, owner, bundle) {
  level endon("game_ended");
  smokedelay = isDefined(bundle) && isDefined(bundle.smokedelay) ? self.bundle.smokedelay : 1;
  smokeduration = isDefined(bundle) && isDefined(bundle.smokeduration) ? bundle.smokeduration : 9.25;
  smokeradius = isDefined(bundle) && isDefined(bundle.smokeradius) ? bundle.smokeradius : 330;
  wait smokedelay;
  thread smokegrenadegiveblindeye(position, owner, bundle);

  if(isDefined(bundle) && isDefined(bundle.smokeduration) && isDefined(bundle.smokedelay)) {
    params = spawnStruct();
    params.position = position;
    params.smokeradius = bundle.smokeradius;
    params.endtime = gettime() + (bundle.smokeduration - bundle.smokedelay) * 1000;
    level callback::callback("smoke_grenade_explode", params);
  }

  if(getdvarint(@ "hash_abe45e35ef030a56") == 1) {
    if(getdvarint(@ "mgl", 0)) {
      thread scripts\common\ai::mgladdactivesmoke(position, 1);
    } else {
      function_8a09c0e5fa78a48c(position, smokeduration, undefined, smokeradius);
    }
  }

  id = addoutlineoccluder(position, smokeradius);
  wait smokeduration - smokedelay;
  removeoutlineoccluder(id);
}

function smokeglvfx(position, normal) {
  playFX(getfx("glsmoke"), position, anglestoup((0, 90, 0)));
}

function smokegrenadegiveblindeye(position, owner, bundle) {
  level endon("game_ended");
  struct = spawnStruct();
  struct.blindeyerecipients = [];
  smokegrenademonitorblindeyerecipients(struct, position, owner, bundle);

  foreach(recipient in struct.blindeyerecipients) {
    if(isDefined(recipient) && isreallyalive(recipient) && recipient _hasperk("specialty_blindeye")) {
      recipient removeperk("specialty_blindeye");
      recipient removeperk("specialty_snapshot_counter_smoke");
      recipient callback::callback("smokeGrenade_playerRemoveBlindeye");
    }
  }
}

function smokegrenademonitorblindeyerecipients(struct, position, owner, bundle) {
  level endon("game_ended");
  smokedelay = 0;

  if(isDefined(bundle.smokedelay)) {
    smokedelay = bundle.smokedelay;
  }

  endtime = gettime() + (bundle.smokeduration - smokedelay) * 1000;

  if(isDefined(bundle) && isDefined(bundle.var_171f20a0968deed1)) {
    endtime += bundle.var_171f20a0968deed1 * 1000;
  }

  if(!isDefined(endtime)) {
    iprintlnbold("<dev string:x45>");

    return;
  }

  scoregiven = 0;
  players = [];

  while(gettime() < endtime) {
    players = getplayersinradius(position, bundle.smokeradius);

    if(!scoregiven) {
      if(isDefined(players) && players.size > 0) {
        if(isDefined(owner) && !array_contains(players, owner)) {
          owner namespace_a850435086c88de3::doonactionscoreevent(0, "smokeGrenadeBlinded");
          scoregiven = 1;
        }
      }
    }

    foreach(var_6758a6f2fd1b6491, recipient in struct.blindeyerecipients) {
      if(!isDefined(recipient)) {
        struct.blindeyerecipients[var_6758a6f2fd1b6491] = undefined;
        continue;
      }

      playersid = array_find(players, recipient);

      if((!isDefined(playersid) || !isreallyalive(recipient)) && recipient _hasperk("specialty_blindeye")) {
        recipient removeperk("specialty_blindeye");
        recipient removeperk("specialty_snapshot_counter_smoke");
        recipient callback::callback("smokeGrenade_playerRemoveBlindeye");
        struct.blindeyerecipients[var_6758a6f2fd1b6491] = undefined;
      }

      if(isDefined(playersid)) {
        players[playersid] = undefined;
      }
    }

    time_left = (endtime - gettime()) * 0.001;

    foreach(player in players) {
      if(!isDefined(player) || !isPlayer(player)) {
        continue;
      }

      player.lastinsmoketime = gettime();

      if(isDefined(struct.blindeyerecipients[player getentitynumber()])) {
        continue;
      }

      if(!isreallyalive(player)) {
        continue;
      }

      player giveperk("specialty_blindeye");
      player giveperk("specialty_snapshot_counter_smoke");
      params = {
        #time_left: time_left
      };
      player callback::callback("smokeGrenade_playerGiveBlindeye", params);
      struct.blindeyerecipients[player getentitynumber()] = player;
    }

    waitframe();
  }
}

function monitorsmokeactive(bundle) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("monitorSmokeActive()");
  self endon("monitorSmokeActive()");
  printgameaction("smoke grenade activated", self);
  self.hasactivesmokegrenade = 1;
  result = waittill_any_timeout_1(bundle.smokeduration, "death");
  self.hasactivesmokegrenade = 0;
  printgameaction("smoke grenade deactivated", self);
}