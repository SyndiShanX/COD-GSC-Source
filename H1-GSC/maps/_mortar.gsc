/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\_mortar.gsc
********************************/

main() {}

hurtgen_style() {
  var_0 = getentarray("mortar", "targetname");
  var_1 = -1;

  for (var_2 = 0; var_2 < var_0.size; var_2++)
    var_0[var_2] setup_mortar_terrain();

  if(!isdefined(level.mortar))
    common_scripts\utility::error("level.mortar not defined. define in level script");

  level waittill("start_mortars");

  for (;;) {
    wait(1 + randomfloat(2));
    var_3 = randomint(var_0.size);

    for (var_2 = 0; var_2 < var_0.size; var_2++) {
      var_4 = (var_2 + var_3) % var_0.size;
      var_5 = distance(level.player getorigin(), var_0[var_4].origin);
      var_6 = undefined;

      if(isdefined(level.foley))
        var_6 = distance(level.foley.origin, var_0[var_4].origin);
      else
        var_6 = 360;

      if(var_5 < 1600 && var_5 > 400 && var_6 > 350 && var_4 != var_1) {
        var_0[var_4] activate_mortar(400, 300, 25, undefined, undefined, undefined, 0);
        var_1 = var_4;

        if(var_5 < 500)
          maps\_shellshock::main(4);

        break;
      }
    }
  }
}

railyard_style(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isdefined(var_0))
    var_0 = 7;

  if(!isdefined(var_1))
    var_1 = 2200;

  if(!isdefined(var_2))
    var_2 = 300;

  if(!isdefined(level.istopbarrage))
    level.istopbarrage = 0;

  if(!isdefined(var_9))
    var_9 = 0;

  var_11 = getentarray("mortar", "targetname");
  var_12 = -1;

  for (var_13 = 0; var_13 < var_11.size; var_13++) {
    if(isdefined(var_11[var_13].target) && var_9 == 0)
      var_11[var_13] setup_mortar_terrain();
  }

  if(!isdefined(level.mortar))
    common_scripts\utility::error("level.mortar not defined. define in level script");

  if(isdefined(level.mortar_notify))
    level waittill(level.mortar_notify);

  for (;;) {
    if(level.istopbarrage != 0)
      wait 1;

    while (level.istopbarrage == 0) {
      if(isdefined(var_10))
        wait(var_10 + (randomfloat(var_0) + randomfloat(var_0)));
      else
        wait(randomfloat(var_0) + randomfloat(var_0));

      var_14 = randomint(var_11.size);

      for (var_13 = 0; var_13 < var_11.size; var_13++) {
        var_15 = (var_13 + var_14) % var_11.size;
        var_16 = distance(level.player getorigin(), var_11[var_15].origin);

        if(var_16 < var_1 && var_16 > var_2 && var_15 != var_12) {
          var_11[var_15] activate_mortar(var_3, var_4, var_5, var_6, var_7, var_8, 0);
          var_12 = var_15;
          break;
        }
      }
    }
  }
}

script_mortargroup_style() {
  var_0 = [];
  var_1 = [];
  level.mortars = [];
  var_2 = getentarray("script_model", "classname");

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(isdefined(var_2[var_3].script_mortargroup)) {
      if(!isdefined(level.mortars[var_2[var_3].script_mortargroup]))
        level.mortars[var_2[var_3].script_mortargroup] = [];

      var_4 = spawnstruct();
      var_4.origin = var_2[var_3].origin;
      var_4.angles = var_2[var_3].angles;

      if(isdefined(var_2[var_3].targetname))
        var_4.targetname = var_2[var_3].targetname;

      if(isdefined(var_2[var_3].target))
        var_4.target = var_2[var_3].target;

      level.mortars[var_2[var_3].script_mortargroup][level.mortars[var_2[var_3].script_mortargroup].size] = var_4;
      var_2[var_3] delete();
    }
  }

  for (var_3 = 0; var_3 < var_0.size; var_3++) {
    var_0[var_3] hide();
    var_0[var_3].has_terrain = 0;
  }

  if(!isdefined(level.mortar))
    level.mortar = loadfx("fx\explosions\artilleryExp_dirt_brown");

  var_5 = common_scripts\utility::array_combine(getentarray("trigger_multiple", "classname"), getentarray("trigger_radius", "classname"));

  for (var_3 = 0; var_3 < var_5.size; var_3++) {
    if(isdefined(var_5[var_3].script_mortargroup)) {
      if(!isdefined(level.mortars[var_5[var_3].script_mortargroup]))
        level.mortars[var_5[var_3].script_mortargroup] = [];

      var_1[var_1.size] = var_5[var_3];
    }
  }

  for (var_3 = 0; var_3 < var_1.size; var_3++) {
    var_1[var_3].mortargroup = 0;
    var_1[var_3] thread script_mortargroup_mortar_group();
  }

  var_6 = undefined;

  for (;;) {
    level waittill("mortarzone", var_7);

    if(isdefined(var_6))
      var_6 notify("wait again");

    level.mortarzone = var_7.script_mortargroup;
    var_7 thread script_mortargroup_mortarzone();
    var_6 = var_7;
  }
}

