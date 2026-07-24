/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\rogue\infil.gsc
*******************************************/

_id_F0D1() {
  precachemodel("nopack_nohelmet_shadow");
  precachemodel("default_character_shadow");
  precachemodel("fx_org_view");
  precachemodel("head_hero_xo");
  precachemodel("veh_mil_air_un_dropship_hero_interior_screen_01");
}

_id_F0CB() {
  scripts\engine\utility::flag_init("transitioned_to_playspace");
  scripts\engine\utility::flag_init("landed_dropship");
  scripts\engine\utility::flag_init("combat_section_active");
}

_id_F0D2() {}

_id_9469() {
  _id_9630();
  thread _id_0B0A::_id_583F(0, 0, 6, 0, 34.1249, 4.7846, 0.05);
  thread optimize_for_bink();
}

optimize_for_bink() {
  setsaveddvar("sm_SunEnable", 0);
  setsaveddvar("sm_SpotEnable", 0);
  scripts\sp\utility::_id_13705();
  setsaveddvar("sm_SunEnable", 1);
  setsaveddvar("sm_SpotEnable", 1);
}

_id_9465() {
  thread infil_dof_exit();
  thread scripts\sp\maps\rogue\rogue_util::_id_119AF(1);
  thread _id_1130A();
  thread _id_B502();
  thread scripts\sp\maps\rogue\rogue_util::_id_E643();
  level._id_B33E scripts\sp\utility::_id_86E4();
  level._id_13E12 scripts\sp\utility::_id_86E4();
  level._id_13E12 detach(level._id_13E12.hatmodel);
  level._id_13E12 detach("head_hero_noHair_xo");
  level._id_13E12 attach("head_hero_xo");
  thread _id_30F9();
  level.player scripts\engine\utility::allow_wallrun(0);
  level.player allowdoublejump(0);
  level.player allowslide(0);
  var_0 = ["rogue_surface_tr", "rogue_base_tr"];
  scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_12643, var_0);

  if(scripts\sp\utility::_id_93A6()) {
    level.player disableoffhandweapons();
    scripts\sp\specialist_MAYBE::_id_F53C(0);
  }

  level.player _meth_82C0("rogue_dropship", 0.05);
  level.player _meth_8573("nopack_nohelmet_shadow");

  while(!isDefined(level._id_5D6C))
    scripts\engine\utility::waitframe();

  level._id_5D6C _meth_83E8();
  level._id_5D6C notify("stop_monitor_player_in_dropship");
  level._id_5D6C notify("stop_thrusters_on_off");
  level._id_5D6C scripts\sp\utility::_id_65E1("inside_dropship_disable_effects");
  level._id_5D6C scripts\sp\utility::_id_65E3("player_dropship_seats_ready");
  thread _id_F94E();
  var_1 = getEnt("fly_in_origin", "targetname");
  var_1 thread scripts\sp\anim::_id_1EC3(level._id_5D6C, "infil_scene_b");
  scripts\engine\utility::waitframe();
  level.player _meth_82C0("rogue_dropship", 0.5);

  if(level._id_10CDA == "infil_flyin") {
    scripts\sp\maps\rogue\rogue_util::_id_1EFB(10);
    level._id_5D6C _id_0BBF::_id_10CB0();
    level.player _meth_823F(undefined);
  }

  foreach(var_3 in level._id_10AC8) {
    var_3 _meth_8250(0);
    var_3 detach(var_3._id_A489);
    level._id_5D6C thread scripts\sp\maps\rogue\rogue_util::_id_1E94(var_3, "infil_scene_b", "infil_scene_b_idle");
    var_3._id_2CC2 = 0;
  }

  level._id_B4F9 thread _id_16A1();
  level._id_B33B thread _id_16A1();
  level._id_5D6C._id_B505 = level._id_5D6C _id_0BBF::_id_796D("right_02");
  level._id_5D6C._id_B33D = level._id_5D6C _id_0BBF::_id_796D("left_01");
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_5D6C._id_B505, "infil_scene_b");
  level._id_5D6C thread scripts\sp\anim::_id_1F35(level._id_5D6C._id_B33D, "infil_scene_b");
  level._id_5D6C scripts\sp\utility::anim_stopanimScripted();
  getEnt("fly_in_origin", "targetname") thread scripts\sp\anim::_id_1F35(level._id_5D6C, "infil_scene_b");
  level._id_5D6C scripts\engine\utility::delaycall(1.4, ::playsound, "rogue_dropship_plr_push_screen");
  thread gentle_landing_jostle();
  level._id_5D6C scripts\sp\maps\rogue\rogue_util::_id_1EFA("infil_scene_b", undefined, undefined, undefined, undefined, 2, "mco_helmet_swap_skip");
  level.player._id_E505 = scripts\sp\utility::_id_10639("player_rig", level.player.origin);
  level.player._id_E505 hide();
  level.player.seat = level._id_5D6C _id_0BBF::_id_796D("right_01");
  level._id_5D6C scripts\sp\anim::_id_1EC3(level.player.seat, "infil_scene_c1");
  thread _id_106EE();
  level.helmet = _id_0E4B::_id_10730(undefined, level.player.seat, "TAG_HELMET_ATTACH");
  level._id_5D6C scripts\sp\anim::_id_1EC3(level.player._id_E505, "infil_scene_c1");
  level.player.seat _id_0E46::_id_48C4("J_handle", (0, 0, 0), &"ROGUE_BOOSTER_PROMPT");
  level.player.seat waittill("trigger");
  thread load_dorm_exterior();
  level notify("mco_helmet_swap_skip");
  thread _id_2CB2();
  level._id_B33E scripts\sp\utility::_id_86E2();
  level._id_13E12 scripts\sp\utility::_id_86E2();
  level._id_13E12 detach("head_hero_xo");
  level._id_13E12 attach("head_hero_noHair_xo");
  level._id_13E12 attach(level._id_13E12.hatmodel);
  level notify("reset_brooks_gun");
  level.player scripts\engine\utility::allow_wallrun(1);
  level.player allowdoublejump(1);
  level.player allowslide(1);
  level.player _meth_8573("default_character_shadow");
  level._id_13E12 attach(level._id_13E12._id_A489);
  level._id_B33E attach(level._id_B33E._id_A489);
  level.player playSound("scn_rogue_dropship_release_lr");
  thread _id_E660();
  thread _id_9472();
  _id_10AC9();
}

