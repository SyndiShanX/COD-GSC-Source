/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\anim\combat_utility.gsc
***********************************************/

#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace combat_utility;

function shootuntilshootbehaviorchange() {}

function initgrenadethrowanims() {}

function throwgrenadeatplayerasap_combat_utility() {
  assert(self isbadguy());

  for(i = 0; i < level.players.size; i++) {
    if(level.players[i] function_4c108309dc0d7fd2() == 0) {
      function_b4ebe6632d7e8efe(level.players[i], "lethal", 0);
    }
  }

  function_98deae9464f6c005(1);

  enemies = getaiarray("<dev string:x1c>");

  if(enemies.size == 0) {
    return;
  }

  var_20d57e479df6089c = 0;

  for(i = 0; i < enemies.size; i++) {
    if(enemies[i].grenadeammo > 0) {
      return;
    }
  }

  println("<dev string:x28>");
}

function function_96d556dea441d1dc(grenadetimer) {
  if(grenadetimer.isplayertimer) {
    for(i = 0; i < level.players.size; i++) {
      if(level.players[i] == grenadetimer.player) {
        break;
      }
    }

    return ("<dev string:x7c>" + i + 1 + "<dev string:x87>" + grenadetimer.weapon.basename);
  }

  return "<dev string:x8c>" + grenadetimer.weapon.basename;
}

function trygrenadethrow(throwingat, destination, optionalanimation, armoffset, fastthrow, withbounce, var_973c51e9fd66d178) {}

function getgrenadedropvelocity() {
  yaw = randomfloat(360);
  pitch = randomfloatrange(30, 75);
  amntz = sin(pitch);
  cospitch = cos(pitch);
  amntx = cos(yaw) * cospitch;
  amnty = sin(yaw) * cospitch;
  speed = randomfloatrange(100, 200);
  velocity = (amntx, amnty, amntz) * speed;
  return velocity;
}

function dropgrenade() {
  if(isDefined(self.nodropgrenade)) {
    return;
  }

  grenadeorigin = self gettagorigin("tag_accessory_right");
  velocity = getgrenadedropvelocity();
  self magicgrenademanual(grenadeorigin, velocity, 3);
}

function getpitchtoshootspot(spot) {
  if(!isDefined(spot)) {
    return 0;
  }

  vectortoenemy = spot - self getshootatpos();
  vectortoenemy = vectorNormalize(vectortoenemy);
  pitchdelta = vectortoangles(vectortoenemy)[0];
  return angleclamp180(pitchdelta);
}

function watchreloading() {
  self.isreloading = 0;
  self.lastreloadstarttime = -1;

  while(true) {
    self waittill("reload_start");
    self.isreloading = 1;
    self.lastreloadstarttime = gettime();
    function_216c67ab6749137a(self, undefined, "reload");
    waittillreloadfinished();
    self.isreloading = 0;
  }
}

function waittillreloadfinished() {
  thread timednotify(4, "reloadtimeout");
  self endon("reloadtimeout");
  self endon("weapon_taken");

  while(true) {
    self waittill("reload");
    weap = self getcurrentweapon();

    if(isnullweapon(weap)) {
      break;
    }

    if(self getcurrentweaponclipammo() >= weaponclipsize(weap)) {
      break;
    }
  }

  self notify("reloadtimeout");
}

function timednotify(time, msg) {
  self endon(msg);
  wait time;
  self notify(msg);
}

