/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_vehicle_missile.gsc
********************************/

main() {
  if(getdvar("cobrapilot_surface_to_air_missiles_enabled") == "")
    setdvar("cobrapilot_surface_to_air_missiles_enabled", "1");

  tryreload();
  thread firemissile();
  thread turret_think();
  thread detachall_on_death();
}

detachall_on_death() {
  self waittill("death");
  self detachall();
}

turret_think() {
  self endon("death");

  if(!isdefined(self.script_turret)) {
    return;
  }
  if(self.script_turret == 0) {
    return;
  }
  self.attackradius = 30000;

  if(isdefined(self.radius))
    self.attackradius = self.radius;

  while (!isdefined(level.cobrapilot_difficulty))
    wait 0.05;

  var_0 = 1.0;

  if(level.cobrapilot_difficulty == "easy")
    var_0 = 0.5;
  else if(level.cobrapilot_difficulty == "medium")
    var_0 = 1.7;
  else if(level.cobrapilot_difficulty == "hard")
    var_0 = 1.0;
  else if(level.cobrapilot_difficulty == "insane")
    var_0 = 1.5;

  self.attackradius = self.attackradius * var_0;

  if(getdvar("cobrapilot_debug") == "1")
    iprintln("surface-to-air missile range difficultyScaler = " + var_0);

  for (;;) {
    wait(2 + randomfloat(1));
    var_1 = undefined;
    var_1 = maps\_helicopter_globals::getenemytarget(self.attackradius, undefined, 0, 1);

    if(!isdefined(var_1)) {
      continue;
    }
    var_2 = var_1.origin;

    if(isdefined(var_1.script_targetoffset_z))
      var_2 = var_2 + (0, 0, var_1.script_targetoffset_z);

    self setturrettargetvec(var_2);
    level thread turret_rotate_timeout(self, 5.0);
    self waittill("turret_rotate_stopped");
    self clearturrettarget();

    if(distance(self.origin, var_1.origin) > self.attackradius) {
      continue;
    }
    var_3 = 0;
    var_3 = sighttracepassed(self.origin, var_1.origin + (0, 0, 150), 0, self);

    if(!var_3) {
      continue;
    }
    if(getdvar("cobrapilot_surface_to_air_missiles_enabled") == "1") {
      self notify("shoot_target", var_1);
      self waittill("missile_fired", var_4);

      if(isdefined(var_4)) {
        if(level.cobrapilot_difficulty == "hard") {
          wait(1 + randomfloat(2));
          continue;
        } else if(level.cobrapilot_difficulty == "insane")
          continue;
        else
          var_4 waittill("death");
      }

      continue;
    }
  }
}

turret_rotate_timeout(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("turret_rotate_stopped");
  wait(var_1);
  var_0 notify("turret_rotate_stopped");
}

within_attack_range(var_0) {
  var_1 = distance((self.origin[0], self.origin[1], 0), (var_0.origin[0], var_0.origin[1], 0));
  var_2 = var_0.origin[2] - self.origin[2];

  if(var_2 <= 750)
    return 0;

  var_3 = var_2 * 2.5;

  if(var_1 <= self.attackradius + var_3)
    return 1;

  return 0;
}

firemissile() {
  self endon("death");

  for (;;) {
    self waittill("shoot_target", var_0);
    var_1 = undefined;

    if(!isdefined(var_0.script_targetoffset_z))
      var_0.script_targetoffset_z = 0;

    var_2 = (0, 0, var_0.script_targetoffset_z);
    var_1 = self fireweapon(self.missiletags[self.missilelaunchnexttag], var_0, var_2);
    var_1 thread maps\_utility::play_sound_on_tag_endon_death("weap_bm21_missile_projectile");

    if(getdvar("cobrapilot_debug") == "1")
      level thread draw_missile_target_line(var_1, var_0, var_2);

    if(!isdefined(var_0.incomming_missiles))
      var_0.incomming_missiles = [];

    var_0.incomming_missiles = common_scripts\utility::array_add(var_0.incomming_missiles, var_1);
    thread maps\_helicopter_globals::missile_deathwait(var_1, var_0);

    if(maps\_utility::hastag(self.missilemodel, self.missiletags[self.missilelaunchnexttag]))
      self detach(self.missilemodel, self.missiletags[self.missilelaunchnexttag]);

    self.missilelaunchnexttag++;
    self.missileammo--;
    var_0 notify("incomming_missile", var_1);
    tryreload();
    wait 0.05;
    self notify("missile_fired", var_1);
  }
}

draw_missile_target_line(var_0, var_1, var_2) {
  var_0 endon("death");

  for (;;)
    wait 0.05;
}

tryreload() {
  if(!isdefined(self.missileammo))
    self.missileammo = 0;

  if(!isdefined(self.missilelaunchnexttag))
    self.missilelaunchnexttag = 0;

  if(self.missileammo > 0) {
    return;
  }
  for (var_0 = 0; var_0 < self.missiletags.size; var_0++) {
    if(maps\_utility::hastag(self.missilemodel, self.missiletags[var_0]))
      self attach(self.missilemodel, self.missiletags[var_0]);
  }

  self.missileammo = self.missiletags.size;
  self.missilelaunchnexttag = 0;
}