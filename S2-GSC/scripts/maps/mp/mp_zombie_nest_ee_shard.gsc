/*******************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_nest_ee_shard.gsc
*******************************************************/

main() {
  _id_52EA();
  _id_0557::_id_7846("3 shard", ::_id_8AD1, ["2 open salt mine"], &"ZOMBIE_NEST_HINT_QUEST_SHARD", "ZOMBIE_NEST_HINT_QUEST_SHARD");
  _id_0557::_id_781E("3 shard", "explore mine", ::_id_7852, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_EXPLORE_MINE");
  _id_0557::_id_781E("3 shard", "activate hilt", ::_id_786A, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_ACTIVATE_HILT");
  _id_0557::_id_781E("3 shard", "collect souls", ::_id_784E, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_COLLECT_SOULS");
  _id_0557::_id_781E("3 shard", "cart raise", ::_id_7866, _id_0557::_id_30D8, &"ZOMBIE_NEST_HINT_STEP_RAISE_CLAW");
  _id_0557::_id_7848("3 shard");
}

_id_8AD1() {
  foreach(var_1 in level.players) {
    var_1 _id_054C::_id_AC23("shardroom");
    var_1 _id_0378::_id_8D74("objective_complete", "shardroom");
  }
}

_id_7852() {
  var_0 = _id_0547::_id_AAFB("hiltroom_entry_trigger");
  thread _id_2E83(var_0);
  _id_0557::_id_782D("3 shard", "explore mine");
}

_id_786A() {
  if(1) {
    var_0 = _func_18E("nest_ee_shard_intro_start_trig", "targetname");
    var_1 = _func_18E("hilt_altar_model", "targetname");

    if(isDefined(var_0)) {
      var_2 = undefined;

      if(1) {
        var_2 = _id_0557::_id_782F(undefined, var_1);
        _id_0557::_id_781D("3 shard", var_2);
      }

      var_0._id_4D91 = _id_0559::_id_7BE3(var_0, "hilt");
      var_0 _meth_80CE(&"ZOMBIE_NEST_SHARD_INTRO_TRIG");
      level thread _id_2E79();
      var_0 waittill("trigger", var_3);
      var_4 = _func_18E("hilt_control", "targetname");

      if(isDefined(var_4)) {
        var_4 thread maps\mp\mp_zombie_nest_ee_util::_id_4D76();
        var_4 thread maps\mp\mp_zombie_nest_ee_util::_id_4D77("green");
      }

      thread _id_2E7A(var_3);
      var_0 common_scripts\utility::_id_9D9F();
      _id_0557::_id_7847("3 shard", var_2);
    }
  }

  _id_0557::_id_782D("3 shard", "activate hilt");
}

_id_784E() {
  _func_147(level._effect["zmb_gk_hilt_init"], level._id_3571, "TAG_FX");
  _id_0378::_id_8D74("aud_claw_move_start", level._id_3571, 0);
  level._id_3576 _id_202A();
  _id_0378::_id_8D74("aud_claw_move_stop", level._id_3571);
  level._id_3576 thread _id_2E88("zombie soul");
  var_0 = undefined;

  if(1) {
    var_0 = _id_0557::_id_782F(undefined, level._id_3576);
    _id_0557::_id_781D("3 shard", var_0);
  }

  var_1 = common_scripts\utility::_id_46B5("zmb_hilt_effects", "targetname");
  var_2 = spawn("script_model", var_1.origin);
  var_2 setModel("tag_origin");
  _func_147(level._effect["zmb_geistkraft_radius_400"], var_2, "tag_origin");
  level._id_3576 maps\mp\mp_zombie_nest_special_event_creator::_id_170B(10, 400, undefined, "zombie soul", undefined, "extend_shroud");
  _func_149(level._effect["zmb_geistkraft_radius_400"], var_2, "tag_origin");
  var_2 delete();
  _func_147(level._effect["zmb_gk_hilt"], level._id_3576, "TAG_FX");
  thread _id_089D();
  common_scripts\utility::flag_set("flag_shard_souls_collected");

  if(1) {
    if(isDefined(var_0))
      _id_0557::_id_7847("3 shard", var_0);
  }

  wait 3;
  _id_0378::_id_8D74("aud_claw_move_start", level._id_3571, 0);
  level._id_3576 _id_2029();
  thread _id_2E7E();
  _id_0557::_id_782D("3 shard", "collect souls");
}

_id_089D() {
  var_0 = _func_21F("shardlgt_activate", "targetname");

  foreach(var_2 in var_0)
  var_2 _meth_83FA("shard", "active");
}

_id_7866() {
  level._id_6F18 = 1;

  if(!common_scripts\utility::_id_3C77("flag_com_valve_turned")) {
    _id_0378::_id_8D74("aud_claw_move_stop", level._id_3571);

    if(0) {
      var_0 = _func_18E("shard_valve", "targetname");
      var_1 = _id_0557::_id_782F(undefined, var_0);
      _id_0557::_id_781D("3 shard", var_1);
    }

    thread _id_2028();
    common_scripts\utility::_id_3C9F("flag_com_valve_turned");
  } else
    _id_0557::_id_8596("3 shard", 0);

  _id_202B();
  _id_0557::_id_782D("3 shard", "cart raise");
}

_id_202E() {
  self _meth_8495("s2_zom_shroud_lift_active", self._id_0BBE.origin, self._id_0BBE.angles);
  wait 0.2;
  self _meth_84CA(1);
  _id_0557::_id_7870("3 shard", "activate hilt");
  self _meth_84CA(0);
}

#using_animtree("animated_props_zombies");

_id_202A() {
  var_0 = _func_065(%s2_zom_shroud_lift_active);
  wait(var_0 - 0.2);
}

_id_2029() {
  var_0 = _func_065(%s2_zom_shroud_lift_2);
  self _meth_8495("s2_zom_shroud_lift_2", self._id_0BBE.origin, self._id_0BBE.angles);
  wait(var_0);
}

_id_2027() {
  return 5.6;
}

_id_2026() {
  return 10.1;
}

_id_2028() {
  level endon("flag_com_valve_turned");

  for(;;) {
    var_0 = _id_2027();
    var_1 = _id_2026();
    wait(_func_0A5(var_0, var_1));

    if(isDefined(level._id_3572._id_A29A)) {
      continue;
    }
    level._id_3576 _meth_8277();
    level._id_3576 _meth_8495("s2_zom_shroud_lift_stuck_idle", level._id_3576._id_0BBE.origin, level._id_3576._id_0BBE.angles);
    level._id_3572 _meth_8277();
    level._id_3572 _meth_8495("s2_zom_shroud_cover_lift_stuck_idle", level._id_3572._id_0BBE.origin, level._id_3572._id_0BBE.angles, _id_0547::_id_A286());
  }
}

_id_202B() {
  var_0 = _func_065(%s2_zom_shroud_lift_rise_active);
  var_1 = level._id_3576;
  var_1 _meth_8277();
  var_1 _meth_8495("s2_zom_shroud_lift_rise_active", var_1._id_0BBE.origin, var_1._id_0BBE.angles);
  _id_0378::_id_8D74("aud_claw_move_start", level._id_3571, 0);
  wait(var_0);
  _id_0378::_id_8D74("aud_claw_move_stop", level._id_3571);
}

_id_2021() {
  common_scripts\utility::_id_3C9F("flag_com_valve_turned");
  self setModel("zmb_light_cage_standalone_green_01");
}

_id_2718() {
  var_0 = _func_067(%s2_zom_shroud_cover_lift_open, "actually_start_open");
  var_1 = var_0[0];
  level._id_3572._id_08F1 = isDefined(var_1) && var_1 >= level._id_3595._id_A2A5;
}

_id_2717() {
  if(!common_scripts\utility::_id_562E(level._id_3572._id_08F1)) {
    return;
  }
  _id_0378::_id_8D74("comm_room_claw_trapdoor_closing", self.origin);
}

_id_2022(var_0) {
  switch (var_0) {
    case "stuck_bang_large":
      level._id_3571 _id_0378::_id_8D74("shard_room_claw_stuck_impact");
      break;
    case "first_panel_closed":
      _id_0378::_id_8D74("comm_room_claw_trapdoor_closed", self.origin);
    case "camera_shake":
      var_1 = 0.2;
      var_2 = 0.4;
      var_3 = self.origin;
      var_4 = 200;
      _func_17F(var_1, var_2, var_3, var_4);
      break;
    case "nudge_start_open":
      _id_0378::_id_8D74("comm_room_claw_trapdoor_stall", self.origin);
      break;
    case "actually_start_open":
      _id_0378::_id_8D74("comm_room_claw_trapdoor_start_open", self.origin);
      level._id_3572._id_08F1 = 1;
      break;
    case "post_open_vibrate":
      _id_0378::_id_8D74("comm_room_claw_trapdoor_end_open", self.origin);
      level._id_3595._id_137B = 1;
      break;
    case "slide_begin":
      _id_0378::_id_8D74("comm_room_claw_trapdoor_slider", self.origin);
      break;
  }
}

_id_52EA() {
  common_scripts\utility::flag_init("flag_shard_souls_collected");
  common_scripts\utility::flag_init("flag_com_valve_turned");
  level._id_3595 = maps\mp\mp_zombie_nest_ee_util::_id_8A38("shard_valve", &"ZOMBIE_NEST_BRUTE_VALVE");
  level._id_3576 = _id_8A45("ee_shard", "cart_align_node");
  level._id_3572 = _id_8A10("com_cover", level._id_3576._id_0BBE);
  level._id_3595._id_6DFC = level._id_3572;
  level._id_3572 _id_0547::_id_A283(["s2_zom_shroud_cover_lift_open", "s2_zom_shroud_cover_lift_close", "s2_zom_shroud_cover_lift_stuck_idle"], ::_id_2022);
  level._id_3595._id_9EC3 = ::_id_2718;
  level._id_3595._id_9EC2 = ::_id_2717;
  var_0 = _func_18E("shard_valve_light", "targetname");

  if(isDefined(var_0))
    var_0 thread _id_2021();

  var_1 = _func_18E("hilt_control", "targetname");

  if(isDefined(var_1))
    var_1 thread maps\mp\mp_zombie_nest_ee_util::_id_4D77("red");

  level._id_3576 thread _id_202E();
}

_id_8A10(var_0, var_1) {
  var_2 = _func_18E(var_0, "targetname");
  var_2._id_0BBE = var_1;
  var_3 = var_2 _id_0547::_id_4315();
  var_2 _id_8A12(var_3);
  return var_2;
}

_id_8A12(var_0) {
  self._id_9ED0 = var_0["turnOnAnim"];

  if(isDefined(self._id_9ED0))
    self._id_9ED7 = _id_0547::_id_A285(self._id_9ED0);

  self._id_9ECA = var_0["turnOffAnim"];

  if(isDefined(self._id_9ECA))
    self._id_9ECE = _id_0547::_id_A285(self._id_9ECA);

  self._id_5058 = var_0["idleOffAnim"];
}

_id_8A45(var_0, var_1) {
  var_2 = _func_18E(var_0, "targetname");
  var_2._id_0BBE = common_scripts\utility::_id_46B5(var_1, "targetname");
  var_2._id_6C4E = var_2.origin;
  return var_2;
}

_id_2E83(var_0) {
  if(isDefined(var_0)) {
    var_0 thread _id_0367::_id_8E3B("conv_hiltroomentrance");
    var_0 thread _id_0367::_id_8E3B("conv_hiltlook");
  }
}

_id_2E88(var_0) {
  level waittill(var_0);

  foreach(var_2 in level.players) {
    if(_id_055A::_id_7413(var_2, "zone4_2_hilt")) {
      if(common_scripts\utility::_id_24A6()) {
        var_2 thread _id_0367::_id_8E3C("clawfillhiltroom");
        continue;
      }

      var_2 thread _id_0367::_id_8E3C("clawfill2");
    }
  }
}

_id_2E79() {
  level endon("flag_shard_souls_collected");
  var_0 = _func_18E("hilt_altar_model", "targetname");
  var_0 _meth_82C3(1);

  for(;;) {
    var_0 waittill("damage", var_1, var_2);

    if(isPlayer(var_2)) {
      var_2 thread _id_0367::_id_8E3B("conv_hiltshoot");
      break;
    }

    wait 5;
  }

  var_0 _meth_82C3(0);
}

_id_2E7A(var_0) {
  wait 0.4;
  var_0 thread _id_0367::_id_8E3C("hilttouch");
}

_id_2E7E() {
  if(!common_scripts\utility::_id_3C77("flag_com_valve_turned")) {
    foreach(var_1 in level.players) {
      if(_id_055A::_id_7413(var_1, "zone3_1_com") || _id_055A::_id_7413(var_1, "zone4_1_mine") || _id_055A::_id_7413(var_1, "zone4_2_hilt"))
        var_1 thread _id_0367::_id_8E3C("clawstuck");
    }
  }
}