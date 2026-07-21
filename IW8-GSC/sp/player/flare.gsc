/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\player\flare.gsc
***********************************************/

level_flareinit() {
  precachemodel("weapon_zd30_glowstick_wm_lit");
  precachemodel("viewmodel_flare_iw6");
  precachemodel("misc_wm_flarestick_throwable");
  precacheshader("hud_icon_equipment_flare");
  scripts\engine\sp\utility::add_hint_string("flare_ignite", &"WOUNDED/FLARE_IGNITE");
  scripts\engine\sp\utility::add_hint_string("flare_off", &"WOUNDED/FLARE_OFF");
  scripts\engine\sp\utility::add_hint_string("flare_throw", &"WOUNDED/FLARE_THROW");
  scripts\engine\sp\utility::add_hint_string("flare_distract", &"WOUNDED/FLARE_DISTRACT");
  level.g_effect["vfx_ai_glow_stick"] = loadfx("vfx/iw8/level/wounded/vfx_ai_glow_stick");
  level.g_effect["vfx_weapon_flare"] = loadfx("vfx/iw8/level/wounded/vfx_weapon_flare");
  level.flare = spawnStruct();
  level.flare.thrownflares = [];
  level_flaresetcantimeout(0);
  level_flareworldplacedenable();
  var_0 = level_getflareofftriggers();
  scripts\engine\utility::array_thread(var_0, ::level_flareofftriggerlogic);
  level.g_effect["vfx_player_flare"] = loadfx("vfx/iw8/level/wounded/vfx_player_flare");
  level.g_effect["vfx_player_flare_light"] = loadfx("vfx/iw8/level/wounded/vfx_player_flare_light");
  level.g_effect["vfx_player_flare_off"] = loadfx("vfx/iw8/level/wounded/vfx_player_flare_off");
  level.flare.player = spawnStruct();
  level.flare.player.model = spawn("script_model", (0, 0, 0));

  if(player_isholdingspecialflareweapon()) {
    level.flare.player.model setModel("viewmodel_flare_iw6");
    level.flare.player.model hidepart("J_Striker_Cap");
  } else
    level.flare.player.model setModel("tag_origin");

  level.flare.player.model linktoplayerview(level.player, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 1, "none");
  level.flare.player.lighttag = spawn("script_model", (0, 0, 0));
  level.flare.player.lighttag setModel("tag_origin");
  level.flare.player.lighttag linktoplayerview(level.player, "tag_view", (-7, 5, -3), (0, 0, 90), 1, "none");
  player_setflareequipment(0);
  player_flaresetammo(0);
  player_flaresetremainingtime(0);
  player_flaresetcantimeout(1);
  player_flaresetcanthrow(1);
  player_flaresetcanuse(1);
  player_flaresetcanturnoff(1);
  player_flaresetautomaticignitehint(0);
  thread player_flarehidemodellogic();
  thread player_flaretogglelogic();
  thread player_flarestealthdetectlogic();
  var_1 = player_flaregetofftriggers();
  scripts\engine\utility::array_thread(var_1, ::player_flareofftriggerlogic);
}

player_flarehidemodellogic() {
  level.player endon("death");

  for(;;) {
    if(player_flareshouldhidemodel())
      level.flare.player.model hide();
    else
      level.flare.player.model show();

    waitframe();
  }
}

player_flareshouldhidemodel() {
  if(level.player ismeleeing() && !player_isholdingspecialflareweapon())
    return 1;

  if(level.player playermount())
    return 1;

  if(level.player isthrowinggrenade())
    return 1;

  if(level.player isonladder())
    return 1;

  return 0;
}

player_flaregive(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  player_flaresetammo(var_0);
  player_setflareequipment(1);
  level.player notifyonplayercommand("toggle_flare", "+actionslot 1");
  level.player scripts\engine\sp\utility::actionslotoverride(1, "hud_icon_equipment_flare", level.flare.player.ammo);

  if(player_getmaxflareammo() == 1)
    level.player scripts\engine\sp\utility::setactionslotoverrideammo(1, -1);
}

player_flaretake(var_0) {
  player_setflareequipment(0);
  level.player scripts\engine\sp\utility::actionslotoverrideremove(1);

  if(player_usingflare())
    player_flareturnoff();
}

