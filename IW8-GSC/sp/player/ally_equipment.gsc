/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\player\ally_equipment.gsc
***********************************************/

ally_equipment_init() {
  precachemodel("offhand_vm_molotov");
  level.focus_pressed = 0;
}

ally_equipment_backpack(var_0, var_1) {
  var_0 endon("death");

  if(!var_0 scripts\engine\utility::ent_flag_exist("show_eq_icon"))
    var_0 scripts\engine\utility::ent_flag_init("show_eq_icon");

  var_2 = undefined;
  var_3 = 0;
  var_4 = undefined;

  switch (var_1) {
    case "flash":
      var_5 = "hud_icon_equipment_flash";
      var_2 = "flash_full";
      break;
    case "frag":
      var_5 = "hud_icon_equipment_frag";
      var_2 = "frag_full";
      break;
    case "molotov":
      var_5 = "hud_icon_equipment_molotov";
      var_2 = "molotov_full";
      break;
    case "smoke":
      var_5 = "hud_icon_equipment_smoke";
      var_2 = "smoke_full";
      break;
    case "iw8_la_rpapa7_straight_slow":
    case "iw8_la_rpapa7_straight":
    case "iw8_la_rpapa7":
      var_5 = "hud_icon_loot_ammo_rocket";
      var_2 = "rpg_full";
      var_3 = 1;
      var_4 = "RPG Ammo";
      break;
    default:
      var_5 = undefined;
      var_2 = "flash_full";
      break;
  }

  var_0.icon_spot = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  var_0.icon_spot dontinterpolate();
  var_0.icon_spot linkTo(var_0, "j_spine4", (-5, 6, 0), (0, 0, 0));
  var_0.model_spot = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  var_0.model_spot dontinterpolate();
  var_0.model_spot linkTo(var_0, "j_spine4", (-5, 7, 0), (90, 0, 0));
  thread ally_equipment_backpack_icon(var_0, var_5);
  ally_equipment_backpack_interact(var_0, var_1, var_5, var_2, var_4);
}

ally_equipment_backpack_interact(var_0, var_1, var_2, var_3, var_4) {
  var_0 notify("remove_equipment");
  var_0 endon("death");

  for(;;) {
    wait 0.1;

    if(var_0.support_equipment <= 0) {
      while(var_0.support_equipment <= 0)
        wait 0.1;
    }

    var_5 = scripts\engine\utility::string(var_0.support_equipment);
    var_0.icon_spot scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), var_4, 40, 200, 100, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, 30);
    var_0 thread ally_equipment_remove();
    var_0.icon_spot waittill("trigger");
    waitframe();

    if(var_0.support_equipment == 0) {
      while(!var_0.support_equipment)
        waitframe();

      continue;
    }

    var_6 = level.player getammocount(getcompleteweaponname(var_1));
    var_7 = weaponmaxammo(var_1);
    var_8 = var_7 - var_6;
    var_9 = 0;

    if(getDvar("LMMLNRSLKS") == "autobuild")
      getentitylessscriptablearray("sp_ally_equipment", ["type", var_3, "levelname", level.script, "x", level.player.origin[0], "y", level.player.origin[1], "z", level.player.origin[2], "checkpoint", level.start_point, "ally", var_0.script_friendname]);

    if(var_6 != var_7) {
      if(var_8 <= var_0.support_equipment) {
        var_9 = var_8 + var_6;
        var_0.support_equipment = 0;
      } else {
        var_9 = var_0.support_equipment + var_6;
        var_0.support_equipment = 0;
      }

      level.player scripts\engine\sp\utility::player_gesture_force("ges_swipe");
      wait 0.3;
      level.player playSound("prox_explo_bounce_default");
      level.player playRumbleOnEntity("damage_heavy");

      if(var_3 == "rpg_full") {
        level.player givemaxammo(var_1);
        level.player switchtoweapon(var_1);
        level.player setweaponammoclip(var_1, weaponclipsize(var_1));
      } else {
        level.player scripts\engine\sp\utility::give_offhand(var_1, var_9);
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

ally_increase_equipment(var_0) {
  while(var_0.support_equipment > 0)
    wait 0.1;

  wait 3;
  var_0.support_equipment = 2;
}

ally_equipment_backpack_icon(var_0, var_1) {
  level.player endon("death");
  level.player.ally_equipment_force_ping = 0;
  var_0 endon("death");
  var_0.icon = undefined;
  var_0.icon_spot = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  var_0.icon_spot linkTo(var_0, "j_spine4", (-5, 6, 0), (0, 0, 0));
  var_0.display_equipment = 0;
  level.focus_pressed = 0;
  thread distance_notify(var_0);

  for(;;) {
    display_icon_logic(var_0, var_1);
    wait 0.1;
  }
}

display_icon_logic(var_0, var_1) {
  var_0 endon("death");

  if(var_0.support_equipment == 0) {
    return;
  }
  if(level.player.ally_equipment_force_ping || var_0.display_equipment || getomnvar("ui_show_objectives")) {
    var_0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
    waitframe();
    var_0 scripts\engine\utility::ent_flag_set("show_eq_icon");
    var_2 = distance(level.player.origin, var_0.origin) + 15;
    var_0.icon = deleteheadicon(var_0.icon_spot);
    setheadiconfriendlyimage(var_0.icon, var_1);
    setheadiconsnaptoedges(var_0.icon, 5000);
    setheadiconmaxdistance(var_0.icon, 100);
    setheadicondrawthroughgeo(var_0.icon, 1);
    var_3 = gettime() + 4000;

    for(;;) {
      if(level.player.ally_equipment_force_ping) {
        if(gettime() > var_3)
          level.player.ally_equipment_force_ping = 0;
      }

      if(var_0.support_equipment == 0) {
        var_0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
        break;
      }

      if(!getomnvar("ui_show_objectives") && !var_0.display_equipment && !level.player.ally_equipment_force_ping) {
        var_0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
        break;
      }

      waitframe();
    }

    var_0 scripts\engine\utility::ent_flag_clear("show_eq_icon");
    level.player.ally_equipment_force_ping = 0;
    level.player notify("remove_ally_icon");

    if(isDefined(var_0.icon)) {
      setheadiconimage(var_0.icon);
      var_0.icon = undefined;
    }
  }
}

display_icon_shutdown_logic(var_0) {
  var_0 endon("death");
  var_0 scripts\engine\utility::ent_flag_waitopen("show_eq_icon");

  if(isDefined(var_0.icon))
    return;
}

distance_notify(var_0) {
  wait 0.5;
  var_0 endon("death");
  var_1 = 0.93;

  for(;;) {
    var_2 = distance(level.player.origin, var_0.origin);

    if(100 > var_2 && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0.origin + (0, 0, 40), var_1)) {
      var_0.display_equipment = 1;
      level.player notify("ally_equipment_notify");
    } else
      var_0.display_equipment = 0;

    wait 0.2;
  }
}

distance_checker(var_0) {
  var_1 = gettime() + 5000;

  for(;;) {
    var_2 = distance(level.player.origin, var_0.origin);

    if(100 < var_2)
      level.player notify("show_icon");

    waitframe();
  }
}

ally_equipment_remove() {
  scripts\engine\utility::waittill_any("remove_equipment", "remove_other_ai_hint");
  self.icon_spot notify("trigger");
  self.icon_spot thread scripts\sp\player\cursor_hint::remove_cursor_hint();
  self.support_equipment = 0;
}