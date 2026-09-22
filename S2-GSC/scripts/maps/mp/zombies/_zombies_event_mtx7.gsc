/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\_zombies_event_mtx7.gsc
***********************************************************/

init() {
  level.zmb_total_fish_collected = 0;
  var_0 = getdvarint("spv_zmb_event_mtx7_active", -1);

  if(var_0 == -1) {
    var_0 = 1;
  }

  var_1 = var_0;

  if(!_isonlinegame()) {
    var_1 = 0;
  }

  if(!maps\mp\_utility::isproductionlevelactive(16)) {
    return;
  }
  if(!var_1) {
    if(maps\mp\_utility::_id_4571() == "mp_zombie_island" || maps\mp\_utility::_id_4571() == "mp_zombie_dnk" || maps\mp\_utility::_id_4571() == "mp_zombie_dnk_srv") {
      apply_cosmetic_changes(1);
      level.zmb_additional_look_check = ::limit_oceanic_zombies;
    }

    return;
  }

  if(!issubstr(maps\mp\_utility::_id_4571(), "mp_zombie")) {
    return;
  }
  common_scripts\utility::_id_092C("mtx_fish_despawn", "vfx/map/mp_zombie_island/zmb_isl_beach_fish_flop_mtx7");

  if(maps\mp\_utility::_id_4571() == "mp_zombie_island") {
    level thread run_fish_quest();
  }

  apply_cosmetic_changes();
  level.zmb_additional_look_check = ::limit_oceanic_zombies;
}

limit_oceanic_zombies(var_0) {
  var_1 = 0;

  foreach(var_3 in _id_0547::_id_408F()) {
    if(_id_0547::is_wet_zombie(undefined, var_3)) {
      var_1++;
    }
  }

  var_5 = 3;

  if(getdvarint("scr_zmbMaxOceanicZombies", 0) > 0) {
    var_5 = getdvarint("scr_zmbMaxOceanicZombies", 0);
  }

  if(var_1 >= var_5) {
    var_0 = common_scripts\utility::_id_0F94(var_0, ["oceana", "oceanb"]);
  }

  return var_0;
}

apply_cosmetic_changes(var_0) {
  level.zombie_prevent_fx_play_func = ::has_body_model;
  level thread add_ocean_zombie_look();

  if(!common_scripts\utility::_id_562E(var_0)) {
    level.zmb_mtx7_event_attached_props = [];
    register_prop_placement("zom_harpoon", "J_Shoulder_RI", (12, 0, 0), (-20, 0, 0));
    register_prop_placement("zom_harpoon", "J_Shoulder_LE", (0, 0, 0), (30, 0, 0));
    register_prop_placement("zom_harpoon", "J_HipTwist_RI", (0, 0, 0), (270, 0, 0));
    register_prop_placement("zom_harpoon", "J_SpineLower", (6, 0, 0), (0, 90, 0));
    level thread _id_0547::perzombiethread(::spawn_fish_on_zombies);
    _id_0547::_id_7BA9(::remove_fish_from_zombies);
  }
}

spawn_fish_on_zombies() {
  if(!_id_0547::is_wet_zombie(undefined, self)) {
    return;
  }
  if(!_id_0547::_id_5565(self._id_0A4B, "zombie_generic")) {
    return;
  }
  if(randomint(100) < 75) {
    return;
  }
  var_0 = get_random_attached_prop();
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel(var_0.char_model);
  var_1 linktosynchronizedparent(self, var_0.joint, var_0.pos_offset, var_0._id_0DD2);
  self.attached_ocean_model = var_1;
}

remove_fish_from_zombies(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(isDefined(self.attached_ocean_model)) {
    self.attached_ocean_model delete();
  }

  if(_id_0547::is_wet_zombie(undefined, self)) {
    level thread spawn_pickupable_fish(self.origin, self _meth_8566());
  }
}