infil_dof_exit() {
  wait 4;
  thread _id_0B0A::_id_583D(1);
}

load_dorm_exterior() {
  scripts\sp\utility::_id_12641("rogue_dorm_tr");
}

gentle_landing_jostle() {
  wait 2;
  earthquake(0.3, 1.5, level.player.origin, 1024);
}

_id_F94E() {
  level._id_5D7F = spawn("script_model", (0, 0, 0));
  level._id_5D7F setModel("veh_mil_air_un_dropship_hero_interior_screen_01");
  level._id_5D7F hide();
  _id_100D4();
}

_id_100D4() {
  if(isDefined(level._id_5D7F)) {
    level._id_5D7F linkTo(level._id_5D6C, "j_seatscreenslide_ri", (0, -1.05, 0.105), (0, 90, 0));
    level._id_5D7F show();
  }
}

_id_CCF0() {
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingameloop("sc_rogue_world_dropship_scan");
}

#using_animtree("vehicles");

_id_1130A() {
  var_0 = getEnt("fake_ds_col_swap_trig", "targetname");

  if(!isDefined(var_0)) {
    return;
  }
  var_1 = getEnt("fake_rogue_ds_col_hangar", "targetname");
  var_1 notsolid();
  var_0 waittill("trigger");
  var_1 solid();
  level._id_5D6C._id_4D94._id_4348 notsolid();
  scripts\sp\maps\rogue\rogue_util::_id_404C();
  var_2 = 0;

  while(var_2 != 4) {
    var_2 = 0;

    foreach(var_4 in level._id_10AC8) {
      if(var_4 scripts\sp\utility::_id_65DF("ready_for_Hangar"))
        var_2++;
    }

    wait 0.05;
  }

  level._id_5D6C _meth_83A1();
  level._id_5D6C setanimknob(%rogue_infil_door_scene_c, 1, 0.01, -1);
}

_id_30F9() {
  while(!isDefined(level._id_5D6C))
    wait 0.05;

  level._id_B33B scripts\sp\utility::_id_86E4();
  var_0 = getweaponmodel("iw7_ake");
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel(var_0);
  var_1._id_1FBB = "brooks_gun";
  var_1 scripts\sp\anim::_id_F64A();
  level._id_5D6C thread scripts\sp\anim::_id_1EEA(var_1, "brooks_gun_infil", "strain");
  level waittill("reset_brooks_gun");
  level._id_5D6C notify("strain");
  var_1 _meth_83A1();
  var_1.origin = level._id_B33B gettagorigin("j_gun");
  var_1.angles = level._id_B33B gettagangles("j_gun");
  var_1 linkTo(level._id_B33B, "j_gun");
  wait 2;
  level._id_B33B scripts\sp\utility::_id_86E2();
  var_1 delete();
}

clear_script_origin_other_on_ai() {
  wait 3;
  level._id_5D6C._id_B505 _meth_83A1();
  level._id_5D6C._id_B33D _meth_83A1();
}