script_mortargroup_mortarzone() {
  var_0 = [];
  var_1 = gettime();
  var_2 = 0;

  if(isdefined(self.script_timer)) {
    level notify("timed barrage");
    var_1 = gettime() + self.script_timer * 1000;
    var_2 = 1;
  }

  if(isdefined(self.script_radius))
    var_3 = self.script_radius;
  else
    var_3 = 0;

  if(isdefined(self.script_delay_min) && isdefined(self.script_delay_max))
    var_4 = 1;
  else
    var_4 = 0;

  var_5 = 0;
  var_6 = 2;
  var_7 = 4;
  var_8 = 0;

  while (level.mortars[self.script_mortargroup].size > 0 && level.mortarzone == self.script_mortargroup || var_2) {
    if(var_4)
      wait(randomfloat(self.script_delay_max - self.script_delay_min) + self.script_delay_min);
    else if(var_8) {
      if(var_5 < var_7) {
        wait(randomfloat(0.5));
        var_5++;
      } else {
        var_5 = 0;
        var_7 = 2 + randomint(4);
        var_8 = 0;
        continue;
      }
    } else if(var_5 < var_6) {
      var_9 = randomfloat(2) + 1;
      wait(var_9);
      var_5++;
    } else {
      var_5 = 0;
      var_8 = 1;
      var_6 = randomint(2) + 3;
      continue;
    }

    var_10 = [];
    var_11 = randomint(level.mortars[self.script_mortargroup].size);

    if(randomint(100) < 75) {
      var_12 = anglestoforward(level.player.angles);
      var_13 = [];

      for (var_14 = 0; var_14 < level.mortars[self.script_mortargroup].size; var_14++) {
        if(var_3 > 0 && distance(level.player.origin, level.mortars[self.script_mortargroup][var_14].origin) > var_3) {
          continue;
        }
        if(is_lastblast(level.mortars[self.script_mortargroup][var_14], var_0)) {
          continue;
        }
        var_15 = vectornormalize(level.mortars[self.script_mortargroup][var_14].origin - level.player.origin);

        if(vectordot(var_12, var_15) > 0.3)
          var_13[var_13.size] = var_14;
      }

      if(var_13.size > 0)
        var_11 = var_13[randomint(var_13.size)];
    }

    if(var_0.size > 3)
      var_0 = [];

    var_0[var_0.size] = level.mortars[self.script_mortargroup][var_11];
    level.mortars[self.script_mortargroup][var_11] thread script_mortargroup_domortar();

    if(var_2 && gettime() > var_1) {
      if(isdefined(self.target)) {
        var_16 = getent(self.target, "targetname");

        if(isdefined(var_16)) {
          var_16 notify("trigger");
          level notify("timed barrage finished");
        }
      }

      break;
    }
  }
}

is_lastblast(var_0, var_1) {
  for (var_2 = 0; var_2 < var_1.size; var_2++) {
    if(var_0 == var_1[var_2])
      return 1;
  }

  return 0;
}

script_mortargroup_domortar() {
  if(isdefined(self.targetname) && isdefined(level.mortarthread[self.targetname]))
    level thread[[level.mortarthread[self.targetname]]](self);
  else
    thread activate_mortar(undefined, undefined, undefined, undefined, undefined, undefined, 1);

  self waittill("mortar");

  if(isdefined(self.target)) {
    var_0 = getent(self.target, "targetname");

    if(isdefined(var_0))
      var_0 notify("trigger");
  }
}

script_mortargroup_mortar_group() {
  for (;;) {
    self waittill("trigger");

    if(isdefined(level.mortarzone) && level.mortarzone == self.script_mortargroup) {
      continue;
    }
    level notify("mortarzone", self);
    self waittill("wait again");
  }
}

