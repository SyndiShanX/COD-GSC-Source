/***********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
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
  var_00 = undefined;
  for(;;) {
    self waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A);
    if(isDefined(var_0A)) {
      if(var_0A == "iw7_entangler2_zm") {
        var_02.has_turnstile = 1;
        var_00 = var_02;
        level.turnstile_piece = spawn("script_model", var_04);
        var_0B = "cp_final_subway_turnstyle_arm";
        level.turnstile_piece setModel(var_0B);
        var_00.entangledmodel = level.turnstile_piece;
        break;
      }
    }
  }

  self setModel("cp_disco_subway_turnstyle_missing_arm");
  var_0C = spawnStruct();
  level.turnstile_piece.collisionfunc = ::check_turnstile_collision;
  level.turnstile_piece thread turnstile_check();
  scripts\cp\crafted_entangler::entangleitem(var_00, var_0C, level.turnstile_piece);
}

check_turnstile_collision(param_00, param_01, param_02) {
  level endon("game_ended");
  level endon("turnstile_success");
  param_00 waittill("collision");
  level.turnstile_piece delete();
  level.turnstile thread turnstile_damage_listener();
}

shoot_piece_into_machine() {
  for(;;) {
    level waittill("70s_activated");
    var_00 = spawn("script_model", level.turnstile_portal.origin);
    level.turnstile_portal.var_C5D9 = 1;
    var_00 setModel("tag_origin_turnstile_portal");
    level thread portal_timer(100);
    var_01 = scripts\engine\utility::waittill_any_return("portal_timeout", "turnstile_success");
    level.turnstile_portal.var_C5D9 = 0;
    var_00 setscriptablepartstate("portal", "portal_end");
    if(var_01 == "turnstile_success") {
      foreach(var_03 in level.players) {
        var_03 scripts\cp\zombies\achievement::update_achievement("MESSAGE_SENT", 1);
      }

      level.turnstile_piece delete();
      return;
    }
  }
}

portal_timer(param_00) {
  wait(param_00);
  level notify("portal_timeout");
}

turnstile_check() {
  self endon("death");
  var_00 = 0;
  var_01 = 250;
  var_02 = var_01 * var_01;
  for(;;) {
    if(level.turnstile_portal.var_C5D9) {
      if(distancesquared(level.turnstile_portal.origin, self.origin) < var_02) {
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