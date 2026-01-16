/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_detonategrenades.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_dds;

init() {
  level._effect["claymore_laser"] = loadfx("weapon/claymore/fx_claymore_laser");
  level._effect["prox_grenade_fx"] = loadfx("weapon/grenade/fx_prox_grenade_scan_grn");
  level._effect["prox_grenade_shock"] = loadfx("weapon/grenade/fx_prox_grenade_impact_player_spwner");
}

watchgrenadeusage() {
  level.satchelexplodethisframe = 0;
  self endon("death");
  self.satchelarray = [];
  self.claymore_array = [];
  self.throwinggrenade = 0;
  self.gotpullbacknotify = 0;
  self thread watch_concussion();
  thread watch_satchel();
  thread watch_satchel_detonation();
  thread watch_claymores();
  thread watch_proximity_grenade();
  thread watch_combat_axe();
  self thread watch_for_throwbacks();

  for(;;) {
    self waittill("grenade_pullback", weaponname);
    self.throwinggrenade = 1;
    self.gotpullbacknotify = 1;

    switch (weaponname) {
      case "willy_pete_80s_sp":
      case "willy_pete_sp":
        break;
      default:
        self begin_grenade_tracking();
        break;
    }
  }
}

begin_smoke_grenade_tracking() {
  self waittill("grenade_fire", grenade, weaponname);

  if(!isDefined(level.smokegrenades))
    level.smokegrenades = 0;

  if(level.smokegrenades > 2 && getdvar(#"player_sustainAmmo") != "0")
    grenade delete();
  else
    grenade thread smoke_grenade_death();
}

begin_mortar_tracking() {
  self endon("death");
  self endon("disconnect");
  self waittill("grenade_fire", mortar, weaponname);

  if(weaponname == "mortar_round")
    mortar thread mortar_death();
}

mortar_death() {
  self waittill_not_moving();
  earthquake(0.55, 3, self.origin, 1500);
  playrumbleonposition("explosion_generic", self.origin);
}

smoke_grenade_death() {
  level.smokegrenades++;
  wait 50;
  level.smokegrenades--;
}

begin_grenade_tracking() {
  self endon("death");
  self waittill("grenade_fire", grenade, weaponname);
  self maps\_dds::dds_notify_grenade(weaponname, self.team == "allies", 0);
  self.throwinggrenade = 0;
}

watch_for_throwbacks() {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("grenade_fire", grenade, weapname);

    if(self.gotpullbacknotify) {
      self.gotpullbacknotify = 0;
      continue;
    }

    if(!issubstr(weapname, "frag")) {
      continue;
    }
    grenade.threwback = 1;
    self maps\_dds::dds_notify_grenade(weapname, self.team == "allies", 1);
  }
}

begin_satchel_tracking() {
  self endon("death");
  self waittill_any("grenade_fire", "weapon_change");
  self.throwinggrenade = 0;
}

watch_satchel() {
  while(true) {
    self waittill("grenade_fire", satchel, weapname);

    if(weapname == "satchel_charge_mp" || weapname == "satchel_charge_new" || weapname == "satchel_charge_sp" || weapname == "satchel_charge_80s_sp") {
      if(self.satchelarray.size >= 5) {
        newarray = [];

        for(i = 0; i < self.satchelarray.size; i++) {
          if(isDefined(self.satchelarray[i]))
            newarray[newarray.size] = self.satchelarray[i];
        }

        self.satchelarray = newarray;

        for(i = 0; i < self.satchelarray.size - 5 + 1; i++)
          self.satchelarray[i] delete();

        newarray = [];

        for(i = 0; i < 4; i++)
          newarray[i] = self.satchelarray[self.satchelarray.size - 5 + 1 + i];

        self.satchelarray = newarray;
      }

      self.satchelarray[self.satchelarray.size] = satchel;
      satchel.owner = self;
      satchel thread satchel_damage();
    }
  }
}

watch_claymores() {
  self endon("spawned_player");
  self endon("disconnect");

  while(true) {
    self waittill("grenade_fire", placed_explosive, weapname);

    if(weapname == "claymore_sp" || weapname == "claymore_80s_sp") {
      placed_explosive.owner = self;
      placed_explosive thread satchel_damage();
      placed_explosive thread claymore_detonation();
      placed_explosive thread play_claymore_effects();
    } else if(weapname == "tc6_mine_sp") {
      placed_explosive.owner = self;
      placed_explosive thread satchel_damage();
      placed_explosive thread tc6_mine_detonation();
    }
  }
}

tc6_mine_detonation() {
  self endon("death");
  waittill_not_moving();
  should_detonate = 0;
  damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - 25), 23, 25, 100);
  ai_damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - 36), 3, 36, 36 * 2);
  wait 0.5;
  self playsound("wpn_claymore_alert");
  wait 0.2;

  while(true) {
    damagearea waittill("trigger", ent);

    if(isDefined(ent.classname) && ent.classname == "script_vehicle" && (ent.vehicleclass == "4 wheel" || ent.vehicleclass == "tank")) {
      if(lengthsquared(ent getvelocity()) > 9) {
        should_detonate = 1;
        wait 0.25;
      }
    } else {
      while(ent istouching(damagearea) && !ent istouching(ai_damagearea))
        wait 0.05;

      if(ent istouching(ai_damagearea))
        should_detonate = 1;
    }

    if(should_detonate) {
      if(isDefined(self.owner))
        self detonate(self.owner);
      else
        self detonate(undefined);

      damagearea delete();
      ai_damagearea delete();
      return;
    }
  }
}

