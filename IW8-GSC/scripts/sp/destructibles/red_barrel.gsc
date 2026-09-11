/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\destructibles\red_barrel.gsc
***************************************************/

function red_barrel_init() {
  level.g_effect["barrel_flame_top"] = loadfx("vfx/iw7/levels/moon/scripted/scriptables/oxygen_tank/vfx_oxygen_tank_spewing_flames.vfx");
  level.g_effect["barrel_flame_small"] = loadfx("vfx/iw8/prop/scriptables/vfx_dest_barrel_fire_sm.vfx");
  level.g_effect["barrel_explosion"] = loadfx("vfx/iw8/prop/scriptables/vfx_red_barrel_exp.vfx");
  level.g_effect["barrel_fire"] = loadfx("vfx/iw8/prop/scriptables/vfx_dest_barrel_fire.vfx");
  var0 = getallredbarrels();

  foreach(var2 in var0) {
    if(is_molotov_barrel(var2)) {
      thread moltovrefillthink();
      continue;
    }

    thread red_barrel();
  }
}

function red_barrel() {
  self endon("barrel_death");
  self endon("barrel_delete");
  scripts\sp\destructibles\barrel_common::barrel_setup("red", 450, 250, 9100, 15000, 80, 28);
  thread red_barrel_death();
  var0 = 999999999;
  var1 = 4;
  var2 = 0;
  self.health = 9450;
  var3 = undefined;

  for(;;) {
    self waittill("damage", var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);

    if(!scripts\sp\destructibles\barrel_common::isvalidbarreldamage(var5, var8)) {
      self.health += var4;
      continue;
    }

    var3 = var5;
    self.barrel_health = self.health - 9000;

    if(barrelshouldexplode(var5, var7, var8, var13)) {
      break;
    }

    if(self.barrel_health <= 449) {
      if(!var2) {
        if(soundexists("o2_barrel_fire")) {
          thread scripts\engine\utility::play_loop_sound_on_entity("o2_barrel_fire");
        }

        playFXOnTag(level.g_effect["barrel_fire"], self, "tag_origin");

        if(scripts\engine\utility::hastag(self.model, "tag_valve")) {
          playFXOnTag(level.g_effect["barrel_flame_top"], self, "tag_valve");
        } else {
          playFXOnTag(level.g_effect["barrel_flame_top"], self, "tag_origin");
        }

        badplace_cylinder("barrel_badplace_" + self getentitynumber(), 0, self.origin, 128, 128, "bad_guys");
        var2 = 1;
        self.onfire = 1;
      }

      var14 = self.barrel_health / 449;
      var15 = (gettime() - var0) / 1000;

      if(4 * var14 < var1 - var15) {
        var1 = 4 * var14;
        thread scripts\sp\destructibles\barrel_common::barrel_fusetimer(var1);
        var0 = gettime();
      }
    }

    if(isDefined(var6)) {
      var16 = length(var6);

      if(var16 > 20) {
        var17 = vectorNormalize(var6);
        var18 = 20;

        if(isDefined(var8) && var8 == "MOD_IMPACT") {
          var18 = 3;
        }

        var6 = var17 * var18;
      }

      self physicslaunchserver(var7, var6 * 1000);
    }

    if(!isDefined(var8)) {
      continue;
    }

    var19 = strtok(var8, "_");

    if(!scripts\engine\utility::array_contains(var19, "BULLET")) {
      continue;
    }

    var20 = scripts\engine\utility::spawn_tag_origin(var7);
    var21 = vectorNormalize(self.origin - var7);
    var22 = vectortoangles(var21 * -1);
    var20.angles = scripts\engine\utility::flat_angle(var22);
    var20 linkTo(self);

    if(soundexists("o2_barrel_hiss_loop")) {
      var20 thread scripts\engine\utility::play_loop_sound_on_entity("o2_barrel_hiss_loop");
    }

    playFXOnTag(level.g_effect["barrel_flame_small"], var20, "tag_origin");
    self.spewtags = scripts\engine\utility::array_add(self.spewtags, var20);
  }

  while(isDefined(self.dont_explode)) {
    waitframe();
  }

  self notify("barrel_death", var3);
}

function barrelshouldexplode(var0, var1, var2, var3) {
  if(self.barrel_health <= 0) {
    return true;
  }

  if(scripts\sp\destructibles\barrel_common::isgrenadeinrange(var1, var2, 80)) {
    return true;
  }

  if(scripts\sp\destructibles\barrel_common::isdirectunderbarrelhit(var2)) {
    return true;
  }

  if(scripts\sp\destructibles\barrel_common::isplayersniperhit(var0, var3)) {
    return true;
  }

  return false;
}