spawn_pickupable_fish(var_0, var_1) {
  if(!isDefined(level.mtx7_fish_array)) {
    level.mtx7_fish_array = [];
  }

  var_2 = undefined;

  if(level.mtx7_fish_array.size < 2) {
    var_2 = spawn("script_model", var_0);
    var_2 setModel("zmi_fish_single_01");
    level.mtx7_fish_array = common_scripts\utility::_id_0F6F(level.mtx7_fish_array, var_2);
  } else {
    foreach(var_4 in level.mtx7_fish_array) {
      if(!common_scripts\utility::_id_562E(var_4._id_08BE)) {
        var_2 = var_4;
        var_2 show();
        break;
      }
    }
  }

  if(!isDefined(var_2)) {
    return;
  }
  var_2 thread fall_onto_ground(var_0, var_1);
  var_2._id_08BE = 1;
  var_6 = var_2 wait_for_player_close_to_fish(60, 1);

  if(isDefined(var_6)) {
    var_6 thread maps\mp\_events_z::contracts_report_player_picked_up_fish();
    var_6 thread maps\mp\gametypes\zombies::_id_4798(10);

    if(!common_scripts\utility::_id_562E(var_6.foundafish) && maps\mp\_utility::_id_4571() == "mp_zombie_island") {
      _id_0555::issprinting("fish_single", var_6);
      var_6.foundafish = 1;
    }

    _id_0378::_id_8D74("zmb_points_pickup", var_6.origin);
    level.zmb_total_fish_collected++;
  }

  var_2 remove_fish(isDefined(var_6));
}

fall_onto_ground(var_0, var_1) {
  var_2 = 0.4;
  self.origin = var_0 + (0, 0, 40) + 18 * vectorNormalize(anglesToForward(var_1));
  self.angles = (0, randomint(360), 0);
  self movegravity((0, 0, 175), 2);
  self._id_6C48 = self.angles;
  self rotateby((180, 180, 0), var_2);
  wait(var_2);
  self.angles = self._id_6C48;
  self.origin = var_0;
}

remove_fish(var_0) {
  if(!common_scripts\utility::_id_562E(var_0)) {
    playFX(common_scripts\utility::_id_44F5("mtx_fish_despawn"), self.origin);
  }

  self ghost();
  self._id_08BE = 0;
}

wait_for_player_close_to_fish(var_0, var_1) {
  var_2 = gettime();

  for(;;) {
    if(isDefined(var_1) && gettime() - var_2 > 4000) {
      return;
    }
    foreach(var_4 in level.players) {
      if(distance(var_4.origin, self.origin) < var_0) {
        return var_4;
      }
    }

    waitframe();
  }
}

register_prop_placement(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.char_model = var_0;
  var_4.joint = var_1;
  var_4.pos_offset = var_2;
  var_4._id_0DD2 = var_3;
  level.zmb_mtx7_event_attached_props = common_scripts\utility::_id_0F6F(level.zmb_mtx7_event_attached_props, var_4);
}

get_random_attached_prop() {
  return common_scripts\utility::random(level.zmb_mtx7_event_attached_props);
}

add_ocean_zombie_look() {
  if(!isDefined(level._id_0A50)) {
    level._id_0A50 = [];
  }

  var_0 = ["zombie_generic", "zombie_heavy"];

  foreach(var_2 in var_0) {
    if(!isDefined(level._id_0A50[var_2])) {
      level._id_0A50[var_2] = [];
    }

    if(!isDefined(level._id_0A50[var_2]._id_5ED2)) {
      level._id_0A50[var_2]._id_5ED2 = [];
    }
  }

  add_ocean_look("a");
  add_ocean_look("b");
  add_ocean_look_follower();
}

add_ocean_look_follower() {
  level._id_0A50["zombie_heavy"]._id_5ED2["ocean"]["whole_body"] = "zom_follower_wet_base";
}

