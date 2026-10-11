/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5d5ed488e7b712ab.gsc
*************************************************/

#using script_32876a523f324870;
#using script_4ab4bd3ef85fb34c;
#using script_5d0aad069db3eeb8;
#using script_a6f526f54ee52f7;
#using scripts\anim\combat_utility;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\door;
#using scripts\sp\maps\sp_jup_flashback\sp_jup_flashback_lighting;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\spawner;
#using scripts\sp\utility;
#namespace namespace_3345ab597fd83308;

function function_81253f168d083e9f() {
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_350377b71c3dfd2e();
  level.player setOrigin((26728, 5672, -24));
  level.player setplayerangles((0, 150, 0));
  thread namespace_fbd1c1b57d4f60c0::function_564579a7b113a217();
  level.var_b24651c26f3bc640 = {
    #angles: (0, 0, 0), #origin: (26657.5, 5637.36, -31.842)
  };
  function_88342a549599c562();

  foreach(transient in level.var_a67ce3c274f5544e) {
    settransientvisibility(transient, 1);
  }
}

function function_2f1b8471b511229b() {
  thread set_flag_on_targetname_trigger("trigger_penthouse_arrive");
  thread function_bcf2f4556bded557();
  thread function_7670ef60f2fb60eb();
  flag_wait_all("player_at_vip_floor", "concourse_stairs_top_open");
  level.player setsoundsubmix("sp_jup_flashback_concourse_upper", 3.5);
  delaythread(2, &activate_trigger_with_targetname, "trigger_color_penthouse_redshirt_stackup");
  thread namespace_fbd1c1b57d4f60c0::function_9d3a4a4d96ade79b();
  thread autosave_by_name();
}

function function_abb9cfecff7e47e0() {
  flag_set("concourse_stairs_top_vo_done");
}

function function_bcf2f4556bded557() {
  flag_init("concourse_stairs_top_vo_done");
  flag_wait("concourse_stairs_vo_done");
  thread function_74e1219b55f0b644();
  flag_wait("concourse_stairs_price_at_door");

  if(flag("constairs_player_interacted_on_door")) {
    flag_wait("constairs_player_open_door_vo_done");
  }

  level.redshirt say_delayed(0.5, "dx_sp_flas_stcs_burn_executivelevelvipare");
  level.price say_delayed(0.2, "dx_sp_flas_stcs_pric_letsgetinthere");
  flag_wait("concourse_stairs_price_at_door");

  while(!level.player can_see_origin((26368, 5664, 32))) {
    waitframe();
  }

  level.player say("dx_sp_flas_penf_soap_clear");
  flag_set("concourse_stairs_top_vo_done");
}

function function_74e1219b55f0b644() {
  level endon("price_reached_door");
  flag_wait("constairs_player_interacted_on_door");
  level.player say_delayed(0.2, "dx_sp_flas_stcs_soap_exitslocked");
  level.price say_delayed(0.2, "dx_sp_flas_stcs_pric_onit");
  flag_set("constairs_player_open_door_vo_done");
}

function function_7670ef60f2fb60eb() {
  doorleft = getEnt("concourse_stairs_top_door", "targetname");
  doorleft assign_animtree("door");
  doorright = scripts\sp\door::get_interactive_door("door_concourse_stair_right");
  flag_init("constairs_player_interacted_on_door");
  thread function_75bb47009db73353();
  flag_wait("concourse_stairs_price_at_door");
  enemies = getaiarray("axis");
  array_call(enemies, &delete);
  namespace_47819225b08b445d::function_f1864fb398798ed6(0);
  level.price thread function_c5498dec1592e748();
  level.redshirt thread function_9ce131bd89ed767a();

  if(flag("constairs_player_animated_entrance")) {
    level.var_b24651c26f3bc640 anim_single_solo(level.price, "concourse_stairs_top_open");
  } else {
    level.var_b24651c26f3bc640 anim_single([doorleft, level.price], "concourse_stairs_top_open");
  }

  namespace_47819225b08b445d::function_f1864fb398798ed6(1);
  flag_set("concourse_stairs_top_open");
}

function function_c5498dec1592e748() {
  enable_ai_color();
  namespace_47819225b08b445d::function_264ea5c38c1ae771();
  level.price setgoalpos(level.price.origin, 32);

  while(distance2dsquared(self.origin, level.player.origin) > 19600) {
    waitframe();
  }

  set_movement_speed(120);
  activate_trigger_with_targetname("trigger_color_penthouse_price_stackup");
}

function function_9ce131bd89ed767a() {
  flag_wait("concourse_stairs_top_open");
  node = spawncovernode((26704, 5648, -16), (0, 150, 0), "Exposed");
  node.radius = 32;
  thread spawner::go_to_node(node);
}

