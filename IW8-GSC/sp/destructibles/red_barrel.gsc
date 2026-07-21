/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\destructibles\red_barrel.gsc
***********************************************/

red_barrel_init() {
  level.g_effect["barrel_flame_top"] = loadfx("vfx/iw7/levels/moon/scripted/scriptables/oxygen_tank/vfx_oxygen_tank_spewing_flames.vfx");
  level.g_effect["barrel_flame_small"] = loadfx("vfx/iw8/prop/scriptables/vfx_dest_barrel_fire_sm.vfx");
  level.g_effect["barrel_explosion"] = loadfx("vfx/iw8/prop/scriptables/vfx_red_barrel_exp.vfx");
  level.g_effect["barrel_fire"] = loadfx("vfx/iw8/prop/scriptables/vfx_dest_barrel_fire.vfx");
  var_0 = getallredbarrels();

  foreach(var_2 in var_0) {
    if(var_2 is_molotov_barrel()) {
      var_2 thread moltovrefillthink();
      continue;
    }

    var_2 thread red_barrel();
  }
}

red_barrel() {
  self endon("barrel_death");
  self endon("barrel_delete");
  scripts\sp\destructibles\barrel_common::barrel_setup("red", 450, 250, 9100, 15000, 80, 28);
  thread red_barrel_death();
  var_0 = 999999999;
  var_1 = 4;
  var_2 = 0;
  self.health = 9450;
  var_3 = undefined;

  for(;;) {
    self waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);

    if(!scripts\sp\destructibles\barrel_common::isvalidbarreldamage(var_5, var_8)) {
      self.health = self.health + var_4;
      continue;
    }

    var_3 = var_5;
    self.barrel_health = self.health - 9000;

    if(barrelshouldexplode(var_5, var_7, var_8, var_13)) {
      break;
    }

    if(self.barrel_health <= 449) {
      if(!var_2) {
        if(soundexists("o2_barrel_fire"))
          thread scripts\engine\utility::play_loop_sound_on_entity("o2_barrel_fire");

        playFXOnTag(level.g_effect["barrel_fire"], self, "tag_origin");

        if(scripts\engine\utility::hastag(self.model, "tag_valve"))
          playFXOnTag(level.g_effect["barrel_flame_top"], self, "tag_valve");
        else
          playFXOnTag(level.g_effect["barrel_flame_top"], self, "tag_origin");

        badplace_cylinder("barrel_badplace_" + self getentitynumber(), 0, self.origin, 128, 128, "bad_guys");
        var_2 = 1;
        self.onfire = 1;
      }

      var_14 = self.barrel_health / 449;
      var_15 = (gettime() - var_0) / 1000;

      if(4 * var_14 < var_1 - var_15) {
        var_1 = 4 * var_14;
        thread scripts\sp\destructibles\barrel_common::barrel_fusetimer(var_1);
        var_0 = gettime();
      }
    }

    if(isDefined(var_6)) {
      var_16 = length(var_6);

      if(var_16 > 20) {
        var_17 = vectorNormalize(var_6);
        var_18 = 20;

        if(isDefined(var_8) && var_8 == "MOD_IMPACT")
          var_18 = 3;

        var_6 = var_17 * var_18;
      }

      self physicslaunchserver(var_7, var_6 * 1000);
    }

    if(!isDefined(var_8)) {
      continue;
    }
    var_19 = strtok(var_8, "_");

    if(!scripts\engine\utility::array_contains(var_19, "BULLET")) {
      continue;
    }
    var_20 = scripts\engine\utility::spawn_tag_origin(var_7);
    var_21 = vectorNormalize(self.origin - var_7);
    var_22 = vectortoangles(var_21 * -1);
    var_20.angles = scripts\engine\utility::flat_angle(var_22);
    var_20 linkTo(self);

    if(soundexists("o2_barrel_hiss_loop"))
      var_20 thread scripts\engine\utility::play_loop_sound_on_entity("o2_barrel_hiss_loop");

    playFXOnTag(level.g_effect["barrel_flame_small"], var_20, "tag_origin");
    self.spewtags = scripts\engine\utility::array_add(self.spewtags, var_20);
  }

  while(isDefined(self.dont_explode))
    waitframe();

  self notify("barrel_death", var_3);
}

barrelshouldexplode(var_0, var_1, var_2, var_3) {
  if(self.barrel_health <= 0)
    return 1;

  if(scripts\sp\destructibles\barrel_common::isgrenadeinrange(var_1, var_2, 80))
    return 1;

  if(scripts\sp\destructibles\barrel_common::isdirectunderbarrelhit(var_2))
    return 1;

  if(scripts\sp\destructibles\barrel_common::isplayersniperhit(var_0, var_3))
    return 1;

  return 0;
}