level_flareworldplacedenable() {
  var_0 = level_flaregetworldplaced();

  foreach(var_2 in var_0)
  playFXOnTag(level.g_effect["vfx_ai_glow_stick"], var_2, "tag_fx");
}

level_flaregetworldplaced() {
  return getEntArray("level_flareWorldPlaced", "targetname");
}

level_flaretimeoutlogic(var_0) {
  var_0 endon("death");
  var_0.accumulatedtime = 0;

  if(istrue(var_0.isthrown)) {
    level.flare.thrownflares = scripts\engine\utility::array_removeundefined(level.flare.thrownflares);

    if(level.flare.thrownflares.size > 3) {
      var_1 = level.flare.thrownflares[0];

      foreach(var_3 in level.flare.thrownflares) {
        if(var_3.accumulatedtime > var_1.accumulatedtime)
          var_1 = var_3;
      }

      level_flareturnoff(var_1);
    }
  }

  for(;;) {
    var_0.accumulatedtime = var_0.accumulatedtime + 0.05;

    if(level_flarecantimeout() && var_0.accumulatedtime >= 60) {
      break;
    }

    waitframe();
  }

  level_flareturnoff(var_0);
}

level_flarecantimeout() {
  return level.flare.cantimeout;
}

level_flaresetcantimeout(var_0) {
  level.flare.cantimeout = var_0;
}

level_flareturnoff(var_0) {
  level notify("level_flareOff");
  killfxontag(level.g_effect["vfx_player_flare"], var_0, "tag_fx");
  var_0 stoploopsound();

  if(isDefined(var_0.interact))
    var_0.interact delete();

  var_0 delete();
}

level_flareofftriggerlogic() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(scripts\engine\utility::is_equal(var_0, level.player)) {
      var_1 = level_getflares();

      foreach(var_3 in var_1)
      level_flareturnoff(var_3);

      self delete();
    }
  }
}

level_getflareofftriggers() {
  return getEntArray("level_flareOff", "targetname");
}

level_getflares() {
  return getEntArray("level_flare", "targetname");
}

level_flareailogic(var_0) {
  var_0 endon("death");
  var_1 = [];
  var_2 = 2;

  if(istrue(1.5))
    var_3 = gettime() + 1500.0;
  else
    var_3 = 0;

  for(;;) {
    var_4 = ai_getaliveaiarray("axis");
    var_5 = [];

    foreach(var_7 in var_4) {
      var_8 = distancesquared(var_7.origin, var_0.origin);
      var_9 = var_5.size >= var_2;
      var_10 = var_8 <= 490000;
      var_11 = gettime() >= var_3;

      if(!var_9 && var_10 && var_11) {
        var_12 = scripts\engine\utility::array_contains(var_1, var_7);

        if(!var_12) {
          var_7 aieventlistenerevent("investigate", var_0, var_0.origin);
          var_5 = scripts\engine\utility::array_add(var_5, var_7);
        }
      }
    }

    var_1 = scripts\engine\sp\utility::array_merge(var_5, var_1);
    wait 1.5;
  }
}

level_flareaigoallogic(var_0) {
  var_0 endon("death");
  var_0 waittill("goal");
  var_0 scripts\engine\sp\utility::set_goalRadius(2048);
}

player_flaretogglelogic() {
  level.player endon("death");
  level.player endon("removeActionslot1");

  for(;;) {
    var_0 = level.player scripts\engine\utility::waittill_any_return("toggle_flare", "smoke_pressed");

    if(!player_flarecanuse() || level.player isonladder()) {
      continue;
    }
    var_1 = var_0 == "smoke_pressed";
    var_2 = !var_1;

    if(player_usingflare()) {
      if(var_2 && player_flarecanthrow()) {
        var_3 = player_getflareammo();
        player_flaresetammo(var_3 - 1);
        player_flarethrow();
      }

      continue;
    }

    if(var_2 && player_getflareammo()) {
      thread player_flareturnon(0);
      level.player waittill("player_flareIgnite");
      var_3 = player_getflareammo();
      player_flaresetammo(var_3 - 1);
    }
  }
}

