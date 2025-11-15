/*******************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\detonategrenades.gsc
*******************************************/

init() {
  level.var_7649["c4_light_blink"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  level.var_7649["frag_tel_radius"] = loadfx("vfx\iw7\core\equipment\frag\vfx_frag_tel_radius.vfx");
  level.player scripts\sp\utility::func_65E0("no_grenade_block_gesture");
  scripts\engine\utility::array_thread(level.players, ::watchgrenadeusage);
  scripts\engine\utility::array_thread(level.players, ::func_13B17);
  level.newteamhudelem = spawnStruct();
  level.newteamhudelem.var_B37A = [];
  level.newteamhudelem.var_A8C6 = undefined;
  scripts\engine\utility::flag_init("frag_force_delete");
}

func_10409() {
  var_00 = [];
  var_00["r_hudoutlineWidth"] = 1;
  var_00["r_hudoutlineFillColor1"] = "0 0 0 1";
  var_00["r_hudoutlineFillColor0"] = "0.8 0.8 0.8 1";
  var_00["r_hudoutlineOccludedOutlineColor"] = "0.8 0.8 0.8 1";
  var_00["r_hudoutlineOccludedInteriorColor"] = "0.5 0.5 0.5 .2";
  var_00["r_hudoutlineOccludedInlineColor"] = "0.5 0.5 0.5 .5";
  var_00["r_hudoutlineFillColor1"] = "0.8 0.8 0.8 .2";
  var_00["r_hudOutlineOccludedColorFromFill"] = 1;
  return var_00;
}

func_10408() {
  scripts\sp\utility::func_9196(1, 1, 1, "sonic");
  wait(0.15);
  scripts\sp\utility::func_9193("sonic");
}

func_13995() {
  self endon("death");
  scripts\sp\utility::func_9187("sonic", 190, ::func_10409);
  for(;;) {
    var_00 = self getcurrentweapon();
    if(!isDefined(var_00) || self getweaponrankinfominxp() < 0.5) {
      wait(0.05);
      continue;
    }

    if(getweaponbasename(var_00) == "iw7_kbs" && scripts\sp\utility::func_9FFE(var_00)) {
      var_01 = getaiarray("axis");
      foreach(var_03 in var_01) {
        if(!isalive(var_03)) {
          continue;
        }

        var_04 = distance2dsquared(var_03.origin, self.origin);
        var_05 = 0;
        var_03 scripts\engine\utility::delaythread(var_05, ::func_10408);
      }
    }

    wait(2.5);
  }
}

watchgrenadeusage() {
  self endon("death");
  childthread begingrenadetracking();
  self.throwinggrenade = 0;
  for(;;) {
    self waittill("grenade_pullback", var_00);
    self.throwinggrenade = 1;
    scripts\engine\utility::waittill_any_3("grenade_fire", "weapon_switch_started");
    self.throwinggrenade = 0;
  }
}

begingrenadetracking() {
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);
    if(isDefined(var_00) && scripts\engine\utility::istrue(var_00._meth_8589)) {
      continue;
    }

    if(isDefined(level.func["player_grenade_thrown"])) {
      level thread[[level.func["player_grenade_thrown"]]](var_00);
    }

    switch (var_01) {
      case "seeker_autohold":
      case "seeker":
        thread lib_0E26::func_F135(var_00);
        break;

      case "antigrav":
        thread lib_0E21::func_2013(var_00);
        break;

      case "emp":
        thread lib_0E25::func_615B(var_00);
        break;

      case "coverwall":
        thread scripts\sp\coverwall::func_475F(var_00);
        break;

      case "frag_up1":
      case "frag":
        thread func_734F(var_00);
        if(self == level.player) {
          level.player thread scripts\anim\battlechatter_ai::func_67CF("frag");
        }
        break;

      case "c8_grenade":
        thread func_734F(var_00);
        thread func_3465(var_00);
        break;

      default:
        break;
    }
  }
}