red_barrel_death() {
  self endon("barrel_delete");
  self waittill("barrel_death", var_0);

  if(soundexists("o2_barrel_fire") && isDefined(self.onfire) && self.onfire)
    self notify("stop soundo2_barrel_fire");

  physicsexplosionsphere(self.origin, self.phys_barrel_radius, 0, 2.0);
  earthquake(0.5, 0.8, self.origin, 400);
  thread scripts\sp\destructibles\barrel_common::barrel_block_gesture(200, self.origin);
  var_1 = 0.3;
  var_2 = sortbydistance(level.phys_barrels, self.origin);

  foreach(var_4 in var_2) {
    if(var_4 == self) {
      continue;
    }
    var_5 = distance(self.origin, var_4.origin);

    if(var_5 > self.phys_barrel_radius) {
      continue;
    }
    var_6 = self.phys_barrel_radius - var_5;
    var_7 = var_6 / self.phys_barrel_radius;
    var_8 = var_1 * var_7;

    if(var_5 <= self.phys_barrel_radius)
      var_4 thread scripts\sp\destructibles\barrel_common::barrel_launch(self.origin, var_5, var_8);

    if(var_5 <= 200)
      var_4 thread red_barrel_hit(self.origin, var_5, var_8);
  }

  var_10 = scripts\engine\sp\utility::getvehiclearray();

  foreach(var_12 in var_10) {
    var_13 = 400;
    var_14 = 370;

    if(isDefined(var_12.script_team) && var_12.script_team == "allies") {
      continue;
    }
    var_15 = distance(self.origin, var_12.origin);
    var_15 = 0;

    if(var_15 <= 19000) {
      var_7 = var_15 / 190 * 100;
      var_13 = var_13 - var_7 * var_14;

      if(getdvarint("barrel_debug"))
        iprintln("BARREL DID " + var_13 + " TO VEH");

      var_12 scripts\sp\utility::do_damage(var_13, self.origin, self, self, "MOD_EXPLOSIVE");
    }
  }

  var_17 = getaiarray();

  foreach(var_19 in var_17) {
    if(!istrue(var_19.magic_bullet_shield))
      var_17 = scripts\engine\utility::array_remove(var_17, var_19);
  }

  var_21 = scripts\engine\trace::sphere_trace_get_all_results(self.origin, self.origin, 190, var_17, scripts\engine\trace::create_character_contents(), 0);
  var_22 = 0;

  foreach(var_24 in var_21) {
    var_25 = var_24["fraction"];

    if(isDefined(var_25) && var_25 != 1) {
      var_26 = var_24["entity"];

      if(isai(var_26)) {
        var_22++;
        var_27 = scripts\engine\utility::is_equal(var_26.subclass, "juggernaut");
        var_28 = scripts\engine\utility::ter_op(var_27 == 1, 1000, var_26.health + 999999);

        if(!var_27 && randomint(100) < 0)
          thread scripts\sp\equipment\molotov::molotovburnenemy(var_26, 1, self.origin);
        else if(!var_27 && isDefined(level.aigibfunction)) {
          if(isDefined(var_0))
            var_0 scripts\engine\utility::delaythread(0.15, level.aigibfunction, var_26, self.origin, "MOD_EXPLOSIVE");
          else
            scripts\engine\utility::delaythread(0.15, level.aigibfunction, var_26, self.origin, "MOD_EXPLOSIVE");
        } else
          var_26 scripts\sp\utility::do_damage(var_28, self.origin, self, self, "MOD_EXPLOSIVE");
      }
    }
  }

  var_30 = distance(self.origin, level.player.origin);

  if(var_30 <= 200) {
    var_7 = var_30 / 200;
    var_14 = 420;
    var_13 = 420 - var_7 * var_14;

    if(getdvarint("barrel_debug"))
      iprintln("BARREL DID " + var_13 + " TO PLAYER");

    level.player scripts\sp\utility::do_damage(var_13, self.origin, self, self, "MOD_EXPLOSIVE");
  }

  level notify("red_barrel_explosion", self, var_22);
  radiusdamage(self.origin, 2, 1, 0, self);
  badplace_delete("barrel_badplace_" + self getentitynumber());

  if(isDefined(self))
    self hide();

  waitframe();

  if(soundexists("o2_barrel_explode"))
    thread scripts\engine\utility::play_sound_in_space("o2_barrel_explode", self.origin);

  playFX(level.g_effect["barrel_explosion"], self.origin);

  foreach(var_32 in self.spewtags) {
    killfxontag(level.g_effect["barrel_flame_small"], var_32, "tag_origin");
    waitframe();

    if(isDefined(var_32))
      var_32 delete();
  }

  killfxontag(level.g_effect["barrel_fire"], self, "tag_origin");

  if(scripts\engine\utility::hastag(self.model, "tag_valve"))
    killfxontag(level.g_effect["barrel_flame_top"], self, "tag_valve");
  else
    killfxontag(level.g_effect["barrel_flame_top"], self, "tag_origin");

  waitframe();

  if(isDefined(self))
    thread delay_delete(5);
}

delay_delete(var_0) {
  wait(var_0);

  if(isDefined(self))
    self delete();
}