claymore_detonation() {
  self endon("death");
  self waittill_not_moving();
  spawnflag = 17;
  playerteamtoallow = "axis";

  if(isDefined(self.owner) && isDefined(self.owner.pers["team"]) && self.owner.pers["team"] == "axis") {
    spawnflag = 18;
    playerteamtoallow = "allies";
  }

  damagearea = spawn("trigger_radius", self.origin + (0, 0, 0 - 192), spawnflag, 192, 192 * 2);
  self thread delete_claymores_on_death(damagearea);

  if(!isDefined(level.claymores))
    level.claymores = [];

  level.claymores[level.claymores.size] = self;

  if(level.claymores.size > 5)
    level.claymores[0] delete();

  while(true) {
    damagearea waittill("trigger", ent);

    if(isDefined(self.owner) && ent == self.owner) {
      continue;
    }
    if(ent isvehicle() && (isDefined(ent getteam()) && ent getteam() != playerteamtoallow)) {
      continue;
    }
    if(isDefined(ent.pers) && isDefined(ent.pers["team"]) && ent.pers["team"] != playerteamtoallow) {
      continue;
    }
    if(ent damageconetrace(self.origin, self) > 0) {
      self playsound("wpn_claymore_alert");
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
  arrayremovevalue(level.claymores, self);
  wait 0.05;

  if(isDefined(ent))
    ent delete();
}

watch_satchel_detonation() {
  self endon("death");

  while(true) {
    self waittill("detonate");
    weap = self getcurrentweapon();
    note = weap + "_detonated";
    self notify(note);

    for(i = 0; i < self.satchelarray.size; i++) {
      if(isDefined(self.satchelarray[i]))
        self.satchelarray[i] thread wait_and_detonate(0.1);
    }

    self.satchelarray = [];
  }
}

wait_and_detonate(delay) {
  self endon("death");
  wait(delay);
  earthquake(0.35, 3, self.origin, 1500);
  self detonate();
  self delete();
}

satchel_damage() {
  self.health = 100;
  self setcandamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  attacker = undefined;

  while(true) {
    self waittill("damage", amount, attacker);

    if(!isplayer(attacker)) {
      continue;
    }
    break;
  }

  if(level.satchelexplodethisframe)
    wait(0.1 + randomfloat(0.4));
  else
    wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  level.satchelexplodethisframe = 1;
  thread reset_satchel_explode_this_frame();
  self detonate(attacker);
}

reset_satchel_explode_this_frame() {
  wait 0.05;
  level.satchelexplodethisframe = 0;
}

saydamaged(orig, amount) {
  for(i = 0; i < 60; i++) {
    print3d(orig, "damaged! " + amount);
    wait 0.05;
  }

}

play_claymore_effects() {
  self endon("death");
  self waittill_not_moving();
  playfxontag(level._effect["claymore_laser"], self, "tag_fx");
}

getdamageableents(pos, radius, dolos, startradius) {
  ents = [];

  if(!isDefined(dolos))
    dolos = 0;

  if(!isDefined(startradius))
    startradius = 0;

  players = get_players();

  for(i = 0; i < players.size; i++) {
    if(!isalive(players[i]) || players[i].sessionstate != "playing") {
      continue;
    }
    playerpos = players[i].origin + vectorscale((0, 0, 1), 32.0);
    distsq = distancesquared(pos, playerpos);

    if(distsq < radius * radius && (!dolos || weapondamagetracepassed(pos, playerpos, startradius, undefined))) {
      newent = spawnstruct();
      newent.isplayer = 1;
      newent.isadestructable = 0;
      newent.entity = players[i];
      newent.damagecenter = playerpos;
      ents[ents.size] = newent;
    }
  }

  grenades = getentarray("grenade", "classname");

  for(i = 0; i < grenades.size; i++) {
    entpos = grenades[i].origin;
    distsq = distancesquared(pos, entpos);

    if(distsq < radius * radius && (!dolos || weapondamagetracepassed(pos, entpos, startradius, grenades[i]))) {
      newent = spawnstruct();
      newent.isplayer = 0;
      newent.isadestructable = 0;
      newent.entity = grenades[i];
      newent.damagecenter = entpos;
      ents[ents.size] = newent;
    }
  }

  destructables = getentarray("destructable", "targetname");

  for(i = 0; i < destructables.size; i++) {
    entpos = destructables[i].origin;
    distsq = distancesquared(pos, entpos);

    if(distsq < radius * radius && (!dolos || weapondamagetracepassed(pos, entpos, startradius, destructables[i]))) {
      newent = spawnstruct();
      newent.isplayer = 0;
      newent.isadestructable = 1;
      newent.entity = destructables[i];
      newent.damagecenter = entpos;
      ents[ents.size] = newent;
    }
  }

  return ents;
}

weapondamagetracepassed(from, to, startradius, ignore) {
  midpos = undefined;
  diff = to - from;

  if(lengthsquared(diff) < startradius * startradius)
    midpos = to;

  dir = vectornormalize(diff);
  midpos = from + (dir[0] * startradius, dir[1] * startradius, dir[2] * startradius);
  trace = bullettrace(midpos, to, 0, ignore);

  if(getdvarint(#"_id_0A1C40B1") != 0) {
    if(trace["fraction"] == 1)
      thread debugline(midpos, to, (1, 1, 1));
    else {
      thread debugline(midpos, trace["position"], (1, 0.9, 0.8));
      thread debugline(trace["position"], to, (1, 0.4, 0.3));
    }
  }

  return trace["fraction"] == 1;
}

damageent(einflictor, eattacker, idamage, smeansofdeath, sweapon, damagepos, damagedir) {
  if(self.isplayer) {
    self.damageorigin = damagepos;
    self.entity thread[[level.callbackplayerdamage]](einflictor, eattacker, idamage, 0, smeansofdeath, sweapon, damagepos, damagedir, "none", 0);
  } else {
    if(self.isadestructable && (sweapon == "artillery_mp" || sweapon == "claymore_mp")) {
      return;
    }
    self.entity damage_notify_wrapper(idamage, eattacker);
  }
}

debugline(a, b, color) {
  for(i = 0; i < 600; i++) {
    line(a, b, color);
    wait 0.05;
  }

}

watch_concussion() {
  self endon("death");

  while(true)
    self waittill("grenade_fire", grenade, weapname);
}

watch_proximity_grenade() {
  self endon("spawned_player");
  self endon("disconnect");

  while(true) {
    self waittill("grenade_fire", grenade, weapname);

    if(weapname == "proximity_grenade_sp") {
      grenade thread proximity_grenade_damage();
      grenade thread proximity_grenade_detonation();
      grenade thread proximity_grenade_fx();
    }
  }
}

proximity_grenade_damage() {
  self endon("death");
  self.health = 100;
  self setcandamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;

  do
    self waittill("damage", undefined, attacker);
  while(!isplayer(attacker));

  level thread proximity_grenade_detonate_think(self.origin);
  self detonate(attacker);
}

proximity_grenade_fx() {
  self endon("death");
  self waittill_not_moving();
  playfxontag(level._effect["prox_grenade_fx"], self, "tag_fx");
}

proximity_grenade_detonation() {
  self endon("death");
  self waittill_not_moving();
  wait 0.5;
  spawnflag = 17;
  playerteamtoallow = "axis";

  if(isDefined(self.owner) && isDefined(self.owner.pers["team"]) && self.owner.pers["team"] == "axis") {
    spawnflag = 18;
    playerteamtoallow = "allies";
  }

  t_damage_area = spawn("trigger_radius", self.origin + vectorscale((0, 0, -1), 192.0), spawnflag, 192, 384);
  self thread proximity_grenade_delete_on_death(t_damage_area);

  if(!isDefined(level.a_proximity_grenades))
    level.a_proximity_grenades = [];

  level.a_proximity_grenades[level.a_proximity_grenades.size] = self;

  if(level.a_proximity_grenades.size > 5)
    level.a_proximity_grenades[0] delete();

  while(true) {
    t_damage_area waittill("trigger", ent);

    if(isDefined(self.owner) && ent == self.owner) {
      continue;
    }
    if(ent isvehicle()) {
      continue;
    }
    if(isDefined(ent.pers) && isDefined(ent.pers["team"]) && ent.pers["team"] != playerteamtoallow) {
      continue;
    }
    level thread proximity_grenade_detonate_think(self.origin);

    if(isDefined(self.owner))
      self detonate(self.owner);
    else
      self detonate(undefined);

    return;
  }
}

proximity_grenade_detonate_think(v_origin) {
  if(distance2d(level.player.origin, v_origin) < 300)
    level.player thread proximity_grenade_player_effect(v_origin);
}

proximity_grenade_delete_on_death(t_radius) {
  self waittill("death");
  arrayremovevalue(level.a_proximity_grenades, self);
  wait 0.05;

  if(isDefined(t_radius))
    t_radius delete();
}

proximity_grenade_player_effect(v_origin) {
  self endon("death");
  n_period = 0.03;
  n_duration = 1.25;
  n_start_time = gettime();
  saved_vision = self getvisionsetnaked();
  toggle = 1;
  self playsound("wpn_taser_mine_zap");
  self shellshock("death", n_duration + 0.5);
  n_duration_ms = n_duration * 1000;
  wait 0.1;

  while(true) {
    if(gettime() > n_start_time + n_duration_ms) {
      break;
    }

    if(toggle) {
      self visionsetnaked("taser_mine_shock", 0);
      self dodamage(5, v_origin, level.player);
      self playrumbleonentity("damage_light");
    } else
      self visionsetnaked(saved_vision, 0);

    toggle = !toggle;
    wait(n_period);
  }

  self visionsetnaked(saved_vision, 0);
}

watch_combat_axe() {
  while(true) {
    self waittill("grenade_fire", grenade, weapname);

    if(weapname == "hatchet_sp" || weapname == "hatchet_80s_sp") {
      if(!isDefined(level.a_combat_axes))
        level.a_combat_axes = [];

      level.a_combat_axes[level.a_combat_axes.size] = grenade;

      if(level.a_combat_axes.size > 5) {
        level.a_combat_axes[0] delete();
        arrayremoveindex(level.a_combat_axes, 0);
      }
    }
  }
}