player_flarestealthdetectlogic() {
  level.player endon("death");

  for(;;) {
    waitframe();

    if(!isDefined(level.stealth)) {
      continue;
    }
    if(player_usingflare()) {
      level.stealth.detect.range["hidden"]["prone"] = 400;
      level.stealth.detect.range["hidden"]["crouch"] = 750;
      level.stealth.detect.range["hidden"]["stand"] = 1200;
      continue;
    }

    level.stealth.detect.range["hidden"]["prone"] = 50;
    level.stealth.detect.range["hidden"]["crouch"] = 90;
    level.stealth.detect.range["hidden"]["stand"] = 275;
  }
}

player_flaregetofftriggers() {
  return getEntArray("player_flareOff", "targetname");
}

player_flareofftriggerlogic() {
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(scripts\engine\utility::is_equal(var_0, level.player) && player_usingflare()) {
      player_flareturnoff();
      self delete();
    }
  }
}

player_flaregetremainingtime() {
  return level.flare.player.remainingtime;
}

player_flaresetremainingtime(var_0) {
  level.flare.player.remainingtime = var_0;
}

player_flaresetcantimeout(var_0) {
  level.flare.player.cantimeout = var_0;
}

player_flarecantimeout() {
  return level.flare.player.cantimeout;
}

player_flaresetcanthrow(var_0) {
  level.flare.player.canthrow = var_0;
}

player_flarecanthrow() {
  return level.flare.player.canthrow;
}

player_flaresetcanuse(var_0) {
  level.flare.player.canuse = var_0;
}

player_flarecanuse() {
  return level.flare.player.canuse;
}

player_flaresetcanturnoff(var_0) {
  level.flare.player.canturnoff = var_0;
}

player_flarecanturnoff() {
  return level.flare.player.canturnoff;
}

player_flaregetautomaticignitehint() {
  return level.flare.player.automaticignitehint;
}

player_flaresetautomaticignitehint(var_0) {
  level.flare.player.automaticignitehint = var_0;
}

player_hasflareequipment() {
  return level.flare.player.hasequipment;
}

player_setflareequipment(var_0) {
  level.flare.player.hasequipment = var_0;
}

player_flaretimeout() {
  level.player endon("toggle_flare");
  level.player endon("player_flareOff");

  for(;;) {
    var_0 = player_flaregetremainingtime();

    if(var_0) {
      if(player_flarecantimeout()) {
        var_1 = max(0, var_0 - 0.05);
        player_flaresetremainingtime(var_1);
      }
    } else
      break;

    waitframe();
  }

  thread player_flareturnoff();
}

player_flareturnvfxon() {
  if(scripts\engine\utility::hastag(level.flare.player.model.model, "tag_fx"))
    playFXOnTag(level.g_effect["vfx_player_flare"], level.flare.player.model, "tag_fx");
  else
    playFXOnTag(level.g_effect["vfx_player_flare"], level.flare.player.model, "tag_origin");
}

player_flareturnvfxoff() {
  if(scripts\engine\utility::hastag(level.flare.player.model.model, "tag_fx"))
    killfxontag(level.g_effect["vfx_player_flare"], level.flare.player.model, "tag_fx");
  else
    killfxontag(level.g_effect["vfx_player_flare"], level.flare.player.model, "tag_origin");
}

player_flareturnoff() {
  level.player notify("player_flareOff");
  player_flaresetremainingtime(0);
  stopFXOnTag(level.g_effect["vfx_player_flare_light"], level.flare.player.lighttag, "tag_origin");
  playFXOnTag(level.g_effect["vfx_player_flare_off"], level.flare.player.lighttag, "tag_origin");

  if(player_isholdingspecialflareweapon())
    level.player stopgestureviewmodel("ges_th_flare_ignite", 0.2, 0);

  thread player_flareturnvfxoff();
  level.flare.player.model stoploopsound();

  if(player_flaregetautomaticignitehint())
    scripts\engine\sp\utility::display_hint("flare_ignite", 10.0, 4.0, level.player, "player_flareIgnite");
}

#using_animtree("player");