trigger_targeted() {
  level.mortartrigger = getentarray("mortartrigger", "targetname");
  level.mortars = getentarray("script_origin", "classname");

  for (var_0 = 0; var_0 < level.mortars.size; var_0++) {
    if(isdefined(level.mortars[var_0].script_mortargroup))
      level.mortars[var_0] setup_mortar_terrain();
  }

  level.lastmortar = -1;

  if(!isdefined(level.mortar))
    common_scripts\utility::error("level.mortar not defined. define in level script");

  for (var_0 = 0; var_0 < level.mortartrigger.size; var_0++)
    thread trigger_targeted_mortars(var_0);
}

trigger_targeted_mortars(var_0) {
  var_1 = getentarray(level.mortartrigger[var_0].target, "targetname");

  for (;;) {
    if(level.player istouching(level.mortartrigger[var_0])) {
      var_2 = randomint(var_1.size);

      while (var_2 == level.lastmortar) {
        var_2 = randomint(var_1.size);
        wait 0.1;
      }

      var_1[var_2] activate_mortar(undefined, undefined, undefined, undefined, undefined, undefined, 0);
      level.lastmortar = var_2;
    }

    wait(randomfloat(3) + randomfloat(4));
  }
}

bunker_style_mortar() {
  var_0 = [];
  var_1 = undefined;
  var_2 = [];
  var_3 = common_scripts\utility::getstructarray("mortar_bunker", "targetname");
  var_4 = getentarray("mortar_bunker", "targetname");

  if(isdefined(var_4) && var_4.size > 0)
    var_1 = maps\_utility::array_merge(var_3, var_4);
  else
    var_1 = var_3;

  for (var_5 = 0; var_5 < var_1.size; var_5++) {
    if(!isdefined(var_1[var_5].script_mortargroup)) {
      continue;
    }
    var_6 = -1;
    var_7 = int(var_1[var_5].script_mortargroup);

    for (var_8 = 0; var_8 < var_0.size; var_8++) {
      if(var_7 != var_2[var_8]) {
        continue;
      }
      var_6 = var_8;
      break;
    }

    if(var_6 == -1) {
      var_0[var_0.size] = [];
      var_2[var_2.size] = var_7;
      var_6 = var_0.size - 1;
    }

    var_0[var_6][var_0[var_6].size] = var_1[var_5];
  }

  for (var_5 = 0; var_5 < var_0.size; var_5++)
    thread bunker_style_mortar_think(var_0[var_5], var_3);

  wait 0.05;
  common_scripts\utility::array_thread(getentarray("mortar_on", "targetname"), ::bunker_style_mortar_trigger, "on");
  common_scripts\utility::array_thread(getentarray("mortar_off", "targetname"), ::bunker_style_mortar_trigger, "off");
}

bunker_style_mortar_think(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(isdefined(level.mortarmininterval))
    var_2 = level.mortarmininterval;
  else
    var_2 = 4;

  if(isdefined(level.mortarmaxinterval))
    var_3 = level.mortarmaxinterval;
  else
    var_3 = 6;

  var_4 = int(var_0[0].script_mortargroup);

  for (;;) {
    level waittill("start_mortars " + var_4);
    thread bunker_style_mortar_activate(var_0, var_2, var_3, var_4, var_1);
  }
}

bunker_style_mortar_activate(var_0, var_1, var_2, var_3, var_4) {
  level endon("start_mortars " + var_3);
  level endon("stop_mortars " + var_3);

  for (;;) {
    wait 0.05;
    var_5 = common_scripts\utility::getclosest(level.player.origin, var_4);

    if(!isdefined(level.mortarnoincomingsound))
      common_scripts\utility::play_sound_in_space("mortar_incoming_bunker", var_5.origin);

    var_5 = common_scripts\utility::getclosest(level.player.origin, var_4);
    thread common_scripts\utility::play_sound_in_space("exp_artillery_underground", var_5.origin);
    common_scripts\utility::array_thread(var_0, ::bunker_style_mortar_explode);

    if(!isdefined(level.mortarnoquake)) {
      if(common_scripts\utility::cointoss())
        earthquake(0.2, 1.5, var_5.origin, 1250);
      else
        earthquake(0.35, 2.75, var_5.origin, 1250);
    }

    level notify("mortar_hit");
    wait(randomfloatrange(var_1, var_2));
    var_0 = common_scripts\utility::array_removeundefined(var_0);
  }
}

