/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\prisoner\prisoner_streets.gsc
*********************************************************/

_id_D83F() {
  scripts\engine\utility::flag_init("flag_collapse_dropship_entered_smoke");
  scripts\engine\utility::flag_init("flag_collapse_end");
  scripts\engine\utility::flag_init("alley_cqbguy_retreat");
  scripts\engine\utility::flag_init("flag_alleys_end");
  scripts\engine\utility::flag_init("flag_streets_end");
  scripts\engine\utility::flag_init("flag_bridge_truck");
  scripts\engine\utility::flag_init("hvt_street_escape");
  scripts\engine\utility::flag_init("hvt_dropped_down");
  scripts\engine\utility::flag_init("railing_runner_go");
  scripts\engine\utility::flag_init("hvt_spotted");
  scripts\engine\utility::flag_init("backroom_entered");
  scripts\engine\utility::flag_init("alley_chatter_1_played");
  scripts\engine\utility::flag_init("alley_chatter_2_played");
  scripts\engine\utility::flag_init("august_door_open");
  scripts\engine\utility::flag_init("salter_done_talking");
  scripts\engine\utility::flag_init("door_peek_on");
  scripts\engine\utility::flag_init("street_jumped");
  scripts\engine\utility::flag_init("hvt_in_backroom");
  scripts\sp\utility::_id_16EB("hint_dismount_dropship", "Press and hold ^3[{+activate}]^7 to get out", ::_id_8FF4);
  scripts\engine\utility::flag_init("hint_dismount_dropship");

  if(scripts\sp\starts::_id_9C4B()) {
    foreach(var_1 in getvehiclenodearray("node_cy_van_stop", "script_noteworthy")) {
      var_2 = spawn("script_model", var_1.origin);
      var_2.angles = var_1.angles;
      var_2 setModel("veh_mil_lnd_ca_humvee_drive");
    }
  }
}

_id_8FF4() {
  return scripts\engine\utility::flag("hint_dismount_dropship");
}

_id_D704() {}

_id_10BF2() {
  wait 0.05;
  scripts\sp\maps\prisoner\prisoner_util::_id_10616(["salter", "atom"]);
  level.player disableweapons();
  level._id_5D6C = scripts\sp\maps\prisoner\prisoner_util::_id_106B5("vehicle_dropship", "collapse_dropship_spot1");

  if(getdvarint("dropship_lighting", 0)) {
    level waittill("forever");
  }

  var_0 = scripts\engine\utility::spawn_tag_origin(level._id_5D6C._id_4D94._id_1FC0["salter"].origin + (4, 10, 18), level._id_5D6C._id_4D94._id_1FC0["salter"].angles);
  var_0 linkTo(level._id_5D6C);
  level._id_EA2C linkTo(var_0);

  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_8E06();
  }

  level._id_EA2C scripts\sp\utility::_id_86E4();
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "intro_sit_idle");
  level._id_5D6C._id_5E11 = scripts\engine\utility::play_loopsound_in_space("prisoner_dropship_idle", level._id_5D6C.origin + (0, 150, 100));
  level._id_5D6C._id_5E11 linkTo(level._id_5D6C);
  scripts\engine\utility::delaythread(0.05, ::_id_9A9B);
  scripts\engine\utility::delaythread(0.05, ::_id_9A9C);
  setmusicstate("mx_105_prisonerintro_temp");
  setglobalsoundcontext("dropship", "flight", 1.0);
  level.player scripts\sp\utility::_id_F526("relaxed");
  scripts\engine\utility::flag_set("enable_volumetrics");
  scripts\sp\maps\prisoner\gen\prisoner_art::_id_111FE();
}

#using_animtree("vehicles");

_id_B1AC() {
  if(getdvarint("dropship_lighting", 0)) {
    level waittill("forever");
  }

  while(!isDefined(level._id_5D6C)) {
    scripts\engine\utility::waitframe();
  }

  thread _id_9AB3();
  thread dof_intro_blend();
  thread _id_4364();
  level._id_5D6C notify("turn_on_floodlight");
  scripts\engine\utility::flag_set("flag_collapse_dropship_entered_smoke");
  _id_542A();
  level._id_5D6C scripts\engine\utility::delaythread(1.0, scripts\engine\utility::play_sound_in_space, "prisoner_dropship_door_open", (1497, -4627, -1842));
  level._id_5D6C scripts\engine\utility::delaythread(1.0, _id_0BBC::_id_C5F1, "back");
  level._id_5D6C scripts\sp\utility::_id_65E3("back_door_animating");
  level._id_5D6C scripts\engine\utility::delaycall(0.2, ::_meth_82B1, %vh_dropship_rear_doors_open, 0.48);
  wait 1;
  level._id_2429 thread _id_4357();
}

dof_intro_blend() {
  thread _id_0B0A::_id_583F(0, 80, 7, 0.05, 120, 6, 0);
  wait 3.0;
  thread _id_0B0A::_id_583F(0, 10, 7, 0.05, 50, 6, 1);
  wait 2.5;
  thread _id_0B0A::_id_583D(3);
}

_id_9AB3() {
  level._id_5D6C scripts\sp\utility::_id_65E3("player_dropship_ready");
  wait 1;
  level._id_5D6C._id_1025A = 1;
}

_id_9A9B() {
  var_0 = level._id_5D6C _id_0BBF::_id_796D("left_cockpit");
  scripts\engine\utility::waitframe();
  var_0._id_8711 = scripts\sp\utility::_id_10639("dropship_seat_mount01", var_0.origin, var_0.angles);
  var_0._id_8711 scripts\sp\anim::_id_F64A();
  var_0 scripts\sp\anim::_id_1EC3(var_0._id_8711, "SH_PRI_7_19_MISSION_SEAT_MNT_enter");
  var_0._id_8711 linkTo(var_0);
  var_0._id_1FBB = "dropship_seat_left_cockpit";
  level._id_2429._id_1FBD = var_0 scripts\engine\utility::spawn_tag_origin();
  level._id_2429._id_1FBD linkTo(var_0, "tag_origin", (-4, 0, 10), (0, 0, 0));
  level._id_2429 linkTo(level._id_2429._id_1FBD);
  level._id_2429._id_1FBD thread scripts\sp\anim::_id_1F35(level._id_86D8, "seat_mount_ff");
  level._id_2429._id_1FBD thread scripts\sp\anim::_id_1F35(var_0, "dropship_chair_exit");
  level._id_2429._id_1FBD scripts\sp\anim::_id_1F35(level._id_2429, "dropship_chair_exit");
  level._id_2429 unlink();
  level._id_2429._id_1FBD delete();
  level._id_2429 scripts\sp\utility::_id_61C7();
  level._id_5D6C scripts\sp\maps\prisoner\prisoner_util::_id_5D75("back");
  wait 5;
  thread _id_6774();
}

