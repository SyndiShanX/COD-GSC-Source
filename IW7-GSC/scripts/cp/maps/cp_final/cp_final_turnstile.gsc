/***********************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_final\cp_final_turnstile.gsc
***********************************************************/

turnstile_init() {
  level.turnstile = getent("turnstile", "targetname");
  level.turnstile thread turnstile_damage_listener();
  level thread shoot_piece_into_machine();
  level.turnstile_portal = scripts\engine\utility::getstruct("turnstile_portal", "targetname");
  if(!isDefined(level.turnstile_portal)) {
    level.turnstile_portal = spawnStruct();
    level.turnstile_portal.origin = (2403.5, 6996, 455);
  }

  level.turnstile_portal.var_C5D9 = 0;
  level._effect["turnstile_teleport"] = loadfx("vfx\iw7\levels\cp_town\vfx_town_telep_diss.vfx");
  level._effect["turnstile_teleport_loop"] = loadfx("vfx\iw7\levels\cp_final\turnstile\vfx_loop_telep.vfx");
}

turnstile_damage_listener() {
  level endon("turnstile_success");
  self setModel("cp_disco_subway_turnstyle");
  self setCanDamage(1);
  var_0 = undefined;
  for(;;) {
    self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    if(isDefined(var_10)) {
      if(var_10 == "iw7_entangler2_zm") {
        var_2.has_turnstile = 1;
        var_0 = var_2;
        level.turnstile_piece = spawn("script_model", var_4);
        var_11 = "cp_final_subway_turnstyle_arm";
        level.turnstile_piece setModel(var_11);
        var_0.entangledmodel = level.turnstile_piece;
        break;
      }
    }
  }

  self setModel("cp_disco_subway_turnstyle_missing_arm");
  var_12 = spawnStruct();
  level.turnstile_piece.collisionfunc = ::check_turnstile_collision;
  level.turnstile_piece thread turnstile_check();
  scripts\cp\crafted_entangler::entangleitem(var_0, var_12, level.turnstile_piece);
}

check_turnstile_collision(var_0, var_1, var_2) {
  level endon("game_ended");
  level endon("turnstile_success");
  var_0 waittill("collision");
  level.turnstile_piece delete();
  level.turnstile thread turnstile_damage_listener();
}

shoot_piece_into_machine() {
  for(;;) {
    level waittill("70s_activated");
    var_0 = spawn("script_model", level.turnstile_portal.origin);
    level.turnstile_portal.var_C5D9 = 1;
    var_0 setModel("tag_origin_turnstile_portal");
    level thread portal_timer(100);
    var_1 = scripts\engine\utility::waittill_any_return("portal_timeout", "turnstile_success");
    level.turnstile_portal.var_C5D9 = 0;
    var_0 setscriptablepartstate("portal", "portal_end");
    if(var_1 == "turnstile_success") {
      foreach(var_3 in level.players) {
        var_3 scripts\cp\zombies\achievement::update_achievement("MESSAGE_SENT", 1);
      }

      level.turnstile_piece delete();
      return;
    }
  }
}

portal_timer(var_0) {
  wait(var_0);
  level notify("portal_timeout");
}

turnstile_check() {
  self endon("death");
  var_0 = 0;
  var_1 = 250;
  var_2 = var_1 * var_1;
  for(;;) {
    if(level.turnstile_portal.var_C5D9) {
      if(distancesquared(level.turnstile_portal.origin, self.origin) < var_2) {
        level thread turnstile_sent();
        return;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

turnstile_sent() {
  level notify("turnstile_success");
}