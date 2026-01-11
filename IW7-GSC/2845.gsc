/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2845.gsc
***************************************/

init() {
  level.func_7649["c4_light_blink"] = loadfx("vfx\core\equipment\light_c4_blink.vfx");
  level.func_7649["frag_tel_radius"] = loadfx("vfx\iw7\core\equipment\frag\vfx_frag_tel_radius.vfx");
  level.player scripts\sp\utility::func_65E0("no_grenade_block_gesture");
  scripts\engine\utility::array_thread(level.players, ::watchgrenadeusage);
  scripts\engine\utility::array_thread(level.players, ::func_13B17);
  level.func_0149 = spawnStruct();
  level.func_0149.func_B37A = [];
  level.func_0149.func_A8C6 = undefined;
  scripts\engine\utility::flag_init("frag_force_delete");
}

func_10409() {
  var_00 = [];
  var_0["r_hudoutlineWidth"] = 1;
  var_0["r_hudoutlineFillColor1"] = "0 0 0 1";
  var_0["r_hudoutlineFillColor0"] = "0.8 0.8 0.8 1";
  var_0["r_hudoutlineOccludedOutlineColor"] = "0.8 0.8 0.8 1";
  var_0["r_hudoutlineOccludedInteriorColor"] = "0.5 0.5 0.5 .2";
  var_0["r_hudoutlineOccludedInlineColor"] = "0.5 0.5 0.5 .5";
  var_0["r_hudoutlineFillColor1"] = "0.8 0.8 0.8 .2";
  var_0["r_hudOutlineOccludedColorFromFill"] = 1;
  return var_00;
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
    var_00 = self getcurrentweapon();

    if(!isDefined(var_00) || self playerads() < 0.5) {
      wait 0.05;
      continue;
    }

    if(getweaponbasename(var_00) == "iw7_kbs" && scripts\sp\utility::func_9FFE(var_00)) {
      var_01 = _getaiarray("axis");

      foreach(var_03 in var_01) {
        if(!isalive(var_03)) {
          continue;
        }
        var_04 = distance2dsquared(var_3.origin, self.origin);
        var_05 = 0;
        var_03 scripts\engine\utility::delaythread(var_05, ::func_10408);
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
    self waittill("grenade_pullback", var_00);
    self.throwinggrenade = 1;
    scripts\engine\utility::waittill_any("grenade_fire", "weapon_switch_started");
    self.throwinggrenade = 0;
  }
}

begingrenadetracking() {
  for(;;) {
    self waittill("grenade_fire", var_00, var_01);

    if(isDefined(var_00) && scripts\engine\utility::is_true(var_0._meth_8589)) {
      continue;
    }
    if(isDefined(level.func["player_grenade_thrown"])) {
      level thread[[level.func["player_grenade_thrown"]]](var_00);
    }

    switch (var_01) {
      case "seeker_autohold":
      case "seeker":
        thread func_0E26::func_F135(var_00);
        break;
      case "antigrav":
        thread func_0E21::func_2013(var_00);
        break;
      case "emp":
        thread func_0E25::func_615B(var_00);
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

func_DBDB(var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07) {
  var_08 = scripts\engine\utility::ter_op(isDefined(var_03), var_03, 600);

  if(distance2dsquared(level.player.origin, var_00) > var_08 * var_08) {
    return;
  }
  if(isDefined(level.func_58DB)) {
    return;
  }
  level.func_58DB = 1;
  var_9["r_mbenable"] = getdvar("r_mbenable");
  var_9["r_mbRadialOverridePosition"] = getdvar("r_mbRadialOverridePosition");
  var_9["r_mbRadialOverridePositionActive"] = getdvarint("r_mbRadialOverridePositionActive");
  var_9["r_mbradialoverridestrength"] = getdvarfloat("r_mbradialoverridestrength");
  var_9["r_mbradialoverrideradius"] = getdvarfloat("r_mbradialoverrideradius");
  _setsaveddvar("r_mbenable", 1);
  _setsaveddvar("r_mbRadialOverridePosition", var_00);
  _setsaveddvar("r_mbRadialOverridePositionActive", 1);
  var_10 = scripts\engine\utility::ter_op(isDefined(var_02), var_02, 270);
  var_01 = scripts\engine\utility::ter_op(isDefined(var_01), var_01, 0.135848);
  var_11 = var_01 / 4;
  var_04 = scripts\engine\utility::ter_op(isDefined(var_04), var_04, -0.107266);
  var_05 = scripts\engine\utility::ter_op(isDefined(var_05), var_05, 0.05);
  var_06 = scripts\engine\utility::ter_op(isDefined(var_06), var_06, 0.5);
  var_12 = distance2d(level.player.origin, var_00);
  var_13 = scripts\sp\math::func_C097(var_08, var_10, var_12);
  var_14 = scripts\sp\math::func_6A8E(var_01, var_11, var_13);
  var_14 = clamp(var_14, 0, 1);

  if(!isDefined(var_07)) {
    if(!scripts\engine\trace::ray_trace_passed(var_00 + (0, 0, 12), level.player getEye())) {
      var_14 = var_14 * 0.5;
      var_14 = clamp(var_14, 0, 1);
    }
  }

  _setsaveddvar("r_mbradialoverridestrength", var_14);
  _setsaveddvar("r_mbradialoverrideradius", var_04);
  wait(var_05);
  thread scripts\sp\utility::func_AB9A("r_mbradialoverridestrength", var_9["r_mbradialoverridestrength"], var_06);
  thread scripts\sp\utility::func_AB9A("r_mbradialoverrideradius", var_9["r_mbradialoverrideradius"], var_06);
  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", var_06);
  _setsaveddvar("r_mbenable", var_9["r_mbenable"]);
  _setsaveddvar("r_mbRadialOverridePosition", var_9["r_mbRadialOverridePosition"]);
  _setsaveddvar("r_mbRadialOverridePositionActive", var_9["r_mbRadialOverridePositionActive"]);
  level.func_58DB = undefined;
}

func_734F(var_00) {
  var_01 = var_00 scripts\engine\utility::spawn_script_origin();
  var_1.grenade = var_00;
  level.func_0149.func_B37A[level.func_0149.func_B37A.size] = var_01;
  var_01 linkto(var_00, "tag_fx", (0, 0, 0), (0, 0, 0));
  var_02 = func_734E();
  var_00 func_13771(var_01);
  var_03 = isDefined(var_1.func_0118);
  var_04 = var_1.origin;
  var_01 func_E011();

  if(!var_03) {
    return;
  }
  if(self == level.player) {
    thread func_734D(var_04, var_02, 256);

    if(isDefined(level.player.func_735A)) {
      thread func_7352(var_04, var_1.func_4D40);
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

    if(var_07 < 0.0) {
      var_05 = 0;
    }
  }

  if(var_05) {
    if(!scripts\engine\trace::ray_trace_passed(var_04 + (0, 0, 12), level.player getEye(), undefined, scripts\engine\trace::create_world_contents())) {
      var_05 = 0;
    }
  }

  if(var_05) {
    level.player thread logplayerendmatchdatamatchresult(var_04);
  }
}

func_13771(var_00) {
  thread func_1376E(var_00);
  thread func_13582(var_00);

  while(isDefined(self)) {
    wait 0.05;
  }
}

func_1376E(var_00) {
  var_00 endon("death");
  self waittill("explode", var_01, var_02);
  var_0.func_0118 = 1;
  var_0.func_4D40 = var_02;
}

func_13582(var_00) {
  var_00 endon("death");
  self waittill("entitydeleted");
  var_0.func_6643 = 1;
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
  level.func_0149.func_A8C6 = self.origin;
  level.func_0149.func_B37A = scripts\engine\utility::array_remove(level.func_0149.func_B37A, self);
  self delete();
}

func_DFBF() {
  level notify("removing_all_frags_instantly");
  level endon("removing_all_frags_instantly");
  scripts\engine\utility::flag_set("frag_force_delete");

  foreach(var_01 in level.func_0149.func_B37A) {
  var_01 func_E012();
  }

  scripts\engine\utility::waitframe();

  for(;;) {
    if(level.func_0149.func_B37A.size > 0) {
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
    foreach(var_02 in _getaiarray("axis")) {
      var_03 = spawnStruct();
      var_3.ent = var_02;
      var_3.health = var_2.health;
      var_3.origin = var_2.origin;
      var_0[var_0.size] = var_03;
    }
  }

  return var_00;
}

func_734D(var_00, var_01, var_02, var_03) {
  level.player endon("death");
  level.player notify("new_frag_info_reticles");
  level.player endon("new_frag_info_reticles");

  if(isDefined(var_03)) {
    scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", var_03);
  }

  var_04 = [];
  var_05 = [];
  var_06 = [];

  for(var_07 = 0; var_07 < var_1.size; var_7++) {
    if(distance(var_1[var_07].origin, var_00) > var_02) {
      continue;
    }
    else if(!isDefined(var_1[var_07].ent) || !isalive(var_1[var_07].ent)) {
      var_4[var_4.size] = var_1[var_07];
      continue;
    } else if(var_1[var_07].ent.health < var_1[var_07].health) {
      var_5[var_5.size] = var_1[var_07];
      continue;
    } else
      continue;
  }

  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", 0.2);
  var_08 = var_4.size;
  var_09 = var_5.size;
  var_10 = var_6.size;
  var_11 = var_04;
  var_11 = scripts\engine\utility::array_combine(var_11, var_05);
  var_11 = scripts\engine\utility::array_combine(var_11, var_06);
  var_12 = 0;
  var_13 = [];
  var_14 = 8;

  for(var_07 = 0; var_07 < var_14; var_7++) {
    if(isDefined(var_11[var_07])) {
      var_15 = scripts\engine\utility::spawn_tag_origin();
      var_15.origin = var_11[var_07].origin;
      var_13[var_13.size] = var_15;
      setomnvar("ui_fragreticles_" + var_07 + "_target_ent", var_15);

      if(var_07 < var_08) {
        setomnvar("ui_fragreticles_" + var_07 + "_lock_state", 1);
      }
      else if(var_07 < var_08 + var_09) {
        if(!isalive(var_11[var_07])) {
          setomnvar("ui_fragreticles_" + var_07 + "_lock_state", 2);
          var_15 linkto(var_11[var_07].ent, func_129D(var_11[var_07].ent), (0, 0, 0), (0, 0, 0));
        }
      } else
        setomnvar("ui_fragreticles_" + var_07 + "_lock_state", 3);

      continue;
    }

    setomnvar("ui_fragreticles_" + var_07 + "_target_ent", undefined);
    setomnvar("ui_fragreticles_" + var_07 + "_lock_state", 0);
  }

  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", 4.0);

  for(var_07 = 0; var_07 < var_14; var_7++) {
    setomnvar("ui_fragreticles_" + var_07 + "_target_ent", undefined);
    setomnvar("ui_fragreticles_" + var_07 + "_lock_state", 0);
  }

  for(var_07 = 0; var_07 < var_13.size; var_7++) {
    var_13[var_07] delete();
  }
}

func_129D(var_00) {
  if(isDefined(var_0.classname) && !issubstr(var_0.classname, "seeker")) {
    return "j_SpineUpper";
  }
  else {
    return "tag_origin";
  }
}

func_7352(var_00, var_01) {
  self endon("death");
  var_02 = [];

  foreach(var_04 in _getaiarray("axis")) {
    if(distance(var_4.origin, var_00) <= 256) {
      if(scripts\engine\trace::ray_trace_passed(var_04 gettagorigin("j_SpineUpper"), var_00, var_04, scripts\engine\trace::create_solid_ai_contents(1))) {
        var_2[var_2.size] = var_04;
        var_04 thread func_7353();
      }
    }
  }

  if(var_2.size > 0) {
    playFX(level.func_7649["frag_tel_radius"], var_00);
  }

  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", var_01);
  scripts\engine\utility::flag_wait_or_timeout("frag_force_delete", 2.0);

  foreach(var_04 in var_02) {
  var_04 notify("frag_outline_display_done");
  }
}

func_7353() {
  scripts\sp\utility::func_9196(0, 0, 0);
  scripts\engine\utility::waittill_any("frag_outline_display_done", "death");
  scripts\sp\utility::func_9193();
}

func_3465(var_00) {
  var_00 waittill("missile_stuck");
  playFXOnTag(level.func_7649["grenade_flash_red"], var_00, "tag_origin");
  var_00 waittill("death");
}

logplayerendmatchdatamatchresult(var_00) {
  self endon("death");
  var_01 = scripts\engine\utility::spawn_tag_origin(var_00, (0, 0, 0));
  thread scripts\engine\utility::delete_on_death(var_01);
  var_02 = "ges_frag_block";
  var_03 = self playgestureviewmodel(var_02, var_01, 1, 0.1);
  thread lockdeathcamera(var_02);

  if(var_03) {
    childthread func_0E49::func_D092(var_02, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1.4);

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

lockdeathcamera(var_00) {
  self endon("grenade_reaction_gesture_done");
  self waittill("weapon_switch_started");
  self stopgestureviewmodel(var_00, 0.2);
}

func_1339D(var_00) {
  var_01 = distance(level.player.origin, var_00);
  var_02 = 600;

  if(var_01 > var_02 || var_01 < 256) {
    return;
  }
  var_03 = vectortoangles(level.player.origin - var_00);
  var_04 = 40;
  var_05 = 5;
  var_06 = scripts\sp\math::func_C097(0, var_02, var_01);
  var_07 = scripts\sp\math::func_6A8E(var_05, var_04, var_06);
  level.player viewkick(int(var_07), var_00);
}

func_385C(var_00, var_01) {
  if(_isent(self) || isai(self)) {
    var_02 = [self, var_01, level.player];
  }
  else {
    var_02 = [var_01, level.player];
  }

  if(scripts\engine\trace::ray_trace_passed(var_00, var_1.origin, var_02)) {
    return 1;
  }

  if(scripts\engine\trace::ray_trace_passed(var_00, var_01 gettagorigin("j_spine4"), var_02)) {
    return 1;
  }

  if(scripts\engine\trace::ray_trace_passed(var_00, var_01 getEye(), var_02)) {
    return 1;
  }

  if(scripts\engine\trace::ray_trace_passed(var_00, var_01 gettagorigin("j_helmet"), var_02)) {
    return 1;
  }

  return 0;
}

func_385D(var_00) {
  if(scripts\engine\trace::ray_trace_passed(var_00, level.player.origin, level.player)) {
    return 1;
  }

  if(scripts\engine\trace::ray_trace_passed(var_00, level.player.origin + (0, 0, 30), level.player)) {
    return 1;
  }

  if(scripts\engine\trace::ray_trace_passed(var_00, level.player getEye(), level.player)) {
    return 1;
  }

  return 0;
}

getdamageableents(var_00, var_01, var_02, var_03) {
  var_04 = [];

  if(!isDefined(var_02)) {
    var_02 = 0;
  }

  if(!isDefined(var_03)) {
    var_03 = 0;
  }

  for(var_05 = 0; var_05 < level.players.size; var_5++) {
    if(!isalive(level.players[var_05]) || level.players[var_05].sessionstate != "playing") {
      continue;
    }
    var_06 = level.players[var_05].origin + (0, 0, 32);
    var_07 = distance(var_00, var_06);

    if(var_07 < var_01 && (!var_02 || func_13C7E(var_00, var_06, var_03, undefined))) {
      var_08 = spawnStruct();
      var_8.isplayer = 1;
      var_8.func_9D26 = 0;
      var_8.entity = level.players[var_05];
      var_8.damagecenter = var_06;
      var_4[var_4.size] = var_08;
    }
  }

  var_09 = getEntArray("grenade", "classname");

  for(var_05 = 0; var_05 < var_9.size; var_5++) {
    var_10 = var_9[var_05].origin;
    var_07 = distance(var_00, var_10);

    if(var_07 < var_01 && (!var_02 || func_13C7E(var_00, var_10, var_03, var_9[var_05]))) {
      var_08 = spawnStruct();
      var_8.isplayer = 0;
      var_8.func_9D26 = 0;
      var_8.entity = var_9[var_05];
      var_8.damagecenter = var_10;
      var_4[var_4.size] = var_08;
    }
  }

  var_11 = getEntArray("destructable", "targetname");

  for(var_05 = 0; var_05 < var_11.size; var_5++) {
    var_10 = var_11[var_05].origin;
    var_07 = distance(var_00, var_10);

    if(var_07 < var_01 && (!var_02 || func_13C7E(var_00, var_10, var_03, var_11[var_05]))) {
      var_08 = spawnStruct();
      var_8.isplayer = 0;
      var_8.func_9D26 = 1;
      var_8.entity = var_11[var_05];
      var_8.damagecenter = var_10;
      var_4[var_4.size] = var_08;
    }
  }

  return var_04;
}

func_13C7E(var_00, var_01, var_02, var_03) {
  var_04 = undefined;
  var_05 = var_01 - var_00;

  if(lengthsquared(var_05) < var_02 * var_02) {
    var_04 = var_01;
  }

  var_06 = vectornormalize(var_05);
  var_04 = var_00 + (var_6[0] * var_02, var_6[1] * var_02, var_6[2] * var_02);
  var_07 = bulletTrace(var_04, var_01, 0, var_03);

  if(getdvarint("scr_damage_debug") != 0) {
    if(var_7["fraction"] == 1) {
      thread debugline(var_04, var_01, (1, 1, 1));
    }
    else {
      thread debugline(var_04, var_7["position"], (1, 0.9, 0.8));
      thread debugline(var_7["position"], var_01, (1, 0.4, 0.3));
    }
  }

  return var_7["fraction"] == 1;
}

damageent(var_00, var_01, var_02, var_03, var_04, var_05, var_06) {
  if(self.isplayer) {
    self.func_4D5B = var_05;
    self.entity thread[[level.callbackplayerdamage]](var_00, var_01, var_02, 0, var_03, var_04, var_05, var_06, "none", 0);
  } else {
    if(self.func_9D26 && (var_04 == "artillery_mp" || var_04 == "claymore_mp")) {
      return;
    }
    self.entity notify("damage", var_02, var_01);
  }
}

debugline(var_00, var_01, var_02) {
  for(var_03 = 0; var_03 < 600; var_3++) {
    wait 0.05;
  }
}

onweapondamage(var_00, var_01, var_02, var_03) {
  self endon("death");

  switch (var_01) {
    case "concussion_grenade_mp":
      var_04 = 512;
      var_05 = 1 - distance(self.origin, var_0.origin) / var_04;
      var_06 = 1 + 4 * var_05;
      wait 0.05;
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
      var_0.owner = self;
      var_00 thread func_3D28();
    }
  }
}

func_3D27() {
  self endon("death");
  var_00 = 50;
  var_01 = self.origin;

  for(;;) {
    var_02 = scripts\engine\utility::get_enemy_team(self.owner.team);
    var_03 = scripts\engine\trace::sphere_trace_get_all_results(var_01, self.origin, var_00, self.owner, scripts\engine\trace::create_character_contents());

    foreach(var_05 in var_03) {
      if(isDefined(var_5["entity"]) && isai(var_5["entity"])) {
        var_5["entity"] thread func_0E25::func_5772(self, var_00);
      }
    }

    var_01 = self.origin;
    wait 0.05;
  }
}

func_3D28() {
  self endon("death");
  var_00 = 32;
  var_01 = scripts\engine\utility::get_enemy_team(self.owner.team);
  wait 0.15;
  var_02 = self.origin;

  for(;;) {
    var_03 = scripts\engine\trace::sphere_trace_get_all_results(var_02, self.origin, var_00, self.owner, scripts\engine\trace::create_character_contents());

    foreach(var_05 in var_03) {
      if(!isDefined(var_5["entity"]) || !isai(var_5["entity"])) {
        continue;
      }
      if(!isDefined(var_5["entity"].team) || var_5["entity"].team != var_01) {
        continue;
      }
      self detonate();
      return;
    }

    var_02 = self.origin;
    wait 0.05;
  }
}