function monitorflash() {
  self endon("death");

  if(!isDefined(level.neverstopmonitoringflash)) {
    self endon("stop_monitoring_flash");
  }

  while(true) {
    amount_distance = undefined;
    origin = undefined;
    amount_angle = undefined;
    attacker = undefined;
    attackerteam = undefined;
    self waittill("flashbang", origin, amount_distance, amount_angle, attacker, attackerteam, duration);

    if(isDefined(self.flashbangimmunity) && self.flashbangimmunity) {
      continue;
    }

    if(isDefined(self.script_immunetoflash) && self.script_immunetoflash != 0) {
      continue;
    }

    if(isDefined(self.team) && isDefined(attackerteam) && self.team == attackerteam) {
      amount_distance = 3 * (amount_distance - 0.75);

      if(amount_distance < 0) {
        continue;
      }

      if(isDefined(self.teamflashbangimmunity)) {
        continue;
      }
    }

    if(scripts\common\utility::function_ec40425fb125f6cf("flashbang", attackerteam)) {
      continue;
    }

    var_fbc487faa5bf1ff = 0.2;

    if(amount_distance > 1 - var_fbc487faa5bf1ff) {
      amount_distance = 1;
    } else {
      amount_distance /= 1 - var_fbc487faa5bf1ff;
    }

    if(!isDefined(duration)) {
      duration = 4.5;
    }

    duration *= amount_distance;

    if(duration < 0.25) {
      continue;
    }

    self.flashingteam = attackerteam;
    flashbangstart(duration);
    self notify("doFlashBanged", origin, attacker);
  }
}

function flashbangstart(duration) {
  assert(isDefined(self));
  assert(isDefined(duration));

  if(isDefined(self.flashbangimmunity) && self.flashbangimmunity) {
    return;
  }

  if(isDefined(self.syncedmeleetarget)) {
    return;
  }

  if(self isinscriptedstate() || scripts\asm\asm_bb::bb_isanimScripted()) {
    return;
  }

  if(!self.allowpain || !self.allowpain_internal) {
    return;
  }

  newflashendtime = gettime() + int(duration * 1000);

  if(isDefined(self.flashendtime)) {
    self.flashendtime = int(max(self.flashendtime, newflashendtime));
  } else {
    self.flashendtime = newflashendtime;

    if(isDefined(self.asm)) {
      scripts\asm\asm::asm_setstate("pain_flashed_transition");
    }
  }

  self notify("flashed");
}

function fasteranimspeed() {
  return 1.5;
}

function showgrenadetimers() {
  setdvarifuninitialized(@ "hash_b4fd9ea4f6486d24", "<dev string:x93>");
  huds = undefined;
  playerhuds = undefined;

  while(true) {
    if(getdvarint(@ "hash_b4fd9ea4f6486d24") == 0) {
      function_c0d677eae75ed3ea(huds);
      function_c0d677eae75ed3ea(playerhuds);
      huds = undefined;
      playerhuds = undefined;
      wait 0.2;
      continue;
    }

    if(!isDefined(huds)) {
      [huds, playerhuds] = function_96de23075e92ba2();
    }

    foreach(key, hud in huds) {
      hud.value = anim.meleechargetimers[key] - gettime();

      if(hud.value < 0) {
        continue;
      }

      hud setvalue(hud.value);
    }

    foreach(key, hud in playerhuds) {
      hud.value = anim.meleechargeplayertimers[key] - gettime();

      if(hud.value < 0) {
        continue;
      }

      hud setvalue(hud.value);
    }

    wait 0.05;
  }
}

function function_96de23075e92ba2() {
  huds = [];
  count = 0;

  foreach(key, item in anim.meleechargetimers) {
    hud = newhudelem();
    hud.x = 80;
    hud.y = 20 + count * 15;
    hud.label = "<dev string:x98>" + key + "<dev string:xa7>";
    hud setvalue(0);
    hud.value = 0;
    huds[key] = hud;
    count++;
  }

  count++;
  playerhuds = [];

  foreach(key, item in anim.meleechargeplayertimers) {
    hud = newhudelem();
    hud.x = 80;
    hud.y = 20 + count * 15;
    hud.label = "<dev string:xad>" + key + "<dev string:xa7>";
    hud setvalue(0);
    hud.value = 0;
    playerhuds[key] = hud;
    count++;
  }

  return [huds, playerhuds];
}

function function_c0d677eae75ed3ea(huds) {
  if(!isDefined(huds)) {
    return;
  }

  foreach(hud in huds) {
    hud destroy();
  }
}

# /