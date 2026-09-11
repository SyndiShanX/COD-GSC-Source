/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\player\ally_equipment.gsc
************************************************/

function ally_equipment_init() {
  precachemodel("offhand_vm_molotov");
  level.focus_pressed = 0;
}

function ally_equipment_backpack(var0, var1) {
  var0 endon("death");

  if(!var0 scripts\engine\utility::ent_flag_exist("show_eq_icon")) {
    var0 scripts\engine\utility::ent_flag_init("show_eq_icon");
  }

  var2 = undefined;
  var3 = 0;
  var4 = undefined;

  switch (var1) {
    case "flash":
      var5 = "hud_icon_equipment_flash";
      var2 = "flash_full";
      break;
    case "frag":
      var5 = "hud_icon_equipment_frag";
      var3 = "frag_full";
      break;
    case "molotov":
      var5 = "hud_icon_equipment_molotov";
      var4 = "molotov_full";
      break;
    case "smoke":
      var5 = "hud_icon_equipment_smoke";
      var5 = "smoke_full";
      break;
    case "iw8_la_rpapa7_straight_slow":
    case "iw8_la_rpapa7_straight":
    case "iw8_la_rpapa7":
      var5 = "hud_icon_loot_ammo_rocket";
      var5 = "rpg_full";
      var5 = 1;
      var5 = "RPG Ammo";
      break;
    default:
      var5 = undefined;
      var5 = "flash_full";
      break;
  }

  var5.icon_spot = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  var5.icon_spot dontinterpolate();
  var5.icon_spot linkTo(var5, "j_spine4", (-5, 6, 0), (0, 0, 0));
  var5.model_spot = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  var5.model_spot dontinterpolate();
  var5.model_spot linkTo(var5, "j_spine4", (-5, 7, 0), (90, 0, 0));
  thread ally_equipment_backpack_icon(var5, var5);
  ally_equipment_backpack_interact(var5, var5, var5, var5, var5);
}

function ally_equipment_backpack_interact(var0, var1, var2, var3, var4) {
  var0 notify("remove_equipment");
  var0 endon("death");

  for(;;) {
    wait 0.1;

    if(var0.support_equipment <= 0) {
      while(var0.support_equipment <= 0) {
        wait 0.1;
      }
    }

    var5 = scripts\engine\utility::string(var0.support_equipment);
    var0.icon_spot scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), var4, 40, 200, 100, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, 30);
    thread ally_equipment_remove();
    var0.icon_spot waittill("trigger");
    waitframe();

    if(var0.support_equipment == 0) {
      while(!var0.support_equipment) {
        waitframe();
      }

      continue;
    }

    var6 = level.player getammocount(getcompleteweaponname(var1));
    var7 = weaponmaxammo(var1);
    var8 = var7 - var6;
    var9 = 0;

    if(getDvar("LMMLNRSLKS") == "autobuild") {
      getentitylessscriptablearray("sp_ally_equipment", ["type", var3, "levelname", level.script, "x", level.player.origin[0], "y", level.player.origin[1], "z", level.player.origin[2], "checkpoint", level.start_point, "ally", var0.script_friendname]);
    }

    if(var6 != var7) {
      if(var8 <= var0.support_equipment) {
        var9 = var8 + var6;
        var0.support_equipment = 0;
      } else {
        var9 = var0.support_equipment + var6;
        var0.support_equipment = 0;
      }

      level.player scripts\engine\sp\utility::player_gesture_force("ges_swipe");
      wait 0.3;
      level.player playSound("prox_explo_bounce_default");
      level.player playRumbleOnEntity("damage_heavy");

      if(var3 == "rpg_full") {
        level.player givemaxammo(var1);
        level.player switchtoweapon(var1);
        level.player setweaponammoclip(var1, weaponclipsize(var1));
      } else {
        level.player scripts\engine\sp\utility::give_offhand(var1, var9);
        level.player notify("equipment_given");
        wait 1;
      }
    } else {
      level.player forceplaygestureviewmodel("ges_titan_bunker");
      wait 0.75;
      level.player stopgestureviewmodel("ges_titan_bunker", 0.5);
      wait 3;
    }

    wait 0.5;
  }
}

function ally_increase_equipment(var0) {
  while(var0.support_equipment > 0) {
    wait 0.1;
  }

  wait 3;
  var0.support_equipment = 2;
}

function ally_equipment_backpack_icon(var0, var1) {
  level.player endon("death");
  level.player.ally_equipment_force_ping = 0;
  var0 endon("death");
  var0.icon = undefined;
  var0.icon_spot = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  var0.icon_spot linkTo(var0, "j_spine4", (-5, 6, 0), (0, 0, 0));
  var0.display_equipment = 0;
  level.focus_pressed = 0;
  thread distance_notify(var0);

  for(;;) {
    display_icon_logic(var0, var1);
    wait 0.1;
  }
}

function display_icon_logic(var0, var1) {
  var0 endon("death");

  if(var0.support_equipment == 0) {
    return;
  }

  if(level.player.ally_equipment_force_ping || var0.display_equipment || getomnvar("ui_show_objectives")) {
    var0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
    waitframe();
    var0 scripts\engine\utility::ent_flag_set("show_eq_icon");
    var2 = distance(level.player.origin, var0.origin) + 15;
    var0.icon = deleteheadicon(var0.icon_spot);
    setheadiconfriendlyimage(var0.icon, var1);
    setheadiconsnaptoedges(var0.icon, 5000);
    setheadiconmaxdistance(var0.icon, 100);
    setheadicondrawthroughgeo(var0.icon, 1);
    var3 = gettime() + 4000;

    for(;;) {
      if(level.player.ally_equipment_force_ping) {
        if(gettime() > var3) {
          level.player.ally_equipment_force_ping = 0;
        }
      }

      if(var0.support_equipment == 0) {
        var0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
        break;
      }

      if(!getomnvar("ui_show_objectives") && !var0.display_equipment && !level.player.ally_equipment_force_ping) {
        var0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
        break;
      }

      waitframe();
    }

    var0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
    level.player.ally_equipment_force_ping = 0;
    level.player notify("remove_ally_icon");

    if(isDefined(var0.icon)) {
      setheadiconimage(var0.icon);
      var0.icon = undefined;
      return;
    }

    return;
  }
}

function display_icon_shutdown_logic(var0) {
  var0 endon("death");
  var0 scripts\engine\utility::ent_flag_waitopen("show_eq_icon");

  if(isDefined(var0.icon)) {
    return;
  }
}

function distance_notify(var0) {
  wait 0.5;
  var0 endon("death");
  var1 = 0.93;

  for(;;) {
    var2 = distance(level.player.origin, var0.origin);

    if(100 > var2 && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var0.origin + (0, 0, 40), var1)) {
      var0.display_equipment = 1;
      level.player notify("ally_equipment_notify");
    } else {
      var0.display_equipment = 0;
    }

    wait 0.2;
  }
}

function distance_checker(var0) {
  var1 = gettime() + 5000;

  for(;;) {
    var2 = distance(level.player.origin, var0.origin);

    if(100 < var2) {
      level.player notify("show_icon");
    }

    waitframe();
  }
}

function ally_equipment_remove() {
  scripts\engine\utility::waittill_any("remove_equipment", "remove_other_ai_hint");
  self.icon_spot notify("trigger");
  self.icon_spot thread scripts\sp\player\cursor_hint::remove_cursor_hint();
  self.support_equipment = 0;
}