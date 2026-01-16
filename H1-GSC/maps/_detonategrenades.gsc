/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_detonategrenades.gsc
********************************/

init() {
  level._effect["c4_light_blink"] = loadfx("vfx\lights\light_c4_blink");
  level._effect["claymore_laser"] = loadfx("vfx\props\claymore_laser");

  for (var_0 = 0; var_0 < level.players.size; var_0++)
    level.players[var_0] thread watchgrenadeusage();
}

watchgrenadeusage() {
  level.c4explodethisframe = 0;
  self endon("death");
  self.c4array = [];
  self.throwinggrenade = 0;
  thread watchc4();
  thread watchc4detonation();
  thread watchclaymores();
  thread begin_semtex_grenade_tracking();
  thread begin_concussion_grenade_tracking();

  for (;;) {
    self waittill("grenade_pullback", var_0);
    self.throwinggrenade = 1;

    if(var_0 == "c4") {
      beginc4tracking();
      continue;
    }

    if(var_0 == "smoke_grenade_american") {
      beginsmokegrenadetracking();
      continue;
    }

    begingrenadetracking();
  }
}

beginsmokegrenadetracking() {
  self waittill("grenade_fire", var_0, var_1);

  if(!isdefined(level.smokegrenades))
    level.smokegrenades = 0;

  var_0 thread smoke_grenade_death();
}

beginflashgrenadetracking() {
  self.throwinggrenade = 0;
  var_0 = gettime();
  self waittill("grenade_fire", var_1, var_2);

  if(isdefined(var_1)) {
    var_3 = gettime();
    var_4 = var_3 - var_0;

    if(var_4 >= 1250) {
      var_1 waittill("explode", var_5);

      if(soundexists("null"))
        thread common_scripts\utility::play_sound_in_space("null", var_5);

      radiusdamage(var_5, 96, 300, 200, self, "MOD_UNKNOWN", "flash_grenade");
    }
  }
}

begin_semtex_grenade_tracking() {
  for (;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "semtex_grenade") {
      thread track_semtex_grenade(var_0);
      var_0 thread semtex_sticky_handle(self);
    }
  }
}

track_semtex_grenade(var_0) {
  self.throwinggrenade = 0;

  if(!isdefined(level.thrown_semtex_grenades))
    level.thrown_semtex_grenades = 1;
  else
    level.thrown_semtex_grenades++;

  var_0 waittill("death");
  waittillframeend;
  level.thrown_semtex_grenades--;
}

semtex_sticky_handle(var_0) {
  self waittill("missile_stuck", var_1);

  if(!isdefined(var_1)) {
    return;
  }
  if(var_1.code_classname != "script_vehicle") {
    return;
  }
  var_1.has_semtex_on_it = 1;
  self waittill("explode");

  if(!isdefined(var_1) || !isalive(var_1)) {
    return;
  }
  if(var_1 maps\_vehicle::is_godmode() || var_1 maps\_vehicle_code::attacker_isonmyteam(var_0)) {
    var_1.has_semtex_on_it = undefined;
    return;
  }

  var_1 kill(var_1.origin, var_0);
}

begin_concussion_grenade_tracking() {
  for (;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "concussion_grenade")
      thread track_concussion_grenade(var_0);
  }
}

track_concussion_grenade(var_0) {
  self.throwinggrenade = 0;
  var_0 waittill("death");
  maps\_utility::slowmo_setlerptime_in(0.1);
  maps\_utility::slowmo_setlerptime_out(0.25);
  maps\_utility::slowmo_setspeed_norm(1);
  maps\_utility::slowmo_setspeed_slow(0.25);
  maps\_utility::slowmo_lerp_in();
  setdvar("noflash", "1");
  wait 0.05;
  setdvar("noflash", "0");
  wait 2.0;
  maps\_utility::slowmo_lerp_out();
}

smoke_grenade_death() {
  level.smokegrenades++;
  wait 50;
  level.smokegrenades--;
}

begingrenadetracking() {
  self endon("death");
  self waittill("grenade_fire", var_0, var_1);

  if(var_1 == "fraggrenade")
    var_0 thread maps\_utility::grenade_earthquake();
  else if(var_1 == "ninebang_grenade")
    self.threw_ninebang = 1;

  self.throwinggrenade = 0;
}

beginc4tracking() {
  self endon("death");
  common_scripts\utility::waittill_any("grenade_fire", "weapon_change");
  self.throwinggrenade = 0;
}

watchc4() {
  for (;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "c4") {
      if(!self.c4array.size)
        thread watchc4altdetonate();

      self.c4array[self.c4array.size] = var_0;
      var_0.owner = self;
      var_0 thread c4damage();
      thread c4death(var_0);
      var_0 thread playc4effects();
    }
  }
}