function red_barrel_death() {
  self endon("barrel_delete");
  self waittill("barrel_death", var0);

  if(soundexists("o2_barrel_fire") && isDefined(self.onfire) && self.onfire) {
    self notify("stop soundo2_barrel_fire");
  }

  physicsexplosionsphere(self.origin, self.phys_barrel_radius, 0, 2);
  earthquake(0.5, 0.8, self.origin, 400);
  thread scripts\sp\destructibles\barrel_common::barrel_block_gesture(200, self.origin);
  var1 = 0.3;
  var2 = sortbydistance(level.phys_barrels, self.origin);

  foreach(var4 in var2) {
    if(var4 == self) {
      continue;
    }

    var5 = distance(self.origin, var4.origin);

    if(var5 > self.phys_barrel_radius) {
      continue;
    }

    var6 = self.phys_barrel_radius - var5;
    var7 = var6 / self.phys_barrel_radius;
    var8 = var1 * var7;

    if(var5 <= self.phys_barrel_radius) {
      var4 thread scripts\sp\destructibles\barrel_common::barrel_launch(self.origin, var5, var8);
    }

    if(var5 <= 200) {
      thread red_barrel_hit(var4, self.origin, var5);
    }
  }

  var10 = scripts\engine\sp\utility::getvehiclearray();

  foreach(var12 in var10) {
    var13 = 400;
    var14 = 370;
    var15 = distance(self.origin, var12.origin);
    var15 = 0;

    if(var15 <= 19000) {
      var7 = var15 / 190 * 100;
      var13 -= var7 * var14;

      if(getdvarint("barrel_debug")) {
        iprintln("BARREL DID " + var13 + " TO VEH");
      }

      var12 scripts\sp\utility::do_damage(var13, self.origin, self, self, "MOD_EXPLOSIVE");
      LOC_000001c8:
    }
    LOC_000001c8:
  }

  var17 = getaiarray();

  foreach(var19 in var17) {
    if(!istrue(var19.magic_bullet_shield)) {
      var17 = scripts\engine\utility::array_remove(var17, var19);
    }
  }

  var21 = scripts\engine\trace::sphere_trace_get_all_results(self.origin, self.origin, 190, var17, scripts\engine\trace::create_character_contents(), 0);
  var22 = 0;

  foreach(var24 in var21) {
    var25 = var24["fraction"];

    if(isDefined(var25) && var25 != 1) {
      var26 = var24["entity"];

      if(isai(var26)) {
        var22++;
        var27 = scripts\engine\utility::is_equal(var26.subclass, "juggernaut");
        var28 = scripts\engine\utility::ter_op(var27 == 1, 1000, var26.health + 999999);

        if(!var27 && randomint(100) < 0) {
          thread scripts\sp\equipment\molotov::molotovburnenemy(var26, 1, self.origin);
        } else if(!var27 && isDefined(level.aigibfunction)) {
          if(isDefined(var0)) {
            var0 scripts\engine\utility::delaythread(0.15, level.aigibfunction, var26, self.origin, "MOD_EXPLOSIVE");
          } else {
            scripts\engine\utility::delaythread(0.15, level.aigibfunction, var26, self.origin, "MOD_EXPLOSIVE");
          }
        } else {
          var26 scripts\sp\utility::do_damage(var28, self.origin, self, self, "MOD_EXPLOSIVE");
        }
      }
    }
  }

  var30 = distance(self.origin, level.player.origin);

  if(var30 <= 200) {
    var7 = var30 / 200;
    var14 = 420;
    var13 = 420 - var7 * var14;

    if(getdvarint("barrel_debug")) {
      iprintln("BARREL DID " + var13 + " TO PLAYER");
    }

    level.player scripts\sp\utility::do_damage(var13, self.origin, self, self, "MOD_EXPLOSIVE");
  }

  level notify("red_barrel_explosion", self, var22);
  radiusdamage(self.origin, 2, 1, 0, self);
  badplace_delete("barrel_badplace_" + self getentitynumber());

  if(isDefined(self)) {
    self hide();
  }

  waitframe();

  if(soundexists("o2_barrel_explode")) {
    thread scripts\engine\utility::play_sound_in_space("o2_barrel_explode", self.origin);
  }

  playFX(level.g_effect["barrel_explosion"], self.origin);

  foreach(var32 in self.spewtags) {
    killfxontag(level.g_effect["barrel_flame_small"], var32, "tag_origin");
    waitframe();

    if(isDefined(var32)) {
      var32 delete();
    }
  }

  killfxontag(level.g_effect["barrel_fire"], self, "tag_origin");

  if(scripts\engine\utility::hastag(self.model, "tag_valve")) {
    killfxontag(level.g_effect["barrel_flame_top"], self, "tag_valve");
  } else {
    killfxontag(level.g_effect["barrel_flame_top"], self, "tag_origin");
  }

  waitframe();

  if(isDefined(self)) {
    thread delay_delete(5);
    return;
  }
}

function delay_delete(var0) {
  wait var0;

  if(isDefined(self)) {
    self delete();
    return;
  }
}