bunker_style_mortar_explode(var_0, var_1) {
  if(!isdefined(self)) {
    return;
  }
  if(isdefined(level.mortarwithinfov) && mortar_within_player_fov(level.mortarwithinfov) == 0) {
    return;
  }
  if(isdefined(level.mortar_min_dist))
    var_2 = level.mortar_min_dist;
  else
    var_2 = 1024;

  var_3 = var_2 * var_2;
  var_4 = distancesquared(level.player.origin, self.origin);

  if(var_4 > var_3) {
    return;
  }
  if(isdefined(self.classname) && self.classname == "trigger_radius") {
    if(!level.player istouching(self) && distance(level.player.origin, self.origin) < level.mortardamagetriggerdist) {
      radiusdamage(self.origin, self.radius, 500, 500);
      self delete();
      return;
    }
  } else {
    playfx(level._effect["mortar"][self.script_fxid], self.origin);

    if(var_4 < 262144)
      thread common_scripts\utility::play_sound_in_space("emt_single_ceiling_debris", self.origin);
  }
}

bog_style_mortar() {
  var_0 = [];
  var_1 = [];
  var_2 = maps\_utility::getstructarray_delete("mortar", "targetname");

  for (var_3 = 0; var_3 < var_2.size; var_3++) {
    if(!isdefined(var_2[var_3].script_mortargroup)) {
      continue;
    }
    var_4 = -1;
    var_5 = int(var_2[var_3].script_mortargroup);

    for (var_6 = 0; var_6 < var_0.size; var_6++) {
      if(var_5 != var_1[var_6]) {
        continue;
      }
      var_4 = var_6;
      break;
    }

    if(var_4 == -1) {
      var_0[var_0.size] = [];
      var_1[var_1.size] = var_5;
      var_4 = var_0.size - 1;
    }

    var_0[var_4][var_0[var_4].size] = var_2[var_3];
  }

  for (var_3 = 0; var_3 < var_0.size; var_3++)
    thread bog_style_mortar_think(var_0[var_3]);

  wait 0.05;
  common_scripts\utility::array_thread(getentarray("mortar_on", "targetname"), ::bog_style_mortar_trigger, "on");
  common_scripts\utility::array_thread(getentarray("mortar_off", "targetname"), ::bog_style_mortar_trigger, "off");
}

bog_style_mortar_think(var_0, var_1) {
  var_2 = undefined;
  var_3 = undefined;

  if(isdefined(level.mortarmininterval))
    var_2 = level.mortarmininterval;
  else
    var_2 = 0.5;

  if(isdefined(level.mortarmaxinterval))
    var_3 = level.mortarmaxinterval;
  else
    var_3 = 3;

  var_1 = int(var_0[0].script_mortargroup);

  for (;;) {
    level waittill("start_mortars " + var_1);
    level thread bog_style_mortar_activate(var_0, var_1, var_2, var_3);

    if(isdefined(level.bogmortarsgoonce))
      return;
  }
}

bog_style_mortar_activate(var_0, var_1, var_2, var_3) {
  level endon("start_mortars " + var_1);
  level endon("stop_mortars " + var_1);

  if(isdefined(level.mortar_min_dist))
    var_4 = level.mortar_min_dist;
  else
    var_4 = 300;

  var_5 = spawn("trigger_radius", (0, 0, 0), 0, var_4, 256);
  thread bog_style_mortar_cleanup(var_5, var_1);

  for (;;) {
    for (;;) {
      wait 0.05;
      var_6 = randomint(var_0.size);

      if(isdefined(var_0[var_6].cooldown)) {
        continue;
      }
      var_7 = distance(level.player.origin, var_0[var_6].origin);

      if(var_7 < var_4) {
        continue;
      }
      if(isdefined(level.mortarexcluders) && level.mortarexcluders.size > 0) {
        var_5.origin = var_0[var_6].origin;

        if(mortars_too_close(level.mortarexcluders, var_5))
          continue;
      }

      if(!isdefined(level.nomaxmortardist) && var_7 > 1000) {
        continue;
      }
      if(isdefined(level.mortar_max_dist) && var_7 > level.mortar_max_dist) {
        continue;
      }
      if(isdefined(level.mortarwithinfov) && var_0[var_6] mortar_within_player_fov(level.mortarwithinfov) == 0) {
        continue;
      }
      break;
    }

    if(isdefined(level.nomortars) && level.nomortars == 1) {
      return;
    }
    var_0[var_6] thread bog_style_mortar_explode();
    wait(var_2 + randomfloat(var_3 - var_2));
  }
}