c4death(var_0) {
  var_0 waittill("death");
  self.c4array = maps\_utility::array_remove_nokeys(self.c4array, var_0);
}

watchclaymores() {
  self endon("spawned_player");
  self endon("disconnect");

  for (;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(var_1 == "claymore" || var_1 == "claymore_mp") {
      var_0.owner = self;
      var_0 thread c4damage(1);
      var_0 thread claymoredetonation();
      var_0 thread playclaymoreeffects();
    }
  }
}

claymoremakesentient(var_0) {
  self endon("death");
  wait 1;

  if(isdefined(level.claymoresentientfunc)) {
    self thread[[level.claymoresentientfunc]](var_0);
    return;
  }

  self makeentitysentient(var_0, 1);
  self.attackeraccuracy = 2;
  self.maxvisibledist = 750;
  self.threatbias = -1000;
}

claymoredetonation() {
  self endon("death");
  self waittill("missile_stuck");
  var_0 = 192;

  if(isdefined(self.detonateradius))
    var_0 = self.detonateradius;

  var_1 = spawn("trigger_radius", self.origin + (0, 0, 0 - var_0), 9, var_0, var_0 * 2);
  thread deleteondeath(var_1);

  if(!isdefined(level.claymores))
    level.claymores = [];

  level.claymores = common_scripts\utility::array_add(level.claymores, self);

  if(!maps\_utility::is_specialop() && level.claymores.size > 15)
    level.claymores[0] delete();

  for (;;) {
    var_1 waittill("trigger", var_2);

    if(isdefined(self.owner) && var_2 == self.owner) {
      continue;
    }
    if(isplayer(var_2)) {
      continue;
    }
    if(var_2 damageconetrace(self.origin, self) > 0) {
      self playsound("claymore_activated_SP");
      wait 0.4;

      if(isdefined(self.owner))
        self detonate(self.owner);
      else
        self detonate(undefined);

      return;
    }
  }
}

deleteondeath(var_0) {
  self waittill("death");
  level.claymores = maps\_utility::array_remove_nokeys(level.claymores, self);
  wait 0.05;

  if(isdefined(var_0))
    var_0 delete();
}

watchc4detonation() {
  self endon("death");

  for (;;) {
    self waittill("detonate");
    var_0 = self getcurrentweapon();

    if(var_0 == "c4") {
      for (var_1 = 0; var_1 < self.c4array.size; var_1++) {
        if(isdefined(self.c4array[var_1]))
          self.c4array[var_1] thread waitanddetonate(0.1);
      }

      self.c4array = [];
    }
  }
}

watchc4altdetonation() {
  self endon("death");
  self endon("disconnect");

  for (;;) {
    self waittill("alt_detonate");
    var_0 = self getcurrentweapon();

    if(var_0 != "c4") {
      var_1 = [];

      for (var_2 = 0; var_2 < self.c4array.size; var_2++) {
        var_3 = self.c4array[var_2];

        if(isdefined(self.c4array[var_2]))
          var_3 thread waitanddetonate(0.1);
      }

      self.c4array = var_1;
      self notify("detonated");
    }
  }
}

waitanddetonate(var_0) {
  self endon("death");
  wait(var_0);
  self detonate();
}

c4damage(var_0) {
  self.health = 100;
  self setcandamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  var_1 = undefined;

  for (;;) {
    self waittill("damage", var_2, var_1);
    break;
  }

  self playsound("claymore_activated_SP");

  if(level.c4explodethisframe)
    wait(0.1 + randomfloat(0.4));
  else
    wait 0.05;

  if(!isdefined(self)) {
    return;
  }
  level.c4explodethisframe = 1;

  if(isdefined(var_0) && var_0 && isplayer(var_1))
    level.claymoreexplodethisframe_byplayer = 1;

  thread resetc4explodethisframe();

  if(isplayer(var_1))
    self detonate(var_1);
  else
    self detonate();
}

resetc4explodethisframe() {
  wait 0.05;
  level.c4explodethisframe = 0;
  level.claymoreexplodethisframe_byplayer = 0;
}

saydamaged(var_0, var_1) {
  for (var_2 = 0; var_2 < 60; var_2++)
    wait 0.05;
}

playc4effects() {
  self endon("death");
  self waittill("missile_stuck");
  playfxontag(common_scripts\utility::getfx("c4_light_blink"), self, "tag_fx");
}

playclaymoreeffects() {
  self endon("death");
  self waittill("missile_stuck");
  playfxontag(common_scripts\utility::getfx("claymore_laser"), self, "tag_fx");
}