_id_B502() {
  while(!isDefined(level._id_5D6C))
    wait 0.05;

  while(!isDefined(level._id_5D6C._id_4D94._id_F08B) || level._id_5D6C._id_4D94._id_F08B.size == 0)
    wait 0.05;

  level._id_B4F9 detach(level._id_B4F9.hatmodel);
  var_0 = level._id_5D6C _id_0BBF::_id_796D("right_02");
  var_1 = spawn("script_model", var_0 gettagorigin("tag_helmet_attach"));
  var_1.angles = var_0 gettagangles("tag_helmet_attach");
  var_1 setModel(level._id_B4F9.hatmodel);
  level waittill("mco_helmet_swap_skip");
  wait 3;
  var_1 delete();
  level._id_B4F9 attach(level._id_B4F9.hatmodel);
}

_id_E660() {
  wait 18;
  setmusicstate("mx_215_rogue_intro");
}

_id_10AC9() {
  wait 7.5;

  foreach(var_1 in level._id_10AC8)
  thread _id_944D(var_1);

  level._id_5D6C._id_4D94._id_5A13._id_4348 scripts\engine\utility::delaycall(17, ::notsolid);
  level._id_5D6C scripts\sp\anim::_id_1F35(level._id_5D6C, "infil_scene_c3");
}

_id_944D(var_0) {
  level._id_5D6C scripts\sp\maps\rogue\rogue_util::_id_1E94(var_0, "infil_scene_c", undefined, undefined, undefined, undefined, scripts\sp\utility::_id_61C7);
  var_0 scripts\sp\maps\rogue\hangar::_id_F567();
}

_id_2CB2() {
  wait 9.5;
  level.player playSound("rogue_dropship_plr_boost_rig_on");
  level thread scripts\sp\utility::_id_9145("fluff_messages_boost_engaged");
}

_id_16A1() {
  self endon("booster_on");

  while(!isDefined(level.player.seat))
    wait 0.05;

  thread _id_106F1();
  level.player.seat waittill("trigger");
  self._id_E628 = 1;
  self attach(self._id_A489);
  self._id_2CC2 = 1;
  scripts\sp\utility::_id_C12D("booster_on", 2);
}

_id_106F1() {
  var_0 = spawn("script_model", (0, 0, 0));

  if(self._id_1FBB == "MCO") {
    var_0.origin = (16363.4, 37603, -735.665);
    var_0.angles = level.player.seat gettagangles("tag_jetpack");
  } else {
    var_0.origin = (16448.8, 37787.3, -736.188);
    var_0.angles = level.player.seat gettagangles("tag_jetpack");
    var_0 rotateYaw(180, 0.05, 0, 0);
  }

  var_0 setModel(self._id_A489);
  self waittill("booster_on");
  var_0 delete();
}

_id_106EE() {
  while(!isDefined(level.player.seat))
    wait 0.05;

  var_0 = spawn("script_model", (0, 0, 0));
  var_0.origin = level.player.seat gettagorigin("tag_jetpack");
  var_0.angles = level.player.seat gettagangles("tag_jetpack");
  var_0 setModel(level._id_B4F9._id_A489);
  level.player.seat waittill("trigger");
  wait 10;
  var_0 delete();
}

_id_9472() {
  scripts\engine\utility::delaythread(1, scripts\engine\utility::flag_set, "player_in_scene");
  level.player _meth_84AF(1);
  level.player disableweapons();
  level.player setstance("stand");
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player freezecontrols(1);
  level.player _meth_84FE();
  level.player _meth_823C(level.player._id_E505, "tag_player", 0.5, 0.25, 0.25);
  wait 0.5;
  level.player._id_E505 setModel("vm_hero_protagonist_base");
  level.player._id_E505 show();
  level.player playerlinktodelta(level.player._id_E505, "tag_player", 1, 0, 0, 0, 0, 1);
  thread clear_script_origin_other_on_ai();
  level._id_D34D = getweaponmodel(level.player getcurrentprimaryweapon());
  level._id_D34D = level.player._id_E505 scripts\sp\anim::_id_1EE5(level._id_D34D, "tag_weapon");
  level thread scripts\sp\maps\rogue\rogue_util::_id_C152("grab_helmet", ::_id_847A);
  level._id_5D6C scripts\sp\anim::_id_1F2C([level.player._id_E505, level.player.seat], "infil_scene_c1");

  if(scripts\sp\utility::_id_93A6())
    scripts\engine\utility::delaythread(4.5, scripts\sp\specialist_MAYBE::_id_F3FF, 1);

  level.player _meth_82C0("rogue_dropship", 0.5);
  level._id_5D6C scripts\sp\anim::_id_1F2C([level.player._id_E505, level.player.seat], "infil_scene_c2");
  level.player _meth_82C0("rogue_dropship", 0.5);
  level notify("notify_scene_c3");
  level._id_5D6C scripts\sp\anim::_id_1F2C([level.player._id_E505, level.player.seat], "infil_scene_c3");
  thread _id_D030();
  level.player _meth_84AF(0);
}