player_flareturnon(var_0) {
  var_1 = player_isholdingspecialflareweapon() && var_0 || !var_0;

  if(var_1) {
    level.flare.player.model setModel("viewmodel_flare_iw6");
    level.flare.player.model hidepart("J_Striker_Cap");

    if(player_isholdingspecialflareweapon())
      var_2 = "ges_th_flare_ignite";
    else
      var_2 = "ges_th_flare_ignite_weapon";

    level.player forceplaygestureviewmodel(var_2, undefined, 0, 0, 1, 1);
    level.player scripts\common\utility::allow_weapon_switch(0);
    level.player scripts\common\utility::allow_reload(0);
    player_flaresetcanuse(0);
    wait 0.35;

    if(!var_0)
      level.flare.player.model playSound("flare_ignite_plr");

    level.flare.player.model unlinkfromplayerview(level.player);
    level.flare.player.model linktoplayerview(level.player, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 1, "none");
  }

  level.flare.player.remainingtime = 60;
  level.player notify("player_flareIgnite");
  level.flare.player.model playLoopSound("flare_loop");
  player_flareturnvfxon();
  playFXOnTag(level.g_effect["vfx_player_flare_light"], level.flare.player.lighttag, "tag_origin");

  if(var_1) {
    if(player_isholdingspecialflareweapon())
      var_3 = getanimlength(%th_vm_flare_turnon);
    else
      var_3 = level.player getgestureanimlength("ges_th_flare_ignite_weapon");

    if(var_3 > 0.35) {
      var_4 = var_3 - 0.35;
      wait(var_4);
    }

    level.player scripts\common\utility::allow_weapon_switch(1);
    level.player scripts\common\utility::allow_reload(1);
    player_flaresetcanuse(1);
  }

  if(!player_isholdingspecialflareweapon()) {
    level.flare.player.model setModel("tag_origin");
    level.flare.player.model unlinkfromplayerview(level.player);
    level.flare.player.model linktoplayerview(level.player, "tag_view", (-7, 5, -3), (90, 0, 0), 1, "none");
  }

  thread player_flareloopgesturelogic();
}

player_flareloopgesturelogic() {
  level.player endon("player_flareOff");
  var_0 = getanimlength(%th_vm_flare_turnon);
  var_1 = getanimlength(%th_vm_flare_idle);
  var_2 = level.player.currentweapon;
  var_3 = player_flarecanloopgesture();

  for(;;) {
    var_4 = player_flarecanloopgesture();

    if(var_4) {
      if(var_3) {
        level.player forceplaygestureviewmodel("ges_th_flare_ignite", undefined, 0, var_0);
        var_5 = var_0;
      } else {
        level.player forceplaygestureviewmodel("ges_th_flare_ignite", undefined, 0, 0, 1, 1);
        var_5 = var_1;
      }
    } else {
      level.player stopgestureviewmodel("ges_th_flare_ignite", 0, 1);
      var_5 = 0.05;
    }

    var_6 = level.player scripts\engine\utility::waittill_notify_or_timeout_return("weapon_change", var_5);

    if(var_6 == "weapon_change") {
      var_7 = player_weaponisspecialflareweapon(var_2);
      var_8 = player_isholdingspecialflareweapon();
      var_9 = var_7 && !var_8;
      var_10 = !var_7 && var_8;

      if(var_9) {
        level.flare.player.model unlinkfromplayerview(level.player);
        level.flare.player.model linktoplayerview(level.player, "tag_view", (-7, 5, -3), (90, 0, 0), 1, "none");
        stopFXOnTag(level.g_effect["vfx_player_flare"], level.flare.player.model, "tag_fx");
        level.flare.player.model setModel("tag_origin");
        playFXOnTag(level.g_effect["vfx_player_flare"], level.flare.player.model, "tag_origin");
        level.player stopgestureviewmodel("ges_th_flare_ignite", 0.2, 0);
        level.player waittill("weapon_change");
      } else if(var_10) {
        level.flare.player.model unlinkfromplayerview(level.player);
        level.flare.player.model linktoplayerview(level.player, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 1, "none");
        stopFXOnTag(level.g_effect["vfx_player_flare"], level.flare.player.model, "tag_origin");
        level.flare.player.model setModel("viewmodel_flare_iw6");
        level.flare.player.model hidepart("J_Striker_Cap");
        playFXOnTag(level.g_effect["vfx_player_flare"], level.flare.player.model, "tag_fx");
      }
    }

    var_3 = var_4;
    var_2 = level.player.currentweapon;
  }
}

