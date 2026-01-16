/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2845.gsc
**************************************/

init() {
  level.var_7649["c4_light_blink"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  level.var_7649["frag_tel_radius"] = loadfx("vfx\iw7\core\equipment\frag\vfx_frag_tel_radius.vfx");
  level.player scripts\sp\utility::func_65E0("no_grenade_block_gesture");
  scripts\engine\utility::array_thread(level.players, ::watchgrenadeusage);
  scripts\engine\utility::array_thread(level.players, ::func_13B17);
  level.var_0149 = spawnStruct();
  level.var_0149.var_B37A = [];
  level.var_0149.var_A8C6 = undefined;
  scripts\engine\utility::flag_init("frag_force_delete");
}

func_10409() {
  var_0 = [];
  var_0["r_hudoutlineWidth"] = 1;
  var_0["r_hudoutlineFillColor1"] = "0 0 0 1";
  var_0["r_hudoutlineFillColor0"] = "0.8 0.8 0.8 1";
  var_0["r_hudoutlineOccludedOutlineColor"] = "0.8 0.8 0.8 1";
  var_0["r_hudoutlineOccludedInteriorColor"] = "0.5 0.5 0.5 .2";
  var_0["r_hudoutlineOccludedInlineColor"] = "0.5 0.5 0.5 .5";
  var_0["r_hudoutlineFillColor1"] = "0.8 0.8 0.8 .2";
  var_0["r_hudOutlineOccludedColorFromFill"] = 1;
  return var_0;
}

func_10408() {
  scripts\sp\utility::func_9196(1, 1, 1, "sonic");
  wait 0.15;
  scripts\sp\utility::func_9193("sonic");
}

func_13995() {
  self endon("death");
  scripts\sp\utility::func_9187("sonic", 190, ::func_10409);

  for(;;) {
    var_0 = self getcurrentweapon();

    if(!isDefined(var_0) || self playerads() < 0.5) {
      wait 0.05;
      continue;
    }

    if(getweaponbasename(var_0) == "iw7_kbs" && scripts\sp\utility::func_9FFE(var_0)) {
      var_1 = _getaiarray("axis");

      foreach(var_3 in var_1) {
        if(!isalive(var_3)) {
          continue;
        }
        var_4 = distance2dsquared(var_3.origin, self.origin);
        var_5 = 0;
        var_3 scripts\engine\utility::delaythread(var_5, ::func_10408);
      }
    }

    wait 2.5;
  }
}

watchgrenadeusage() {
  self endon("death");
  childthread begingrenadetracking();
  self.throwinggrenade = 0;

  for(;;) {
    self waittill("grenade_pullback", var_0);
    self.throwinggrenade = 1;
    scripts\engine\utility::waittill_any("grenade_fire", "weapon_switch_started");
    self.throwinggrenade = 0;
  }
}

begingrenadetracking() {
  for(;;) {
    self waittill("grenade_fire", var_0, var_1);

    if(isDefined(var_0) && scripts\engine\utility::is_true(var_0.func_8589)) {
      continue;
    }
    if(isDefined(level.func["player_grenade_thrown"])) {
      level thread[[level.func["player_grenade_thrown"]]](var_0);
    }

    switch (var_1) {
      case "seeker_autohold":
      case "seeker":
        thread func_0E26::func_F135(var_0);
        break;
      case "antigrav":
        thread func_0E21::func_2013(var_0);
        break;
      case "emp":
        thread func_0E25::func_615B(var_0);
        break;
      case "coverwall":
        thread scripts\sp\coverwall::func_475F(var_0);
        break;
      case "frag_up1":
      case "frag":
        thread func_734F(var_0);

        if(self == level.player) {
          level.player thread scripts\anim\battlechatter_ai::func_67CF("frag");
        }

        break;
      case "c8_grenade":
        thread func_734F(var_0);
        thread func_3465(var_0);
        break;
      default:
        break;
    }
  }
}

func_DBDB(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, 600);

  if(distance2dsquared(level.player.origin, var_0) > var_8 * var_8) {
    return;
  }
  if(isDefined(level.var_58DB)) {
    return;
  }
  level.var_58DB = 1;
  var_9["r_mbenable"] = getdvar("r_mbenable");
  var_9["r_mbRadialOverridePosition"] = getdvar("r_mbRadialOverridePosition");
  var_9["r_mbRadialOverridePositionActive"] = getdvarint("r_mbRadialOverridePositionActive");
  var_9["r_mbradialoverridestrength"] = getdvarfloat("r_mbradialoverridestrength");
  var_9["r_mbradialoverrideradius"] = getdvarfloat("r_mbradialoverrideradius");
  _setsaveddvar("r_mbenable", 1);
  _setsaveddvar("r_mbRadialOverridePosition", var_0);
  _setsaveddvar("r_mbRadialOverridePositionActive", 1);
  var_10 = scripts\engine\utility::ter_op(isDefined(var_2), var_2, 270);
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 0.135848);
  var_11 = var_1 / 4;
  var_4 = scripts\engine\utility::ter_op(isDefined(var_4), var_4, -0.107266);
  var_5 = scripts\engine\utility::ter_op(isDefined(var_5), var_5, 0.05);
  var_6 = scripts\engine\utility::ter_op(isDefined(var_6), var_6, 0.5);
  var_12 = distance2d(level.player.origin, var_0);
  var_13 = scripts\sp\math::func_C097(var_8, var_10, var_12);
  var_14 = scripts\sp\math::func_6A8E(var_1, var_11, var_13);
  var_14 = clamp(var_14, 0, 1);

  if(!isDefined(var_7)) {
    if(!scripts\engine\trace::ray_trace_passed(var_0 + (0, 0, 12), level.player getEye())) {
      var_14 = var_14 * 0.5;
      var_14 = clamp(var_14, 0, 1);
    }
  }

  _setsaveddvar("r_mbradialoverridestrength", var_14);
  _setsaveddvar("r_mbradialoverrideradius", var_4);
  wait(var_5);
  thread scripts\sp\utility::func_AB9A("r_mbradialoverridestrength", var_9["r_mbradialoverridestrength"], var_6);
  thread scripts\sp\utility::func_AB9A("r_mbradialoverrideradius", var_9["r_mbradialoverrideradius"], var_6);
  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", var_6);
  _setsaveddvar("r_mbenable", var_9["r_mbenable"]);
  _setsaveddvar("r_mbRadialOverridePosition", var_9["r_mbRadialOverridePosition"]);
  _setsaveddvar("r_mbRadialOverridePositionActive", var_9["r_mbRadialOverridePositionActive"]);
  level.var_58DB = undefined;
}