func_DBDB(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07) {
  var_08 = scripts\engine\utility::ter_op(isDefined(param_03), param_03, 600);
  if(distance2dsquared(level.player.origin, param_00) > var_08 * var_08) {
    return;
  }

  if(isDefined(level.var_58DB)) {
    return;
  }

  level.var_58DB = 1;
  var_09["r_mbenable"] = getdvar("r_mbenable");
  var_09["r_mbRadialOverridePosition"] = getdvar("r_mbRadialOverridePosition");
  var_09["r_mbRadialOverridePositionActive"] = getdvarint("r_mbRadialOverridePositionActive");
  var_09["r_mbradialoverridestrength"] = getdvarfloat("r_mbradialoverridestrength");
  var_09["r_mbradialoverrideradius"] = getdvarfloat("r_mbradialoverrideradius");
  setsaveddvar("r_mbenable", 1);
  setsaveddvar("r_mbRadialOverridePosition", param_00);
  setsaveddvar("r_mbRadialOverridePositionActive", 1);
  var_0A = scripts\engine\utility::ter_op(isDefined(param_02), param_02, 270);
  param_01 = scripts\engine\utility::ter_op(isDefined(param_01), param_01, 0.135848);
  var_0B = param_01 / 4;
  param_04 = scripts\engine\utility::ter_op(isDefined(param_04), param_04, -0.107266);
  param_05 = scripts\engine\utility::ter_op(isDefined(param_05), param_05, 0.05);
  param_06 = scripts\engine\utility::ter_op(isDefined(param_06), param_06, 0.5);
  var_0C = distance2d(level.player.origin, param_00);
  var_0D = scripts\sp\math::func_C097(var_08, var_0A, var_0C);
  var_0E = scripts\sp\math::func_6A8E(param_01, var_0B, var_0D);
  var_0E = clamp(var_0E, 0, 1);
  if(!isDefined(param_07)) {
    if(!scripts\common\trace::ray_trace_passed(param_00 + (0, 0, 12), level.player getEye())) {
      var_0E = var_0E * 0.5;
      var_0E = clamp(var_0E, 0, 1);
    }
  }

  setsaveddvar("r_mbradialoverridestrength", var_0E);
  setsaveddvar("r_mbradialoverrideradius", param_04);
  wait(param_05);
  thread scripts\sp\utility::func_AB9A("r_mbradialoverridestrength", var_09["r_mbradialoverridestrength"], param_06);
  thread scripts\sp\utility::func_AB9A("r_mbradialoverrideradius", var_09["r_mbradialoverrideradius"], param_06);
  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", param_06);
  setsaveddvar("r_mbenable", var_09["r_mbenable"]);
  setsaveddvar("r_mbRadialOverridePosition", var_09["r_mbRadialOverridePosition"]);
  setsaveddvar("r_mbRadialOverridePositionActive", var_09["r_mbRadialOverridePositionActive"]);
  level.var_58DB = undefined;
}

func_734F(param_00) {
  var_01 = param_00 scripts\engine\utility::spawn_script_origin();
  var_01.objective_position = param_00;
  level.newteamhudelem.var_B37A[level.newteamhudelem.var_B37A.size] = var_01;
  var_01 linkto(param_00, "tag_fx", (0, 0, 0), (0, 0, 0));
  var_02 = func_734E();
  param_00 func_13771(var_01);
  var_03 = isDefined(var_01.isteamradarblocked);
  var_04 = var_01.origin;
  var_01 func_E011();
  if(!var_03) {
    return;
  }

  if(self == level.player) {
    thread func_734D(var_04, var_02, 256);
    if(isDefined(level.player.var_735A)) {
      thread func_7352(var_04, var_01.var_4D40);
    }
  }

  thread func_DBDB(var_04);
  earthquake(0.7, 0.8, var_04, 600);
  thread scripts\sp\utility::func_54EF(var_04);
  if(level.player scripts\sp\utility::func_65DB("no_grenade_block_gesture") || level.player isthrowinggrenade() || level.player func_8448()) {
    return;
  }

  var_05 = 1;
  var_06 = distance2dsquared(level.player.origin, var_04);
  if(var_05 && var_06 > 102400) {
    var_05 = 0;
  }

  if(var_05 && var_06 > 4096) {
    var_07 = vectordot(scripts\engine\utility::flatten_vector(vectornormalize(var_04 - level.player.origin)), anglesToForward(level.player.angles));
    if(var_07 < 0) {
      var_05 = 0;
    }
  }

  if(var_05) {
    if(!scripts\common\trace::ray_trace_passed(var_04 + (0, 0, 12), level.player getEye(), undefined, scripts\common\trace::create_world_contents())) {
      var_05 = 0;
    }
  }

  if(var_05) {
    level.player thread logplayerendmatchdatamatchresult(var_04);
  }
}

func_13771(param_00) {
  thread func_1376E(param_00);
  thread func_13582(param_00);
  while(isDefined(self)) {
    wait(0.05);
  }
}

func_1376E(param_00) {
  param_00 endon("death");
  self waittill("explode", var_01, var_02);
  param_00.isteamradarblocked = 1;
  param_00.var_4D40 = var_02;
}

func_13582(param_00) {
  param_00 endon("death");
  self waittill("entitydeleted");
  param_00.var_6643 = 1;
}