_id_847A() {
  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_8E06();
    level._id_10964.helmet linkTo(level.player._id_E505, "tag_playerhelmet", (0, 0, 0), (0, 0, 0));
    level.helmet delete();
  } else
    level.player.helmet linkTo(level.player._id_E505, "tag_playerhelmet", (0, 0, 0), (0, 0, 0));
}

_id_9468() {}

#using_animtree("player");

_id_9467() {
  level.player _meth_82C0("rogue_dropship", 0.05);
  level.player freezecontrols(1);
  thread _id_0E4B::_id_8E06();
  _id_9630();

  while(!isDefined(level._id_5D6C))
    wait 0.05;

  var_0 = level.player _meth_84C6("loadouts", 0, "weaponSetups", 0, "weapon");
  var_1 = getweaponmodel(var_0);
  level._id_5D6C scripts\sp\utility::_id_65E3("player_dropship_seats_ready");
  var_2 = level._id_5D6C _id_0BBF::_id_796D("right_01");
  level.player._id_E505 = scripts\sp\utility::_id_10639("player_rig", level._id_5D6C.origin);
  level._id_D34D = level.player._id_E505 scripts\sp\anim::_id_1EE5(var_1, "tag_weapon");
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player _meth_84FE();
  level.player playerlinktodelta(level.player._id_E505, "tag_player", 1, 0, 0, 0, 0, 1);
  var_3 = getanimlength(%rogue_infil_plr_exit_seat);
  var_4 = getanimlength(level._id_5D6C scripts\sp\utility::_id_7DC1("infil_scene_c"));

  foreach(var_6 in level._id_10AC8)
  level._id_5D6C thread scripts\sp\maps\rogue\rogue_util::_id_1E94(var_6, "infil_scene_c", undefined, undefined, undefined, undefined, scripts\sp\utility::_id_61C7);

  level._id_5D6C thread scripts\sp\anim::_id_1F2C([level.player._id_E505, level._id_5D6C, var_2], "infil_scene_c");
  level._id_5D6C._id_4D94._id_5A13._id_4348 scripts\engine\utility::delaycall(17, ::notsolid);
  level.player scripts\engine\utility::delaycall(17, ::clearclienttriggeraudiozone, 0.35);
  level._id_D34D show();
  level.player._id_E505 show();
  level.player freezecontrols(0);
  level.player lerpviewangleclamp(1, 0.5, 0.5, 20, 20, 10, 10);
  scripts\engine\utility::delaythread(var_3, ::_id_D030);
  wait(var_4);
}

_id_5E12() {
  wait 0.05;
  var_0 = scripts\engine\utility::play_loopsound_in_space("rogue_dropship_idle", (16489, 37702, -697));
  var_0 linkTo(self);
  scripts\engine\utility::flag_wait("combat_section_active");
  var_0 delete();
}

_id_D030() {
  level.player unlink();
  level.player enableweapons();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player _meth_84FD();
  level.player freezecontrols(0);
  level.player thread scripts\sp\maps\rogue\rogue_util::_id_6ED0();
  level._id_D34D delete();
  level.player._id_E505 delete();
  _id_0E4B::_id_8E0A();
  level.player scripts\sp\utility::_id_F526("normal");
  scripts\engine\utility::delaythread(1, scripts\engine\utility::flag_clear, "player_in_scene");
}

_id_3B76() {
  if(scripts\sp\utility::_id_93A6()) {
    scripts\sp\specialist_MAYBE::_id_F53C(0);
    scripts\sp\specialist_MAYBE::_id_8E06();
  }

  level.player thread scripts\sp\maps\rogue\rogue_util::_id_D0D6();
}

_id_9630() {
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626();
  level._id_5D6C = _id_0BBF::_id_106B8("rogue_dropship");
  level._id_5D6C thread _id_5E12();
  level._id_5D6C._id_1FBB = "dropship";
  level._id_5D6C scripts\sp\anim::_id_F64A();
  level._id_5D6C _id_0BBF::_id_F458();
  scripts\engine\utility::array_call(level._id_10AC8, ::linkto, level._id_5D6C);
  level._id_5D6C _id_0BBF::_id_106BA();
  level._id_5D6C _id_0BBF::_id_F37F("right_01");
  scripts\engine\utility::flag_set("sun_safe_zone");
  var_0 = [1, 0.25, 0.09];
  level._id_111C3.light = 30 * vectorNormalize((var_0[0], var_0[1], var_0[2]));
  setsunlight(level._id_111C3.light[0], level._id_111C3.light[1], level._id_111C3.light[2]);
  thread scripts\sp\maps\rogue\rogue_util::_id_111E7(6.76, 350, 5, -240, 0);
}