function red_barrel_hit(var0, var1, var2) {
  self endon("barrel_death");
  self endon("barrel_delete");
  wait var2;

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.onfire)) {
    return;
  }

  var3 = 95;
  var4 = 200;

  if(var1 <= 90) {
    var5 = 20;
    var6 = (90 - var1) / var4;
    var7 = 1 + var6 * var5;
  } else {
    var6 = (var7 - var3) / var7;
    var7 = var6 * var6;
  }

  self notify("damage", var7, undefined, undefined, undefined, "MOD_EXPLOSIVE", undefined, undefined, undefined, undefined, undefined);
}

function moltovrefillthink() {
  self.molotovs = getEntArray(self.target, "targetname");
  thread createmoltovinteractwhenavailable();

  for(;;) {
    var0 = scripts\engine\utility::waittill_any_return_no_endon_death("trigger", "barrel_death", "death");

    if(var0 == "trigger") {
      self.interactable = 0;
      molotovrefilltriggerthink();

      if(level.player getammocount("molotov") == weaponmaxammo("molotov")) {
        removeallmolotovinteractsuntilavailable();
      }
    } else {
      removemoltovinteract();

      foreach(var2 in self.molotovs) {
        if(isDefined(var2)) {
          var2 delete();
        }
      }

      break;
    }

    if(self.molotovs.size == 0) {
      break;
    }
  }
}

function removeallmolotovinteractsuntilavailable() {
  var0 = getEntArray("phys_barrel_destructible", "targetname");

  foreach(var2 in var0) {
    if(is_molotov_barrel(var2)) {
      removemoltovinteract(var2);
      thread createmoltovinteractwhenavailable();
    }
  }
}

function createmoltovinteract() {
  if(isDefined(self.interactable) && self.interactable) {
    return;
  }

  if(self.molotovs.size == 0) {
    return;
  }

  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 50), &"WEAPON/LABEL_MOLOTOV", 55, 400, 55, 1);
  self.interactable = 1;
}

function removemoltovinteract() {
  if(!isDefined(self.interactable) || !self.interactable) {
    return;
  }

  scripts\sp\player\cursor_hint::remove_cursor_hint();
  self.interactable = 0;
}

function createmoltovinteractwhenavailable() {
  self notify("wait_for_interact_available");
  self endon("trigger");
  self endon("barrel_death");
  self endon("wait_for_interact_available");
  self endon("death");
  wait 0.05;
  var0 = weaponmaxammo("molotov");

  for(;;) {
    if(level.player getammocount("molotov") < var0 && !ishidden()) {
      break;
    }

    wait 0.1;
  }

  createmoltovinteract();
}

function ishidden() {
  if(isDefined(self.hidden) && self.hidden) {
    return true;
  }

  return false;
}

function molotov_refill_hide() {
  if(!is_molotov_barrel()) {
    return;
  }

  if(ishidden()) {
    return;
  }

  var0 = scripts\engine\utility::array_add(self.molotovs, self);

  foreach(var2 in var0) {
    var2 hide();
    var2 notsolid();
  }

  removemoltovinteract();
  self.hidden = 1;
}

function molotov_refill_show() {
  if(!is_molotov_barrel()) {
    return;
  }

  if(!ishidden()) {
    return;
  }

  var0 = scripts\engine\utility::array_add(self.molotovs, self);

  foreach(var2 in var0) {
    var2 show();
    var2 solid();
  }

  createmoltovinteractwhenavailable();
  self.hidden = 0;
}

function is_molotov_barrel() {
  if(isDefined(self.script_parameters) && self.script_parameters == "molotov_refill") {
    return true;
  }

  return false;
}

function molotovrefilltriggerthink() {
  var0 = level.player getweaponslistoffhands();

  if(!playerhasmolotovs(var0)) {
    level.player scripts\engine\sp\utility::give_offhand("molotov");
    level.player setweaponammoclip("molotov", 0);
  }

  var1 = weaponmaxammo("molotov");
  var2 = var1 - level.player getammocount("molotov");
  var3 = min(self.molotovs.size, var2);

  for(var4 = 0; var4 < var3; var4++) {
    lootoffhandhack();
    self.molotovs[self.molotovs.size - 1] delete();
    self.molotovs = scripts\engine\utility::array_remove(self.molotovs, self.molotovs[self.molotovs.size - 1]);
    wait 0.2;
  }
}

function playerhasmolotovs(var0) {
  foreach(var2 in var0) {
    if(var2.basename == "molotov") {
      return true;
    }
  }

  return false;
}

function getallredbarrels() {
  return getEntArray("phys_barrel_destructible", "targetname");
}

function lootoffhandhack() {
  var0 = "Molotov";
  level.player thread[[level.loot.types[var0].lootfunc]](var0);
  scripts\sp\loot::playlootsound(var0);

  if(level.loot.types[var0].createnotification) {
    thread scripts\sp\loot::createnotification(level.loot.types[var0].shader, level.loot.types[var0].loc);
    return;
  }
}