func_734F(var_0) {
  var_1 = var_0 scripts\engine\utility::spawn_script_origin();
  var_1.grenade = var_0;
  level.var_0149.var_B37A[level.var_0149.var_B37A.size] = var_1;
  var_1 linkto(var_0, "tag_fx", (0, 0, 0), (0, 0, 0));
  var_2 = func_734E();
  var_0 func_13771(var_1);
  var_3 = isDefined(var_1.var_0118);
  var_4 = var_1.origin;
  var_1 func_E011();

  if(!var_3) {
    return;
  }
  if(self == level.player) {
    thread func_734D(var_4, var_2, 256);

    if(isDefined(level.player.var_735A)) {
      thread func_7352(var_4, var_1.var_4D40);
    }
  }

  thread func_DBDB(var_4);
  earthquake(0.7, 0.8, var_4, 600);
  thread scripts\sp\utility::func_54EF(var_4);

  if(level.player scripts\sp\utility::func_65DB("no_grenade_block_gesture") || level.player isthrowinggrenade() || level.player func_8448()) {
    return;
  }
  var_5 = 1;
  var_6 = distance2dsquared(level.player.origin, var_4);

  if(var_5 && var_6 > 102400) {
    var_5 = 0;
  }

  if(var_5 && var_6 > 4096) {
    var_7 = vectordot(scripts\engine\utility::flatten_vector(vectornormalize(var_4 - level.player.origin)), anglesToForward(level.player.angles));

    if(var_7 < 0.0) {
      var_5 = 0;
    }
  }

  if(var_5) {
    if(!scripts\engine\trace::ray_trace_passed(var_4 + (0, 0, 12), level.player getEye(), undefined, scripts\engine\trace::create_world_contents())) {
      var_5 = 0;
    }
  }

  if(var_5) {
    level.player thread logplayerendmatchdatamatchresult(var_4);
  }
}

func_13771(var_0) {
  thread func_1376E(var_0);
  thread func_13582(var_0);

  while(isDefined(self)) {
    wait 0.05;
  }
}

func_1376E(var_0) {
  var_0 endon("death");
  self waittill("explode", var_1, var_2);
  var_0.var_0118 = 1;
  var_0.var_4D40 = var_2;
}