add_ocean_look(var_0) {
  level._id_0A50["zombie_generic"]._id_5ED2["ocean" + var_0] = [];
  level._id_0A50["zombie_generic"]._id_5ED2["ocean" + var_0]["whole_body"] = "zom_infantry" + var_0 + "_wet_bodywhole";
  level._id_0A50["zombie_generic"]._id_5ED2["ocean" + var_0]["torso"] = "zom_infantry" + var_0 + "_wet_torso_slice";
  level._id_0A50["zombie_generic"]._id_5ED2["ocean" + var_0]["left_arm"] = "zom_infantrya_wet_l_arm_slice";
  level._id_0A50["zombie_generic"]._id_5ED2["ocean" + var_0]["left_leg"] = "zom_infantrya_wet_l_leg_slice";
  level._id_0A50["zombie_generic"]._id_5ED2["ocean" + var_0]["right_arm"] = "zom_infantrya_wet_r_arm_slice";
  level._id_0A50["zombie_generic"]._id_5ED2["ocean" + var_0]["right_leg"] = "zom_infantrya_wet_r_leg_slice";
  level._id_0A50["zombie_generic"]._id_5ED2["ocean" + var_0]["heads"] = ["zom_head_wet_fdr02_org1", "zom_head_wet_fdr03_org1", "zom_head_wet_fdr04_org1"];
  level._id_0A50["zombie_generic"]._id_5ED2["ocean" + var_0]["helmets"] = level._id_0A50["zombie_generic"]._id_5ED2["guts"]["helmets"];
  level._id_0A50["zombie_generic"]._id_5ED2["ocean" + var_0]["facegear"] = level._id_0A50["zombie_generic"]._id_5ED2["guts"]["facegear"];
}

has_body_model() {
  var_0 = ["zombie_assassin"];
  return common_scripts\utility::_id_0F79(var_0, self._id_0A4B) || isDefined(self._id_18A8) && self._id_18A8.model == "";
}

run_fish_quest() {
  var_0 = spawn("script_model", (432, 1824, -8));
  var_0.angles = (0, 174, 0);
  var_0 setModel("zdu_red_herring_obj_01");
  var_0 scriptmodelplayanim("zmb_follow_the_fish_loop", undefined, 0, 0.4);
  var_1 = spawn("script_model", (432, 1824, -8));
  var_1.angles = (13, 80, -7);
  var_1 setModel("ger_crate_ammo_closed_01_dirty");
  var_1.origin = var_1.origin + (0, 0, -32);
  var_0 thread move_current();
  wait_for_required_fish();

  foreach(var_3 in level.players) {
    _id_0555::issprinting("fish_total_ee", var_3);
  }

  var_0 wait_for_player_close_to_fish(130);
  wait 1;
  var_0 notify("leaving");
  var_0 movez(-12, 2, 1);
  var_0 rotateYaw(170, 3);
  wait 3;
  var_1 moveTo(var_1.origin + (0, 0, 32), 6, 0, 1);
  var_1 thread vibrate_box();
  var_1 _id_0547::_id_AC41(&"ZOMBIES_EMPTY_STRING", (0, 0, 16));
  level thread maps\mp\_utility::_id_6F74(::collect_teslaguns, var_1);
}

collect_teslaguns(var_0) {
  var_0 waittill("player_used", var_1);
  var_1 thread ee_give_teslagun_rental("teslagun_zm");
}

wait_for_required_fish() {
  while(!isDefined(level.zmb_total_fish_collected) || level.zmb_total_fish_collected < 50) {
    wait 1;
  }
}

vibrate_box() {
  for(;;) {
    self vibrate(anglesToForward(self.angles), 2.1, 3, 3);
    wait 3;
  }
}

ee_give_teslagun_rental(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("disconnect");
  var_1 _id_0586::_id_078C(var_0);
  var_1 _id_0586::_id_078E(var_0);
  _id_0555::issprinting("teslagun_found", var_1);
  wait_for_usage_done(var_0);

  if(var_1 hasweapon(var_0)) {
    var_2 = var_1 getweaponlistprimaries();
    var_1 _id_0586::_id_0790(var_0);
    var_1 _id_0586::_id_078E(var_2[0]);
  }
}

wait_for_usage_done(var_0) {
  var_1 = self;
  var_1 endon("death");
  var_1 endon("disconnect");
  wait 180;
}

force_take_tesla() {
  var_0 = self;
  var_0 notify("force_take_tesla");
}

move_current() {
  self endon("leaving");
  var_0 = self.origin + 7 * vectorNormalize(anglestoright(self.angles));
  self._id_6C4E = self.origin;

  for(;;) {
    self moveTo(var_0, 2, 1, 1);
    wait 2;
    self moveTo(self._id_6C4E, 2, 1, 1);
    wait 4;
  }
}