/***********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_nest_ee_shard.gsc
***********************************************/

func_00F9() {
  func_52EA();
  lib_0557::func_7846("3 shard", ::func_8AD1, ["2 open salt mine"], &"ZOMBIE_NEST_HINT_QUEST_SHARD", "ZOMBIE_NEST_HINT_QUEST_SHARD");
  lib_0557::func_781E("3 shard", "explore mine", ::func_7852, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_EXPLORE_MINE");
  lib_0557::func_781E("3 shard", "activate hilt", ::func_786A, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_ACTIVATE_HILT");
  lib_0557::func_781E("3 shard", "collect souls", ::func_784E, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_COLLECT_SOULS");
  lib_0557::func_781E("3 shard", "cart raise", ::func_7866, ::lib_0557::func_30D8, &"ZOMBIE_NEST_HINT_STEP_RAISE_CLAW");
  lib_0557::func_7848("3 shard");
}

func_8AD1() {
  foreach(var_01 in level.var_744A) {
    var_01 maps\mp\zombies\_zombies_rank::func_AC23("shardroom");
    var_01 lib_0378::func_8D74("objective_complete", "shardroom");
  }
}

func_7852() {
  var_00 = lib_0547::func_AAFB("hiltroom_entry_trigger");
  thread func_2E83(var_00);
  lib_0557::func_782D("3 shard", "explore mine");
}

func_786A() {
  if(1) {
    var_00 = getent("nest_ee_shard_intro_start_trig", "targetname");
    var_01 = getent("hilt_altar_model", "targetname");
    if(isDefined(var_00)) {
      var_02 = undefined;
      if(1) {
        var_02 = lib_0557::func_782F(undefined, var_01);
        lib_0557::func_781D("3 shard", var_02);
      }

      var_00.var_4D91 = lib_0559::func_7BE3(var_00, "hilt");
      var_00 sethintstring(&"ZOMBIE_NEST_SHARD_INTRO_TRIG");
      level thread func_2E79();
      var_00 waittill("trigger", var_03);
      var_04 = getent("hilt_control", "targetname");
      if(isDefined(var_04)) {
        var_04 thread maps\mp\mp_zombie_nest_ee_util::func_4D76();
        var_04 thread maps\mp\mp_zombie_nest_ee_util::func_4D77("green");
      }

      thread func_2E7A(var_03);
      var_00 common_scripts\utility::func_9D9F();
      lib_0557::func_7847("3 shard", var_02);
    }
  }

  lib_0557::func_782D("3 shard", "activate hilt");
}

func_784E() {
  playFXOnTag(level.var_0611["zmb_gk_hilt_init"], level.var_3571, "TAG_FX");
  lib_0378::func_8D74("aud_claw_move_start", level.var_3571, 0);
  level.var_3576 func_202A();
  lib_0378::func_8D74("aud_claw_move_stop", level.var_3571);
  level.var_3576 thread func_2E88("zombie soul");
  var_00 = undefined;
  if(1) {
    var_00 = lib_0557::func_782F(undefined, level.var_3576);
    lib_0557::func_781D("3 shard", var_00);
  }

  var_01 = common_scripts\utility::func_46B5("zmb_hilt_effects", "targetname");
  var_02 = spawn("script_model", var_01.var_0116);
  var_02 setModel("tag_origin");
  playFXOnTag(level.var_0611["zmb_geistkraft_radius_400"], var_02, "tag_origin");
  level.var_3576 maps\mp\mp_zombie_nest_special_event_creator::func_170B(10, 400, undefined, "zombie soul", undefined, "extend_shroud");
  killfxontag(level.var_0611["zmb_geistkraft_radius_400"], var_02, "tag_origin");
  var_02 delete();
  playFXOnTag(level.var_0611["zmb_gk_hilt"], level.var_3576, "TAG_FX");
  thread func_089D();
  common_scripts\utility::func_3C8F("flag_shard_souls_collected");
  if(1) {
    if(isDefined(var_00)) {
      lib_0557::func_7847("3 shard", var_00);
    }
  }

  wait(3);
  lib_0378::func_8D74("aud_claw_move_start", level.var_3571, 0);
  level.var_3576 func_2029();
  thread func_2E7E();
  lib_0557::func_782D("3 shard", "collect souls");
}

func_089D() {
  var_00 = function_021F("shardlgt_activate", "targetname");
  foreach(var_02 in var_00) {
    var_02 setscriptablepartstate("shard", "active");
  }
}

func_7866() {
  level.var_6F18 = 1;
  if(!common_scripts\utility::func_3C77("flag_com_valve_turned")) {
    lib_0378::func_8D74("aud_claw_move_stop", level.var_3571);
    if(0) {
      var_00 = getent("shard_valve", "targetname");
      var_01 = lib_0557::func_782F(undefined, var_00);
      lib_0557::func_781D("3 shard", var_01);
    }

    thread func_2028();
    common_scripts\utility::func_3C9F("flag_com_valve_turned");
  } else {
    lib_0557::func_8596("3 shard", 0);
  }

  func_202B();
  lib_0557::func_782D("3 shard", "cart raise");
}

func_202E() {
  self method_8495("s2_zom_shroud_lift_active", self.var_0BBE.var_0116, self.var_0BBE.var_001D);
  wait(0.2);
  self scriptmodelpauseanim(1);
  lib_0557::func_7870("3 shard", "activate hilt");
  self scriptmodelpauseanim(0);
}

func_202A() {
  var_00 = getanimlength(%s2_zom_shroud_lift_active);
  wait(var_00 - 0.2);
}

func_2029() {
  var_00 = getanimlength(%s2_zom_shroud_lift_2);
  self method_8495("s2_zom_shroud_lift_2", self.var_0BBE.var_0116, self.var_0BBE.var_001D);
  wait(var_00);
}

func_2027() {
  return 5.6;
}

func_2026() {
  return 10.1;
}

func_2028() {
  level endon("flag_com_valve_turned");
  for(;;) {
    var_00 = func_2027();
    var_01 = func_2026();
    wait(randomfloatrange(var_00, var_01));
    if(isDefined(level.var_3572.var_A29A)) {
      continue;
    }

    level.var_3576 scriptmodelclearanim();
    level.var_3576 method_8495("s2_zom_shroud_lift_stuck_idle", level.var_3576.var_0BBE.var_0116, level.var_3576.var_0BBE.var_001D);
    level.var_3572 scriptmodelclearanim();
    level.var_3572 method_8495("s2_zom_shroud_cover_lift_stuck_idle", level.var_3572.var_0BBE.var_0116, level.var_3572.var_0BBE.var_001D, lib_0547::func_A286());
  }
}

func_202B() {
  var_00 = getanimlength(%s2_zom_shroud_lift_rise_active);
  var_01 = level.var_3576;
  var_01 scriptmodelclearanim();
  var_01 method_8495("s2_zom_shroud_lift_rise_active", var_01.var_0BBE.var_0116, var_01.var_0BBE.var_001D);
  lib_0378::func_8D74("aud_claw_move_start", level.var_3571, 0);
  wait(var_00);
  lib_0378::func_8D74("aud_claw_move_stop", level.var_3571);
}

func_2021() {
  common_scripts\utility::func_3C9F("flag_com_valve_turned");
  self setModel("zmb_light_cage_standalone_green_01");
}

func_2718() {
  var_00 = getnotetracktimes(%s2_zom_shroud_cover_lift_open, "actually_start_open");
  var_01 = var_00[0];
  level.var_3572.var_08F1 = isDefined(var_01) && var_01 >= level.var_3595.var_A2A5;
}

func_2717() {
  if(!common_scripts\utility::func_562E(level.var_3572.var_08F1)) {
    return;
  }

  lib_0378::func_8D74("comm_room_claw_trapdoor_closing", self.var_0116);
}

func_2022(param_00) {
  switch (param_00) {
    case "stuck_bang_large":
      level.var_3571 lib_0378::func_8D74("shard_room_claw_stuck_impact");
      break;

    case "first_panel_closed":
      lib_0378::func_8D74("comm_room_claw_trapdoor_closed", self.var_0116);
      break;

    case "camera_shake":
      var_01 = 0.2;
      var_02 = 0.4;
      var_03 = self.var_0116;
      var_04 = 200;
      earthquake(var_01, var_02, var_03, var_04);
      break;

    case "nudge_start_open":
      lib_0378::func_8D74("comm_room_claw_trapdoor_stall", self.var_0116);
      break;

    case "actually_start_open":
      lib_0378::func_8D74("comm_room_claw_trapdoor_start_open", self.var_0116);
      level.var_3572.var_08F1 = 1;
      break;

    case "post_open_vibrate":
      lib_0378::func_8D74("comm_room_claw_trapdoor_end_open", self.var_0116);
      level.var_3595.var_137B = 1;
      break;

    case "slide_begin":
      lib_0378::func_8D74("comm_room_claw_trapdoor_slider", self.var_0116);
      break;
  }
}

func_52EA() {
  common_scripts\utility::func_3C87("flag_shard_souls_collected");
  common_scripts\utility::func_3C87("flag_com_valve_turned");
  level.var_3595 = maps\mp\mp_zombie_nest_ee_util::func_8A38("shard_valve", &"ZOMBIE_NEST_BRUTE_VALVE");
  level.var_3576 = func_8A45("ee_shard", "cart_align_node");
  level.var_3572 = func_8A10("com_cover", level.var_3576.var_0BBE);
  level.var_3595.var_6DFC = level.var_3572;
  level.var_3572 lib_0547::func_A283(["s2_zom_shroud_cover_lift_open", "s2_zom_shroud_cover_lift_close", "s2_zom_shroud_cover_lift_stuck_idle"], ::func_2022);
  level.var_3595.var_9EC3 = ::func_2718;
  level.var_3595.var_9EC2 = ::func_2717;
  var_00 = getent("shard_valve_light", "targetname");
  if(isDefined(var_00)) {
    var_00 thread func_2021();
  }

  var_01 = getent("hilt_control", "targetname");
  if(isDefined(var_01)) {
    var_01 thread maps\mp\mp_zombie_nest_ee_util::func_4D77("red");
  }

  level.var_3576 thread func_202E();
}

func_8A10(param_00, param_01) {
  var_02 = getent(param_00, "targetname");
  var_02.var_0BBE = param_01;
  var_03 = var_02 lib_0547::func_4315();
  var_02 func_8A12(var_03);
  return var_02;
}

func_8A12(param_00) {
  self.var_9ED0 = param_00["turnOnAnim"];
  if(isDefined(self.var_9ED0)) {
    self.var_9ED7 = lib_0547::func_A285(self.var_9ED0);
  }

  self.var_9ECA = param_00["turnOffAnim"];
  if(isDefined(self.var_9ECA)) {
    self.var_9ECE = lib_0547::func_A285(self.var_9ECA);
  }

  self.var_5058 = param_00["idleOffAnim"];
}

func_8A45(param_00, param_01) {
  var_02 = getent(param_00, "targetname");
  var_02.var_0BBE = common_scripts\utility::func_46B5(param_01, "targetname");
  var_02.var_6C4E = var_02.var_0116;
  return var_02;
}

func_2E83(param_00) {
  if(isDefined(param_00)) {
    param_00 thread lib_0367::func_8E3B("conv_hiltroomentrance");
    param_00 thread lib_0367::func_8E3B("conv_hiltlook");
  }
}

func_2E88(param_00) {
  level waittill(param_00);
  foreach(var_02 in level.var_744A) {
    if(lib_055A::func_7413(var_02, "zone4_2_hilt")) {
      if(common_scripts\utility::func_24A6()) {
        var_02 thread lib_0367::func_8E3C("clawfillhiltroom");
        continue;
      }

      var_02 thread lib_0367::func_8E3C("clawfill2");
    }
  }
}

func_2E79() {
  level endon("flag_shard_souls_collected");
  var_00 = getent("hilt_altar_model", "targetname");
  var_00 setCanDamage(1);
  for(;;) {
    var_00 waittill("damage", var_01, var_02);
    if(isPlayer(var_02)) {
      var_02 thread lib_0367::func_8E3B("conv_hiltshoot");
      break;
    }

    wait(5);
  }

  var_00 setCanDamage(0);
}

func_2E7A(param_00) {
  wait(0.4);
  param_00 thread lib_0367::func_8E3C("hilttouch");
}

func_2E7E() {
  if(!common_scripts\utility::func_3C77("flag_com_valve_turned")) {
    foreach(var_01 in level.var_744A) {
      if(lib_055A::func_7413(var_01, "zone3_1_com") || lib_055A::func_7413(var_01, "zone4_1_mine") || lib_055A::func_7413(var_01, "zone4_2_hilt")) {
        var_01 thread lib_0367::func_8E3C("clawstuck");
      }
    }
  }
}