bog_style_mortar_cleanup(var_0, var_1) {
  level waittill("stop_mortars " + var_1);
  var_0 delete();
}

mortars_too_close(var_0, var_1) {
  foreach(var_3 in level.mortarexcluders) {
    if(!isalive(var_3)) {
      continue;
    }
    if(!isdefined(var_3)) {
      continue;
    }
    if(var_3 istouching(var_1))
      return 1;
  }

  return 0;
}

mortar_within_player_fov(var_0) {
  var_1 = level.player geteye();
  var_2 = (0, 0, 0);

  if(isdefined(level.playermortarfovoffset))
    var_2 = level.playermortarfovoffset;

  var_3 = common_scripts\utility::within_fov(var_1, level.player getplayerangles() + var_2, self.origin, var_0);
  return var_3;
}

bog_style_mortar_explode(var_0, var_1) {
  if(!isdefined(level.mortardamageradius))
    level.mortardamageradius = 250;

  if(!isdefined(level.mortarearthquakeradius))
    level.mortarearthquakeradius = 1250;

  if(!isdefined(var_0))
    var_0 = 0;

  thread bog_style_mortar_cooldown();

  if(!var_0)
    common_scripts\utility::play_sound_in_space(level.scr_sound["mortar"]["incomming"]);

  if(isdefined(var_1))
    thread common_scripts\utility::play_sound_in_space(var_1);
  else
    thread common_scripts\utility::play_sound_in_space(level.scr_sound["mortar"][self.script_fxid]);

  setplayerignoreradiusdamage(1);
  radiusdamage(self.origin, level.mortardamageradius, 150, 50);
  setplayerignoreradiusdamage(0);
  playfx(level._effect["mortar"][self.script_fxid], self.origin);

  if(isdefined(level.alwaysquake))
    earthquake(0.3, 1, level.player.origin, 2000);

  if(getdvarint("bog_camerashake") > 0) {
    if(level.player getcurrentweapon() == "dragunov" && level.player playerads() > 0.8) {
      return;
    }
    earthquake(0.25, 0.75, self.origin, level.mortarearthquakeradius);
  }
}

bog_style_mortar_cooldown() {
  self.cooldown = 1;
  wait(3 + randomfloat(2));
  self.cooldown = undefined;
}

bog_style_mortar_trigger(var_0) {
  self waittill("trigger");

  if(var_0 == "on")
    bog_style_mortar_on(self.script_mortargroup);
  else if(var_0 == "off")
    bog_style_mortar_off(self.script_mortargroup);
}

bog_style_mortar_on(var_0) {
  level notify("start_mortars " + var_0);
}

bog_style_mortar_off(var_0) {
  level notify("stop_mortars " + var_0);
}

bunker_style_mortar_on(var_0) {
  if(!isdefined(level.mortardamagetriggerdist))
    level.mortardamagetriggerdist = 512;

  if(!isdefined(level.mortarwithinfov))
    level.mortarwithinfov = cos(35);

  level notify("start_mortars " + var_0);
}

bunker_style_mortar_off(var_0) {
  level waittill("mortar_hit");
  level notify("stop_mortars " + var_0);
}

bunker_style_mortar_off_nowait(var_0) {
  level notify("stop_mortars " + var_0);
}

bunker_style_mortar_trigger(var_0) {
  self waittill("trigger");

  if(var_0 == "on")
    bunker_style_mortar_on(self.script_mortargroup);
  else if(var_0 == "off")
    bunker_style_mortar_off(self.script_mortargroup);
}

burnville_style_mortar() {
  level endon("stop falling mortars");
  setup_mortar_terrain();
  wait(randomfloat(0.5) + randomfloat(0.5));

  for (;;) {
    if(distance(level.player getorigin(), self.origin) < 600) {
      activate_mortar(undefined, undefined, undefined, undefined, undefined, undefined, 0);
      break;
    }

    wait 1;
  }

  wait(7 + randomfloat(20));

  for (;;) {
    if(distance(level.player getorigin(), self.origin) < 1200 && distance(level.player getorigin(), self.origin) > 400) {
      activate_mortar(undefined, undefined, undefined, undefined, undefined, undefined, 0);
      wait(3 + randomfloat(14));
    }

    wait 1;
  }
}