red_barrel_hit(var_0, var_1, var_2) {
  self endon("barrel_death");
  self endon("barrel_delete");
  wait(var_2);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.onfire)) {
    return;
  }
  var_3 = 95;
  var_4 = 200;

  if(var_1 <= 90) {
    var_5 = 20;
    var_6 = (90 - var_1) / var_4;
    var_7 = 1 + var_6 * var_5;
  } else {
    var_6 = (var_4 - var_1) / var_4;
    var_7 = var_6 * var_3;
  }

  self notify("damage", var_7, undefined, undefined, undefined, "MOD_EXPLOSIVE", undefined, undefined, undefined, undefined, undefined);
}

moltovrefillthink() {
  self.molotovs = getEntArray(self.target, "targetname");
  thread createmoltovinteractwhenavailable();

  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_return_no_endon_death("trigger", "barrel_death", "death");

    if(var_0 == "trigger") {
      self.interactable = 0;
      molotovrefilltriggerthink();

      if(level.player getammocount("molotov") == weaponmaxammo("molotov"))
        removeallmolotovinteractsuntilavailable();
    } else {
      removemoltovinteract();

      foreach(var_2 in self.molotovs) {
        if(isDefined(var_2))
          var_2 delete();
      }

      break;
    }

    if(self.molotovs.size == 0) {
      break;
    }
  }
}

removeallmolotovinteractsuntilavailable() {
  var_0 = getEntArray("phys_barrel_destructible", "targetname");

  foreach(var_2 in var_0) {
    if(var_2 is_molotov_barrel()) {
      var_2 removemoltovinteract();
      var_2 thread createmoltovinteractwhenavailable();
    }
  }
}

createmoltovinteract() {
  if(isDefined(self.interactable) && self.interactable) {
    return;
  }
  if(self.molotovs.size == 0) {
    return;
  }
  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 50), &"WEAPON/LABEL_MOLOTOV", 55, 400, 55, 1);
  self.interactable = 1;
}

removemoltovinteract() {
  if(!isDefined(self.interactable) || !self.interactable) {
    return;
  }
  scripts\sp\player\cursor_hint::remove_cursor_hint();
  self.interactable = 0;
}

createmoltovinteractwhenavailable() {
  self notify("wait_for_interact_available");
  self endon("trigger");
  self endon("barrel_death");
  self endon("wait_for_interact_available");
  self endon("death");
  wait 0.05;
  var_0 = weaponmaxammo("molotov");

  for(;;) {
    if(level.player getammocount("molotov") < var_0 && !ishidden()) {
      break;
    }

    wait 0.1;
  }

  createmoltovinteract();
}

ishidden() {
  if(isDefined(self.hidden) && self.hidden)
    return 1;

  return 0;
}

molotov_refill_hide() {
  if(!is_molotov_barrel()) {
    return;
  }
  if(ishidden()) {
    return;
  }
  var_0 = scripts\engine\utility::array_add(self.molotovs, self);

  foreach(var_2 in var_0) {
    var_2 hide();
    var_2 notsolid();
  }

  removemoltovinteract();
  self.hidden = 1;
}

molotov_refill_show() {
  if(!is_molotov_barrel()) {
    return;
  }
  if(!ishidden()) {
    return;
  }
  var_0 = scripts\engine\utility::array_add(self.molotovs, self);

  foreach(var_2 in var_0) {
    var_2 show();
    var_2 solid();
  }

  createmoltovinteractwhenavailable();
  self.hidden = 0;
}

is_molotov_barrel() {
  if(isDefined(self.script_parameters) && self.script_parameters == "molotov_refill")
    return 1;

  return 0;
}

molotovrefilltriggerthink() {
  var_0 = level.player getweaponslistoffhands();

  if(!playerhasmolotovs(var_0)) {
    level.player scripts\engine\sp\utility::give_offhand("molotov");
    level.player setweaponammoclip("molotov", 0);
  }

  var_1 = weaponmaxammo("molotov");
  var_2 = var_1 - level.player getammocount("molotov");
  var_3 = min(self.molotovs.size, var_2);

  for(var_4 = 0; var_4 < var_3; var_4++) {
    lootoffhandhack();
    self.molotovs[self.molotovs.size - 1] delete();
    self.molotovs = scripts\engine\utility::array_remove(self.molotovs, self.molotovs[self.molotovs.size - 1]);
    wait 0.2;
  }
}

playerhasmolotovs(var_0) {
  foreach(var_2 in var_0) {
    if(var_2.basename == "molotov")
      return 1;
  }

  return 0;
}

getallredbarrels() {
  return getEntArray("phys_barrel_destructible", "targetname");
}

lootoffhandhack() {
  var_0 = "Molotov";
  level.player thread[[level.loot.types[var_0].lootfunc]](var_0);
  scripts\sp\loot::playlootsound(var_0);

  if(level.loot.types[var_0].createnotification)
    thread scripts\sp\loot::createnotification(level.loot.types[var_0].shader, level.loot.types[var_0].loc);
}