player_flarecanloopgesture() {
  if(level.player isthrowinggrenade())
    return 0;

  if(level.player islinked())
    return 0;

  if(!level.player isweaponsenabled())
    return 0;

  if(!player_isholdingspecialflareweapon())
    return 0;

  return 1;
}

player_flarethrow() {
  level.player notify("flare_throw");
  level.player stopgestureviewmodel("ges_th_flare_ignite", 0, 1);
  level.player forceplaygestureviewmodel("ges_th_flare_throw");
  level.player scripts\common\utility::allow_offhand_primary_weapons(0);
  level.player scripts\common\utility::allow_reload(0);
  player_flaresetcanuse(0);
  wait 0.2;
  thread player_flareturnvfxoff();
  level.flare.player.model unlinkfromplayerview(level.player);
  level.flare.player.model linktoplayerview(level.player, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 1, "none");
  level.flare.player.model setModel("viewmodel_flare_iw6");
  level.flare.player.model hidepart("J_Striker_Cap");
  thread player_flareturnvfxon();
  wait 0.1;
  level.flare.player.model unlinkfromplayerview(level.player);
  level.flare.player.model linktoplayerview(level.player, "tag_view", (-7, 5, -3), (0, 0, 0), 1, "none");
  level.player scripts\common\utility::allow_reload(1);
  level.player scripts\common\utility::allow_offhand_primary_weapons(1);
  player_flaresetcanuse(1);
  player_flareturnoff();
  var_0 = [];
  var_0["prone"] = 600;
  var_0["crouch"] = 675;
  var_0["stand"] = 975;
  var_1 = var_0[level.player getstance()];
  var_2 = anglesToForward(level.player getplayerangles());
  var_3 = level.player getEye() + var_2 * 20;
  var_4 = level_spawnflare(var_3, var_2, var_1, 1);
  thread level_flareailogic(var_4);
}

level_spawnstaticflare(var_0, var_1) {
  var_2 = scripts\sp\script_items::scriptitem_buildspawnflags(0, 1, 1, 0, 1);
  var_3 = spawnscriptitem("script_item_level_flare", var_0, var_1, var_2, "misc_wm_flarestick_throwable", "", (0, 0, 0), var_0);
  playFXOnTag(level.g_effect["vfx_weapon_flare"], var_3, "tag_fx");
  var_3 playLoopSound("flare_loop");
  var_3.targetname = "level_flare";
  thread player_flarepickuplogic(var_3);
  thread level_flaretimeoutlogic(var_3);
  thread level_flareatrestmonitor(var_3);
  return var_3;
}

level_spawnflare(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1))
    var_1 = (0, 0, 0);

  if(!isDefined(var_2))
    var_2 = 0;

  var_4 = scripts\sp\script_items::scriptitem_buildspawnflags(0, 1, 1, 0, 1);
  var_5 = var_1 * var_2;
  var_6 = (0, 0, 0);

  if(istrue(var_3))
    var_6 = (83, 0, 0);

  var_7 = spawnscriptitem("script_item_level_flare", var_0, var_6, var_4, "misc_wm_flarestick_throwable", "", var_5, var_0);
  playFXOnTag(level.g_effect["vfx_weapon_flare"], var_7, "tag_fx");
  var_7 playLoopSound("flare_loop");
  var_7.targetname = "level_flare";

  if(istrue(var_3)) {
    var_7.isthrown = 1;
    level.flare.thrownflares = scripts\engine\utility::array_removeundefined(level.flare.thrownflares);
    level.flare.thrownflares[level.flare.thrownflares.size] = var_7;
  }

  thread player_flarepickuplogic(var_7);
  thread level_flaretimeoutlogic(var_7);
  thread level_flareatrestmonitor(var_7);
  return var_7;
}

level_flareatrestmonitor(var_0) {
  var_0 endon("death");
  var_0 endon("entitydeleted");
  var_1 = 0.25;
  var_2 = var_0.origin;
  var_0.atrest = 0;
  var_3 = 12;

  for(;;) {
    var_2 = var_0.origin;
    wait(var_1);
    var_4 = length(var_0.origin - var_2);

    if(var_4 > var_3 * var_1) {
      var_0.atrest = 0;
      continue;
    }

    var_0.atrest = 1;
  }
}