func_13582(var_0) {
  var_0 endon("death");
  self waittill("entitydeleted");
  var_0.var_6643 = 1;
}

func_E012() {
  if(isDefined(self.grenade)) {
    self unlink();
    self.grenade delete();
  }
}

func_E011() {
  if(!isDefined(self)) {
    return;
  }
  func_E012();
  level.var_0149.var_A8C6 = self.origin;
  level.var_0149.var_B37A = scripts\engine\utility::array_remove(level.var_0149.var_B37A, self);
  self delete();
}

func_DFBF() {
  level notify("removing_all_frags_instantly");
  level endon("removing_all_frags_instantly");
  scripts\engine\utility::flag_set("frag_force_delete");

  foreach(var_1 in level.var_0149.var_B37A) {
    var_1 func_E012();
  }

  scripts\engine\utility::waitframe();

  for(;;) {
    if(level.var_0149.var_B37A.size > 0) {
      scripts\engine\utility::waitframe();
      continue;
    }

    break;
  }

  scripts\engine\utility::flag_clear("frag_force_delete");
}

func_734E() {
  var_0 = [];

  if(self == level.player) {
    foreach(var_2 in _getaiarray("axis")) {
      var_3 = spawnStruct();
      var_3.ent = var_2;
      var_3.health = var_2.health;
      var_3.origin = var_2.origin;
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

func_734D(var_0, var_1, var_2, var_3) {
  level.player endon("death");
  level.player notify("new_frag_info_reticles");
  level.player endon("new_frag_info_reticles");

  if(isDefined(var_3)) {
    scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", var_3);
  }

  var_4 = [];
  var_5 = [];
  var_6 = [];

  for(var_7 = 0; var_7 < var_1.size; var_7++) {
    if(distance(var_1[var_7].origin, var_0) > var_2) {
      continue;
    } else if(!isDefined(var_1[var_7].ent) || !isalive(var_1[var_7].ent)) {
      var_4[var_4.size] = var_1[var_7];
      continue;
    } else if(var_1[var_7].ent.health < var_1[var_7].health) {
      var_5[var_5.size] = var_1[var_7];
      continue;
    } else {
      continue;
    }
  }

  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", 0.2);
  var_8 = var_4.size;
  var_9 = var_5.size;
  var_10 = var_6.size;
  var_11 = var_4;
  var_11 = scripts\engine\utility::array_combine(var_11, var_5);
  var_11 = scripts\engine\utility::array_combine(var_11, var_6);
  var_12 = 0;
  var_13 = [];
  var_14 = 8;

  for(var_7 = 0; var_7 < var_14; var_7++) {
    if(isDefined(var_11[var_7])) {
      var_15 = scripts\engine\utility::spawn_tag_origin();
      var_15.origin = var_11[var_7].origin;
      var_13[var_13.size] = var_15;
      setomnvar("ui_fragreticles_" + var_7 + "_target_ent", var_15);

      if(var_7 < var_8) {
        setomnvar("ui_fragreticles_" + var_7 + "_lock_state", 1);
      } else if(var_7 < var_8 + var_9) {
        if(!isalive(var_11[var_7])) {
          setomnvar("ui_fragreticles_" + var_7 + "_lock_state", 2);
          var_15 linkto(var_11[var_7].ent, func_129D(var_11[var_7].ent), (0, 0, 0), (0, 0, 0));
        }
      } else {
        setomnvar("ui_fragreticles_" + var_7 + "_lock_state", 3);
      }

      continue;
    }

    setomnvar("ui_fragreticles_" + var_7 + "_target_ent", undefined);
    setomnvar("ui_fragreticles_" + var_7 + "_lock_state", 0);
  }

  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", 4.0);

  for(var_7 = 0; var_7 < var_14; var_7++) {
    setomnvar("ui_fragreticles_" + var_7 + "_target_ent", undefined);
    setomnvar("ui_fragreticles_" + var_7 + "_lock_state", 0);
  }

  for(var_7 = 0; var_7 < var_13.size; var_7++) {
    var_13[var_7] delete();
  }
}

func_129D(var_0) {
  if(isDefined(var_0.classname) && !issubstr(var_0.classname, "seeker")) {
    return "j_SpineUpper";
  } else {
    return "tag_origin";
  }
}

func_7352(var_0, var_1) {
  self endon("death");
  var_2 = [];

  foreach(var_4 in _getaiarray("axis")) {
    if(distance(var_4.origin, var_0) <= 256) {
      if(scripts\engine\trace::ray_trace_passed(var_4 gettagorigin("j_SpineUpper"), var_0, var_4, scripts\engine\trace::create_solid_ai_contents(1))) {
        var_2[var_2.size] = var_4;
        var_4 thread func_7353();
      }
    }
  }

  if(var_2.size > 0) {
    playFX(level.var_7649["frag_tel_radius"], var_0);
  }

  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", var_1);
  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", 2.0);

  foreach(var_4 in var_2) {
    var_4 notify("frag_outline_display_done");
  }
}

func_7353() {
  scripts\sp\utility::func_9196(0, 0, 0);
  scripts\engine\utility::waittill_any("frag_outline_display_done", "death");
  scripts\sp\utility::func_9193();
}

func_3465(var_0) {
  var_0 waittill("missile_stuck");
  playFXOnTag(level.var_7649["grenade_flash_red"], var_0, "tag_origin");
  var_0 waittill("death");
}

logplayerendmatchdatamatchresult(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0, (0, 0, 0));
  thread scripts\engine\utility::delete_on_death(var_1);
  var_2 = "ges_frag_block";
  var_3 = self playgestureviewmodel(var_2, var_1, 1, 0.1);
  thread lockdeathcamera(var_2);

  if(var_3) {
    childthread func_0E49::func_D092(var_2, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1.4);

    for(;;) {
      self waittill("gesture_stopped", var_2);

      if(var_2 == "ges_frag_block") {
        break;
      }
    }
  }

  self notify("grenade_reaction_gesture_done");
  var_1 delete();
}

lockdeathcamera(var_0) {
  self endon("grenade_reaction_gesture_done");
  self waittill("weapon_switch_started");
  self stopgestureviewmodel(var_0, 0.2);
}

func_1339D(var_0) {
  var_1 = distance(level.player.origin, var_0);
  var_2 = 600;

  if(var_1 > var_2 || var_1 < 256) {
    return;
  }
  var_3 = vectortoangles(level.player.origin - var_0);
  var_4 = 40;
  var_5 = 5;
  var_6 = scripts\sp\math::func_C097(0, var_2, var_1);
  var_7 = scripts\sp\math::func_6A8E(var_5, var_4, var_6);
  level.player viewkick(int(var_7), var_0);
}

func_385C(var_0, var_1) {
  if(_isent(self) || isai(self)) {
    var_2 = [self, var_1, level.player];
  } else {
    var_2 = [var_1, level.player];
  }

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1.origin, var_2)) {
    return 1;
  }

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1 gettagorigin("j_spine4"), var_2)) {
    return 1;
  }

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1 getEye(), var_2)) {
    return 1;
  }

  if(scripts\engine\trace::ray_trace_passed(var_0, var_1 gettagorigin("j_helmet"), var_2)) {
    return 1;
  }

  return 0;
}