setup_mortar_terrain() {
  self.has_terrain = 0;

  if(isdefined(self.target)) {
    self.terrain = getentarray(self.target, "targetname");
    self.has_terrain = 1;
  } else {}

  if(!isdefined(self.terrain)) {}

  if(isdefined(self.script_hidden)) {
    if(isdefined(self.script_hidden))
      self.hidden_terrain = getent(self.script_hidden, "targetname");
    else if(isdefined(self.terrain) && isdefined(self.terrain[0].target))
      self.hidden_terrain = getent(self.terrain[0].target, "targetname");

    if(isdefined(self.hidden_terrain))
      self.hidden_terrain hide();
  } else if(isdefined(self.has_terrain)) {
    if(isdefined(self.terrain) && isdefined(self.terrain[0].target))
      self.hidden_terrain = getent(self.terrain[0].target, "targetname");

    if(isdefined(self.hidden_terrain))
      self.hidden_terrain hide();
  }
}

activate_mortar(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  incoming_sound(undefined, var_6);
  level notify("mortar");
  self notify("mortar");

  if(!isdefined(var_0))
    var_0 = 256;

  if(!isdefined(var_1))
    var_1 = 400;

  if(!isdefined(var_2))
    var_2 = 25;

  radiusdamage(self.origin, var_0, var_1, var_2);

  if(isdefined(self.has_terrain) && self.has_terrain == 1 && isdefined(self.terrain)) {
    for (var_7 = 0; var_7 < self.terrain.size; var_7++) {
      if(isdefined(self.terrain[var_7]))
        self.terrain[var_7] delete();
    }
  }

  if(isdefined(self.hidden_terrain))
    self.hidden_terrain show();

  self.has_terrain = 0;
  mortar_boom(self.origin, var_3, var_4, var_5, undefined, var_6);
}

mortar_boom(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isdefined(var_1))
    var_1 = 0.15;

  if(!isdefined(var_2))
    var_2 = 2;

  if(!isdefined(var_3))
    var_3 = 850;

  thread mortar_sound(var_5);

  if(isdefined(var_4))
    playfx(var_4, var_0);
  else
    playfx(level.mortar, var_0);

  earthquake(var_1, var_2, var_0, var_3);

  if(isdefined(level.playermortar)) {
    return;
  }
  if(distance(level.player.origin, var_0) > 300) {
    return;
  }
  level.playermortar = 1;
  level notify("shell shock player", var_2 * 4);
  maps\_shellshock::main(var_2 * 4);
}

mortar_sound(var_0) {
  if(!isdefined(level.mortar_last_sound))
    level.mortar_last_sound = -1;

  for (var_1 = randomint(3) + 1; var_1 == level.mortar_last_sound; var_1 = randomint(3) + 1) {}

  level.mortar_last_sound = var_1;

  if(!var_0)
    self playsound("mortar_explosion" + var_1);
  else
    common_scripts\utility::play_sound_in_space("mortar_explosion" + var_1, self.origin);
}

incoming_sound(var_0, var_1) {
  var_2 = gettime();

  if(!isdefined(level.lastmortarincomingtime))
    level.lastmortarincomingtime = var_2;
  else if(var_2 - level.lastmortarincomingtime < 1000) {
    wait 1;
    return;
  } else
    level.lastmortarincomingtime = var_2;

  if(!isdefined(var_0))
    var_0 = randomint(3) + 1;

  if(var_0 == 1) {
    if(var_1)
      thread common_scripts\utility::play_sound_in_space("mortar_incoming1", self.origin);
    else
      self playsound("mortar_incoming1");

    wait 0.82;
  } else if(var_0 == 2) {
    if(var_1)
      thread common_scripts\utility::play_sound_in_space("mortar_incoming2", self.origin);
    else
      self playsound("mortar_incoming2");

    wait 0.42;
  } else {
    if(var_1)
      thread common_scripts\utility::play_sound_in_space("mortar_incoming3", self.origin);
    else
      self playsound("mortar_incoming3");

    wait 1.3;
  }
}