_id_6774() {
  level._id_6EBC = scripts\engine\utility::spawn_tag_origin(level._id_2429 gettagorigin("tag_eye"), level._id_2429 gettagangles("tag_eye"));
  level._id_6EBC linkTo(level._id_2429, "tag_eye", (0, 0, 2), (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("sa_flashlight"), level._id_6EBC, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("sa_flashlight_flare"), level._id_6EBC, "tag_origin");
}

_id_9A9C() {
  scripts\engine\utility::waitframe();
  thread _id_ECE0();
  var_0 = level._id_5D6C _id_0BBF::_id_796D("right_cockpit");
  level._id_5D6C _id_0BBF::_id_DFFC("right_cockpit");
  scripts\engine\utility::waitframe();
  var_0._id_1FBB = "dropship_seat_right_cockpit";
  level.player._id_1FBD = var_0 scripts\engine\utility::spawn_tag_origin();
  level.player._id_1FBD linkTo(var_0, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0._id_8711 = scripts\sp\utility::_id_10639("dropship_seat_mount01", var_0.origin, var_0.angles);
  var_0._id_8711 scripts\sp\anim::_id_F64A();
  var_0 scripts\sp\anim::_id_1EC3(var_0._id_8711, "SH_PRI_7_19_MISSION_SEAT_MNT_enter");
  var_0._id_8711 linkTo(var_0);
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player disableweapons();
  level.player._id_1F63 = scripts\sp\utility::_id_10639("player_rig", var_0.origin + (0, 0, 10), var_0.angles);
  level.player scripts\engine\utility::delaycall(0.0, ::playerlinktodelta, level.player._id_1F63, "tag_player", 1, 5, 5, 0, 10, 1);
  thread _id_110C7(level.player._id_1F63);
  level.player._id_1FBD linkTo(var_0);
  level.player._id_1F63 linkTo(level.player._id_1FBD);
  level.player._id_1FBD thread scripts\sp\anim::_id_1EC3(var_0, "dropship_chair_exit_seat");
  level.player._id_1FBD scripts\sp\anim::_id_1EC3(level.player._id_1F63, "dropship_chair_exit");
  wait 1.5;
  thread _id_12ACB(level.player._id_1FBD);
  level.player._id_1FBD thread scripts\sp\anim::_id_1F35(var_0, "dropship_chair_exit_seat");
  wait 0.6;
  level.player._id_1FBD scripts\sp\anim::_id_1F35(level.player._id_1F63, "dropship_chair_exit");
  level waittill("player_rig_exit");
  level.player unlink();
  level.player._id_1F63 delete();
  level.player._id_1FBD delete();
  level.player scripts\engine\utility::allow_prone(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player enableweapons();
}

_id_12ACB(var_0) {
  wait 3.2;
  thread _id_544B();
  wait 2;
  level._id_FD47 = 0;
  level.player._id_1FBD unlink();
  scripts\engine\utility::waitframe();
  level.player._id_1FBD movex(-10, 1);
  level.player._id_1FBD rotateYaw(115, 1.5, 0.5, 0.0);
  level.player._id_1FBD waittill("rotatedone");
  level notify("player_rig_exit");
}

_id_ECE0() {
  level._id_FD47 = 1;
  level.player _meth_8244("subtle_tank_rumble");
  level.player _meth_8291(0.1, 0, 0.1, 10, 0, 2, 300, 10, 0, 5);
  wait 10;
  level.player stoprumble("subtle_tank_rumble");
  thread _id_C7DE();
}

_id_C7DE() {
  var_0 = undefined;
  var_1 = getEntArray("rain_blocker", "targetname");

  foreach(var_3 in var_1) {
    if(isDefined(var_3.script_noteworthy) && var_3.script_noteworthy == "dropship_rain_blocker") {
      var_0 = var_3;
      wait 10;

      while(level.player istouching(var_0)) {
        scripts\engine\utility::waitframe();
      }

      level._id_FD47 = 0;
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
}

_id_110C7(var_0) {
  wait 1;
  var_1 = spawn("script_model", var_0 gettagorigin("tag_weapon_right"));
  var_1 setModel(getweaponmodel(level.player getcurrentprimaryweapon()));
  var_1 linkTo(var_0, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  level waittill("player_rig_exit");
  var_1 delete();
}

_id_4364() {
  level._id_5D6C vehicle_setspeed(15, 10, 10);
  level._id_5D6C sethoverparams(0, 0, 0);
  scripts\engine\utility::delaythread(4.5, scripts\sp\maps\prisoner\prisoner_util::_id_5EC2, "land");
  level._id_5D6C _id_0BBF::_id_5E04("collapse_dropship_spot2", 1, 0);
  level._id_5D6C scripts\sp\maps\prisoner\prisoner_util::_id_5EAF();
  level._id_5D6C _id_0BBF::_id_F37E(scripts\engine\utility::getStruct("collapse_dropship_spot2", "targetname").angles[1]);
  level._id_5D6C waittill("turn_on_floodlight");
  setglobalsoundcontext("dropship", "idle", 12.0);
  level._id_5D6C._id_55A4 = 1;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = level._id_5D6C.origin + anglesToForward(level._id_5D6C.angles) * -450 + anglestoup(level._id_5D6C.angles) * 130;
  var_0.angles = level._id_5D6C.angles + (70, 180, 0);
  var_0 linkTo(level._id_5D6C, "tag_origin");
  level._id_5D6C waittill("goal");
  level._id_5D6C _id_5EC0(["left", "right", "back"]);
  level._id_5D6C setyawspeed(0, 10);
  scripts\engine\utility::flag_wait_any("collapse_out_of_dropship", "player_on_ground");
  level._id_5D6C _id_0BBF::_id_1101E();
  level._id_5D6C._id_4D94._id_4348 notsolid();
  level._id_2429 thread scripts\sp\maps\prisoner\prisoner_util::_id_D2DC(250);
  level._id_5D6C thread _id_0BBC::_id_4265("back");
  level._id_5D6C scripts\engine\utility::delaycall(0.2, ::_meth_82B1, %vh_dropship_rear_doors_close, 2);
  wait 2;
  thread scripts\sp\coverwall::_id_DFBD();
  level._id_5D6C playSound("prisoner_dropship_lift_off");
  level._id_5D6C scripts\engine\utility::delaycall(1.5, ::playsound, "prisoner_dropship_fly_away_close");
  level._id_5D6C vehicle_setspeed(20, 15, 15);
  scripts\engine\utility::waitframe();
  level._id_5D6C setyawspeed(20, 15);
  level._id_5D6C._id_5E11 _meth_8278(0.0, 3.0);
  var_1 = scripts\engine\utility::getStruct("collapse_dropship_spot3", "targetname");
  level._id_5D6C _id_0BBF::_id_5E04(var_1.origin + (1000, 1000, 1200), 0, 0);
  level._id_5D6C _id_0BBF::_id_F37E("collapse_dropship_spot3");
  level._id_5D6C waittill("goal");
  level._id_5D6C playSound("dropship_flyby_med_mid");
  level._id_5D6C vehicle_setspeed(30, 15, 15);
  level._id_5D6C _id_0BBF::_id_5E04(var_1.origin + (-5000, 0, 0));
  level._id_5D6C _id_0BBF::_id_F37E("collapse_dropship_spot3");
  level._id_5D6C._id_5E11 delete();
  level._id_5D6C waittill("goal");
  level._id_EA2C scripts\sp\maps\prisoner\prisoner_util::_id_4046(0);
  _id_406B();
}

_id_10008() {
  playFXOnTag(scripts\engine\utility::getfx("suit_light_ally_le"), self, "j_shouldertwist_le");
}

_id_4357() {
  level._id_5D6C._id_4D94._id_4348 _meth_80AF();
  var_0 = getnode("node_dropship_jump_start", "script_noteworthy");
  var_0 _id_F444();
  var_1 = getnode("node_dropship_jump_end", "script_noteworthy");
  createnavlink("dropship1_jump1", var_0.origin, var_1.origin, var_0);
  level._id_2429 thread _id_435A();
  level._id_2429 waittill("double_jump_finished");
  level._id_2429 notify("stop_collapse_walk_think");
  thread _id_675D();
  level.player scripts\sp\utility::_id_F526("normal");
}

_id_675D() {
  level endon("august_door_open");
  level._id_2429 scripts\sp\utility::_id_61C7();
  level._id_2429 scripts\sp\utility::_id_417A();
  level._id_2429 scripts\sp\utility::_id_51E1("combat");
  level._id_2429.moveplaybackrate = 1.0;
  level._id_2429 scripts\sp\utility::_id_F3B5("g");
  scripts\sp\utility::_id_15F1("collapse_color_01", "targetname");
  var_0 = getEnt("dropship_rain_blocker", "script_noteworthy");

  while(level.player istouching(var_0)) {
    wait 0.05;
  }

  var_1 = scripts\engine\utility::getStruct("anim_org_ethan_debris", "targetname");
  var_1 scripts\sp\anim::_id_1F17(level._id_2429, "prisoner_ally_debris_jump");
  level notify("collapse_reaction");
  thread scripts\sp\maps\prisoner\prisoner_util::_id_10181();
  var_1 scripts\sp\anim::_id_1F35(level._id_2429, "prisoner_ally_debris_jump");
  scripts\sp\utility::_id_15F1("collapse_color_02", "targetname");
  level._id_2429 scripts\sp\utility::_id_51E1("cqb");
  level._id_2429 scripts\sp\utility::_id_61C7();
  level._id_2429.moveplaybackrate = 1.0;
}

_id_6795() {
  level endon("collapse_reaction");
  var_0 = scripts\engine\utility::getStruct("anim_org_ethan_debris", "targetname");
  var_1 = distance2dsquared(level._id_2429.origin, var_0.origin);
  var_2 = distance2dsquared(level.player.origin, var_0.origin);

  if(var_1 > var_2) {
    level._id_2429 scripts\sp\utility::_id_51E1("sprint");
    level._id_2429.moveplaybackrate = 1.1;
    level.player scripts\engine\utility::allow_sprint(0);
  }
}

_id_F444() {
  self._id_10DCE = self.angles;
  self._id_A4C9 = self._id_A4C8 - self.origin;
  self._id_126D4 = self._id_A4C8[2];
  self._id_126D5 = self._id_A4C8[2] - self.origin[2];
}

_id_435A() {
  self endon("death");
  self endon("stop_collapse_walk_think");
  var_0 = scripts\sp\maps\prisoner\prisoner_streets_util::_id_4355("collapse_ally_path");

  for(;;) {
    var_1 = scripts\sp\maps\prisoner\prisoner_streets_util::_id_4356(var_0, level.player.origin + anglesToForward((0, 320, 0)) * 500);
    self setgoalpos(var_1);
    scripts\sp\utility::_id_F3E0(100);
    wait 0.2;
  }
}

_id_10BF5() {
  scripts\sp\maps\prisoner\prisoner_util::_id_D2F9("playerstart_collapse_smoke");
  thread scripts\sp\maps\prisoner\prisoner_streets_util::_id_106B7();
  scripts\sp\maps\prisoner\prisoner_util::_id_10616("atom");
  var_0 = scripts\engine\utility::getStruct("collapse_ally_path", "targetname");
  level._id_2429 _meth_80F1(var_0.origin, var_0.angles, 1000000);
  level.player scripts\sp\utility::_id_F526("normal");
  level._id_2429 scripts\sp\utility::_id_51E1("combat");
  level._id_2429.moveplaybackrate = 1.1;
  scripts\engine\utility::flag_set("enable_volumetrics");
  scripts\sp\maps\prisoner\gen\prisoner_art::_id_111F9();
  setumbraportalstate("umbra_spaceship_view", 1);
  thread _id_6774();
}

_id_10BF3() {
  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_8E06();
  }

  _id_406B();
}

_id_B1AE() {
  thread _id_4362();
  level.player scripts\sp\utility::_id_2B76(0.9, 0.5);
  thread _id_D7E8();
  thread _id_5712();
  thread scripts\sp\maps\prisoner\prisoner_util::_id_978E();
  scripts\sp\utility::_id_127AE("ethan_debris_reach", "targetname");
  wait 0.5;
  var_0 = distance2dsquared(level._id_2429.origin, level.player.origin);
  var_1 = squared(500);

  if(var_0 < var_1) {
    level._id_2429 scripts\engine\utility::delaythread(1.5, scripts\sp\utility::_id_10346, "prisoner_eth_carefulsir");
  }

  thread _id_4365();
  level._id_436C thread scripts\sp\anim::_id_1EC3(level._id_1283E, "collapse_truck_anim");
  scripts\engine\utility::flag_wait("collapse_heavy_fog_clear");
}

_id_5712() {
  level endon("flag_collapse_end");

  for(;;) {
    thread scripts\engine\utility::play_sound_in_space("scn_collapse_distant_destruction", (4088, -7296, -1295));
    wait 9.0;
  }
}

_id_4365() {
  var_0 = getEnt("collapse_rumble_trig", "targetname");
  thread scripts\engine\utility::play_sound_in_space("scn_collapse_rock_tower_fall", (2773, -6182, -1777));
  level.player playSound("scn_collapse_rock_tower_rumble_lr");
  level endon("flag_collapse_end");
  var_0 waittill("trigger", var_1);

  if(var_1 == level.player) {
    wait 0.5;
    level.player _meth_8244("damage_light");
    earthquake(0.2, 2, level.player.origin, 100);
    wait 1;
    level.player stoprumble("damage_light");
    earthquake(0.3, 2, level.player.origin, 100);
    level.player _meth_8244("damage_heavy");
    wait 2.0;
    level.player stoprumble("damage_heavy");
    wait 1;
    level.player _meth_8244("damage_light");
    wait 1;
    level.player stoprumble("damage_light");
  }
}

_id_D7E8() {
  scripts\sp\utility::_id_127AE("fway_shift_c", "targetname");
  level.player playSound("scn_collapse_smoke_bus_rumble_lr");
  playworldsound("prisoner_collapse_bus_debris", (3385, -6480, -1719));
  wait 0.8;
  playworldsound("prisoner_collapse_rock_debris", (3602, -6669, -1710));
}

_id_10BF6() {
  scripts\sp\maps\prisoner\prisoner_util::_id_D2F9("playerstart_collapse_truck");
  scripts\sp\maps\prisoner\prisoner_streets_util::_id_106B7();
  thread scripts\sp\maps\prisoner\prisoner_util::_id_978E();
  scripts\sp\maps\prisoner\prisoner_util::_id_10616("atom");
  var_0 = scripts\engine\utility::getStruct("collapse_brooks_goal_truck", "targetname");
  level._id_2429 _meth_80F1(var_0.origin, var_0.angles, 1000000);
  thread _id_6774();
  scripts\engine\utility::flag_set("enable_volumetrics");
  scripts\sp\maps\prisoner\gen\prisoner_art::_id_111F9();
  setumbraportalstate("umbra_spaceship_view", 1);
  level._id_436C thread scripts\sp\anim::_id_1EC3(level._id_1283E, "collapse_truck_anim");
}

_id_B1AF() {
  level.player scripts\sp\utility::_id_2B76(1.0, 0.5);

  while(!isDefined(level._id_2429)) {
    scripts\engine\utility::waitframe();
  }

  level._id_2429 notify("stop_collapse_walk_think");
  scripts\sp\utility::_id_15F5("trig_allies_crashedvehicle");
  level._id_2429 scripts\sp\utility::_id_61C7();
  var_0 = scripts\engine\utility::getStruct("collapse_atomtruck_sidedoor_origin", "targetname");
  var_0 _id_0E46::_id_48C4(undefined, (0, 0, 0), undefined, undefined, 400);
  var_0 waittill("trigger");
  level.player setvelocity((0, 0, 0));
  scripts\engine\utility::flag_set("august_door_open");
  level._id_2429._id_EDB8 = "";
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player _meth_84AF(1);
  level.player disableweapons();
  thread _id_540E();
  thread _id_435C();
  thread _id_102EE();
  thread _id_D6EB();
  thread _id_D6ED();
  scripts\engine\utility::flag_wait("flag_exit_truck");
  scripts\sp\maps\prisoner\prisoner_util::_id_6E55("flag_collapse_end", ::_id_4061);
}

_id_435C() {
  var_0 = getEnt("truck_blocker", "targetname");
  var_0 notsolid();
  var_1 = getEnt("slide_blocker", "targetname");
  var_1 notsolid();
  scripts\sp\maps\prisoner\prisoner_util::_id_10616("august");
  level._id_4DEB = scripts\sp\utility::_id_107EA("dead_01");
  var_2 = scripts\sp\utility::_id_107EA("dead_02");
  level._id_4DEB._id_1FBB = "civ_corpse";
  var_2._id_1FBB = "civ_corpse";
  level._id_4DEB scripts\sp\utility::_id_86E4();
  level._id_4DEB scripts\sp\utility::_id_B14F();
  var_2 scripts\sp\utility::_id_86E4();
  var_3 = scripts\engine\utility::getStruct("collapse_dead_soldier", "targetname");
  var_4 = scripts\engine\utility::getStruct("collapse_dead_soldier_2", "targetname");
  var_3 scripts\sp\anim::_id_1EC3(level._id_4DEB, "un_corpse02");
  var_4 scripts\sp\anim::_id_1EC3(var_2, "un_corpse01");
  level._id_2612._id_1FBB = "generic";
  var_5 = [level._id_2429, level._id_2612];
  level._id_2429.name = "";
  level._id_2612.name = "";
  level.player._id_1F63 = scripts\sp\utility::_id_10639("player_rig", level.player.origin, level.player.angles);
  level.player._id_1F63 hide();
  level._id_436C scripts\sp\anim::_id_1EC3(level.player._id_1F63, "injured_august_scene");
  level.player _meth_823C(level.player._id_1F63, "tag_player", 0.5);
  level.player scripts\engine\utility::delaycall(0.8, ::playsound, "scn_truck_plr_open_door");
  wait 0.5;
  level.player._id_1F63 show();
  level.player scripts\engine\utility::delaycall(4, ::playrumbleonentity, "damage_heavy");
  thread _id_6796();
  level._id_436C thread scripts\sp\anim::_id_1F35(level._id_2612, "prisoner_august_truck");
  level._id_436C thread scripts\sp\anim::_id_1F35(level._id_1283E, "collapse_truck_anim");
  level._id_436C scripts\sp\anim::_id_1F35(level.player._id_1F63, "injured_august_scene");
  level._id_436C thread scripts\sp\anim::_id_1EE7([level._id_2429, level._id_2612], "prisoner_august_truck_idle");
  level._id_2429 scripts\sp\utility::_id_86E4();
  level._id_2612.name = "Auguste";
  level._id_2429.name = "Ethan";
  thread _id_77BC();
  level.player unlink();
  level.player._id_1F63 delete();
  level.player scripts\engine\utility::allow_prone(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player _meth_84AF(0);
  level.player enableweapons();
  var_0 solid();
  scripts\sp\utility::_id_2669("post_truck_save");
  level.player scripts\sp\utility::_id_2B76(0.75, 0.2);
  scripts\engine\utility::flag_wait("flag_collapse_end");
  var_1 solid();
  level.player scripts\sp\utility::_id_2B76(1, 0.2);
}

_id_6796() {
  level.player._id_1F63 waittillmatch("single anim", "start_ethan");
  level._id_436C thread scripts\sp\anim::_id_1F35(level._id_2429, "prisoner_august_truck");
  wait 1.5;
  stopFXOnTag(scripts\engine\utility::getfx("sa_flashlight"), level._id_6EBC, "tag_origin");
  stopFXOnTag(scripts\engine\utility::getfx("sa_flashlight_flare"), level._id_6EBC, "tag_origin");
}

_id_77BC() {
  wait 2;
  level.player thread scripts\sp\utility::_id_D090("ges_radio");
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  level waittill("salt_convo_done");
  level.player playSound("ges_plr_radio_off");
  level.player scripts\sp\utility::_id_1102B("ges_radio");
}

_id_4061() {
  level._id_2429 scripts\sp\maps\prisoner\prisoner_util::_id_4046(0);
  level._id_2612 scripts\sp\maps\prisoner\prisoner_util::_id_4046(0);
  level._id_4DEB scripts\sp\maps\prisoner\prisoner_util::_id_4046(0);
}

_id_10BF4() {
  scripts\sp\maps\prisoner\prisoner_util::_id_D2F9("playerstart_collapse_post_truck");
  scripts\sp\maps\prisoner\prisoner_util::_id_10616("atom");
  thread _id_102EE();
  thread _id_D6EB();
  thread _id_D6ED();
  var_0 = getEnt("slide_blocker", "targetname");
  var_0 notsolid();
  scripts\engine\utility::flag_set("enable_volumetrics");
  scripts\sp\maps\prisoner\gen\prisoner_art::_id_111F6();
  setumbraportalstate("umbra_spaceship_view", 1);
}

_id_B1AD() {
  scripts\engine\utility::flag_wait("flag_collapse_end");
  level.player notify("stop_collapse_close_smoke");
  level.player setstance("stand");
}

_id_D6EB() {
  scripts\sp\utility::_id_127AE("fway_shift_d", "targetname");
  level.player playSound("scn_collapse_cave_in_rumble_lr");
}

_id_102EE() {
  level.player waittill("is_sliding");
  level notify("player_sliding");
  level.player playSound("scn_collapse_plr_slide");
}

_id_D6ED() {
  scripts\sp\utility::_id_127AE("fway_shift_e", "targetname");
  level.player playSound("scn_collapse_slide_rumble_lr");
}

_id_406B() {
  if(isDefined(level._id_5D6C)) {
    level._id_5D6C delete();
  } else {
    thread _id_0BBF::_id_5D92("vehicle_dropship", "dropship_player_parts");
  }
}

_id_10B9A() {
  scripts\sp\maps\prisoner\prisoner_util::_id_D2F9("playerstart_alleys");
  scripts\engine\utility::array_call(getEntArray("model_dropship_temp_mover", "script_noteworthy"), ::delete);
  scripts\engine\utility::flag_set("enable_volumetrics");
  scripts\engine\utility::flag_set("sun_shadow_alleys_enter");
  setumbraportalstate("umbra_spaceship_view", 1);
}

_id_B183() {
  if(scripts\sp\utility::_id_93A6()) {
    thread scripts\sp\specialist_MAYBE::_id_2683();
  }

  scripts\engine\utility::array_thread(scripts\sp\utility::_id_77DF("enemy_alleys"), scripts\sp\utility::_id_1747, ::_id_1088F);
  thread _id_925A();
  thread _id_1C02();
  thread _id_9213();
  scripts\engine\utility::flag_wait("flag_alleys_end");
}

_id_9213() {
  var_0 = scripts\engine\utility::getStruct("struct_hvt_enter_alley", "targetname");
  wait 4;
}

_id_925A() {
  thread _id_6ED2();
  scripts\sp\maps\prisoner\prisoner_util::_id_10616("hvt");
  var_0 = scripts\sp\utility::_id_107EA("hvt_alley_tease_helper");
  thread _id_86B6(var_0);
  var_1 = scripts\engine\utility::getStruct("struct_hvt_enter_alley", "targetname");
  scripts\sp\utility::_id_127AE("trig_hvt_alley_enter", "targetname");
  level._id_920F scripts\sp\utility::_id_F3E0(100);
  level._id_920F _meth_82EE(getnode("node_hvt_alley_goal", "targetname"));
  var_1 thread scripts\sp\anim::_id_1F35(level._id_920F, "pnr_alley_ent_hvt");
  scripts\engine\utility::waitframe();
  var_1 scripts\sp\anim::_id_1F29(level._id_920F, "pnr_alley_ent_hvt", 1.1);
  thread scripts\engine\utility::play_sound_in_space("generic_meleeattack_enemy_3", (4070.5, -8843, -1916));
  wait 1.0;
  scripts\engine\utility::flag_set("hvt_dropped_down");
  wait 0.2;
  level._id_920F scripts\sp\utility::anim_stopanimScripted();
  wait 0.5;
  level._id_920F scripts\sp\utility::_id_51E1("sprint");
  level._id_920F scripts\sp\utility::_id_1101B();
  wait 0.6;
  level._id_920F delete();
  var_2 = scripts\engine\utility::getStruct("hvt_glimps_ap", "targetname");
  scripts\sp\maps\prisoner\prisoner_util::_id_10616("hvt");
  var_3 = scripts\engine\utility::getStruct("hvt_glimps_idle", "targetname");
  level._id_920F scripts\sp\utility::_id_5564();
  level._id_920F scripts\sp\utility::_id_F3E0(35);
  level._id_920F.ignoreall = 1;
  level._id_920F _meth_80F1(var_3.origin, var_3.angles);
  thread _id_9222();
  level scripts\engine\utility::waittill_any("alleys_entrance_high", "alleys_low_entrance", "hvt_damaged");
  thread _id_540B();
  var_2 scripts\sp\anim::_id_1F17(level._id_920F, "prisoner_hvt_glimpse_library");
  var_2 thread scripts\sp\anim::_id_1F35(level._id_920F, "prisoner_hvt_glimpse_library");
  scripts\engine\utility::waitframe();
  thread _id_7698();
  wait 0.7;
  level._id_920F scripts\sp\utility::_id_51E1("sprint");
  level._id_920F scripts\sp\utility::anim_stopanimScripted();
  level._id_920F.moveplaybackrate = 1.2;
  var_4 = scripts\engine\utility::getStruct("hvt_alley_01", "targetname");
  level._id_920F setgoalpos(var_4.origin);
}

_id_9222() {
  level._id_920F waittill("damage");
  level notify("hvt_damaged");
}

_id_86B6(var_0) {
  scripts\engine\utility::flag_wait("salter_done_talking");
  wait 0.75;

  if(isalive(var_0)) {
    thread scripts\engine\utility::play_sound_in_space("prisoner_sf1_radiocheckradio", var_0.origin + (0, 0, 70));
  }

  scripts\engine\utility::flag_wait("hvt_dropped_down");

  if(isalive(var_0)) {
    wait 0.25;
    thread scripts\engine\utility::play_sound_in_space("pris_sd_2_exposed_acquired", var_0.origin + (0, 0, 70));
    var_0 scripts\sp\utility::_id_51E1("sprint");
    playFXOnTag(scripts\engine\utility::getfx("sa_flashlight"), var_0, "tag_flash");
    playFXOnTag(scripts\engine\utility::getfx("sa_flashlight_flare"), var_0, "tag_flash");
  }
}

_id_7698() {
  wait 0.65;
  var_0 = scripts\engine\utility::getStruct("peach_pusher_end", "targetname");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_1 playSound("pnr_plastic_impactrex_plastic_lg");
  physicsexplosionsphere(var_0.origin, 150, 50, 200);
  wait 0.25;
  var_1 playSound("church_metal_crashing");
}

_id_6ED2() {
  var_0 = scripts\engine\utility::getStruct("spotStruct1", "targetname");
  var_1 = scripts\engine\utility::getStruct("spotStruct2", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_0.origin;
  var_2.angles = var_0.angles;
  playFXOnTag(scripts\engine\utility::getfx("sa_flashlight"), var_2, "tag_origin");
  level scripts\engine\utility::waittill_any("alleys_entrance_high", "alleys_low_entrance");

  while(!scripts\engine\utility::flag("railing_runner_go")) {
    if(!scripts\engine\utility::flag("railing_runner_go") && !scripts\engine\utility::flag("hvt_spotted")) {
      wait 1.5;
      scripts\engine\utility::flag_set("hvt_spotted");
    }

    wait 0.2;
    var_3 = randomintrange(-20, 20);
    var_4 = randomintrange(10, 20);
    var_2 moveTo(var_1.origin, 2);
    var_2 rotateTo(var_1.angles - (var_3, var_4, 0), 2);

    if(!scripts\engine\utility::flag("railing_runner_go")) {
      var_2 waittill("movedone");
    } else {
      break;
    }

    wait 0.2;
    var_2 moveTo(var_0.origin, 2);
    var_2 rotateTo(var_0.angles - (var_3, var_4, 0), 2);

    if(!scripts\engine\utility::flag("railing_runner_go")) {
      var_2 waittill("movedone");
      continue;
    }

    break;
  }

  if(isDefined(var_2)) {
    var_2 moveTo(var_1.origin, 1);
    var_2 rotateTo(var_1.angles, 1);
    wait 1;
    var_2 delete();
  }
}

#using_animtree("generic_human");

_id_1C02() {
  scripts\engine\utility::flag_wait_any("alleys_entrance_high", "alleys_low_entrance");
  scripts\sp\utility::_id_127B3("trigger_alleys_entered");
  scripts\engine\utility::flag_set("railing_runner_go");
  var_0 = scripts\sp\utility::_id_22CD("railing_runner");
  var_1 = scripts\sp\utility::_id_107EA("wood_balcony_guys");
  level._id_1C07 = [scripts\sp\utility::_id_77DA("enemy_alleys")];

  foreach(var_3 in var_0) {
    var_3 scripts\sp\utility::_id_51E1("cqb");
  }

  wait 0.5;
  _id_2004();
  var_5 = scripts\engine\utility::getStruct("hvt_alley_01", "targetname");
  var_6 = scripts\engine\utility::getStruct("hvt_street_escape_struct", "targetname");
  var_7 = scripts\engine\utility::getStruct("hvt_van_run_start", "targetname");
  var_8 = scripts\engine\utility::spawn_tag_origin(var_5.origin, var_5.angles);
  var_8.origin = var_8.origin + (0, 0, 30);
  var_9 = getspawner("office_high_guy", "targetname");
  var_9 thread scripts\sp\utility::_id_1747(::_id_C349);
  scripts\engine\utility::flag_wait_any("alley_high_path", "alley_low_path");
  var_10 = scripts\sp\utility::_id_107EA("exit_revealer", 1);
  var_11 = scripts\sp\utility::_id_107EA("alley_pit");

  if(isDefined(var_11)) {
    var_11 _meth_82F1(getEnt("exit_fall_back", "targetname"));
  }

  var_11 thread _id_CBE5();
  thread _id_695F(var_10);

  if(scripts\engine\utility::flag("alley_high_path")) {
    var_12 = scripts\sp\utility::_id_107EA("shotgun_fighter_high", 1);
  } else {
    var_12 = scripts\sp\utility::_id_107EA("shotgun_fighter_low", 1);
  }

  var_12 scripts\sp\utility::_id_51E1("cqb");
  thread _id_9221();

  while(!scripts\engine\utility::flag("alley_hvt_go") && !scripts\engine\utility::flag("alley_high_path") && !level.player scripts\sp\utility::_id_D1DF(var_8.origin, 0.5)) {
    scripts\engine\utility::waitframe();
  }

  level._id_920F setgoalpos(var_6.origin);
  level._id_920F.moveplaybackrate = 1.3;
  level._id_920F waittill("traverse_begin");
  wait 0.1;
  level._id_920F _meth_82B1(%hm_grnd_org_jumpup_128, 3.0);
  level._id_920F waittill("goal");
  level._id_920F scripts\sp\utility::_id_51E1("casual_gun");
  var_13 = 1.2;
  var_14 = distance2dsquared(level.player.origin, level._id_920F.origin);
  var_15 = squared(600);

  if(var_14 > var_15) {
    var_13 = 1;
  }

  level._id_920F.moveplaybackrate = var_13;
  level._id_920F scripts\sp\utility::_id_F3E0(60);

  while(!scripts\engine\utility::flag("hvt_street_run")) {
    scripts\engine\utility::waitframe();
  }

  level._id_920F scripts\sp\utility::_id_51E1("sprint");
  level._id_920F setgoalpos(var_7.origin);
  level._id_920F scripts\sp\utility::_id_F3E0(120);
}

_id_9221() {
  level endon("alley_hvt_go");
  level._id_920F waittill("damage");
  scripts\engine\utility::flag_set("alley_hvt_go");
}

_id_2004() {
  wait 0.15;
  var_0 = scripts\engine\utility::getStruct("barrel_shoot_1", "targetname");
  var_1 = scripts\engine\utility::getStruct("barrel_shoot_2", "targetname");
  var_2 = vectorNormalize(var_1.origin - var_0.origin) * 400;
  var_3 = magicgrenademanual("antigrav", var_0.origin, var_2, 3);
  thread _id_0E21::_id_2013(var_3);
}

_id_C349() {
  scripts\engine\utility::flag_wait("alley_high_path");

  if(isalive(self)) {
    self _meth_82F1(getEnt("alley_corner", "targetname"));
  }
}

_id_695F(var_0) {
  scripts\engine\utility::flag_wait("exit_reveal");
  wait 0.5;

  if(isDefined(var_0) && isalive(var_0) && !var_0 scripts\sp\utility::_id_58DA() && var_0 scripts\sp\utility::hastag(var_0.model, "tag_flash")) {
    playFXOnTag(scripts\engine\utility::getfx("sa_flashlight"), var_0, "tag_flash");
    playFXOnTag(scripts\engine\utility::getfx("sa_flashlight_flare"), var_0, "tag_flash");
    scripts\engine\utility::play_sound_in_space("pris_sd_1_callout_clock_6", var_0.origin + (0, 0, 70));
  }

  scripts\engine\utility::flag_wait("hvt_street_run");

  if(isDefined(var_0) && isalive(var_0) && !var_0 scripts\sp\utility::_id_58DA() && var_0 scripts\sp\utility::hastag(var_0.model, "tag_flash")) {
    stopFXOnTag(scripts\engine\utility::getfx("sa_flashlight"), var_0, "tag_flash");
    stopFXOnTag(scripts\engine\utility::getfx("sa_flashlight_flare"), var_0, "tag_flash");
  }
}

_id_1088F() {
  self.maxfaceenemydist = 500;
  playFXOnTag(scripts\engine\utility::getfx("sa_flashlight"), self, "tag_flash");
  playFXOnTag(scripts\engine\utility::getfx("sa_flashlight_flare"), self, "tag_flash");
  _id_540A();
}

_id_10D34() {
  scripts\sp\maps\prisoner\prisoner_util::_id_D2F9("playerstart_street");
  scripts\engine\utility::array_call(getEntArray("model_dropship_temp_mover", "script_noteworthy"), ::delete);
  scripts\sp\maps\prisoner\prisoner_util::_id_10616("hvt", 1);
  var_0 = scripts\engine\utility::getStruct("hvt_van_run_start", "targetname");
  level._id_920F _meth_80F1(var_0.origin, var_0.angles, 1000000);
  level._id_920F scripts\sp\utility::_id_F3E0(24);
  scripts\engine\utility::flag_set("enable_volumetrics");
  scripts\engine\utility::flag_set("sun_shadow_post_alleys_enter");
  setumbraportalstate("umbra_spaceship_view", 1);
  scripts\engine\utility::flag_set("street_jumped");
}

_id_B239() {
  thread _id_D7B4();
  thread _id_5421();
  var_0 = scripts\engine\utility::getStruct("ship_lookat", "targetname");
  var_1 = getEnt("rubble_slowdown_trig", "targetname");
  var_1 thread _id_1880();
  thread _id_5A1D();
  scripts\sp\utility::_id_127AE("ship_slide_trig", "targetname");
  wait 0.5;

  while(!level.player scripts\sp\utility::_id_D1DF(var_0.origin, 0.1)) {
    scripts\engine\utility::waitframe();
  }

  playworldsound("scn_street_capital_ship_settle", (2809, -10493, -1660));
  scripts\sp\utility::_id_15F1("ship_mover", "targetname");
  scripts\sp\utility::_id_15F1("ship_exploder", "targetname");
  thread _id_FD59();
  thread _id_4E43();
  thread _id_11121();
  level._id_9238 = scripts\sp\utility::_id_107EA("hvt_lmg", 1);
  level._id_9238 thread _id_9239();
  thread _id_E593();
  thread _id_2ACD();
  thread _id_2ACE();
  level._id_59E6 = 0;
  scripts\engine\utility::flag_wait("flag_streets_end");
}

_id_D7B4() {
  level endon("flag_streets_end");

  for(;;) {
    playworldsound("scn_street_capital_ship_destruction", (2809, -10493, -1660));
    wait 5.0;
  }
}

_id_2ACD() {
  var_0 = scripts\engine\utility::getStruct("bike_alarm_struct", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  playFXOnTag(scripts\engine\utility::getfx("vfx_pr_alarm"), var_1, "tag_origin");
  var_1 playLoopSound("pnr_alarm_heist_mons_lp4");
  scripts\engine\utility::flag_wait("flag_hvt_terrace_run");
  var_1 stoploopsound("pnr_alarm_heist_mons_lp4");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_pr_alarm"), var_1, "tag_origin");
}

_id_2ACE() {
  var_0 = scripts\sp\utility::_id_107EA("bike_shop_owner_sp", 1);
  var_0.goalradius = 15;
  var_0._id_1FBB = "generic";
  var_0 thread scripts\sp\anim::_id_1EEA(var_0, "ph_cafe_civis_ambient_civ11", "run");
  var_0.allowdeath = 1;
  var_1 = scripts\engine\utility::getStruct("bike_shop_owner", "targetname");
  thread _id_192A();
  var_2 = 1;

  while(var_2) {
    if(isDefined(var_0)) {
      var_3 = distance2dsquared(level.player.origin, var_0.origin);
      var_4 = squared(500);

      if(var_4 > var_3) {
        var_2 = 0;
      }
    } else
      var_2 = 0;

    wait 0.5;
  }

  if(isDefined(var_0)) {
    var_0 notify("run");
    var_5 = getnode("work_station_node", "targetname");
    var_0 _meth_82EE(var_5);
    var_0 playLoopSound("prisoner_fem_civ_wimper_loop");
    scripts\engine\utility::flag_wait("flag_hvt_terrace_run");

    if(isDefined(var_0)) {
      var_0 stoploopsound("prisoner_fem_civ_wimper_loop");
    }
  }
}

_id_192A() {
  scripts\engine\utility::flag_wait("hvt_street_escape");
  wait 2;
  level endon("street_dead");

  for(;;) {
    var_0 = getaicount("axis");

    if(var_0 == 0) {
      level notify("street_dead");
      continue;
    }

    wait 0.1;
  }
}

_id_1880() {
  level endon("flag_streets_end");
  level endon("ship_settled");

  for(;;) {
    self waittill("trigger", var_0);

    if(var_0 == level.player) {
      while(level.player istouching(self)) {
        level.player scripts\sp\utility::_id_2B76(0.85, 0.2);
        wait 0.1;
      }

      level.player scripts\sp\utility::_id_2B76(1, 0.25);
    }
  }
}

_id_FD59() {
  wait 1;
  level.player _meth_8244("damage_heavy");
  earthquake(0.1, 2, level.player.origin, 100);
  wait 3;
  level.player stoprumble("damage_heavy");
  level.player scripts\sp\utility::_id_2B76(1, 0.25);
  wait 1;
  var_0 = scripts\engine\utility::getStruct("hvt_van_run_start", "targetname");
}

_id_5A1D() {
  var_0 = _id_0B1E::_id_794D("bike_shop_door");
  var_1 = getEnt("door_peek_door_fake", "targetname");
  var_2 = getEntArray("bike_shop_door", "targetname");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "door_peek_clip") {
      var_0.clip = var_4;
    }
  }

  var_0 hide();
  var_0.clip connectpaths();
  var_0.clip hide();
  scripts\sp\utility::_id_127AE("hvt_peek_close", "targetname");
  var_1 rotateYaw(70, 1, 0);
  wait 1;
  var_0 show();
  var_1 hide();
  var_0.clip show();
  var_0.clip disconnectPaths();
  wait 5;

  if(!scripts\engine\utility::flag("hvt_in_backroom") && isDefined(level._id_920F)) {
    var_6 = scripts\engine\utility::getStruct("hvt_van_run_end", "targetname");
    level._id_920F _meth_80F1(var_6.origin, var_6.angles);
  }
}

_id_11121() {
  scripts\sp\utility::_id_28D7("axis");
  var_0 = scripts\engine\utility::getStruct("hvt_van_run_start", "targetname");
  var_1 = scripts\engine\utility::getStruct("hvt_van_run_end", "targetname");
  var_2 = scripts\sp\utility::_id_22CD("biker_boys", 1);

  foreach(var_4 in var_2) {
    if(isalive(var_4)) {
      var_4.grenadeweapon = "antigrav";
      var_4.ignoreall = 1;
    }
  }

  scripts\engine\utility::flag_wait("hvt_street_escape");

  foreach(var_4 in var_2) {
    if(isalive(var_4)) {
      var_4.ignoreall = 0;
    }
  }

  if(!scripts\engine\utility::flag("street_jumped")) {
    level._id_920F waittill("goal");
  }

  level._id_920F scripts\sp\utility::_id_51E1("sprint");
  level._id_920F setgoalpos(var_1.origin);
  level._id_920F scripts\sp\utility::_id_F3DD(35);
  wait 2;
  level._id_920F waittill("goal");
  scripts\engine\utility::flag_set("hvt_in_backroom");
  level._id_920F scripts\sp\utility::_id_1101B();
  level._id_920F delete();
  wait 1;
  scripts\engine\utility::flag_set("door_peek_on");
  wait 2;
  thread _id_0B1E::_id_59BE("bike_shop_door");
}

_id_4E43() {
  level._id_13158 = getscriptablearray("prsn_street_van", "targetname")[0];
  var_0 = getEntArray("van_lights", "targetname");
  var_1 = getEntArray("van_light_origin", "targetname");
  level._id_13158 waittill("death");
  level notify("lights_off");

  foreach(var_3 in var_0) {
    var_3 setlightintensity(0.0);
  }
}

_id_13159() {
  var_0 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  playFXOnTag(scripts\engine\utility::getfx("vfx_pr_flashlight_rain"), var_0, "tag_origin");
  self waittill("lights_off");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_pr_flashlight_rain"), var_0, "tag_origin");
}

_id_E593() {
  level.player waittill("player_is_hacked_robot");
  scripts\engine\utility::flag_set("hvt_street_escape");
}

_id_9239() {
  self endon("death");
  self addaieventlistener("grenade danger");
  self addaieventlistener("gunshot");
  self addaieventlistener("gunshot_teammate");
  self addaieventlistener("silenced_shot");
  self addaieventlistener("bulletwhizby");
  self addaieventlistener("projectile_impact");
  self addaieventlistener("explode");
  self.ignoreall = 1;
  scripts\engine\utility::waittill_any("ai_events", "hvt_street_escape");
  self.ignoreall = 0;
  scripts\engine\utility::flag_set("hvt_street_escape");
  var_0 = 300;
  var_0 = squared(var_0);

  for(;;) {
    if(isDefined(self) && distancesquared(self.origin, level.player.origin) <= var_0) {
      break;
    }

    wait 0.1;
  }

  scripts\engine\utility::flag_set("flag_civ_bike_shop");
}

_id_10BBC() {
  scripts\sp\maps\prisoner\prisoner_util::_id_D2F9("playerstart_bikeshop");
  thread _id_59D4();
  thread _id_2ACD();
  scripts\engine\utility::flag_set("enable_volumetrics");
  scripts\engine\utility::flag_set("sun_shadow_streets_enter");
  scripts\engine\utility::flag_set("door_peek_on");
}

_id_B192() {
  scripts\engine\utility::flag_wait("door_peek_on");
  scripts\sp\utility::_id_127AE("backroom_vo_trig", "targetname");
  scripts\sp\utility::_id_28D7("axis");
  var_0 = scripts\engine\utility::getStruct("hvt_backroom_1", "targetname");
  var_1 = scripts\engine\utility::getStruct("hvt_backroom_2", "targetname");
  thread scripts\engine\utility::play_sound_in_space("prisoner_ria_iseverythinginp", var_1.origin);
  scripts\engine\utility::delaythread(1.1, scripts\engine\utility::play_sound_in_space, "prisoner_sf3_almostsir", var_1.origin);
  scripts\sp\maps\prisoner\prisoner_util::_id_10616("hvt", 1);
  level._id_920F scripts\sp\utility::_id_5564();
  level._id_920F scripts\sp\utility::_id_F3E0(15);
  level._id_920F _meth_80F1(var_0.origin, var_0.angles);
  level._id_920F scripts\sp\utility::_id_51E1("combat");
  var_2 = scripts\sp\utility::_id_22CD("biker_boys_backroom", 1);

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_noteworthy) && var_4.script_noteworthy == "hvt_guard") {
      level._id_9252 = var_4;
    }
  }

  level._id_9252.allowdeath = 1;
  var_6 = scripts\engine\utility::getStruct("hvt_shove_anim", "targetname");
  level._id_9252._id_1FBB = "generic";
  var_7 = [level._id_9252, level._id_920F];
  var_6 thread scripts\sp\anim::_id_1EE7(var_7, "pnr_bikeshop_idle", "bike_loop_end");
  _id_137CA();

  if(isalive(level._id_9252)) {
    wait 0.75;

    if(isalive(level._id_9252)) {
      scripts\engine\utility::delaythread(0.4, scripts\engine\utility::play_sound_in_space, "generic_meleeattack_enemy_3", level._id_920F.origin + (0, 0, 50));
      var_6 notify("bike_loop_end");
      level._id_920F playSound("prisoner_hvt_bikeshop_stairs");
      var_6 scripts\sp\anim::_id_1F2C(var_7, "pnr_bikeshop_shove");
      level._id_920F setgoalpos(var_1.origin);
      level._id_920F waittill("goal");
      level._id_920F scripts\sp\utility::_id_1101B();
      level._id_920F delete();
    }
  } else {
    var_6 notify("bike_loop_end");
    level._id_920F setgoalpos(var_1.origin);
    level._id_920F waittill("goal");
    level._id_920F scripts\sp\utility::_id_1101B();
    level._id_920F delete();
  }

  scripts\engine\utility::flag_set("backroom_entered");
  thread _id_5711();
  thread _id_8806();
}

_id_137CA() {
  level endon("door_peek_start");
  level endon("door_kick_start");
  scripts\engine\utility::flag_wait("bike_scene_prog");
}

_id_8806() {
  level endon("flag_cy_spawn_jeeps");
  var_0 = _id_0E29::_id_87F3();

  if(isDefined(var_0._id_ECE7) && var_0._id_ECE7 == "enemy_bike_shop") {
    _id_0E29::_id_87E0(3);
  }
}

_id_59D4() {
  wait 1;
  _id_0B1E::_id_59BE("bike_shop_door");
}

_id_5711() {
  level endon("flag_hvt_terrace_run");

  for(;;) {
    var_0 = randomintrange(1, 4);

    if(var_0 < 3) {
      thread scripts\engine\utility::play_sound_in_space("scn_collapse_distant_destruction_metal", (-2149, -14710, -742));
    } else {
      thread scripts\engine\utility::play_sound_in_space("scn_collapse_distant_destruction", (-2149, -14710, -742));
    }

    wait 9.0;
  }
}

_id_542A() {
  wait 1;
  level.player scripts\sp\utility::_id_1034D("prisoner_plr_ethanyoureonpoint");
  level._id_EA2C scripts\sp\utility::_id_10346("prisoner_slt_cantgetyouanycl");
}

_id_544B() {
  level.player scripts\sp\utility::_id_1034D("prisoner_plr_saltcoverpatter");
  level._id_EA2C scripts\sp\utility::_id_10346("prisoner_slt_copycoverstandi");
  level.player scripts\sp\utility::_id_1034D("prisoner_plr_findthetrucketh");
  level._id_2429 scripts\sp\utility::_id_10346("prisoner_eth_thisway");
  thread _id_5E4A();
  scripts\engine\utility::flag_wait("collapse_out_of_dropship");
  level.player thread scripts\sp\utility::_id_D090("ges_radio");
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  level.player scripts\sp\utility::_id_1034D("prisoner_plr_11toechohowcopy");
  level.player scripts\sp\utility::_id_1034D("prisoner_plr_echothisis11doy");
  level.player playSound("ges_plr_radio_off");
  level.player scripts\sp\utility::_id_1102B("ges_radio");
  level endon("august_door_open");
  level waittill("collapse_reaction");
  wait 2;
  var_0 = scripts\engine\utility::getStruct("playerstart_collapse_post_truck", "targetname");
  magicbullet("iw7_ar57", var_0.origin, var_0.origin + (200, 0, 20));
  wait 0.1;
  magicbullet("iw7_ar57", var_0.origin, var_0.origin + (200, 0, 20));
  wait 0.1;
  magicbullet("iw7_ar57", var_0.origin, var_0.origin + (200, 0, 20));
  wait 0.1;
  magicbullet("iw7_ar57", var_0.origin, var_0.origin + (200, 0, 20));
  wait 0.5;
  magicbullet("iw7_devastator", var_0.origin, var_0.origin + (5, 0, 20));
  wait 0.2;
  magicbullet("iw7_devastator", var_0.origin, var_0.origin + (5, 0, 20));
  wait 0.75;
  magicbullet("iw7_ar57", var_0.origin, var_0.origin + (200, 0, 20));
  wait 0.1;
  magicbullet("iw7_ar57", var_0.origin, var_0.origin + (200, 0, 20));
  wait 0.1;
  magicbullet("iw7_ar57", var_0.origin, var_0.origin + (200, 0, 20));
  wait 0.1;
  magicbullet("iw7_ar57", var_0.origin, var_0.origin + (200, 0, 20));
  wait 0.1;
  magicbullet("iw7_ar57", var_0.origin, var_0.origin + (200, 0, 20));
  wait 0.5;
  thread scripts\engine\utility::play_sound_in_space("generic_dogdeathlong_enemy_6", var_0.origin);
  wait 0.4;
  magicbullet("iw7_devastator", var_0.origin, var_0.origin + (5, 0, 20));
  wait 0.35;
  magicbullet("iw7_devastator", var_0.origin, var_0.origin + (5, 0, 20));
  thread _id_548B();
}

_id_5E4A() {
  wait 10;

  if(scripts\engine\utility::flag("collapse_out_of_dropship") || scripts\engine\utility::flag("player_on_ground")) {
    return;
  }
  level._id_EA2C scripts\sp\utility::_id_10346("prisoner_slt_getouttherereye");
}

_id_548B() {
  level endon("dialogue_open_truck");
  level endon("august_door_open");
  level._id_2429 scripts\sp\utility::_id_10346("prisoner_eth_survivors");
  level.player scripts\sp\utility::_id_1034D("prisoner_plr_letshelpemout");
  thread _id_12840();
  wait 3;

  if(!scripts\engine\utility::flag("august_door_open")) {
    level._id_2429 scripts\sp\utility::_id_10346("prisoner_eth_doorsyourssiril");
  }

  wait 6;

  if(!scripts\engine\utility::flag("august_door_open")) {
    level._id_2429 scripts\sp\utility::_id_10346("prisoner_eth_readywhenyouare");
  }
}

_id_12840() {
  var_0 = scripts\engine\utility::getStruct("collapse_atomtruck_sidedoor_origin", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, var_0.angles);
  var_1 playSound("prisoner_um2_woundedmoanings");
  scripts\engine\utility::flag_wait("august_door_open");
  var_1 _meth_8278(0, 0.5);
}

_id_540E() {
  level notify("dialogue_open_truck");
  wait 16;
  level.player scripts\sp\utility::_id_1034D("prisoner_plr_fever2");
  level.player scripts\sp\utility::_id_1034D("prisoner_plr_ineedacommjamin");
  level._id_EA2C scripts\sp\utility::_id_10350("prisoner_slt_thisisnobuenora");
  level.player scripts\sp\utility::_id_1034D("prisoner_plr_salthegetstoate");
  level notify("salt_convo_done");
  level._id_EA2C scripts\sp\utility::_id_10350("prisoner_slt_solidcopygoodhu");
  scripts\engine\utility::flag_set("salter_done_talking");
  wait 5;

  if(!scripts\engine\utility::flag("flag_exit_truck")) {
    level._id_2429 scripts\sp\utility::_id_10346("prisoner_eth_sirthetransponder");
  }
}

_id_540B() {
  level._id_920F thread scripts\sp\utility::_id_10346("prisoner_ria_onesrightbehind");
}

_id_5421() {
  scripts\engine\utility::flag_wait("flag_alleys_end");
  var_0 = scripts\engine\utility::getStruct("hvt_escort_vo1", "targetname");
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin + (300, 0, 0), var_0.angles);
  var_2 = scripts\engine\utility::getStruct("hvt_van_run_start", "targetname");
  thread scripts\engine\utility::play_sound_in_space("prisoner_ria_keepmovinggetto", var_1.origin);
  scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_1034D, "prisoner_plr_annexwhatthehel");
  scripts\sp\utility::_id_127AE("ship_mover", "targetname");
  wait 7;
  scripts\engine\utility::play_sound_in_space("prisoner_sf1_dariangroundisd", level._id_920F.origin + (0, 0, 50));
  scripts\engine\utility::flag_wait("hvt_street_escape");

  if(isalive(level._id_920F)) {
    level._id_920F scripts\sp\utility::_id_10346("prisoner_sf1_dontletthemnear");
  }

  var_1 delete();
  scripts\sp\utility::_id_28D8("axis");
}

_id_540A() {
  level endon("hvt_street_escape");

  while(!scripts\engine\utility::flag("alley_chatter_1_played")) {
    if(isalive(self) && self cansee(level.player) && !scripts\engine\utility::flag("alley_chatter_1_played")) {
      thread scripts\engine\utility::play_sound_in_space("pris_sd_0_callout_clock_11", self.origin + (0, 0, 70));
      scripts\engine\utility::flag_set("alley_chatter_1_played");
    }

    wait 0.1;
  }

  wait 13;

  while(!scripts\engine\utility::flag("alley_chatter_2_played")) {
    if(!scripts\engine\utility::flag("alley_chatter_2_played") && isalive(self)) {
      thread scripts\engine\utility::play_sound_in_space("pris_sd_0_reaction_whizby_generic", self.origin + (0, 0, 70));
      scripts\engine\utility::flag_set("alley_chatter_2_played");
    }

    wait 0.1;
  }
}

_id_CBE5() {
  scripts\engine\utility::flag_wait("alley_chatter_2_played");
  wait 13;

  if(isDefined(self) && !scripts\engine\utility::flag("hvt_street_run")) {
    thread scripts\engine\utility::play_sound_in_space("pris_sd_0_callout_contactclock_8", self.origin + (0, 0, 70));
  }
}

_id_5EC0(var_0) {
  var_1 = [];

  if(isarray(var_0)) {
    var_1 = var_0;
  } else {
    var_1[0] = var_0;
  }

  if(!isDefined(var_1[0]) || var_1[0] == "all") {
    var_1 = ["left", "right", "back"];
  }

  foreach(var_3 in var_1) {
    switch (var_3) {
      case "left":
        if(!isDefined(self._id_4D94._id_5A13._id_4348)) {
          break;
        }

        self._id_4D94._id_5A13._id_4348 stoploopsound();
        break;
      case "right":
        if(!isDefined(self._id_4D94._id_5A27._id_4348)) {
          break;
        }

        self._id_4D94._id_5A27._id_4348 stoploopsound();
        break;
      case "back":
        if(!isDefined(self._id_4D94._id_5A01._id_4348)) {
          break;
        }

        self._id_4D94._id_5A01._id_4348 stoploopsound();
        break;
      default:
    }
  }
}

_id_4362() {
  var_0 = getEnt("debris_wall", "targetname");
  var_1 = getEnt("collapse_pillar", "targetname");
  var_2 = getEnt("collapse_pillar_2", "targetname");
  var_3 = getEnt("collapse_pillar_3", "targetname");
  var_4 = getEnt("collapse_pillar_4", "targetname");
  var_2 linkTo(var_1);
  var_3 linkTo(var_1);
  var_4 linkTo(var_1);
  var_1 scripts\sp\utility::_id_23B7("pillar_fall");
  scripts\sp\utility::_id_127AE("ethan_debris_reach", "targetname");
  wait 0.5;
  var_1 thread scripts\sp\anim::_id_1F35(var_1, "prisoner_debris_fall");
  var_0 delete();
  var_1 waittillmatch("single anim", "shake");
  var_5 = distance2dsquared(level._id_2429.origin, level.player.origin);
  var_6 = squared(400);

  if(var_5 < var_6) {
    level.player _meth_8291(0.2, 0.2, 0.1, 1, 0.25, 0, 300, 10, 0, 5);
  }

  wait 0.15;
  var_1 waittillmatch("single anim", "shake");
  level.player _meth_8291(0.2, 0.2, 0.1, 1, 0, 0, 300, 10, 0, 5);
}