func_385D(var_0) {
  if(scripts\engine\trace::ray_trace_passed(var_0, level.player.origin, level.player)) {
    return 1;
  }

  if(scripts\engine\trace::ray_trace_passed(var_0, level.player.origin + (0, 0, 30), level.player)) {
    return 1;
  }

  if(scripts\engine\trace::ray_trace_passed(var_0, level.player getEye(), level.player)) {
    return 1;
  }

  return 0;
}

getdamageableents(var_0, var_1, var_2, var_3) {
  var_4 = [];

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  for(var_5 = 0; var_5 < level.players.size; var_5++) {
    if(!isalive(level.players[var_5]) || level.players[var_5].sessionstate != "playing") {
      continue;
    }
    var_6 = level.players[var_5].origin + (0, 0, 32);
    var_7 = distance(var_0, var_6);

    if(var_7 < var_1 && (!var_2 || func_13C7E(var_0, var_6, var_3, undefined))) {
      var_8 = spawnStruct();
      var_8.isplayer = 1;
      var_8.var_9D26 = 0;
      var_8.entity = level.players[var_5];
      var_8.damagecenter = var_6;
      var_4[var_4.size] = var_8;
    }
  }

  var_9 = getEntArray("grenade", "classname");

  for(var_5 = 0; var_5 < var_9.size; var_5++) {
    var_10 = var_9[var_5].origin;
    var_7 = distance(var_0, var_10);

    if(var_7 < var_1 && (!var_2 || func_13C7E(var_0, var_10, var_3, var_9[var_5]))) {
      var_8 = spawnStruct();
      var_8.isplayer = 0;
      var_8.var_9D26 = 0;
      var_8.entity = var_9[var_5];
      var_8.damagecenter = var_10;
      var_4[var_4.size] = var_8;
    }
  }

  var_11 = getEntArray("destructable", "targetname");

  for(var_5 = 0; var_5 < var_11.size; var_5++) {
    var_10 = var_11[var_5].origin;
    var_7 = distance(var_0, var_10);

    if(var_7 < var_1 && (!var_2 || func_13C7E(var_0, var_10, var_3, var_11[var_5]))) {
      var_8 = spawnStruct();
      var_8.isplayer = 0;
      var_8.var_9D26 = 1;
      var_8.entity = var_11[var_5];
      var_8.damagecenter = var_10;
      var_4[var_4.size] = var_8;
    }
  }

  return var_4;
}