function function_75bb47009db73353() {
  level.price thread price_to_door();
  level.redshirt thread function_fe078253e8419160();
  doorleft = getEnt("concourse_stairs_top_door", "targetname");
  doorright = scripts\sp\door::get_interactive_door("door_concourse_stair_right");
  doorright.no_bash = 1;
  doorright thread function_906345f2536d929e(0);
  result = waittill_any_ents_return(level, "price_reached_door", doorright, "trigger", doorright, "fake_bashed");
  level.price notify("stop_pathing_to_door");
  level.redshirt notify("stop_pathing_to_landing");
  doorright notify("stop_fake_bash");

  if(result == "fake_bashed") {
    flag_set("constairs_player_interacted_on_door");
    var_557e38b8880783a9 = getnode("struct_concourse_stairs_landing_redshirt", "targetname");
    level.redshirt forceteleport(var_557e38b8880783a9.origin, var_557e38b8880783a9.angles);
    level.var_b24651c26f3bc640 anim_first_frame_solo(level.price, "concourse_stairs_top_open");
  } else if(result == "trigger") {
    flag_set("constairs_player_interacted_on_door");
    direction = function_3ab5963c9bcc440b((26584, 5728, -16), (0, 135, 0), 90);

    if(direction == "left") {
      flag_set("constairs_player_animated_entrance");
      anim_str = "concourse_stairs_top_open_left";
      level.player disableweapons();
      level.player_rig = spawn_anim_model("player_rig", (0, 0, 0));
      level.player_rig hide();
      level.player_rig dontinterpolate();
      animlength = getanimlength(level.player_rig getanim(anim_str));
      level.player delaycall(animlength, &unlink);
      level.player delaycall(animlength, &enableweapons);
      level.player_rig delaycall(animlength, &delete);
      level.var_b24651c26f3bc640 anim_first_frame_solo(doorleft, "concourse_stairs_top_plr_open");
      level.var_b24651c26f3bc640 anim_first_frame_solo(level.player_rig, anim_str);
      waitframe();
      level.var_b24651c26f3bc640 thread anim_single_solo(level.player_rig, anim_str);
      level.var_b24651c26f3bc640 thread anim_single_solo(doorleft, "concourse_stairs_top_plr_open");

      if(level.player getstance() != "stand") {
        level.player setstance("stand", 1, 0, 0);
        waitframe();
      }

      blendtime = 0.3;
      var_be589a16ae42c0cd = blendtime * 0.8;
      rightarc = 30;
      leftarc = 30;
      toparc = 30;
      bottomarc = 30;
      level.player playerlinktoblend(level.player_rig, "tag_player", blendtime, blendtime * 0.5, blendtime * 0.5);
      level.player delaycall(blendtime, &playerlinktodelta, level.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
      level.player delaycall(blendtime + 0.5, &lerpviewangleclamp, 1, 0.5, 0.5, rightarc, leftarc, toparc, bottomarc);
      level.player_rig delaycall(var_be589a16ae42c0cd, &show);
    }
  }

  flag_set("concourse_stairs_price_at_door");
  thread function_7d54441cf105253b();
}

function price_to_door() {
  self endon("stop_pathing_to_door");
  level.var_b24651c26f3bc640 anim_reach_solo(self, "concourse_stairs_top_open");
  flag_set("price_reached_door");
}

function function_fe078253e8419160() {
  self endon("stop_pathing_to_landing");
  node = getnode("struct_concourse_stairs_landing_redshirt", "targetname");
  thread spawner::go_to_node(node);
  self waittill("goal");
}

function function_88342a549599c562() {
  var_85e72717148a9523 = getStruct("struct_concourse_stairs_price", "targetname");

  if(!level.player namespace_47819225b08b445d::function_e7c30095a6cdc3ef(var_85e72717148a9523.origin)) {
    level.price forceteleport(var_85e72717148a9523.origin, var_85e72717148a9523.angles);
  } else {
    level.price thread spawner::go_to_node(var_85e72717148a9523);
  }

  var_557e38b8880783a9 = getStruct("struct_concourse_stairs_redshirt", "targetname");

  if(!level.player namespace_47819225b08b445d::function_e7c30095a6cdc3ef(var_557e38b8880783a9.origin)) {
    level.redshirt forceteleport(var_557e38b8880783a9.origin, var_557e38b8880783a9.angles);
    return;
  }

  level.redshirt thread spawner::go_to_node(var_557e38b8880783a9);
}

function function_7634214c5a6e0757() {
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_350377b71c3dfd2e();
  set_start_location("struct_start_penthouse_floor", array_add(level.allies, level.player));
  activate_trigger_with_targetname("trigger_color_penthouse_price_stackup");
  activate_trigger_with_targetname("trigger_color_penthouse_redshirt_stackup");
  thread set_flag_on_targetname_trigger("trigger_penthouse_arrive");
  level.player setsoundsubmix("sp_jup_flashback_concourse_upper", 3.5);
}

function function_f31c22483c77b393() {
  level notify("stop_concourse_civ_logic");
  thread function_e099cbf58f010c0f();
  thread function_5a3fd2b18b03bed4();
  namespace_fbd1c1b57d4f60c0::function_a4d5dee1f16e5ad7();
  namespace_fbd1c1b57d4f60c0::function_af71e5d06fda8b30(0);
  flag_wait("trigger_penthouse_arrive");
  var_1385824410cbe0e2 = array_remove_array(level.var_4291dad1008f93e6, level.var_a67ce3c274f5544e);

  foreach(transient in var_1385824410cbe0e2) {
    settransientvisibility(transient, 0);
  }
}

function function_64b178abc1f05288() {
  flag_set("penthouse_floor_vo_done");
}

function function_fa1cebd2b668aa80() {
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_350377b71c3dfd2e();
  thread function_5a3fd2b18b03bed4();
  set_start_location("struct_start_penthouse_arrive", array_add(level.allies, level.player));
  var_1385824410cbe0e2 = array_remove_array(level.var_4291dad1008f93e6, level.var_a67ce3c274f5544e);

  foreach(transient in var_1385824410cbe0e2) {
    settransientvisibility(transient, 0);
  }
}

function function_4d32f716029af98e() {
  foreach(ally in level.allies) {
    ally.og_grenadeawareness = ally.grenadeawareness;
    ally.grenadeawareness = 0;
  }

  thread function_e93d15e50511b28();
  thread function_e23fa3095370783f();
  thread function_b094554913622b6a();
  flag_wait("penthouse_secure");
  level.redshirt allowedstances("stand");

  foreach(ally in level.allies) {
    ally.grenadeawareness = ally.og_grenadeawareness;
    ally.og_grenadeawareness = undefined;
  }

  thread autosave_by_name();
}

function function_46f0a3fe07c4cfc7() {
  flag_set("penthouse_secure");
  flag_set("price_ready_for_penthouse_anim");
  flag_set("redshirt_ready_for_penthouse_anim");
  level.player notify("stop_warning_civ_deaths");
  temp_bounds = getEntArray("OutOfBounds_Deleteable_Penthouse", "script_noteworthy");

  if(isDefined(temp_bounds) && temp_bounds.size > 0) {
    array_delete(temp_bounds);
  }
}

function function_b094554913622b6a() {
  trigg = getEnt("OutOfBounds_concourse_stairs", "targetname");
  trigg thread namespace_47819225b08b445d::function_8f2ebae90f61cb99();
  flag_wait("player_at_elevator_bottom");
  trigg delete();
}

function function_b09ce984fb9372d3() {
  namespace_47819225b08b445d::spawn_price();
  namespace_47819225b08b445d::function_350377b71c3dfd2e();
  level.player setsoundsubmix("sp_jup_flashback_paramedics_room", 3.5);
  level.penthouse = spawnStruct();
  level.penthouse.animnode = getStruct("animnode_panthouse_conflict", "targetname");
  function_a7b0ec5f85cf2c55();
  level.penthouse.bomb_bag = spawn_anim_model("bomb_bag");
  assert(isDefined(level.penthouse.bomb_bag));
  animnode = getStruct("animnode_panthouse_conflict", "targetname");
  animators = [level.penthouse.bomb_bag, level.penthouse.back_door_left];
  animnode anim_first_frame(animators, "penthouse_bomb");
  level.player setOrigin((26149, 5011, -8), 1);
  level.player setplayerangles((0, 284, 0));
}

function function_fdabe0101feb30cf() {
  level.elevator_node = {
    #targetname: "elevator_anim_node", #angles: (0, 0, 0), #origin: (25298, 4429, -17)
  };
  thread function_6985b854d7321482();
  delaythread(1, &function_1411467caac81168);
  thread function_c1da45b47c3d1fe6();
  temp_bounds = getEntArray("OutOfBounds_Deleteable_Penthouse", "script_noteworthy");

  if(temp_bounds.size > 0) {
    array_delete(temp_bounds);
  }

  flag_wait("penthouse_bomb_scene_done");
  level.price enable_ai_color();
  activate_trigger_with_targetname("trigger_color_penthouse_exit_hallway");
  level.price utility::demeanor_override("cqb");
}

function function_cdd66098f777287c() {}

function function_1411467caac81168() {
  foreach(door in level.penthouse.back_doors) {
    door scripts\sp\door::reset_door();
  }
}

function function_c1da45b47c3d1fe6() {
  flag_init("penthouse_bomb_scene_done");

  if(level.start_point == "penthouse_bomb") {
    wait 1;
  }

  thread function_34963ffe92eee864();
  animnode = getStruct("animnode_panthouse_conflict", "targetname");
  flag_wait_all("price_ready_for_penthouse_anim", "redshirt_ready_for_penthouse_anim");
  animnode thread anim_single([level.penthouse.bomb_bag, level.penthouse.back_door_left], "penthouse_bomb");
  level.price thread function_713886ce68135c9(animnode);
  level.redshirt thread function_cfa6beef79905a23(animnode);
}

function function_34963ffe92eee864() {
  flag_wait_all("price_ready_for_penthouse_anim", "redshirt_ready_for_penthouse_anim");
  battlechatter_off();
  flag_wait("penthouse_bomb_scene_done");
  battlechatter_on();
}

function function_713886ce68135c9(animnode) {
  animnode anim_single_solo(self, "penthouse_bomb");
  utility::clear_movement_speed();
  namespace_47819225b08b445d::function_f1864fb398798ed6(1);
  flag_set("penthouse_bomb_scene_done");
}

function function_cfa6beef79905a23(animnode) {
  level.redshirt.script_pushable = 0;
  animnode anim_single_solo(self, "penthouse_bomb");
  self setgoalpos(self.origin, 32);
}

function function_95771ce6161268ef() {
  var_5eb2cfd74e5fc61b = getEnt("trigger_penthouse_interior", "targetname");
  return level.player istouching(var_5eb2cfd74e5fc61b);
}

function function_262264ed43bd28f1() {
  thread function_6985b854d7321482();
  namespace_47819225b08b445d::spawn_price();
  set_start_location("struct_start_penthouse_elevator", array_add(level.allies, level.player));
  var_1385824410cbe0e2 = array_remove_array(level.var_4291dad1008f93e6, level.var_a67ce3c274f5544e);

  foreach(transient in var_1385824410cbe0e2) {
    settransientvisibility(transient, 0);
  }

  level.player setsoundsubmix("sp_jup_flashback_paramedics_room", 3.5);
  flag_set("trigger_color_penthouse_elevator");
}

function function_9102ea8393f24961() {
  flag_wait("trigger_color_penthouse_elevator");
  thread vo_elevator();
  elevator_animated();
  namespace_aa821a9218e60e7b::function_ce9fdd7fe834de65();

  foreach(transient in level.var_a67ce3c274f5544e) {
    settransientvisibility(transient, 0);
  }

  level.player notify("stop_warning_civ_deaths");
  remove_extra_autosave_check("prevent_save_on_field");
  remove_extra_autosave_check("player_oob");
  function_819657b33ca571ab();
}

function vo_elevator() {
  function_42d71413c0c39620();
  function_df49b2ee807daf0b();
  function_bb79f064ce8a4216();
}

function function_bb79f064ce8a4216() {
  if(flag("player_entered_elevator")) {
    return;
  }

  wait 8;
  array = ["dx_sp_flas_phlv_pric_downheresergeantther", "dx_sp_flas_phlv_pric_makarovisonthemoveso", "dx_sp_flas_phlv_pric_ineedyoudownhereserg"];
  level.price dialogue::nag_wait("player_entered_elevator", array, 11, 2);
}

function function_42d71413c0c39620() {
  elevator = (25295, 4435, -14);
  var_d09d33b1e445f3f2 = 40000;
  playerclose = 22500;

  while(true) {
    if(distancesquared(level.price.origin, elevator) <= var_d09d33b1e445f3f2) {
      autosave_by_name();
      return;
    } else if(distancesquared(level.player.origin, elevator) <= playerclose && utility::within_fov(level.player.origin, level.player.angles, elevator, 0.5)) {
      autosave_by_name();
      return;
    }

    wait 0.2;
  }
}

function function_df49b2ee807daf0b() {
  if(flag("elevator_scene_start")) {
    return;
  }

  level endon("elevator_scene_start");
  var_e687bba1d1cae639 = create_deck(["dx_sp_flas_phlv_pric_weremovingtothegarag", "dx_sp_flas_phlv_pric_theyllexfilmakarovth", "dx_sp_flas_phlv_pric_makarovhastoexitfrom"]);
  var_d8b5ec1d530687e0 = create_deck(["dx_sp_flas_phlv_pric_takethedoorletsgetit", "dx_sp_flas_phlv_pric_getonthedoor", "dx_sp_flas_phlv_pric_ineedyouonthatdoorse"]);
  elevator = (25295, 4435, -14);

  while(true) {
    wait 7;
    var_bb1f50a4748e192c = distancesquared(level.player.origin, elevator) < 62500 ? var_d8b5ec1d530687e0 : var_e687bba1d1cae639;
    level.price say_team(var_bb1f50a4748e192c utility::deck_draw());
  }
}

function function_6985b854d7321482() {
  if(!isDefined(level.elevator_node)) {
    level.elevator_node = {
      #targetname: "elevator_anim_node", #angles: (0, 0, 0), #origin: (25298, 4429, -17)
    };
  }

  door_r = getEnt("elevator_door_r", "targetname");
  door_l = getEnt("elevator_door_l", "targetname");
  door_r delete();
  door_l delete();
  var_5185322fbda123d8 = spawn_anim_model("elevator_door_l", (0, 0, 0), (0, 0, 0));
  var_d4f45e8355364e9e = spawn_anim_model("elevator_door_r", (0, 0, 0), (0, 0, 0));
  level.elevator_node.doors = [var_5185322fbda123d8, var_d4f45e8355364e9e];
  level.elevator_node anim_first_frame([var_5185322fbda123d8, var_d4f45e8355364e9e], "elevator_open");
}

function elevator_animated() {
  level thread function_a301281a66326099();
  level.player_rig = spawn_anim_model("player_rig", (0, 0, 0), (0, 0, 0));
  level.player_rig hide();
  level.elevator_node anim_first_frame_solo(level.player_rig, "elevator_open_enter");
  waitframe();
  var_dc1280b0e35763a7 = {
    #angles: (0, 0, 0), #origin: (25292, 4439, 36)
  };
  var_788f478911d428b = {
    #angles: (0, 0, 0), #origin: (25302, 4426, 33)
  };
  var_dc1280b0e35763a7 scripts\sp\player\cursor_hint::create_cursor_hint();
  var_dc1280b0e35763a7.cursor_hint_ent sethintonobstruction("show");
  var_dc1280b0e35763a7 waittill("trigger");
  function_6a85e32a9a2ada7c();
  namespace_84ed3a3872f22d68::function_e1669c4e37d61ff9();
  thread function_bb0d1b75fe9f566d();
  flag_set("elevator_scene_start");
  fb_lighting::function_e672a8b815c0a7f0();
  thread namespace_47819225b08b445d::player_pov_animated(1);
  var_9859a37c0dfe3f62 = flag("price_at_elevator") == 1 ? "elevator_open_enter" : "elevator_open_enter_early";
  var_28bb2ef86b103314 = function_a39b20c9ff530e2();
  enter_xanim = namespace_47819225b08b445d::function_fbca877c7dca5b38(level.elevator_node, var_28bb2ef86b103314);
  level.scr_anim["player_rig"][var_9859a37c0dfe3f62] = enter_xanim;
  level.elevator_node anim_first_frame_solo(level.player_rig, var_9859a37c0dfe3f62);
  waitframe();
  namespace_47819225b08b445d::function_8da3daaa6d7ab1a1({
    #rightarc: 9, #leftarc: 9, #bottomarc: 5, #toparc: 30
  });

  if(utility::flag("price_at_elevator") && !utility::flag("price_waiting_at_elevator")) {
    utility::flag_wait_or_timeout("price_waiting_at_elevator", 2.6);

    if(!utility::flag("price_waiting_at_elevator")) {
      flag_set("price_waiting_at_elevator");
    }
  }

  level.elevator_node notify("stop_loop");
  level.price notify("goal");
  level.elevator_node animation::anim_single([level.player_rig, level.price], var_9859a37c0dfe3f62);
  everyone = utility::array_combine(level.elevator_node.doors, [level.price, level.player_rig]);
  level.elevator_node thread animation::anim_single(everyone, "elevator_open");
  level thread function_d0e353aa4dc7e6d7();
  level.player_rig waittillmatch("single anim", "end");
  thread namespace_47819225b08b445d::player_pov_animated(0);
  namespace_47819225b08b445d::unlink_player_from_rig();
  var_3abcf9d3931eb635 = getEnt("elevator_player_clip", "targetname");

  if(isDefined(var_3abcf9d3931eb635)) {
    var_3abcf9d3931eb635 delete();
  }

  thread function_6d13150407a6848c();
  autosave_by_name();
  thread function_2ce5fd21816e7f10();
  level.player_rig = spawn_anim_model("player_rig", (0, 0, 0), (0, 0, 0));
  level.player_rig hide();
  level.elevator_node anim_first_frame([level.player_rig], "elevator_rappel_enter");
  wait 1;
  rappel_interact();
  level.player setsoundsubmix("sp_jup_flashback_slide_down_elevator", 0.5);
  level.player delaycall(2, &clearsoundsubmix, "sp_jup_flashback_slide_down_elevator", 4);
  level.player delaycall(2, &clearsoundsubmix, "sp_jup_flashback_paramedics_room", 4);
  level.player delaycall(3, &setsoundsubmix, "sp_jup_flashback_lower_garage", 3);
  flag_set("player_entered_elevator");
  thread elevator_music();
  level.var_4b4aedbd7c100540 delete();
  thread namespace_47819225b08b445d::player_pov_animated(1);

  if(flag("player_jumped_to_elevator")) {
    thread function_cd683ece3990120();
  } else {
    namespace_47819225b08b445d::function_8da3daaa6d7ab1a1();
    level.elevator_node animation::anim_single_solo(level.player_rig, "elevator_rappel_enter");
  }

  if(!flag("price_at_elevator_bottom")) {
    level.price stopanimScripted();
  }

  level.price utility::delaythread(1, &utility::enable_ai_color);
  level.elevator_node animation::anim_single([level.player_rig, level.price], "elevator_go");
  thread namespace_47819225b08b445d::player_pov_animated(0);
  namespace_47819225b08b445d::unlink_player_from_rig();
  namespace_47819225b08b445d::function_f1864fb398798ed6(1);
  flag_set("player_at_elevator_bottom");
  level.player utility::set_player_demeanor("normal");
  autosave_by_name();
}

function function_6d13150407a6848c() {
  wait 1;

  if(!flag("player_entered_elevator")) {
    level.player utility::set_player_demeanor("relaxed");
  }
}

function function_ccaa179c6a8cd9e1() {
  temp = spawn_tag_origin();
  temp playSound("fbk_0400_clubhouse_elevator_interact2_plr_01");
  wait 1;
  temp scalevolume(0, 1.3);
  wait 3;
  temp delete();
}

function function_cd683ece3990120() {
  waitframe();
  level.player_rig setanimtime(level.player_rig getanim("elevator_go"), 0.3);
  blendtime = 1;
  var_858203d3d31e76f2 = 0.1;
  rightarc = 30;
  leftarc = 30;
  toparc = 30;
  bottomarc = 30;

  if(level.player getstance() != "stand") {
    level.player setstance("stand", 1, 0, 0);
    waitframe();
  }

  level.player_rig.allows = ["weapon", "offhand_weapons", "melee", "sprint", "allow_jump", "mantle", "crouch", "prone"];
  level.player val::set_array("player_rig", level.player_rig.allows, 0);
  level.player playerlinktoblend(level.player_rig, "tag_player", blendtime, blendtime * 0.5, blendtime * 0.5);
  level.player delaycall(blendtime, &playerlinktodelta, level.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player delaycall(blendtime + 0.5, &lerpviewangleclamp, 1, 0.5, 0.5, rightarc, leftarc, toparc, bottomarc);
  level.player_rig delaycall(var_858203d3d31e76f2 + 0.5, &show);
}

function function_2ce5fd21816e7f10() {
  level endon("player_entered_elevator");

  while(true) {
    if(level.player jumpbuttonPressed()) {
      level.player.var_d1e548a08ad3484c = gettime();
    }

    waitframe();
  }
}

function rappel_interact() {
  var_fde25a217e808bad = (25351, 4383, 60);
  var_bb4312b66e37c5f = (var_fde25a217e808bad[0], var_fde25a217e808bad[1], 0);
  var_8776b4bfef0709 = (var_fde25a217e808bad[0], var_fde25a217e808bad[1], -60);
  level.var_4b4aedbd7c100540 = spawn_tag_origin();
  level.var_4b4aedbd7c100540 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", undefined, &"SP_JUP_FLASHBACK/HINT_RAPPEL", 50, 160, 138);
  waitframe();
  level.var_4b4aedbd7c100540 sethintonobstruction("show");
  level.var_4b4aedbd7c100540 setuseholdduration("duration_none");
  level.var_4b4aedbd7c100540 endon("trigger");

  while(true) {
    start = level.player getEye();
    var_21230ad9e2e0959d = distance(start, var_bb4312b66e37c5f);
    end = start + anglesToForward(level.player getplayerangles()) * var_21230ad9e2e0959d;
    level.var_4b4aedbd7c100540.origin = pointonsegmentnearesttopoint(var_fde25a217e808bad, var_8776b4bfef0709, end);

    if(var_21230ad9e2e0959d < 110 && function_742ac1846e4c155f(level.var_4b4aedbd7c100540.origin)) {
      thread function_ccaa179c6a8cd9e1();
      flag_set("player_jumped_to_elevator");
      level.var_4b4aedbd7c100540 notify("trigger");
    }

    waitframe();
  }
}

function function_742ac1846e4c155f(var_f208eb71426fc5f5) {
  if(istrue(level.player getnormalizedmovement()[0]) && !level.player isonground() && isDefined(level.player.var_d1e548a08ad3484c) && gettime() - level.player.var_d1e548a08ad3484c < 1000) {
    if(level.player math::is_point_in_front(var_f208eb71426fc5f5)) {
      return true;
    }

    if(namespace_47819225b08b445d::in_screen_center(var_f208eb71426fc5f5, 200)) {
      return true;
    }
  }

  return false;
}

function function_a301281a66326099() {
  level.elevator_node anim_reach_solo(level.price, "elevator_intro");
  utility::flag_set("price_at_elevator");
  namespace_47819225b08b445d::function_f1864fb398798ed6(0);

  if(flag("elevator_scene_start")) {
    return;
  }

  level thread utility::flag_set_delayed("price_waiting_at_elevator", 2.4);
  level.elevator_node anim_single_solo(level.price, "elevator_intro");

  if(flag("elevator_scene_start")) {
    return;
  }

  level.elevator_node thread anim_loop_solo(level.price, "elevator_idle");
}

function function_d0e353aa4dc7e6d7() {
  level endon("player_entered_elevator");
  level.price waittillmatch("single anim", "end");
  flag_set("price_at_elevator_bottom");
  level.elevator_node anim_first_frame_solo(level.price, "elevator_go");
}

function function_bb0d1b75fe9f566d() {
  level endon("player_entered_elevator");
  var_44fa4900f2042017 = level.player.origin[2] - 60;

  while(true) {
    if(level.player.origin[2] <= var_44fa4900f2042017) {
      level.player die();
      return;
    }

    waitframe();
  }
}

function function_e5430163f1ff288e() {
  flag_set("trigger_color_penthouse_elevator");
}

function function_b005cce1bb38c3eb() {
  level endon("penthouse_door_interacted");

  if(level.start_point != "penthouse_arrive") {
    level.penthouse.animnode anim_reach_solo(self, "fbk_0360_price_to_door");
    level.penthouse.animnode anim_single_solo(self, "fbk_0360_price_to_door");
  } else {
    level.penthouse.animnode anim_first_frame_solo(self, "fbk_0360_price_idle_door");
  }

  level.penthouse.animnode childthread anim_loop_solo(self, "fbk_0360_price_idle_door", "stop_price_door_loop");
}

function function_d05bf470721dc115() {
  level endon("penthouse_door_interacted");
  self.script_pushable = 0;
  wait 1;
  node = getnode("node_penthouse_stack_up_redshirt", "targetname");
  scripts\sp\spawner::go_to_node(node);
  level.penthouse.animnode thread anim_reach_solo(self, "fbk_0360_intro");
}

function function_7b6bcd3f8ad3dba9() {
  thread function_8f42def5a63cb059();
}

function function_920bffe6b195b138() {
  exploder("penthouse_smoke");
}

function function_431e36c3d6a95d81() {
  self endon("death");
  self endon("behavior_normal_done");
  self waittill("doFlashBanged");
  self stopanimScripted();
  waitframe();
  scripts\anim\combat_utility::flashbangstart(1.5);
}

function function_e23fa3095370783f() {
  flag_wait("penthouse_scene_initialized");
  assertex(isDefined(level.penthouse), "Trying to play penthouse scene without it being initialized yet!");
  disable_trigger_with_targetname("trigger_color_penthouse_elevator");
  level.price thread function_b005cce1bb38c3eb();
  level.redshirt thread function_d05bf470721dc115();
  thread function_b69a4e871476186e();
  level waittill("penthouse_door_interacted", interact_type);
  var_2d7b5ccd309f3a6f = interact_type == "fake_bashed";
  level.penthouse.animnode notify("stop_price_door_loop");
  array_call(level.penthouse.enemies, &visiblesolid);
  flag_set("player_in_penthouse");
  thread autosave_by_name();
  namespace_47819225b08b445d::function_f1864fb398798ed6(0);
  level.player setsoundsubmix("sp_jup_flashback_paramedics_room", 3.5);
  level.player clearsoundsubmix("sp_jup_flashback_concourse_upper", 3.5);
  level.penthouse.enemy01 thread function_5883f56d225b4f89();
  level.penthouse.enemy02 thread function_3e31d6d3a1099890();
  level.penthouse.enemy03 thread function_e88ca8840459e0b();
  level.penthouse.enemy04 thread function_b322866f1a7f1f1a();
  level.penthouse.enemy05 thread function_902f710ec4728cf5();
  array_thread(level.penthouse.enemies, &function_431e36c3d6a95d81);
  level notify("visibilityTeamName", "neutral", level.penthouse.enemies, 1);
  thread player_intro_anims(var_2d7b5ccd309f3a6f);
  level.price thread function_8a4ba00f272a838f(var_2d7b5ccd309f3a6f);
  level.redshirt thread function_2b8e8d55bb12210d(var_2d7b5ccd309f3a6f);
  thread function_9db6e4648ce6b850();
  thread function_e96ed542357e45b1();
  thread function_1a4995da9ba1c914(var_2d7b5ccd309f3a6f);
  thread function_45944cac9c94ab3f();
  combat_reason = level waittill_any_return("intro_anims_done", "player_lured_to_ambush", "player_triggered_ambush");
  level notify("stop_combat_checks");

  thread function_7b6bcd3f8ad3dba9();
  thread function_920bffe6b195b138();

  foreach(enemy in level.penthouse.enemies) {
    if(!is_dead_or_dying(enemy)) {
      if(enemy.animname != "enemy01") {
        enemy utility::function_1a479cad9c3adbb1(1);
      }

      enemy set_ignoreme(0);
      enemy setgoalpos(enemy.origin, 32);
      enemy actoraimassiston();
    }
  }

  if(combat_reason == "player_lured_to_ambush") {
    foreach(enemy in level.penthouse.enemies) {
      if(!is_dead_or_dying(enemy)) {
        switch (enemy.animname) {
          case #"hash_b1814a65888b98f0":
            break;
          case #"hash_b1814d65888b9da9":
            enemy scripts\anim\shared::forceuseweapon(make_weapon("iw9_pi_golf17_sp"), "primary");
            break;
          default:
            enemy namespace_47819225b08b445d::function_17177a175dd8f243("iw9_sm_aviktor_sp");
            break;
        }
      }
    }

    level.player thread function_3fa59ff4da1f2db7();
    level.player thread function_63273eb420810c49();
    level.player thread function_8fdd5ec3d6f3505e();
    array_thread(level.allies, &set_ignoreall, 1);
    blend_settings = spawnStruct();
    blend_settings.animnode = level.penthouse.animnode;
    blend_settings.var_80a430288ed01864 = "lure_ambush";
    blend_settings.var_298fc64ffe3d9320 = "stand";
    blend_settings.var_a900ec49b62870fb = 0.55;
    direction = function_3ab5963c9bcc440b((26099, 5006.5, 12), (0, 175, 0), 63, 110);

    switch (direction) {
      case #"hash_bf1a695c21e57fe4":
      case #"hash_c9b3133a17a3b2d0":
        blend_settings.var_a779bb61fe7ea6b = "lure_ambush_enter_front";
        break;
      case #"hash_96815ce4f2a3dbc5":
        blend_settings.var_a779bb61fe7ea6b = "lure_ambush_enter_right";
        break;
    }

    thread function_c1de9e8d1524edce(blend_settings);
    level.player thread function_52c52c2bebc39658();
    level.penthouse.enemy02 notify("stop_react_logic");
    level.penthouse.animnode thread anim_single_solo(level.penthouse.enemy02, "lure_ambush_enter");
    animating_combatants = level.penthouse.enemies;
    animating_combatants = array_add(animating_combatants, level.price);
    animating_combatants = array_add(animating_combatants, level.redshirt);
    waitframe();
    level.player waittill("enter_blend_done");
    level.penthouse.enemy01 thread namespace_47819225b08b445d::kill_on_anim_end();
    level.penthouse.enemy02 thread namespace_47819225b08b445d::kill_on_anim_end();
    array_notify(animating_combatants, "stop_react_logic");
    level.penthouse.animnode thread anim_single(animating_combatants, "lure_ambush");
    level.player waittill("blended_anim_done");
    array_thread(level.allies, &set_ignoreall, 0);
    level.price thread function_3035d61a7fc9452f();
    level.redshirt thread function_b71a8bf8942d4201();
    point = getclosestpointonnavmesh(level.player.origin);
    level.player setOrigin(point);
  }

  flag_set("penthouse_combat", combat_reason);
  level notify("visibilityTeamName", "axis", level.penthouse.enemies, 1);
  namespace_47819225b08b445d::function_5da13e5444950c67(level.penthouse.enemies, "penthouse_secure");
  enable_trigger_with_targetname("trigger_color_penthouse_elevator");
}

function function_52c52c2bebc39658() {
  wait 0.5;
  self setstance("crouch", 1);

  while(self getstance() != "crouch") {
    waitframe();
  }

  function_c8e47b79550e4319(0);
  flag_wait("lure_ambush_weapons_raised");
  function_c8e47b79550e4319(1);
}

function function_3fa59ff4da1f2db7() {
  weapons = self getweaponslistprimaries();
  pistol_weapon = undefined;

  foreach(weapon in weapons) {
    if(issubstr(weapon.basename, "_pi_")) {
      pistol_weapon = weapon;
      break;
    }
  }

  if(!isDefined(pistol_weapon)) {
    weapon_to_take = self getcurrentweapon();
    self disableweapons();

    while(true) {
      if(self getcurrentweapon() == nullweapon()) {
        break;
      }

      waitframe();
    }

    self takeweapon(weapon_to_take);
    function_536aa7cbedb60aea(weapon_to_take, (26136, 5008, -8));
    pistol_weapon = make_weapon("iw9_pi_golf17_sp");
    give_weapon(pistol_weapon, 0, 0, 0, 1);
    self setweaponammoclip(pistol_weapon, weaponclipsize(pistol_weapon) - 1);
  } else {
    flag_set("lure_ambush_player_had_pistol");
    self disableweapons();
  }

  self switchtoweapon(pistol_weapon);
}

function function_536aa7cbedb60aea(var_37f1c96156afa5b9, drop_origin) {
  flag_wait("lure_ambush_weapons_raised");
  utility::function_ec8a443fe8165fe4(var_37f1c96156afa5b9.basename, drop_origin, var_37f1c96156afa5b9.attachments);
}

function function_8f42def5a63cb059() {
  setmusicstate("mx_flashback_paramedicfight");
}

function function_8fdd5ec3d6f3505e() {
  flag_wait("nt_lure_ambush_grab_player");
  self playSound("scn_grab_pull");
  flag_wait("nt_lure_ambush_hit_player");
  level.penthouse.enemy02 shoot();
  wait 0.1;
  self playSound("prj_bullet_large_flesh_torso_plr_armor");
  level.player setsoundsubmix("sp_jup_flashback_paramedics_shot_plr", 0.1);
  level.player delaycall(3, &clearsoundsubmix, "sp_jup_flashback_paramedics_shot_plr", 4);
}

function function_63273eb420810c49() {
  level endon("penthouse_secure");
  self waittill("death");

  foreach(ally in level.allies) {
    ally stop_magic_bullet_shield();
    namespace_7f81dff3bcaf7919::squib_head(ally);
    ally.diequietly = 1;
    ally kill();
  }
}

function function_b3fbc2d04553c6cc(animnode, anim_scene, var_4bf386b0f91a435f, var_2b24b3fcff178873, forced_stance, var_c1934658d6661228) {
  if(!isDefined(var_4bf386b0f91a435f)) {
    var_4bf386b0f91a435f = 1;
  }

  if(!isDefined(var_2b24b3fcff178873)) {
    var_2b24b3fcff178873 = 1;
  }

  if(!isDefined(forced_stance)) {
    forced_stance = "stand";
  }

  if(!isDefined(var_c1934658d6661228)) {
    var_c1934658d6661228 = 0.6;
  }

  if(var_4bf386b0f91a435f) {
    self disableweapons();
  }

  if(isDefined(level.player_rig)) {
    level.player_rig delete();
  }

  level.player_rig = spawn_anim_model("player_rig", (0, 0, 0), (0, 0, 0));
  level.player_rig hide();
  level.player_rig dontinterpolate();
  self dontinterpolate();
  level.player setstance(forced_stance, 1);

  while(level.player getstance() != forced_stance) {
    waitframe();
  }

  self freezecontrols(var_2b24b3fcff178873);
  animnode anim_first_frame_solo(level.player_rig, anim_scene);
  waitframe();
  function_e86b9ca948270886(var_c1934658d6661228);
  self notify("blended_to_igc_state");
}

function function_6c85278bd835d3ab(var_e17dc8df92787dda) {
  var_e17dc8df92787dda = default_to(var_e17dc8df92787dda, 1);

  if(var_e17dc8df92787dda) {
    self enableweapons();
  }

  self unlink();
  level.player_rig hide();
  self freezecontrols(0);
  self notify("disabled_igc_state");
}

function function_e86b9ca948270886(blend_time) {
  if(!isDefined(blend_time)) {
    blend_time = 0.6;
  }

  assert(isDefined(level.player_rig));
  level.player playerlinktoblend(level.player_rig, "tag_player", blend_time, blend_time * 0.5, blend_time * 0.5);
  level.player delaycall(blend_time, &playerlinktodelta, level.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player delaycall(blend_time + 0.5, &lerpviewangleclamp, 1, 0.5, 0.5, 10, 10, 10, 10);
  level.player_rig delaycall(blend_time + 0.1, &show);
  wait blend_time;
}

function player_intro_anims(var_2d7b5ccd309f3a6f) {
  if(var_2d7b5ccd309f3a6f) {
    return;
  }

  blend_settings = spawnStruct();
  blend_settings.animnode = level.penthouse.animnode;
  blend_settings.var_80a430288ed01864 = "fbk_0360_intro";
  blend_settings.var_298fc64ffe3d9320 = "stand";
  blend_settings.var_a900ec49b62870fb = 0.5;
  direction = function_3ab5963c9bcc440b((26312, 5122, -16), (0, 224, 0));

  switch (direction) {
    case #"hash_bf1a695c21e57fe4":
      blend_settings.var_a779bb61fe7ea6b = "fbk_0360_intro_enter_front";
      break;
    case #"hash_c9b3133a17a3b2d0":
      blend_settings.var_a779bb61fe7ea6b = "fbk_0360_intro_enter_left";
      break;
    case #"hash_96815ce4f2a3dbc5":
      blend_settings.var_a779bb61fe7ea6b = "fbk_0360_intro_enter_right";
      break;
  }

  thread function_c1de9e8d1524edce(blend_settings);
  level.player waittill("enter_blend_done");
  level.penthouse.animnode thread anim_single_solo(level.penthouse.door_right, "fbk_0360_intro");
  level.penthouse.door_right namespace_47819225b08b445d::function_cd8107d772ca6582();
}

function function_3ab5963c9bcc440b(origin, angles, var_413274c2fbe6d9d8, var_186abf38478e3e49) {
  if(!isDefined(var_413274c2fbe6d9d8)) {
    var_413274c2fbe6d9d8 = 65;
  }

  if(!isDefined(var_186abf38478e3e49)) {
    var_186abf38478e3e49 = 93;
  }

  door_forward = anglesToForward((angles[0], angles[1] - 90, angles[2]));
  to_player = vectorNormalize(level.player.origin - origin);
  dot = vectordot(door_forward, to_player);
  angle = acos(dot);
  door_dist = distance2d(origin, level.player.origin);

  if(angle < var_186abf38478e3e49 && angle > var_413274c2fbe6d9d8) {
    return "center";
  }

  if(angle > var_186abf38478e3e49) {
    return "left";
  }

  if(angle < var_413274c2fbe6d9d8) {
    return "right";
  }
}

function function_c1de9e8d1524edce(settings) {
  var_a900ec49b62870fb = 0.5;

  if(isDefined(settings)) {
    animnode = settings.animnode;
    var_80a430288ed01864 = settings.var_80a430288ed01864;
    var_a779bb61fe7ea6b = settings.var_a779bb61fe7ea6b;
    bodymodel = settings.var_1df5b199075babd6;
    var_298fc64ffe3d9320 = settings.var_298fc64ffe3d9320;
    var_a900ec49b62870fb = settings.var_a900ec49b62870fb;
  }

  level.player disableweapons();
  level.player disableoffhandweapons();
  level.player allowmelee(0);

  if(isDefined(var_298fc64ffe3d9320)) {
    level.player setstance(var_298fc64ffe3d9320, 1);

    while(level.player getstance() != var_298fc64ffe3d9320) {
      waitframe();
    }
  }

  if(isDefined(level.player_rig)) {
    level.player_rig delete();
  }

  level.player_rig = spawn_anim_model("player_rig", (0, 0, 0), (0, 0, 0));

  if(isDefined(bodymodel)) {
    level.player_rig setModel(bodymodel);
  }

  level.player_rig hide();
  level.player_rig dontinterpolate();
  level.player dontinterpolate();
  var_c2e9164803e03be9 = getanimlength(level.player_rig getanim(var_a779bb61fe7ea6b));
  animnode anim_first_frame_solo(level.player_rig, var_a779bb61fe7ea6b);
  waitframe();
  animnode thread anim_single_solo(level.player_rig, var_a779bb61fe7ea6b);
  blendtime = var_c2e9164803e03be9;
  var_be589a16ae42c0cd = blendtime * var_a900ec49b62870fb;
  rightarc = 30;
  leftarc = 30;
  toparc = 30;
  bottomarc = 30;
  level.player playerlinktoblend(level.player_rig, "tag_player", blendtime, blendtime * 0.5, blendtime * 0.5);
  level.player delaycall(blendtime, &playerlinktodelta, level.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player delaycall(blendtime + 0.5, &lerpviewangleclamp, 1, 0.5, 0.5, rightarc, leftarc, toparc, bottomarc);
  level.player_rig delaycall(var_be589a16ae42c0cd, &show);
  wait blendtime;
  level.player notify("enter_blend_done");
  animnode anim_first_frame_solo(level.player_rig, var_80a430288ed01864);
  animnode anim_single_solo(level.player_rig, var_80a430288ed01864);
  level.player unlink();
  level.player_rig delete();
  level.player notify("blended_anim_done");
  level.player allowmelee(1);
  level.player enableweapons();
  level.player enableoffhandweapons();
}

function function_4c1f8dec3e3915d8() {
  level.player disableweapons();
  level.player_rig = spawn_anim_model("player_rig", (0, 0, 0), (0, 0, 0));
  level.player_rig hide();
  level.player_rig dontinterpolate();
  var_c2e9164803e03be9 = getanimlength(level.player_rig getanim("fbk_0360_intro_enter_front"));
  level.penthouse.animnode anim_first_frame_solo(level.player_rig, "fbk_0360_intro_enter_front");
  level.penthouse.animnode thread anim_single_solo(level.player_rig, "fbk_0360_intro_enter_front");
  blendtime = var_c2e9164803e03be9;
  rightarc = 30;
  leftarc = 30;
  toparc = 30;
  bottomarc = 30;
  level.player playerlinktoblend(level.player_rig, "tag_player", blendtime, blendtime * 0.5, blendtime * 0.5);
  level.player delaycall(blendtime, &playerlinktodelta, level.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player delaycall(blendtime + 0.5, &lerpviewangleclamp, 1, 0.5, 0.5, rightarc, leftarc, toparc, bottomarc);
  wait blendtime;
  level.player_rig show();
  level.penthouse.animnode anim_single_solo(level.player_rig, "fbk_0360_intro");
  level.player enableweapons();
  level.player unlink();
  level.player_rig delete();
}

function function_8a4ba00f272a838f(var_2d7b5ccd309f3a6f) {
  self endon("stop_react_logic");
  childthread function_39d953db4052dc35();
  childthread function_c68f5069b0feaf58();
}

function function_39d953db4052dc35() {
  level endon("penthouse_combat");
  level.penthouse.animnode anim_first_frame_solo(self, "fbk_0360_intro");
  level.penthouse.animnode thread anim_single_solo(level.penthouse.door_left, "fbk_0360_intro");
  level.penthouse.animnode anim_single_solo(self, "fbk_0360_intro");
  level notify("intro_anims_done");
}

function function_c68f5069b0feaf58() {
  flag_wait("penthouse_combat");
  self stopanimScripted();
  anim_single_solo(self, "fbk_0360_react_dynamic");
  function_3035d61a7fc9452f();
}

function function_3035d61a7fc9452f() {
  set_movement_speed(90);
  level.penthouse.animnode anim_reach_solo(self, "penthouse_bomb");
  flag_set("price_ready_for_penthouse_anim");
}

function function_2b8e8d55bb12210d(var_2d7b5ccd309f3a6f) {
  self endon("stop_react_logic");
  childthread function_7d97bc289555c653();
  childthread function_9e4024359e756f32();
}

function function_7d97bc289555c653() {
  level endon("penthouse_combat");
  level.penthouse.animnode anim_first_frame_solo(self, "fbk_0360_intro");
  level.penthouse.animnode anim_single_solo(self, "fbk_0360_intro");
  level notify("intro_anims_done");
}

function function_9e4024359e756f32() {
  combat_reason = level waittill_any_return("penthouse_combat", "intro_anims_done");
  self stopanimScripted();
  waitframe();
  function_b71a8bf8942d4201();
}

function function_b71a8bf8942d4201() {
  level.penthouse.animnode anim_reach_solo(self, "penthouse_bomb");
  self setgoalpos(self.origin, 32);
  self allowedstances("crouch");
  flag_set("redshirt_ready_for_penthouse_anim");
}

function function_9db6e4648ce6b850() {
  animators = array_merge(level.penthouse.civs, level.penthouse.stretchers);
  level.penthouse.animnode anim_single(animators, "fbk_0360_intro");
}

function function_5883f56d225b4f89() {
  self endon("death");
  self endon("stop_react_logic");
  childthread function_3242c3938ea0580f();
  flag_wait("penthouse_combat");
  self.health = 1;
  self.deathfunction = &animation::function_ce450b9957138bd5;
  childthread function_342303677755165e();
}

function function_342303677755165e() {
  self endon("death");
  thread function_ec985bcfd00c5bbf();
  animnode = {
    #angles: (0, 45, 0), #origin: self.origin
  };
  animnode anim_single_solo(self, "fbk_0360_react_dive_death");
  self.deathfunction = undefined;
  die_frozen();
}

function function_ec985bcfd00c5bbf() {
  self playSound("fbk_0360_clubhouse_conflict_react_enmy01_01_Script");
}

function function_3242c3938ea0580f() {
  self endon("death");
  level endon("penthouse_combat");
  level.penthouse.animnode anim_single_solo(self, "fbk_0360_intro");
  level notify("intro_anims_done");
  level.penthouse.animnode anim_single_solo(self, "fbk_0360_react");
  self notify("behavior_normal_done");
  die_frozen();
}

function function_3e31d6d3a1099890() {
  self endon("death");
  self endon("stop_react_logic");
  childthread function_80fac2be80e55ca();
  childthread function_244f6c9d5604a94f();
}

function function_80fac2be80e55ca() {
  self endon("death");
  self endon("stop_behavior_normal");
  level.penthouse.animnode anim_single_solo(self, "fbk_0360_intro");
  level notify("intro_anims_done");
  level.penthouse.animnode thread anim_single_solo(self, "fbk_0360_react");
  self notify("behavior_normal_done");
  wait 0.5;
  scripts\anim\shared::forceuseweapon(make_weapon("iw9_pi_golf17_sp"), "primary");
}

function function_244f6c9d5604a94f() {
  level endon("intro_anims_done");
  flag_wait("penthouse_combat");
  self notify("stop_behavior_normal");
  level.penthouse.animnode thread anim_single_solo(self, "fbk_0360_react_crouch_pistol");
  wait 0.5;
  scripts\anim\shared::forceuseweapon(make_weapon("iw9_pi_golf17_sp"), "primary");
}

function function_e88ca8840459e0b() {
  self endon("death");
  self endon("stop_react_logic");
  function_7ba88b2ee15a39a1("iw9_sm_aviktor_sp", "j_gun");
  childthread function_83f6650aebbd6401();
  childthread function_dd1f3fd8c2bcbb0();
}

function function_83f6650aebbd6401() {
  self endon("death");
  self endon("stop_behavior_normal");
  level.penthouse.animnode anim_single_solo(self, "fbk_0360_intro");
  level notify("intro_anims_done");
  function_67e4cafd8e2ff2da();
  scripts\anim\shared::forceuseweapon(make_weapon("iw9_sm_aviktor_sp"), "primary");
  level.penthouse.animnode anim_single_solo(self, "fbk_0360_react_toss_ar_into_ar");
  self notify("behavior_normal_done");
}

function function_dd1f3fd8c2bcbb0() {
  self endon("death");
  level endon("intro_anims_done");
  flag_wait("penthouse_combat");
  self notify("stop_behavior_normal");
  function_c68144cb77976e2f(0);
  thread anim_single_solo(self, "fbk_0360_react_stand_pistol");
  wait 0.5;
  scripts\anim\shared::forceuseweapon(make_weapon("iw9_pi_golf17_sp"), "primary");
}

function function_b322866f1a7f1f1a() {
  self endon("death");
  self endon("stop_react_logic");
  function_7ba88b2ee15a39a1("iw9_ar_akilo_sp", "j_gun");
  childthread function_559e45777ecdd47c();
  childthread function_96270100193d8d21();
}

function function_559e45777ecdd47c() {
  self endon("death");
  self endon("stop_behavior_normal");
  level.penthouse.animnode anim_single_solo(self, "fbk_0360_intro");
  level notify("intro_anims_done");
  thread function_228c332440741c42();
  thread function_aa0516799368e121();
  level.penthouse.animnode anim_single_solo(self, "fbk_0360_react_toss_ar_into_ar");
  self notify("behavior_normal_done");
}

function function_96270100193d8d21() {
  self endon("death");
  level endon("intro_anims_done");
  level waittill("penthouse_combat", combat_reason);

  if(combat_reason == "player_lured_to_ambush") {
    return;
  }

  self notify("stop_behavior_normal");
  self stopanimScripted();
  function_c68144cb77976e2f(0);
  thread anim_single_solo(self, "fbk_0360_react_stand_pistol");
  wait 0.5;
  scripts\anim\shared::forceuseweapon(make_weapon("iw9_pi_golf17_sp"), "primary");
}

function function_228c332440741c42() {
  level endon("nt_lure_ambush_gun_throw_end");
  self endon("death");
  self.fake_rifle linkTo(self, "j_gun");
  self.fake_rifle setCanDamage(1);
  flag_wait("nt_lure_ambush_gun_throw_start");
  self.fake_rifle waittill("damage", dmg, attacker, dir, point, mod, modelname, tagname, full_partname, idflags, weapobj);

  if(!is_equal(attacker, level.player)) {
    return;
  }

  scripts\sp\utility::giveachievement_wrapper("jup_sp_shotblocked");

  thread function_57932a67c0e35049(dir);
  self stopanimScripted();
  thread anim_single_solo(self, "fbk_0360_react_stand_pistol");
  wait 0.5;
  scripts\anim\shared::forceuseweapon(make_weapon("iw9_pi_golf17_sp"), "primary");
}

function function_57932a67c0e35049(impact_direction) {
  self.fake_rifle detachall();
  self.fake_rifle make_weapon_model("iw9_ar_akilo_sp", ["rec_akilo|17"]);
  self.fake_rifle unlink();
  self.fake_rifle physicslaunchserver(self.fake_rifle.origin, impact_direction * (2000, 2000, 2000));
  fake_rifle = self.fake_rifle;
  flag_wait("penthouse_secure");
  fake_rifle function_3eb3744aab74c231(0, ["rec_akilo|17"]);
}

function function_aa0516799368e121() {
  self.fake_rifle endon("damage");
  flag_wait("nt_lure_ambush_gun_throw_end");
  function_67e4cafd8e2ff2da();
  scripts\anim\shared::forceuseweapon(make_weapon("iw9_ar_akilo_sp"), "primary");
}

function function_902f710ec4728cf5() {
  self endon("death");
  self endon("stop_react_logic");
  function_7ba88b2ee15a39a1("iw9_sm_aviktor_sp", "j_gun");
  childthread function_a6c2cf599a11ebfb();
  childthread function_427d69d7e9aa7dfe();
}

function function_a6c2cf599a11ebfb() {
  self endon("death");
  self endon("stop_behavior_normal");
  level.penthouse.animnode anim_single_solo(self, "fbk_0360_intro");
  level notify("intro_anims_done");
  function_67e4cafd8e2ff2da();
  scripts\anim\shared::forceuseweapon(make_weapon("iw9_sm_aviktor_sp"), "primary");
  level.penthouse.animnode anim_single_solo(self, "fbk_0360_react");
  self notify("behavior_normal_done");
}

function function_427d69d7e9aa7dfe() {
  self endon("death");
  level endon("intro_anims_done");
  level waittill("penthouse_combat", combat_reason);

  if(combat_reason == "player_lured_to_ambush") {
    return;
  }

  self notify("stop_behavior_normal");
  function_c68144cb77976e2f(0);
  thread anim_single_solo(self, "fbk_0360_react_walk_pistol");
  wait 0.5;
  scripts\anim\shared::forceuseweapon(make_weapon("iw9_pi_golf17_sp"), "primary");
}

function function_7ba88b2ee15a39a1(weaponname, tag) {
  self.fake_rifle = spawn("script_model", self gettagorigin(tag));
  self.fake_rifle.angles = self gettagangles(tag);
  self.fake_rifle make_weapon_model(weaponname);
  self.spawn_tag = tag;
  self.fake_rifle.weaponname = weaponname;
}

function function_3eb3744aab74c231(var_45f92ce964dee8d7, weapon_attachments) {
  if(!isDefined(var_45f92ce964dee8d7)) {
    var_45f92ce964dee8d7 = 1;
  }

  spawn_flags = 1;

  if(!isDefined(weapon_attachments)) {
    weapon_attachments = [];
  }

  spawn_origin = self.origin;
  spawn_angles = self.angles;

  if(var_45f92ce964dee8d7) {
    spawn_flags = 0;
  }

  if(isDefined(self)) {
    utility::function_ec8a443fe8165fe4(self.weaponname, spawn_origin, weapon_attachments, spawn_angles, spawn_flags);
    self delete();
  }
}

function function_c68144cb77976e2f(var_45f92ce964dee8d7, var_37667c11929f84ee, var_d8d96f683dc1e744, weapon_attachments) {
  if(!isDefined(var_45f92ce964dee8d7)) {
    var_45f92ce964dee8d7 = 1;
  }

  if(!isDefined(var_37667c11929f84ee)) {
    var_37667c11929f84ee = 1;
  }

  if(!isDefined(var_d8d96f683dc1e744)) {
    var_d8d96f683dc1e744 = 1;
  }

  spawn_flags = 1;

  if(!isDefined(weapon_attachments)) {
    weapon_attachments = [];
  }

  spawn_origin = ter_op(var_37667c11929f84ee, self gettagorigin(self.spawn_tag), self.fake_rifle.origin);
  spawn_angles = ter_op(var_d8d96f683dc1e744, self gettagangles(self.spawn_tag), self.fake_rifle.angles);

  if(var_45f92ce964dee8d7) {
    spawn_flags = 0;
  }

  if(isDefined(self.fake_rifle)) {
    utility::function_ec8a443fe8165fe4(self.fake_rifle.weaponname, spawn_origin, weapon_attachments, spawn_angles, spawn_flags);
    self.fake_rifle delete();
  }
}

function function_67e4cafd8e2ff2da() {
  if(isDefined(self.fake_rifle)) {
    self.fake_rifle delete();
  }
}

function function_1a4995da9ba1c914(var_2d7b5ccd309f3a6f) {
  level endon("stop_combat_checks");

  if(!var_2d7b5ccd309f3a6f) {
    enter_anim = level.player_rig getanim("fbk_0360_intro_enter_front");
    open_anim = level.player_rig getanim("fbk_0360_intro");
    wait getanimlength(enter_anim) + getanimlength(open_anim);
  }

  ents = array_add(level.penthouse.enemies, level.player);
  waittill_any_ents_array(ents, "death", "damage", "bulletwhizby", "grenade danger", "frag_pressed", "attack_pressed");
  level notify("player_triggered_ambush");
}

function function_45944cac9c94ab3f() {
  level endon("stop_combat_checks");
  childthread trigger_wait_targetname("trig_player_start_ambush");
  level waittill_any("trig_player_start_ambush", "player_exited_room");
  level notify("player_triggered_ambush");
}

function function_570bc16ef580d2a8() {
  level endon("stop_combat_checks");
  room_center = getStruct("struct_objective_penthouse_interior", "targetname");
  wait 3;

  while(true) {
    if(!function_95771ce6161268ef() && !level.player namespace_47819225b08b445d::function_e7c30095a6cdc3ef(room_center.origin)) {
      break;
    }

    waitframe();
  }

  level notify("player_exited_room");
}

function function_e96ed542357e45b1() {
  level endon("stop_combat_checks");
  flag_wait("penthouse_lure_start");
  var_7a95ecadafe6b282 = {
    #angles: (0, 0, 0), #origin: (26091, 4994.5, 12)
  };
  var_7a95ecadafe6b282 scripts\sp\player\cursor_hint::create_cursor_hint(undefined, undefined, &"SP_JUP_FLASHBACK/INTERACT_HELP", undefined, undefined, 80);
  var_7a95ecadafe6b282 thread function_133d406234b362b8();
  var_7a95ecadafe6b282 waittill("trigger");
  level notify("player_lured_to_ambush");
}

function function_133d406234b362b8() {
  self endon("trigger");
  level waittill_any("penthouse_combat");
  scripts\sp\player\cursor_hint::remove_cursor_hint();
}

function function_906345f2536d929e(var_a8ab85e00a32f402) {
  if(!isDefined(var_a8ab85e00a32f402)) {
    var_a8ab85e00a32f402 = 1;
  }

  self endon("stop_fake_bash");

  while(true) {
    door_angles = scripts\sp\door::get_door_angles();
    door_forward = anglesToForward((door_angles[0], door_angles[1] - 90, door_angles[2]));
    player_forward = anglesToForward(level.player getplayerangles());
    dot = vectordot(door_forward, player_forward);
    door_dist = distance2d(self.origin, level.player.origin);

    if(door_dist <= 60 && dot > 0.87 && (level.player ismeleeing() || level.player issprinting())) {
      break;
    }

    waitframe();
  }

  self notify("fake_bashed");

  if(var_a8ab85e00a32f402) {
    thread scripts\sp\door::door_bash_open(level.player, 0.4);
  }
}

function function_cc509b516bc03b00() {
  level.penthouse.door_right.no_bash = 1;
  level.penthouse.door_right thread function_906345f2536d929e();
  result = level.penthouse.door_right waittill_any_return("trigger", "fake_bashed");
  level.penthouse.door_right notify("stop_fake_bash");
  flag_set("penthouse_door_interacted", result);
}

function function_5a3fd2b18b03bed4() {
  level.penthouse = spawnStruct();
  flag_init("penthouse_lure_start");
  flag_init("penthouse_combat");
  flag_init("penthouse_door_interacted");
  flag_init("penthouse_scene_initialized");
  function_a7b0ec5f85cf2c55();
  level.penthouse.animnode = getStruct("animnode_panthouse_conflict", "targetname");
  level.penthouse.bomb_bag = spawn_anim_model("bomb_bag");
  level.penthouse.animnode anim_first_frame_solo(level.penthouse.bomb_bag, "penthouse_bomb");
  thread function_cc509b516bc03b00();
  enemy_spawner = getspawner("enemy_vip", "targetname");
  civ_spawner = getspawner("civ_vip", "targetname");
  enemy_spawner.count = 4;
  level.penthouse.enemies = [];

  for(i = 1; i < 6; i++) {
    enemy_spawner.count = 1;
    enemy = spawn_aitype(enemy_spawner.classname, enemy_spawner.origin, enemy_spawner.angles, 1);
    assert(isDefined(enemy));
    enemy.animname = "enemy0" + i;
    enemy.script_noteworthy = enemy.animname;
    enemy.targetname = enemy.animname;
    level.penthouse.enemies[level.penthouse.enemies.size] = enemy;
    enemy set_allowdeath(1);
    enemy set_ignoreme(1);
    enemy utility::function_1a479cad9c3adbb1(0);
    enemy.weapon_backup = enemy.weapon;
    enemy putgunaway();
    enemy visiblenotsolid();
    enemy actoraimassistoff();

    switch (enemy.animname) {
      case #"hash_b1814a65888b98f0":
        level.penthouse.enemy01 = enemy;
        level.penthouse.door_opener = enemy;
        enemy detach(enemy.headmodel);
        enemy.headmodel = "c_jup_head_sc_m_dunn";
        enemy attach(enemy.headmodel);
        break;
      case #"hash_b1814d65888b9da9":
        level.penthouse.enemy02 = enemy;
        level.penthouse.lurer = enemy;
        enemy detach(enemy.headmodel);
        enemy.headmodel = "head_c_jup_sc_m_sharipov_flashback";
        enemy attach(enemy.headmodel);
        break;
      case #"hash_b1814c65888b9c16":
        level.penthouse.enemy03 = enemy;
        break;
      case #"hash_b1814f65888ba0cf":
        level.penthouse.enemy04 = enemy;
        break;
      case #"hash_b1814e65888b9f3c":
        level.penthouse.enemy05 = enemy;
        break;
    }
  }

  level.penthouse.stretchers = [];

  for(i = 1; i < 4; i++) {
    animname = "stretcher_" + i;
    stretcher = spawn_anim_model(animname);
    level.penthouse.stretchers[level.penthouse.stretchers.size] = stretcher;
  }

  level.penthouse.civs = [];

  for(i = 1; i < 5; i++) {
    body_model = "body_civ_embassy_ambassador";
    animname = "civ0" + i;
    spawner = getspawner("alpha_civ_spawner_male", "script_noteworthy");

    if(animname == "civ01") {
      body_model = "body_civ_embassy_office_worker_female_2_2";
      spawner = getspawner("alpha_civ_spawner_female", "script_noteworthy");
    }

    civ = bodyonlyspawn(spawner);
    civ.animname = animname;
    civ.script_noteworthy = animname;
    civ setModel(body_model);
    civ notsolid();
    level.penthouse.animnode anim_first_frame_solo(civ, "fbk_0360_intro");
    level.penthouse.civs[level.penthouse.civs.size] = civ;
  }

  level.penthouse.animators = array_merge(level.penthouse.civs, level.penthouse.front_doors);
  level.penthouse.animators = array_merge(level.penthouse.animators, level.penthouse.stretchers);
  level.penthouse.animators = array_merge(level.penthouse.animators, level.penthouse.enemies);
  level.penthouse.animnode anim_first_frame(level.penthouse.animators, "fbk_0360_intro");
  flag_set("penthouse_scene_initialized");
}

function function_a7b0ec5f85cf2c55() {
  assert(isDefined(level.penthouse));
  level.penthouse.door_left = scripts\sp\door::get_interactive_door("penthouse_front_door_left");
  level.penthouse.door_right = scripts\sp\door::get_interactive_door("penthouse_front_door_right");
  level.penthouse.door_left assign_animtree("penthouse_front_door_left");
  level.penthouse.door_right assign_animtree("penthouse_front_door_right");
  level.penthouse.front_doors = [level.penthouse.door_left, level.penthouse.door_right];

  foreach(door in level.penthouse.front_doors) {
    animnode = getStruct("animnode_panthouse_conflict", "targetname");
    animnode anim_first_frame_solo(door, "fbk_0360_intro");
  }

  level.penthouse.door_left namespace_47819225b08b445d::function_cd8107d772ca6582();
  level.penthouse.door_right.script_spawn_open_yaw = 0.01;
  level.penthouse.back_door_left = scripts\sp\door::get_interactive_door("penthouse_back_door_left");
  level.penthouse.back_door_right = scripts\sp\door::get_interactive_door("penthouse_back_door_right");
  level.penthouse.back_door_left assign_animtree("penthouse_back_door_left");
  level.penthouse.back_doors = [level.penthouse.back_door_left, level.penthouse.back_door_right];

  foreach(door in level.penthouse.back_doors) {
    door.script_forceyaw = 1;
    door.max_yaw_left = 95;
    door namespace_47819225b08b445d::function_cd8107d772ca6582();
    door scripts\sp\door::updatenavobstacle(1);
  }
}

function function_b5b2fd4d0f7abb3c() {
  level.penthouse.enemies = array_remove(level.penthouse.enemies, level.penthouse.enemy06);
  level.penthouse.enemy06 delete();
}

function function_6a85e32a9a2ada7c() {
  if(!isDefined(level.penthouse)) {
    return;
  }
}

function function_819657b33ca571ab() {
  if(isDefined(level.ghost)) {
    level.ghost stop_magic_bullet_shield();
    level.ghost delete();
  }

  if(isDefined(level.redshirt)) {
    level.redshirt stop_magic_bullet_shield();
    level.redshirt delete();
  }
}

function elevator_music() {
  setmusicstate("mx_flashback_elevator");
}

function function_35ce8a71fb1d1a88(guy) {
  self waittill("movedone");
  guy unlink();
}

function function_e099cbf58f010c0f() {
  thread set_flag_on_targetname_trigger("trigger_penthouse_arrive");
  flag_init("penthouse_floor_vo_done");
  flag_wait("concourse_stairs_vo_done");

  if(level.player can_see_origin((26216, 5376, 72))) {
    level.player say_delayed(0.2, "dx_sp_flas_penf_soap_eyesontheviparea");
  } else {
    level.price say_delayed(0.2, "dx_sp_flas_penf_pric_eyesontheviparea");
  }

  if(!flag("trigger_penthouse_arrive")) {
    nags = ["dx_sp_flas_penf_pric_weremovingupsergeant", "dx_sp_flas_penf_pric_goteyesonthevipareas", "dx_sp_flas_penf_pric_sergeantgetyourarseu"];
    level.price thread nagtill([level, "trigger_penthouse_arrive"], nags, 11);
  }

  flag_wait("trigger_penthouse_arrive");
  flag_set("penthouse_floor_vo_done");
}

function function_7d54441cf105253b() {
  stopmusicstate("mx_flashback_combatstairs");
}

function function_e93d15e50511b28() {
  level endon("penthouse_door_interacted");
  flag_wait("penthouse_floor_vo_done");
  level.price say("dx_sp_flas_penf_pric_gotmovementinsidesta");
  level.price say("dx_sp_flas_penf_pric_onyousergeant");
  nags = ["dx_sp_flas_penf_pric_letsgetinthere", "dx_sp_flas_penf_pric_onyousergeant", "dx_sp_flas_penf_pric_ready"];
  level.price childthread nagtill([level, "penthouse_door_interacted"], nags, 11);
}

function function_b69a4e871476186e() {
  level endon("penthouse_combat");
  thread function_bfdddea701e82ab3();
  thread function_10af6c9023fff17f();
  thread function_8bb00b09c8521d04();
  interact_type = flag_wait("penthouse_door_interacted");

  if(is_equal(interact_type, "fake_bashed")) {
    level.player function_fc0eb6b81c66c661(1, "dx_sp_flas_pena_soap_handsshowyourhands");
  }

  delaythread(10, &flag_set, "penthouse_lure_start");
}

function function_8bb00b09c8521d04() {
  level endon("penthouse_combat");
  wait 22;
  flag_set("price_enemy_warning");
}

function function_10af6c9023fff17f() {
  level endon("penthouse_stop_lure_vo");
  level waittill("player_lured_to_ambush");
  flag_wait("nt_lure_ambush_grab_player");
  function_54d3bd59bff7e908();
  flag_wait("penthouse_secure");
  wait 0.5;
  level.redshirt say("dx_sp_flas_pena_burn_secure");
  level.price say("dx_sp_flas_pena_pric_sergeantyoubroken");
  level.player say("dx_sp_flas_pena_soap_justtheplate");
  flag_set("penthouse_vo_done");
}

function function_bfdddea701e82ab3() {
  level endon("player_lured_to_ambush");
  level waittill("penthouse_combat", combat_reason);
  function_54d3bd59bff7e908();
  flag_wait("penthouse_secure");
  level.redshirt say("dx_sp_flas_pena_burn_secure");

  if(!flag("price_enemy_warning")) {
    switch (combat_reason) {
      case #"hash_803ae8da9cbe3c03":
      default:
        wait 0.2;
        level.player say("dx_sp_flas_pena_soap_fuckerswereinnercirc");
        level.price say("dx_sp_flas_pena_pric_goodcallthen");
        break;
    }
  }
}

#using_animtree("player");

function function_a39b20c9ff530e2() {
  if(flag("price_at_elevator")) {
    array = [%fbk_0400_clubhouse_elevator_open_enter_left_plr, %fbk_0400_clubhouse_elevator_open_enter_front_plr];
  } else {
    array = [%fbk_0400_clubhouse_elevator_plr_open_enter_left_plr, %fbk_0400_clubhouse_elevator_plr_open_enter_right_plr, %fbk_0400_clubhouse_elevator_plr_open_enter_front_plr];
  }

  return array;
}