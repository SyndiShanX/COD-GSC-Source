/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\aitypes\c12api.gsc
***********************************************/

function c12_setscriptedtargets(var0, var1, var2, var3) {
  if(isarray(var1)) {
    self.scripted_targets[var0] = var1;
  } else {
    self.scripted_targets[var0] = [var1];
  }

  self.scripted_targets_notify[var0] = var2;

  if(!isDefined(var3)) {
    var3 = 1;
  }

  self.scripted_targets_check_los[var0] = var3;
}

function c12_setrocketarc(var0) {
  self.rocket_arc = var0;
}

function c12_clearscriptedtargets(var0) {
  if(!isDefined(self.scripted_targets)) {
    return;
  }

  self.scripted_targets[var0] = undefined;
  self.scripted_targets_notify[var0] = undefined;
  self.scripted_targets_check_los[var0] = undefined;

  if(self.scripted_targets.size == 0) {
    self.scripted_targets = undefined;
    self.scripted_targets_notify = undefined;
    self.scripted_targets_check_los = undefined;
    return;
  }
}

function c12_enablesecondarytargeting(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  self.ballowsecondaries = var0;
}

function c12_enableweaponslot(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 1;
  }

  self.weaponenabled[var0] = var1;
}

function c12_enableautonomouscombat(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  self.bautonomouscombat = var0;

  if(!var0) {
    self clearbtgoal(0);
    return;
  }
}

function c12_disablerodeohint(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  self.brodeohintdisabled = var0;
}

function c12_disablerodeo(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  self.brodeodisabled = var0;

  if(var0) {
    self notify("rodeo_disabled");
    return;
  }

  self notify("rodeo_enabled");
}

function c12_enablestrafe(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(var0) {
    self.bstrafeenabled = 1;
    return;
  }

  self.bstrafeenabled = undefined;
}

function c12_setaimspeedmultiplier(var0) {
  self.aimspeedmultiplier = var0;
}

function c12_islegdismembered() {
  return scripts\asm\asm_bb::ispartdismembered("right_leg") || scripts\asm\asm_bb::ispartdismembered("left_leg");
}

function c12_enableweakrockets(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  self.buseweakrockets = var0;
}

function c12_updateachievement(var0) {
  thread waittill_death_for_achievement(var0);
}

function waittill_death_for_achievement(var0) {
  level.player endon("death");
  self waittill("death");
  wait 0.1;
  level.player setplayerprogression(var0, 1);

  if(level.player getplayerprogression("c12AchievementRodeoLeft") && level.player getplayerprogression("c12AchievementRodeoRight") && level.player getplayerprogression("c12AchievementSelfdestruct")) {
    scripts\engine\sp\utility::giveachievement_wrapper("KILL_C12S");
    return;
  }
}

function c12_initpickuphints(var0, var1, var2, var3, var4) {
  if(!isDefined(var4)) {
    var4 = 0;
  }

  scripts\engine\utility::array_thread(var0, &c12_weapon_pickup_hint_check, var1, var2, var3, var4);
}

function c12_weapon_pickup_hint_check(var0, var1, var2, var3) {
  level.player endon("death");
  var4 = scripts\engine\utility::spawn_tag_origin(self.origin + (0, 0, 25));
  var4.respawning = 0;
  var4 endon("death");
  thread c12_weapon_pickup_hint_delete_check(var4);
  thread c12_weapon_pickup_respawn_check(var4, var3);

  if(isDefined(var2)) {
    level waittill(var2);
  }

  if(level.gameskill == 3) {
    wait 10;
  }

  for(;;) {
    while(distance2dsquared(var4.origin, level.player.origin) < squared(128)) {
      wait 0.05;
    }

    if(c12_player_out_of_heavy_ammo(var3) && !var4.respawning) {
      var4 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", undefined, undefined, undefined, 5000, 0, 1, 0, 0, var1, 0);

      while(distance2dsquared(var4.origin, level.player.origin) >= squared(128)) {
        if(c12_player_out_of_heavy_ammo(var3)) {
          wait 0.05;
          continue;
        }

        break;
      }

      var4 scripts\sp\player\cursor_hint::remove_cursor_hint();
    }

    wait 0.05;
  }
}

function c12_weapon_pickup_hint_delete_check(var0) {
  while(!isDefined(var0.c12)) {
    wait 0.05;
  }

  var0.c12 scripts\engine\utility::waittill_any("death", "begin_rodeo", "self_destruct");
  self delete();
}

function c12_player_out_of_heavy_ammo(var0) {
  var1 = level.player getweaponslistprimaries();
  var2 = [];

  foreach(var4 in var1) {
    switch (getweaponbasename(var4)) {
      case "iw7_atomizer":
        return false;
      case "iw7_penetrationrail":
      case "iw7_lockon":
      case "iw7_chargeshot":
      case "iw7_steeldragon":
        var2 = var4;
        break;
    }
  }

  if(var2.size == 0) {
    return true;
  }

  foreach(var4 in var2) {
    var7 = 0;

    if(var0) {
      var7 = int(weaponclipsize(var4) / 2);
    }

    if(level.player getweaponammostock(var4) + level.player getweaponammoclip(var4) > var7) {
      return false;
    }
  }

  return true;
}

function c12_weapon_pickup_respawn_check(var0, var1) {
  level.player endon("death");
  var0 endon("death");
  var2 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var3 = self;
  var4 = getsubstr(var3.classname, 7);

  if(var1) {
    var5 = weaponmaxammo(var4);
    var6 = 0;
  } else {
    var5 = 1;
    var6 = 1;
  }

  for(;;) {
    var5 itemweaponsetammo(var6, var5);
    var5 waittill("trigger");

    if(isDefined(var5)) {
      var5 delete();
    }

    if(level.player getammocount(var6) == var6 + var5) {
      level.player switchtoweapon(var6);

      if(var3) {
        level.player setweaponammoclip(var6, weaponclipsize(var6));
        level.player setweaponammostock(var6, var5);
      }
    }

    var2.respawning = 1;

    while(distance2dsquared(var4.origin, level.player.origin) < squared(512)) {
      wait 1;
    }

    wait 10;

    if(level.gameskill == 3) {
      wait 10;
    }

    var2.respawning = 0;
    var5 = spawn("weapon_" + var6, var4.origin, 1);
    var5.angles = var4.angles;
  }
}