generic_style_init() {
  level._explosion_imaxrange = [];
  level._explosion_iminrange = [];
  level._explosion_iblastradius = [];
  level._explosion_idamagemax = [];
  level._explosion_idamagemin = [];
  level._explosion_fquakepower = [];
  level._explosion_iquaketime = [];
  level._explosion_iquakeradius = [];
}

generic_style_setradius(var_0, var_1, var_2) {
  level._explosion_iminrange[var_0] = var_1;
  level._explosion_imaxrange[var_0] = var_2;
}

generic_style_setdamage(var_0, var_1, var_2, var_3) {
  level._explosion_iblastradius[var_0] = var_1;
  level._explosion_idamagemin[var_0] = var_2;
  level._explosion_idamagemax[var_0] = var_3;
}

generic_style_setquake(var_0, var_1, var_2, var_3) {
  level._explosion_fquakepower[var_0] = var_1;
  level._explosion_iquaketime[var_0] = var_2;
  level._explosion_iquakeradius[var_0] = var_3;
}

generic_style(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = -1;
  var_8 = var_5;
  var_9 = var_4;
  generic_style_setradius(var_0, 300, 2200);

  if(!isdefined(var_1))
    var_1 = 7;

  if(!isdefined(var_2))
    var_2 = 1;

  if(!isdefined(var_3))
    var_3 = 0;

  if(!isdefined(var_6))
    var_6 = 0;

  if(isdefined(level.explosion_stopnotify) && isdefined(level.explosion_stopnotify[var_0]))
    level endon(level.explosion_stopnotify[var_0]);

  if(!isdefined(level.bstopbarrage) || !isdefined(level.bstopbarrage[var_0]))
    level.bstopbarrage[var_0] = 0;

  var_10 = getentarray(var_0, "targetname");

  for (var_11 = 0; var_11 < var_10.size; var_11++) {
    if(isdefined(var_10[var_11].target) && !var_6)
      var_10[var_11] setup_mortar_terrain();
  }

  if(isdefined(level.explosion_startnotify) && isdefined(level.explosion_startnotify[var_0]))
    level waittill(level.explosion_startnotify[var_0]);

  for (;;) {
    while (!level.bstopbarrage[var_0]) {
      for (var_12 = 0; var_12 < var_2; var_12++) {
        if(!isdefined(var_5))
          var_8 = level._explosion_imaxrange[var_0];

        if(!isdefined(var_4))
          var_9 = level._explosion_iminrange[var_0];

        var_13 = randomint(var_10.size);

        for (var_11 = 0; var_11 < var_10.size; var_11++) {
          var_14 = (var_11 + var_13) % var_10.size;
          var_15 = distance(level.player getorigin(), var_10[var_14].origin);

          if(var_15 < var_8 && var_15 > var_9 && var_14 != var_7) {
            var_10[var_14].iminrange = var_9;
            var_10[var_14] explosion_activate(var_0);
            var_7 = var_14;
            break;
          }
        }

        var_7 = -1;

        if(isdefined(level.explosion_delay) && isdefined(level.explosion_delay[var_0])) {
          wait(level.explosion_delay[var_0]);
          continue;
        }

        wait(randomfloat(var_1) + randomfloat(var_1));
      }

      if(isdefined(level.explosion_barrage_delay) && isdefined(level.explosion_barrage_delay[var_0])) {
        wait(level.explosion_barrage_delay[var_0]);
        continue;
      }

      wait(randomfloat(var_3) + randomfloat(var_3));
    }

    wait 0.05;
  }
}