player_flarepickuplogic(var_0) {
  var_0 endon("death");

  if(istrue(level.flare_pickup_disabled)) {
    return;
  }
  var_0.interact = scripts\engine\utility::spawn_tag_origin(var_0 gettagorigin("tag_origin"));
  var_0.interact linkTo(var_0, "tag_origin");
  var_0.interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"SCRIPT/PICKUP", 50, 125, 125, 0, undefined, undefined, undefined, "duration_none", undefined, undefined, 45);
  var_0.interact notsolid();
  thread player_flareconditionalpickup(var_0);
  var_0.interact waittill("trigger");
  player_flarepickupsingle(var_0);
  var_0.interact delete();
  killfxontag(level.g_effect["vfx_player_flare"], var_0, "tag_fx");
  var_0 stoploopsound();
  var_0 delete();
}

player_flareconditionalpickup(var_0) {
  var_0 endon("death");
  var_0.interact endon("death");

  while(isDefined(var_0.interact)) {
    if(player_getflareammo() >= player_getmaxflareammo()) {
      var_0.interact unlink();
      var_0.interact.origin = var_0 gettagorigin("tag_origin") - (0, 0, 10000);
    }

    while(player_getflareammo() >= player_getmaxflareammo())
      wait 0.25;

    var_0.interact.origin = var_0 gettagorigin("tag_origin");
    var_0.interact linkTo(var_0, "tag_origin");

    while(player_getflareammo() < player_getmaxflareammo())
      wait 0.25;

    wait 0.05;
  }
}

player_flarepickupsingle(var_0) {
  var_0 endon("death");

  if(istrue(level.flarefastpickup))
    player_flaresetcanuse(0);
  else {
    level.player forceplaygestureviewmodel("ges_swipe");
    player_flaresetcanuse(0);
    wait 0.35;
  }

  if(!player_hasflareequipment())
    player_flaregive(0);
  else {
    var_1 = player_getflareammo();
    player_flaresetammo(var_1 + 1);
  }

  if(!player_usingflare()) {
    if(player_isholdingspecialflareweapon()) {
      level.player stopgestureviewmodel("ges_swipe", 0, 1);
      thread player_flareturnon(1);
      level.player waittill("player_flareIgnite");
    } else
      player_flareturnon(1);
  }

  thread scripts\engine\utility::play_sound_in_space("weap_pickup", level.player.origin);
  player_flaresetcanuse(1);
}

player_isholdingspecialflareweapon() {
  if(!isDefined(level.player.currentweapon))
    return 0;

  if(level.player.currentweapon.basename == "none")
    return 0;

  return player_weaponisspecialflareweapon(level.player.currentweapon);
}

player_weaponisspecialflareweapon(var_0) {
  var_1 = player_getflareweapons();
  return scripts\engine\utility::array_contains(var_1, var_0);
}

player_getflareweapons() {
  return [getcompleteweaponname("iw8_gunless")];
}

player_usingflare() {
  return level.flare.player.remainingtime;
}

player_waittillusingflare() {
  while(!player_usingflare())
    waitframe();
}

player_getmaxflareammo() {
  if(isDefined(level.flare) && isDefined(level.flare.player) && isDefined(level.flare.player.ammomax))
    return level.flare.player.ammomax;

  return 1;
}

player_getflareammo() {
  return level.flare.player.ammo;
}

player_flaresetammo(var_0) {
  var_1 = player_getmaxflareammo();
  level.flare.player.ammo = int(clamp(var_0, 0, var_1));

  if(!player_hasflareequipment()) {
    return;
  }
  if(var_1 == 1) {
    if(level.flare.player.ammo > 0)
      level.player setweaponhudiconoverride("actionslot1", "hud_icon_equipment_flare");
    else
      level.player setweaponhudiconoverride("actionslot1", "none");
  } else
    level.player scripts\engine\sp\utility::setactionslotoverrideammo(1, level.flare.player.ammo);
}

ai_getaliveaiarray(var_0) {
  if(isDefined(var_0))
    var_1 = getaiarray(var_0);
  else
    var_1 = getaiarray();

  var_1 = array_removedeaddyingorundefined(var_1);
  return var_1;
}

array_removedeaddyingorundefined(var_0) {
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
  return var_0;
}