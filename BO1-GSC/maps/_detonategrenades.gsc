/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_detonategrenades.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;

init() {
  level._effect["claymore_laser"] = loadfx("weapon/claymore/fx_claymore_laser");
}

watchGrenadeUsage() {
  level.satchelexplodethisframe = false;
  self endon("death");
  self.satchelarray = [];
  self.claymore_array = [];
  self.throwingGrenade = false;
  self.gotPullbackNotify = false;
  thread watch_satchel();
  thread watch_satchel_detonation();
  thread watch_claymores();
  self thread watch_for_throwbacks();
  for(;;) {
    self waittill("grenade_pullback", weaponName);
    self.throwingGrenade = true;
    self.gotPullbackNotify = true;
    switch (weaponName) {
      case "willy_pete_sp":
        break;
      default:
        self begin_grenade_tracking();
        break;
    }
  }
}

begin_smoke_grenade_tracking() {
  self waittill("grenade_fire", grenade, weaponName);
  if(!isDefined(level.smokegrenades))
    level.smokegrenades = 0;
  if(level.smokegrenades > 2 && getDvar(#"player_sustainAmmo") != "0")
    grenade delete();
  else
    grenade thread smoke_grenade_death();
}

begin_mortar_tracking() {
  self endon("death");
  self endon("disconnect");
  self waittill("grenade_fire", mortar, weaponName);
  if(weaponName == "mortar_round") {
    mortar thread mortar_death();
  }
}

mortar_death() {
  self waittill_not_moving();
  earthquake(.55, 3, self.origin, 1500);
  PlayRumbleOnPosition("explosion_generic", self.origin);
}

smoke_grenade_death() {
  level.smokegrenades++;
  wait 50;
  level.smokegrenades--;
}

begin_grenade_tracking() {
  self endon("death");
  self waittill("grenade_fire", grenade, weaponName);
  self maps\_dds::dds_notify_grenade(weaponName, (self.team == "allies"), false);
  self.throwingGrenade = false;
}

watch_for_throwbacks() {
  self endon("death");
  self endon("disconnect");
  for(;;) {
    self waittill("grenade_fire", grenade, weapname);
    if(self.gotPullbackNotify) {
      self.gotPullbackNotify = false;
      continue;
    }
    if(!isSubStr(weapname, "frag"))
      continue;
    grenade.threwBack = true;
    self maps\_dds::dds_notify_grenade(weapname, (self.team == "allies"), true);
  }
}

begin_satchel_tracking() {
  self endon("death");
  self waittill_any("grenade_fire", "weapon_change");
  self.throwingGrenade = false;
}

watch_satchel() {
  while(1) {
    self waittill("grenade_fire", satchel, weapname);
    if(weapname == "satchel_charge_mp" || weapname == "satchel_charge_new" || weapname == "satchel_charge_sp") {
      self.satchelarray[self.satchelarray.size] = satchel;
      satchel.owner = self;
      satchel thread satchel_damage();
    }
  }
}

watch_claymores() {
  self endon("spawned_player");
  self endon("disconnect");
  while(1) {
    self waittill("grenade_fire", claymore, weapname);
    if(weapname == "claymore_sp") {
      claymore.owner = self;
      claymore thread satchel_damage();
      claymore thread claymore_detonation();
      claymore thread play_claymore_effects();
    }
  }
}

claymore_detonation() {
  self endon("death");
  self waittill_not_moving();
  detonateRadius = 192;
  spawnFlag = 1;
  playerTeamToAllow = "axis";
  if(isDefined(self.owner) && isDefined(self.owner.pers["team"]) && self.owner.pers["team"] == "axis") {
    spawnFlag = 2;
    playerTeamToAllow = "allies";
  }
  damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - detonateRadius), spawnFlag, detonateRadius, detonateRadius * 2);
  self thread delete_claymores_on_death(damagearea);
  if(!isDefined(level.claymores))
    level.claymores = [];
  level.claymores = array_add(level.claymores, self);
  if(level.claymores.size > 15 && getDvar(#"player_sustainAmmo") != "0")
    level.claymores[0] delete();
  while(1) {
    damagearea waittill("trigger", ent);
    if(isDefined(self.owner) && ent == self.owner)
      continue;
    if(isDefined(ent.pers) && isDefined(ent.pers["team"]) && ent.pers["team"] != playerTeamToAllow)
      continue;
    if(ent damageConeTrace(self.origin, self) > 0) {
      self playsound("claymore_activated_SP");
      wait 0.4;
      if(isDefined(self.owner))
        self detonate(self.owner);
      else
        self detonate(undefined);
      return;
    }
  }
}

delete_claymores_on_death(ent) {
  self waittill("death");
  level.claymores = array_remove_nokeys(level.claymores, self);
  wait .05;
  if(isDefined(ent))
    ent delete();
}

watch_satchel_detonation() {
  self endon("death");
  while(1) {
    self waittill("detonate");
    weap = self GetCurrentWeapon();
    if(weap == "satchel_charge_sp" || weap == "ied_sp") {
      note = weap + "_detonated";
      self notify(note);
      for(i = 0; i < self.satchelarray.size; i++) {
        if(isDefined(self.satchelarray[i]))
          self.satchelarray[i] thread wait_and_detonate(0.1);
      }
      self.satchelarray = [];
    }
  }
}

wait_and_detonate(delay) {
  self endon("death");
  wait delay;
  earthquake(.35, 3, self.origin, 1500);
  self detonate();
  self delete();
}

satchel_damage() {
  self.health = 100;
  self setcandamage(true);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;
  while(1) {
    self waittill("damage", amount, attacker);
    if(!isplayer(attacker))
      continue;
    break;
  }
  if(level.satchelexplodethisframe)
    wait .1 + randomfloat(.4);
  else
    wait .05;
  if(!isDefined(self))
    return;
  level.satchelexplodethisframe = true;
  thread reset_satchel_explode_this_frame();
  self detonate(attacker);
}

reset_satchel_explode_this_frame() {
  wait .05;
  level.satchelexplodethisframe = false;
}

saydamaged(orig, amount) {
  for(i = 0; i < 60; i++) {
    print3d(orig, "damaged! " + amount);
    wait .05;
  }
}

play_claymore_effects() {
  self endon("death");
  self waittill_not_moving();
  PlayFXOnTag(level._effect["claymore_laser"], self, "tag_fx");
}

getDamageableEnts(pos, radius, doLOS, startRadius) {
  ents = [];
  if(!isDefined(doLOS))
    doLOS = false;
  if(!isDefined(startRadius))
    startRadius = 0;
  players = get_players();
  for(i = 0; i < players.size; i++) {
    if(!isalive(players[i]) || players[i].sessionstate != "playing")
      continue;
    playerpos = players[i].origin + (0, 0, 32);
    dist = distance(pos, playerpos);
    if(dist < radius && (!doLOS || weaponDamageTracePassed(pos, playerpos, startRadius, undefined))) {
      newent = spawnstruct();
      newent.isPlayer = true;
      newent.isADestructable = false;
      newent.entity = players[i];
      newent.damageCenter = playerpos;
      ents[ents.size] = newent;
    }
  }
  grenades = getentarray("grenade", "classname");
  for(i = 0; i < grenades.size; i++) {
    entpos = grenades[i].origin;
    dist = distance(pos, entpos);
    if(dist < radius && (!doLOS || weaponDamageTracePassed(pos, entpos, startRadius, grenades[i]))) {
      newent = spawnstruct();
      newent.isPlayer = false;
      newent.isADestructable = false;
      newent.entity = grenades[i];
      newent.damageCenter = entpos;
      ents[ents.size] = newent;
    }
  }
  destructables = getentarray("destructable", "targetname");
  for(i = 0; i < destructables.size; i++) {
    entpos = destructables[i].origin;
    dist = distance(pos, entpos);
    if(dist < radius && (!doLOS || weaponDamageTracePassed(pos, entpos, startRadius, destructables[i]))) {
      newent = spawnstruct();
      newent.isPlayer = false;
      newent.isADestructable = true;
      newent.entity = destructables[i];
      newent.damageCenter = entpos;
      ents[ents.size] = newent;
    }
  }
  return ents;
}

weaponDamageTracePassed(from, to, startRadius, ignore) {
  midpos = undefined;
  diff = to - from;
  if(lengthsquared(diff) < startRadius * startRadius)
    midpos = to;
  dir = vectornormalize(diff);
  midpos = from + (dir[0] * startRadius, dir[1] * startRadius, dir[2] * startRadius);
  trace = bullettrace(midpos, to, false, ignore);
  if(GetDvarInt(#"scr_damage_debug") != 0) {
    if(trace["fraction"] == 1) {
      thread debugline(midpos, to, (1, 1, 1));
    } else {
      thread debugline(midpos, trace["position"], (1, .9, .8));
      thread debugline(trace["position"], to, (1, .4, .3));
    }
  }
  return (trace["fraction"] == 1);
}

damageEnt(eInflictor, eAttacker, iDamage, sMeansOfDeath, sWeapon, damagepos, damagedir) {
  if(self.isPlayer) {
    self.damageOrigin = damagepos;
    self.entity thread[[level.callbackPlayerDamage]](
      eInflictor,
      eAttacker,
      iDamage,
      0,
      sMeansOfDeath,
      sWeapon,
      damagepos,
      damagedir,
      "none",
      0
    );
  } else {
    if(self.isADestructable && (sWeapon == "artillery_mp" || sWeapon == "claymore_mp"))
      return;
    self.entity damage_notify_wrapper(iDamage, eAttacker);
  }
}

debugline(a, b, color) {
  for(i = 0; i < 30 * 20; i++) {
    line(a, b, color);
    wait .05;
  }
}

onWeaponDamage(eInflictor, sWeapon, meansOfDeath, damage) {
  self endon("death");
  switch (sWeapon) {
    case "concussion_grenade_mp":
      radius = 512;
      scale = 1 - (distance(self.origin, eInflictor.origin) / radius);
      time = 1 + (4 * scale);
      wait(0.05);
      self shellShock("concussion_grenade_mp", time);
      break;
    default:
      break;
  }
}