func_E012() {
  if(isDefined(self.objective_position)) {
    self unlink();
    self.objective_position delete();
  }
}

func_E011() {
  if(!isDefined(self)) {
    return;
  }

  func_E012();
  level.newteamhudelem.var_A8C6 = self.origin;
  level.newteamhudelem.var_B37A = scripts\engine\utility::array_remove(level.newteamhudelem.var_B37A, self);
  self delete();
}

func_DFBF() {
  level notify("removing_all_frags_instantly");
  level endon("removing_all_frags_instantly");
  scripts\engine\utility::flag_set("frag_force_delete");
  foreach(var_01 in level.newteamhudelem.var_B37A) {
    var_01 func_E012();
  }

  scripts\engine\utility::waitframe();
  for(;;) {
    if(level.newteamhudelem.var_B37A.size > 0) {
      scripts\engine\utility::waitframe();
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_clear("frag_force_delete");
}

func_734E() {
  var_00 = [];
  if(self == level.player) {
    foreach(var_02 in getaiarray("axis")) {
      var_03 = spawnStruct();
      var_03.ent = var_02;
      var_03.health = var_02.health;
      var_03.origin = var_02.origin;
      var_00[var_00.size] = var_03;
    }
  }

  return var_00;
}

func_734D(param_00, param_01, param_02, param_03) {
  level.player endon("death");
  level.player notify("new_frag_info_reticles");
  level.player endon("new_frag_info_reticles");
  if(isDefined(param_03)) {
    scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", param_03);
  }

  var_04 = [];
  var_05 = [];
  var_06 = [];
  for(var_07 = 0; var_07 < param_01.size; var_07++) {
    if(distance(param_01[var_07].origin, param_00) > param_02) {
      continue;
    } else if(!isDefined(param_01[var_07].ent) || !isalive(param_01[var_07].ent)) {
      var_04[var_04.size] = param_01[var_07];
      continue;
    } else if(param_01[var_07].ent.health < param_01[var_07].health) {
      var_05[var_05.size] = param_01[var_07];
      continue;
    } else {
      continue;
    }
  }

  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", 0.2);
  var_08 = var_04.size;
  var_09 = var_05.size;
  var_0A = var_06.size;
  var_0B = var_04;
  var_0B = scripts\engine\utility::array_combine(var_0B, var_05);
  var_0B = scripts\engine\utility::array_combine(var_0B, var_06);
  var_0C = 0;
  var_0D = [];
  var_0E = 8;
  for(var_07 = 0; var_07 < var_0E; var_07++) {
    if(isDefined(var_0B[var_07])) {
      var_0F = scripts\engine\utility::spawn_tag_origin();
      var_0F.origin = var_0B[var_07].origin;
      var_0D[var_0D.size] = var_0F;
      setomnvar("ui_fragreticles_" + var_07 + "_target_ent", var_0F);
      if(var_07 < var_08) {
        setomnvar("ui_fragreticles_" + var_07 + "_lock_state", 1);
      } else if(var_07 < var_08 + var_09) {
        if(!isalive(var_0B[var_07])) {
          setomnvar("ui_fragreticles_" + var_07 + "_lock_state", 2);
          var_0F linkto(var_0B[var_07].ent, func_129D(var_0B[var_07].ent), (0, 0, 0), (0, 0, 0));
        }
      } else {
        setomnvar("ui_fragreticles_" + var_07 + "_lock_state", 3);
      }

      continue;
    }

    setomnvar("ui_fragreticles_" + var_07 + "_target_ent", undefined);
    setomnvar("ui_fragreticles_" + var_07 + "_lock_state", 0);
  }

  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", 4);
  for(var_07 = 0; var_07 < var_0E; var_07++) {
    setomnvar("ui_fragreticles_" + var_07 + "_target_ent", undefined);
    setomnvar("ui_fragreticles_" + var_07 + "_lock_state", 0);
  }

  for(var_07 = 0; var_07 < var_0D.size; var_07++) {
    var_0D[var_07] delete();
  }
}

func_129D(param_00) {
  if(isDefined(param_00.classname) && !issubstr(param_00.classname, "seeker")) {
    return "j_SpineUpper";
  }

  return "tag_origin";
}

func_7352(param_00, param_01) {
  self endon("death");
  var_02 = [];
  foreach(var_04 in getaiarray("axis")) {
    if(distance(var_04.origin, param_00) <= 256) {
      if(scripts\common\trace::ray_trace_passed(var_04 gettagorigin("j_SpineUpper"), param_00, var_04, scripts\common\trace::create_solid_ai_contents(1))) {
        var_02[var_02.size] = var_04;
        var_04 thread func_7353();
      }
    }
  }

  if(var_02.size > 0) {
    playFX(level.var_7649["frag_tel_radius"], param_00);
  }

  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", param_01);
  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", 2);
  foreach(var_04 in var_02) {
    var_04 notify("frag_outline_display_done");
  }
}

func_7353() {
  scripts\sp\utility::func_9196(0, 0, 0);
  scripts\engine\utility::waittill_any_3("frag_outline_display_done", "death");
  scripts\sp\utility::func_9193();
}

func_3465(param_00) {
  param_00 waittill("missile_stuck");
  playFXOnTag(level.var_7649["grenade_flash_red"], param_00, "tag_origin");
  param_00 waittill("death");
}

logplayerendmatchdatamatchresult(param_00) {
  self endon("death");
  var_01 = scripts\engine\utility::spawn_tag_origin(param_00, (0, 0, 0));
  thread scripts\engine\utility::delete_on_death(var_01);
  var_02 = "ges_frag_block";
  var_03 = self playgestureviewmodel(var_02, var_01, 1, 0.1);
  thread lockdeathcamera(var_02);
  if(var_03) {
    childthread lib_0E49::func_D092(var_02, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1.4);
    for(;;) {
      self waittill("gesture_stopped", var_02);
      if(var_02 == "ges_frag_block") {
        break;
      }
    }
  }

  self notify("grenade_reaction_gesture_done");
  var_01 delete();
}

lockdeathcamera(param_00) {
  self endon("grenade_reaction_gesture_done");
  self waittill("weapon_switch_started");
  self stopgestureviewmodel(param_00, 0.2);
}

func_1339D(param_00) {
  var_01 = distance(level.player.origin, param_00);
  var_02 = 600;
  if(var_01 > var_02 || var_01 < 256) {
    return;
  }

  var_03 = vectortoangles(level.player.origin - param_00);
  var_04 = 40;
  var_05 = 5;
  var_06 = scripts\sp\math::func_C097(0, var_02, var_01);
  var_07 = scripts\sp\math::func_6A8E(var_05, var_04, var_06);
  level.player viewkick(int(var_07), param_00);
}

func_385C(param_00, param_01) {
  if(isent(self) || isai(self)) {
    var_02 = [self, param_01, level.player];
  } else {
    var_02 = [var_02, level.player];
  }

  if(scripts\common\trace::ray_trace_passed(param_00, param_01.origin, var_02)) {
    return 1;
  }

  if(scripts\common\trace::ray_trace_passed(param_00, param_01 gettagorigin("j_spine4"), var_02)) {
    return 1;
  }

  if(scripts\common\trace::ray_trace_passed(param_00, param_01 getEye(), var_02)) {
    return 1;
  }

  if(scripts\common\trace::ray_trace_passed(param_00, param_01 gettagorigin("j_helmet"), var_02)) {
    return 1;
  }

  return 0;
}

func_385D(param_00) {
  if(scripts\common\trace::ray_trace_passed(param_00, level.player.origin, level.player)) {
    return 1;
  }

  if(scripts\common\trace::ray_trace_passed(param_00, level.player.origin + (0, 0, 30), level.player)) {
    return 1;
  }

  if(scripts\common\trace::ray_trace_passed(param_00, level.player getEye(), level.player)) {
    return 1;
  }

  return 0;
}

getdamageableents(param_00, param_01, param_02, param_03) {
  var_04 = [];
  if(!isDefined(param_02)) {
    param_02 = 0;
  }

  if(!isDefined(param_03)) {
    param_03 = 0;
  }

  for(var_05 = 0; var_05 < level.players.size; var_05++) {
    if(!isalive(level.players[var_05]) || level.players[var_05].sessionstate != "playing") {
      continue;
    }

    var_06 = level.players[var_05].origin + (0, 0, 32);
    var_07 = distance(param_00, var_06);
    if(var_07 < param_01 && !param_02 || func_13C7E(param_00, var_06, param_03, undefined)) {
      var_08 = spawnStruct();
      var_08.isplayer = 1;
      var_08.var_9D26 = 0;
      var_08.issplitscreen = level.players[var_05];
      var_08.damagecenter = var_06;
      var_04[var_04.size] = var_08;
    }
  }

  var_09 = getEntArray("grenade", "classname");
  for(var_05 = 0; var_05 < var_09.size; var_05++) {
    var_0A = var_09[var_05].origin;
    var_07 = distance(param_00, var_0A);
    if(var_07 < param_01 && !param_02 || func_13C7E(param_00, var_0A, param_03, var_09[var_05])) {
      var_08 = spawnStruct();
      var_08.isplayer = 0;
      var_08.var_9D26 = 0;
      var_08.issplitscreen = var_09[var_05];
      var_08.damagecenter = var_0A;
      var_04[var_04.size] = var_08;
    }
  }

  var_0B = getEntArray("destructable", "targetname");
  for(var_05 = 0; var_05 < var_0B.size; var_05++) {
    var_0A = var_0B[var_05].origin;
    var_07 = distance(param_00, var_0A);
    if(var_07 < param_01 && !param_02 || func_13C7E(param_00, var_0A, param_03, var_0B[var_05])) {
      var_08 = spawnStruct();
      var_08.isplayer = 0;
      var_08.var_9D26 = 1;
      var_08.issplitscreen = var_0B[var_05];
      var_08.damagecenter = var_0A;
      var_04[var_04.size] = var_08;
    }
  }

  return var_04;
}

func_13C7E(param_00, param_01, param_02, param_03) {
  var_04 = undefined;
  var_05 = param_01 - param_00;
  if(lengthsquared(var_05) < param_02 * param_02) {
    var_04 = param_01;
  }

  var_06 = vectornormalize(var_05);
  var_04 = param_00 + (var_06[0] * param_02, var_06[1] * param_02, var_06[2] * param_02);
  var_07 = bulletTrace(var_04, param_01, 0, param_03);
  if(getdvarint("scr_damage_debug") != 0) {
    if(var_07["fraction"] == 1) {
      thread debugline(var_04, param_01, (1, 1, 1));
    } else {
      thread debugline(var_04, var_07["position"], (1, 0.9, 0.8));
      thread debugline(var_07["position"], param_01, (1, 0.4, 0.3));
    }
  }

  return var_07["fraction"] == 1;
}

damageent(param_00, param_01, param_02, param_03, param_04, param_05, param_06) {
  if(self.isplayer) {
    self.var_4D5B = param_05;
    self.issplitscreen thread[[level.callbackplayerdamage]](param_00, param_01, param_02, 0, param_03, param_04, param_05, param_06, "none", 0);
    return;
  }

  if(self.var_9D26 && param_04 == "artillery_mp" || param_04 == "claymore_mp") {
    return;
  }

  self.issplitscreen notify("damage", param_02, param_01);
}

debugline(param_00, param_01, param_02) {
  for(var_03 = 0; var_03 < 600; var_03++) {
    wait(0.05);
  }
}

onweapondamage(param_00, param_01, param_02, param_03) {
  self endon("death");
  switch (param_01) {
    case "concussion_grenade_mp":
      var_04 = 512;
      var_05 = 1 - distance(self.origin, param_00.origin) / var_04;
      var_06 = 1 + 4 * var_05;
      wait(0.05);
      self shellshock("concussion_grenade_mp", var_06);
      break;

    default:
      break;
  }
}

func_13B17() {
  self endon("death");
  for(;;) {
    self waittill("missile_fire", var_00, var_01);
    if(getweaponbasename(var_01) == "iw7_chargeshot") {
      var_00.triggerportableradarping = self;
      var_00 thread func_3D28();
    }
  }
}

func_3D27() {
  self endon("death");
  var_00 = 50;
  var_01 = self.origin;
  for(;;) {
    var_02 = scripts\engine\utility::get_enemy_team(self.triggerportableradarping.team);
    var_03 = scripts\common\trace::sphere_trace_get_all_results(var_01, self.origin, var_00, self.triggerportableradarping, scripts\common\trace::create_character_contents());
    foreach(var_05 in var_03) {
      if(isDefined(var_05["entity"]) && isai(var_05["entity"])) {
        var_05["entity"] thread lib_0E25::func_5772(self, var_00);
      }
    }

    var_01 = self.origin;
    wait(0.05);
  }
}

func_3D28() {
  self endon("death");
  var_00 = 32;
  var_01 = scripts\engine\utility::get_enemy_team(self.triggerportableradarping.team);
  wait(0.15);
  var_02 = self.origin;
  for(;;) {
    var_03 = scripts\common\trace::sphere_trace_get_all_results(var_02, self.origin, var_00, self.triggerportableradarping, scripts\common\trace::create_character_contents());
    foreach(var_05 in var_03) {
      if(!isDefined(var_05["entity"]) || !isai(var_05["entity"])) {
        continue;
      }

      if(!isDefined(var_05["entity"].team) || var_05["entity"].team != var_01) {
        continue;
      }

      self detonate();
      return;
    }

    var_02 = self.origin;
    wait(0.05);
  }
}