func_13C7E(var_0, var_1, var_2, var_3) {
  var_4 = undefined;
  var_5 = var_1 - var_0;

  if(lengthsquared(var_5) < var_2 * var_2) {
    var_4 = var_1;
  }

  var_6 = vectornormalize(var_5);
  var_4 = var_0 + (var_6[0] * var_2, var_6[1] * var_2, var_6[2] * var_2);
  var_7 = bulletTrace(var_4, var_1, 0, var_3);

  if(getdvarint("scr_damage_debug") != 0) {
    if(var_7["fraction"] == 1) {
      thread debugline(var_4, var_1, (1, 1, 1));
    } else {
      thread debugline(var_4, var_7["position"], (1, 0.9, 0.8));
      thread debugline(var_7["position"], var_1, (1, 0.4, 0.3));
    }
  }

  return var_7["fraction"] == 1;
}

damageent(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(self.isplayer) {
    self.var_4D5B = var_5;
    self.entity thread[[level.callbackplayerdamage]](var_0, var_1, var_2, 0, var_3, var_4, var_5, var_6, "none", 0);
  } else {
    if(self.var_9D26 && (var_4 == "artillery_mp" || var_4 == "claymore_mp")) {
      return;
    }
    self.entity notify("damage", var_2, var_1);
  }
}

debugline(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < 600; var_3++) {
    wait 0.05;
  }
}

onweapondamage(var_0, var_1, var_2, var_3) {
  self endon("death");

  switch (var_1) {
    case "concussion_grenade_mp":
      var_4 = 512;
      var_5 = 1 - distance(self.origin, var_0.origin) / var_4;
      var_6 = 1 + 4 * var_5;
      wait 0.05;
      self shellshock("concussion_grenade_mp", var_6);
      break;
    default:
      break;
  }
}

func_13B17() {
  self endon("death");

  for(;;) {
    self waittill("missile_fire", var_0, var_1);

    if(getweaponbasename(var_1) == "iw7_chargeshot") {
      var_0.owner = self;
      var_0 thread func_3D28();
    }
  }
}

func_3D27() {
  self endon("death");
  var_0 = 50;
  var_1 = self.origin;

  for(;;) {
    var_2 = scripts\engine\utility::get_enemy_team(self.owner.team);
    var_3 = scripts\engine\trace::sphere_trace_get_all_results(var_1, self.origin, var_0, self.owner, scripts\engine\trace::create_character_contents());

    foreach(var_5 in var_3) {
      if(isDefined(var_5["entity"]) && isai(var_5["entity"])) {
        var_5["entity"] thread func_0E25::func_5772(self, var_0);
      }
    }

    var_1 = self.origin;
    wait 0.05;
  }
}

func_3D28() {
  self endon("death");
  var_0 = 32;
  var_1 = scripts\engine\utility::get_enemy_team(self.owner.team);
  wait 0.15;
  var_2 = self.origin;

  for(;;) {
    var_3 = scripts\engine\trace::sphere_trace_get_all_results(var_2, self.origin, var_0, self.owner, scripts\engine\trace::create_character_contents());

    foreach(var_5 in var_3) {
      if(!isDefined(var_5["entity"]) || !isai(var_5["entity"])) {
        continue;
      }
      if(!isDefined(var_5["entity"].team) || var_5["entity"].team != var_1) {
        continue;
      }
      self detonate();
      return;
    }

    var_2 = self.origin;
    wait 0.05;
  }
}