explosion_activate(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  generic_style_setdamage(var_0, 256, 25, 400);
  generic_style_setquake(var_0, 0.15, 2, 850);

  if(!isdefined(var_1))
    var_1 = level._explosion_iblastradius[var_0];

  if(!isdefined(var_2))
    var_2 = level._explosion_idamagemin[var_0];

  if(!isdefined(var_3))
    var_3 = level._explosion_idamagemax[var_0];

  if(!isdefined(var_4))
    var_4 = level._explosion_fquakepower[var_0];

  if(!isdefined(var_5))
    var_5 = level._explosion_iquaketime[var_0];

  if(!isdefined(var_6))
    var_6 = level._explosion_iquakeradius[var_0];

  explosion_incoming(var_0);
  level notify("explosion", var_0);
  var_7 = 1;
  var_8 = undefined;
  var_9 = self;

  if(isdefined(self.iminrange) && distance(level.player.origin, self.origin) < self.iminrange) {
    var_10 = getentarray(var_0, "targetname");

    for (var_11 = 0; var_11 < var_10.size; var_11++) {
      var_12 = distance(level.player getorigin(), var_10[var_11].origin);

      if(var_12 > self.iminrange) {
        if(!isdefined(var_8) || var_12 < var_8) {
          var_8 = var_12;
          var_9 = var_10[var_11];
        }
      }
    }

    if(!isdefined(var_8))
      var_7 = 0;
  }

  if(var_7)
    radiusdamage(var_9.origin, var_1, var_3, var_2);

  if(isdefined(var_9.has_terrain) && var_9.has_terrain == 1 && isdefined(var_9.terrain)) {
    for (var_13 = 0; var_13 < var_9.terrain.size; var_13++) {
      if(isdefined(var_9.terrain[var_13]))
        var_9.terrain[var_13] delete();
    }
  }

  if(isdefined(var_9.hidden_terrain))
    var_9.hidden_terrain show();

  var_9.has_terrain = 0;
  var_9 explosion_boom(var_0, var_4, var_5, var_6);
}

explosion_boom(var_0, var_1, var_2, var_3) {
  if(!isdefined(var_1))
    var_1 = 0.15;

  if(!isdefined(var_2))
    var_2 = 2;

  if(!isdefined(var_3))
    var_3 = 850;

  explosion_sound(var_0);
  var_4 = self.origin;
  playfx(level._effect[var_0], var_4);
  earthquake(var_1, var_2, var_4, var_3);

  if(distance(level.player.origin, var_4) > 300) {
    return;
  }
  level.playermortar = 1;
  level notify("shell shock player", var_2 * 4);
  maps\_shellshock::main(var_2 * 4);
}

explosion_sound(var_0) {
  if(!isdefined(level._explosion_last_sound))
    level._explosion_last_sound = 0;

  for (var_1 = randomint(3) + 1; var_1 == level._explosion_last_sound; var_1 = randomint(3) + 1) {}

  level._explosion_last_sound = var_1;

  if(level._effecttype[var_0] == "mortar") {
    switch (var_1) {
      case 1:
        self playsound("mortar_explosion1");
        break;
      case 2:
        self playsound("mortar_explosion2");
        break;
      case 3:
        self playsound("mortar_explosion3");
        break;
    }
  } else if(level._effecttype[var_0] == "artillery") {
    switch (var_1) {
      case 1:
        self playsound("mortar_explosion4");
        break;
      case 2:
        self playsound("mortar_explosion5");
        break;
      case 3:
        self playsound("mortar_explosion1");
        break;
    }
  } else if(level._effecttype[var_0] == "bomb") {
    switch (var_1) {
      case 1:
        self playsound("mortar_explosion1");
        break;
      case 2:
        self playsound("mortar_explosion4");
        break;
      case 3:
        self playsound("mortar_explosion5");
        break;
    }
  }
}

explosion_incoming(var_0, var_1) {
  if(!isdefined(level._explosion_last_incoming))
    level._explosion_last_incoming = -1;

  for (var_1 = randomint(4) + 1; var_1 == level._explosion_last_incoming; var_1 = randomint(4) + 1) {}

  level._explosion_last_incoming = var_1;

  if(level._effecttype[var_0] == "mortar") {
    switch (var_1) {
      case 1:
        self playsound("mortar_incoming1");
        wait 0.82;
        break;
      case 2:
        self playsound("mortar_incoming2");
        wait 0.42;
        break;
      case 3:
        self playsound("mortar_incoming3");
        wait 1.3;
        break;
      default:
        wait 1.75;
        break;
    }
  } else if(level._effecttype[var_0] == "artillery") {
    switch (var_1) {
      case 1:
        self playsound("mortar_incoming4");
        wait 0.82;
        break;
      case 2:
        self playsound("mortar_incoming4_new");
        wait 0.42;
        break;
      case 3:
        self playsound("mortar_incoming1_new");
        wait 1.3;
        break;
      default:
        wait 1.75;
        break;
    }
  } else if(level._effecttype[var_0] == "bomb") {
    switch (var_1) {
      case 1:
        self playsound("mortar_incoming2_new");
        wait 1.75;
        break;
      case 2:
        self playsound("mortar_incoming3_new");
        wait 1.75;
        break;
      case 3:
        self playsound("mortar_incoming4_new");
        wait 1.75;
        break;
      default:
        wait 1.75;
        break;
    }
  }
}