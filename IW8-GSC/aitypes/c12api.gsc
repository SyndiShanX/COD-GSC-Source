/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aitypes\c12api.gsc
***********************************************/

c12_setscriptedtargets(var_0, var_1, var_2, var_3) {
  if(isarray(var_1))
    self.scripted_targets[var_0] = var_1;
  else
    self.scripted_targets[var_0] = [var_1];

  self.scripted_targets_notify[var_0] = var_2;

  if(!isDefined(var_3))
    var_3 = 1;

  self.scripted_targets_check_los[var_0] = var_3;
}

c12_setrocketarc(var_0) {
  self.rocket_arc = var_0;
}

c12_clearscriptedtargets(var_0) {
  if(!isDefined(self.scripted_targets)) {
    return;
  }
  self.scripted_targets[var_0] = undefined;
  self.scripted_targets_notify[var_0] = undefined;
  self.scripted_targets_check_los[var_0] = undefined;

  if(self.scripted_targets.size == 0) {
    self.scripted_targets = undefined;
    self.scripted_targets_notify = undefined;
    self.scripted_targets_check_los = undefined;
  }
}

c12_enablesecondarytargeting(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self.ballowsecondaries = var_0;
}

c12_enableweaponslot(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  self.weaponenabled[var_0] = var_1;
}

c12_enableautonomouscombat(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self.bautonomouscombat = var_0;

  if(!var_0)
    self clearbtgoal(0);
}

c12_disablerodeohint(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self.brodeohintdisabled = var_0;
}

c12_disablerodeo(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self.brodeodisabled = var_0;

  if(var_0)
    self notify("rodeo_disabled");
  else
    self notify("rodeo_enabled");
}

c12_enablestrafe(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(var_0)
    self.bstrafeenabled = 1;
  else
    self.bstrafeenabled = undefined;
}

c12_setaimspeedmultiplier(var_0) {
  self.aimspeedmultiplier = var_0;
}

c12_islegdismembered() {
  return scripts\asm\asm_bb::ispartdismembered("right_leg") || scripts\asm\asm_bb::ispartdismembered("left_leg");
}

c12_enableweakrockets(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  self.buseweakrockets = var_0;
}

c12_updateachievement(var_0) {
  thread waittill_death_for_achievement(var_0);
}

waittill_death_for_achievement(var_0) {
  level.player endon("death");
  self waittill("death");
  wait 0.1;
  level.player setplayerprogression(var_0, 1);

  if(level.player getplayerprogression("c12AchievementRodeoLeft") && level.player getplayerprogression("c12AchievementRodeoRight") && level.player getplayerprogression("c12AchievementSelfdestruct"))
    scripts\engine\sp\utility::giveachievement_wrapper("KILL_C12S");
}

c12_initpickuphints(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = 0;

  scripts\engine\utility::array_thread(var_0, ::c12_weapon_pickup_hint_check, var_1, var_2, var_3, var_4);
}

c12_weapon_pickup_hint_check(var_0, var_1, var_2, var_3) {
  level.player endon("death");
  var_4 = scripts\engine\utility::spawn_tag_origin(self.origin + (0, 0, 25));
  var_4.respawning = 0;
  var_4 endon("death");
  var_4 thread c12_weapon_pickup_hint_delete_check(var_0);
  thread c12_weapon_pickup_respawn_check(var_4, var_3);

  if(isDefined(var_2))
    level waittill(var_2);

  if(level.gameskill == 3)
    wait 10;

  for(;;) {
    while(distance2dsquared(var_4.origin, level.player.origin) < squared(128))
      wait 0.05;

    if(c12_player_out_of_heavy_ammo(var_3) && !var_4.respawning) {
      var_4 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", undefined, undefined, undefined, 5000, 0, 1, 0, 0, var_1, 0);

      while(distance2dsquared(var_4.origin, level.player.origin) >= squared(128)) {
        if(c12_player_out_of_heavy_ammo(var_3)) {
          wait 0.05;
          continue;
        }

        break;
      }

      var_4 scripts\sp\player\cursor_hint::remove_cursor_hint();
    }

    wait 0.05;
  }
}

c12_weapon_pickup_hint_delete_check(var_0) {
  while(!isDefined(var_0.c12))
    wait 0.05;

  var_0.c12 scripts\engine\utility::waittill_any("death", "begin_rodeo", "self_destruct");
  self delete();
}

c12_player_out_of_heavy_ammo(var_0) {
  var_1 = level.player getweaponslistprimaries();
  var_2 = [];

  foreach(var_4 in var_1) {
    switch (getweaponbasename(var_4)) {
      case "iw7_atomizer":
        return 0;
      case "iw7_penetrationrail":
      case "iw7_lockon":
      case "iw7_chargeshot":
      case "iw7_steeldragon":
        var_2[var_2.size] = var_4;
        break;
    }
  }

  if(var_2.size == 0)
    return 1;

  foreach(var_4 in var_2) {
    var_7 = 0;

    if(var_0)
      var_7 = int(weaponclipsize(var_4) / 2);

    if(level.player getweaponammostock(var_4) + level.player getweaponammoclip(var_4) > var_7)
      return 0;
  }

  return 1;
}

c12_weapon_pickup_respawn_check(var_0, var_1) {
  level.player endon("death");
  var_0 endon("death");
  var_2 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var_3 = self;
  var_4 = getsubstr(var_3.classname, 7);

  if(var_1) {
    var_5 = weaponmaxammo(var_4);
    var_6 = 0;
  } else {
    var_5 = 1;
    var_6 = 1;
  }

  for(;;) {
    var_3 itemweaponsetammo(var_6, var_5);
    var_3 waittill("trigger");

    if(isDefined(var_3))
      var_3 delete();

    if(level.player getammocount(var_4) == var_6 + var_5) {
      level.player switchtoweapon(var_4);

      if(var_1) {
        level.player setweaponammoclip(var_4, weaponclipsize(var_4));
        level.player setweaponammostock(var_4, var_5);
      }
    }

    var_0.respawning = 1;

    while(distance2dsquared(var_2.origin, level.player.origin) < squared(512))
      wait 1;

    wait 10;

    if(level.gameskill == 3)
      wait 10;

    var_0.respawning = 0;
    var_3 = spawn("weapon_" + var_4, var_2.origin, 1);
    var_3.angles = var_2.angles;
  }
}