clearfxondeath(var_0) {
  self waittill("death");
  var_0 delete();
}

getdamageableents(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(!isdefined(var_2))
    var_2 = 0;

  if(!isdefined(var_3))
    var_3 = 0;

  for (var_5 = 0; var_5 < level.players.size; var_5++) {
    if(!isalive(level.players[var_5]) || level.players[var_5].sessionstate != "playing") {
      continue;
    }
    var_6 = level.players[var_5].origin + (0, 0, 32);
    var_7 = distance(var_0, var_6);

    if(var_7 < var_1 && (!var_2 || weapondamagetracepassed(var_0, var_6, var_3, undefined))) {
      var_8 = spawnstruct();
      var_8.isplayer = 1;
      var_8.isadestructable = 0;
      var_8.entity = level.players[var_5];
      var_8.damagecenter = var_6;
      var_4[var_4.size] = var_8;
    }
  }

  var_9 = getentarray("grenade", "classname");

  for (var_5 = 0; var_5 < var_9.size; var_5++) {
    var_10 = var_9[var_5].origin;
    var_7 = distance(var_0, var_10);

    if(var_7 < var_1 && (!var_2 || weapondamagetracepassed(var_0, var_10, var_3, var_9[var_5]))) {
      var_8 = spawnstruct();
      var_8.isplayer = 0;
      var_8.isadestructable = 0;
      var_8.entity = var_9[var_5];
      var_8.damagecenter = var_10;
      var_4[var_4.size] = var_8;
    }
  }

  var_11 = getentarray("destructable", "targetname");

  for (var_5 = 0; var_5 < var_11.size; var_5++) {
    var_10 = var_11[var_5].origin;
    var_7 = distance(var_0, var_10);

    if(var_7 < var_1 && (!var_2 || weapondamagetracepassed(var_0, var_10, var_3, var_11[var_5]))) {
      var_8 = spawnstruct();
      var_8.isplayer = 0;
      var_8.isadestructable = 1;
      var_8.entity = var_11[var_5];
      var_8.damagecenter = var_10;
      var_4[var_4.size] = var_8;
    }
  }

  return var_4;
}

weapondamagetracepassed(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = var_1 - var_0;

  if(lengthsquared(var_5) < var_2 * var_2)
    var_4 = var_1;

  var_6 = vectornormalize(var_5);
  var_4 = var_0 + (var_6[0] * var_2, var_6[1] * var_2, var_6[2] * var_2);
  var_7 = bullettrace(var_4, var_1, 0, var_3);

  if(getdvarint("scr_damage_debug") != 0) {
    if(var_7["fraction"] == 1)
      thread debugline(var_4, var_1, (1, 1, 1));
    else {
      thread debugline(var_4, var_7["position"], (1, 0.9, 0.8));
      thread debugline(var_7["position"], var_1, (1, 0.4, 0.3));
    }
  }

  return var_7["fraction"] == 1;
}

damageent(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(self.isplayer) {
    self.damageorigin = var_5;
    self.entity thread[[level.callbackplayerdamage]](var_0, var_1, var_2, 0, var_3, var_4, var_5, var_6, "none", 0);
  } else {
    if(self.isadestructable && (var_4 == "artillery_mp" || var_4 == "claymore_mp")) {
      return;
    }
    self.entity notify("damage", var_2, var_1);
  }
}

debugline(var_0, var_1, var_2) {
  for (var_3 = 0; var_3 < 600; var_3++)
    wait 0.05;
}

onweapondamage(var_0, var_1, var_2, var_3) {
  self endon("death");

  switch (var_1) {
    case "concussion_grenade_mp":
      var_4 = 512;
      var_5 = 1 - distance(self.origin, var_0.origin) / var_4;
      var_6 = 1 + 4 * var_5;
      wait 0.05;
      self shellshock("concussion_grenade_mp", var_6);
      break;
    default:
      break;
  }
}

watchc4altdetonate() {
  self endon("death");
  self endon("disconnect");
  self endon("detonated");
  level endon("game_ended");
  var_0 = 0;

  for (;;) {
    if(self usebuttonpressed()) {
      var_0 = 0;

      while (self usebuttonpressed()) {
        var_0 = var_0 + 0.05;
        wait 0.05;
      }

      if(var_0 >= 0.5) {
        continue;
      }
      var_0 = 0;

      while (!self usebuttonpressed() && var_0 < 0.5) {
        var_0 = var_0 + 0.05;
        wait 0.05;
      }

      if(var_0 >= 0.5) {
        continue;
      }
      if(!self.c4array.size) {
        return;
      }
      self notify("alt_detonate");
    }

    wait 0.05;
  }
}