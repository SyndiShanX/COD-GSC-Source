/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\prisoner\prisoner_hvt_scene.gsc
***********************************************************/

_id_924A() {
  scripts\sp\utility::_id_16EB("hint_open_door", "Press and hold ^3[{+activate}]^7 to open level.church_door", ::_id_9008);
  scripts\sp\utility::_id_16EB("hint_crawl", &"HEIST_GO_FWD", ::_id_8FEC);
  scripts\sp\utility::_id_16EB("hint_crawl_pc", &"HEIST_GO_FWD_PC", ::_id_8FEC);
  scripts\engine\utility::flag_init("hint_open_door");
  scripts\engine\utility::flag_init("flag_hint_crawl");
  scripts\engine\utility::flag_init("flag_missionfail");
  scripts\engine\utility::flag_init("hvt_anim_done");
  scripts\engine\utility::flag_init("flag_punch_prisoner_end");
  scripts\engine\utility::flag_init("pip_gator_done");
  scripts\engine\utility::flag_init("pause_dynamic_dof");
  scripts\engine\utility::flag_init("hvt_kick_to_face");
  scripts\engine\utility::flag_init("hvt_stabs_self");
  setdvarifuninitialized("bink_capture", 0);
  precachemodel("equipment_sp_transponder");
  precacheitem("iw7_gunless");
  level._id_871C = scripts\engine\utility::array_reverse(sortbydistance(getEntArray("atis_guns", "targetname"), (0, -100000, 0)));

  if(level.script == "heist") {
    for(var_0 = 0; var_0 < level._id_871C.size; var_0++) {
      if(var_0 == 0)
        level._id_871C[var_0].angles = level._id_871C[var_0].angles + (0, -90, 0);
      else if(var_0 == 2)
        level._id_871C[var_0].angles = level._id_871C[var_0].angles - (0, 90, 0);

      level._id_871C[var_0] setModel("building_aatis_planetary_defense_gun_large");
      level._id_871C[var_0] scripts\sp\utility::_id_23B7("aatis_gun_" + var_0);
      level._id_871C[var_0] thread scripts\sp\anim::_id_1EC3(level._id_871C[var_0], "aatis_destroy");
    }
  }

  thread _id_8D20();
}

_id_8D20() {
  if(level.script == "heist") {
    if(isDefined(level._id_E6C3)) {
      return;
    }
    while(!isDefined(level._id_9265))
      scripts\engine\utility::waitframe();

    level._id_E6C3 = scripts\sp\utility::_id_10639("rooftop_rubble");
    level._id_E690 = scripts\sp\utility::_id_10639("rooftop_bucket");
    level._id_9265 thread scripts\sp\anim::_id_1EC1([level._id_E6C3, level._id_E690], "mons_rumble");
  }
}

_id_9008() {
  return !scripts\engine\utility::flag("hint_open_door");
}

_id_8FEC() {
  return !scripts\engine\utility::flag("flag_hint_crawl");
}

_id_9243() {
  level endon("churchfall_stab_transponder");

  for(;;) {
    level waittill("churchfall_fade_out");
    scripts\sp\hud_util::_id_6AA3(0.2, "black");
    wait 0.1;
    scripts\sp\hud_util::_id_6A99(0.3);
  }
}

_id_9241() {
  level endon("churchfall_stab_transponder");

  for(;;) {
    level waittill("churchfall_black_out");
    thread _id_C876();
    level.player playRumbleOnEntity("heavy_1s");
    scripts\sp\hud_util::_id_6AA3(0.1, "black");
    wait 0.1;
    scripts\sp\hud_util::_id_6A99(0.2);
  }
}

_id_9244() {
  level waittill("churchfall_fade_out_stab");
  level.player playSound("scn_heist_stab_fade_out_lr");
  thread scripts\sp\hud_util::_id_6AA3(0.5, "black");
  level scripts\engine\utility::delaythread(0.2, scripts\sp\utility::_id_F225, "bloody_body_swap");
  level waittill("churchfall_fade_in_stab");
  level.player playSound("scn_heist_stab_fade_in_lr");
  scripts\sp\hud_util::_id_6A99(0.5);
}

_id_9245() {
  level waittill("churchfall_fade_out_wall");
  level.player playSound("scn_heist_wall_fade_out_lr");
  thread _id_C876();
  thread scripts\sp\hud_util::_id_6AA3(0.9, "black");
  level waittill("churchfall_fade_in_wall");
  level.player playSound("scn_heist_wall_fade_in_lr");
  scripts\sp\hud_util::_id_6A99(2.5);
}

_id_9242() {
  level waittill("churchfall_black_out_kick");
  thread _id_C876();
  level.player playRumbleOnEntity("heavy_1s");
  scripts\engine\utility::flag_set("hvt_kick_to_face");
  scripts\engine\utility::flag_clear("flag_hint_crawl");
  level.player playSound("scn_heist_kick_fade_out_lr");
  scripts\sp\hud_util::_id_6AA3(0.05, "black");
  level waittill("churchfall_fade_in_kick");
  level.player playSound("scn_heist_kick_fade_in_lr");
  scripts\sp\hud_util::_id_6A99(0.9);
}

_id_C863() {
  if(isDefined(level._id_C863)) {
    return;
  }
  level._id_C863 = 1;
  var_0 = scripts\sp\hud_util::_id_48B7("black", 0, level.player);
  var_1 = scripts\sp\hud_util::_id_48B7("vfx_ui_player_pain_overlay", 0, level.player);
  var_1._id_02B4 = 1;
  var_1.enablehudlighting = 1;

  while(!scripts\engine\utility::flag("hvt_kick_to_face")) {
    var_2 = randomfloatrange(0.2, 0.4);
    var_1 fadeovertime(var_2);
    var_1.alpha = randomfloatrange(0.4, 0.7);
    var_0 fadeovertime(0.2);
    var_0.alpha = randomfloatrange(0.2, 0.4);
    wait(var_2);
    level.player playRumbleOnEntity("damage_light");
    var_1 fadeovertime(1.5);
    var_1.alpha = 0.1;
    var_0 fadeovertime(1.5);
    var_0.alpha = 0.1;
    wait(2.0 + randomfloatrange(0, 1.0));
  }

  while(!scripts\engine\utility::flag("hvt_stabs_self")) {
    var_2 = randomfloatrange(0.5, 0.7);
    var_1 fadeovertime(var_2);
    var_1.alpha = randomfloatrange(0.2, 0.3);
    var_0 fadeovertime(var_2);
    var_0.alpha = randomfloatrange(0.2, 0.3);
    wait(var_2);
    level.player playRumbleOnEntity("damage_light");
    var_1 fadeovertime(2.0);
    var_1.alpha = 0;
    var_0 fadeovertime(2.0);
    var_0.alpha = 0;
    wait(2.0 + randomfloatrange(0, 1.0));
  }

  var_1 destroy();
  var_0 destroy();
}

_id_C876(var_0) {
  var_1 = scripts\sp\hud_util::_id_48B7("vfx_ui_player_pain_overlay", 0, level.player);
  var_1._id_02B4 = 1;
  var_1.enablehudlighting = 1;
  var_1 fadeovertime(0.5);
  var_1.alpha = 0.7;
  var_2 = scripts\engine\utility::ter_op(isDefined(var_0), var_0, 1);
  wait(var_2);
  var_1 fadeovertime(1.5);
  var_1.alpha = 0;
  wait 2;
  var_1 destroy();
  thread _id_C863();
}

_id_5F7D(var_0) {
  thread _id_5F7B();
  level waittill("poopypants");
  level endon("stop_dynamic_dof");
  var_1 = 2;
  level._id_B439 = 200;

  if(!isDefined(var_0))
    var_0 = 5;

  for(;;) {
    while(scripts\engine\utility::flag("pause_dynamic_dof"))
      wait 0.05;

    var_2 = anglesToForward(level.player getplayerangles());
    var_3 = level.player getEye() + var_2 * 20;
    var_4 = level.player getEye() + var_2 * 1000;
    var_5 = scripts\common\trace::ray_trace(var_3, var_4, level.player);
    var_6 = distance2d(level.player.origin, var_5["position"]);
    var_7 = scripts\engine\utility::ter_op(var_6 < level._id_B439, var_6, level._id_B439);
    thread _id_0B0A::_id_583F(0, var_0, 2, var_7, var_7 + 500, 2, var_1);
    _id_5F7E(var_1);
  }
}

_id_1017E() {
  level notify("stop_dynamic_dof");
  setblur(0, 2.0);
  _id_0B0A::_id_583D(1);
  scripts\engine\utility::flag_clear("pause_dynamic_dof");
}

_id_5F7E(var_0) {
  level endon("pause_dynamic_dof");
  wait(var_0);
}

_id_5F7B() {
  level endon("stop_dynamic_dof");

  for(;;) {
    var_0 = randomfloatrange(1.0, 2.0);
    setblur(2.5, var_0);
    wait(var_0);
    var_0 = randomfloatrange(1.0, 2.0);
    setblur(0, 1.0);
    wait 2.0;
  }
}

_id_9240() {
  _id_F270();
  level._id_9265 scripts\sp\anim::_id_1EC1([level.player._id_E505], "churchfall_door_open");
  level._id_9266 scripts\sp\anim::_id_1EC1([level._id_9225], "churchfall_door_open");

  if(level.script == "prisoner" || getdvarint("bink_capture") == 1) {
    level.player scripts\sp\utility::_id_F526("relaxed");
    var_0 = scripts\engine\utility::getStruct("church_door_interact", "targetname");
    var_0 _id_0E46::_id_48C4(undefined, (0, 0, 0), &"PRISONER_OPEN", undefined, 10000, 128, 1);
    var_0 waittill("trigger");
    level.player setvelocity((0, 0, 0));
    var_0 _id_0E46::_id_DFE3();
    setmusicstate("mx_427_hvt_scene");
    level.player _meth_82C0("heist_ext_church_rooftop", 1);
    thread church_library_radio_stop();
  }

  _id_D75A();
  _id_6C4C();
  thread _id_9243();
  thread _id_9241();
  thread _id_9244();
  thread _id_9242();
  thread _id_9245();
  level.player _meth_823C(level.player._id_E505, "tag_player", 1.1, 0.3, 0.3);
  wait 1.1;

  if(getdvarint("bink_capture") == 1)
    level.player playerlinktodelta(level.player._id_E505, "tag_player", 1, 0, 0, 0, 0, 1);
  else
    level.player playerlinktodelta(level.player._id_E505, "tag_player", 1, 10, 10, 10, 10, 1);

  level.player _meth_8392(0, 5, 5);
  level.player._id_E505 show();

  if(level.script != "prisoner") {
    thread _id_3F45();
    thread _id_9246();
    level._id_9266 thread scripts\sp\anim::_id_1F35(level._id_9225, "churchfall_door_open");
  }

  if(level.script == "prisoner" && getdvarint("bink_capture") == 0) {
    wait 0.05;
    var_1 = level._id_B8D2 scripts\sp\endmission::_id_7F6B(level.script);
    var_2 = var_1 + 1;

    if(var_1 == level._id_B8D2._id_ABFA.size - 1)
      var_2 = var_1;

    var_3 = scripts\sp\endmission::_id_7F6D(var_2);
    thread scripts\sp\utility::_id_13C3C(var_3);
    scripts\sp\utility::_id_BF95();
  } else
    thread _id_9247();

  level.player waittill("start_crawl");
  level waittill("churchfall_boom_tower");
  thread _id_91F9();
  level._id_9265 waittill("churchfall_door_open");
  level.player notify("stop_crawl");
}

church_library_radio_stop() {
  level notify("stoplibrary_radio");
}

_id_9247() {
  scripts\sp\utility::_id_13705();
  setomnvar("ui_show_bink", 0);
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");

  if(getdvarint("bink_capture") == 1) {
    cinematicingame("heist_screen_riah_laptop");

    while(!iscinematicplaying())
      wait 0.05;

    while(iscinematicplaying())
      wait 0.05;
  }

  cinematicingame("heist_screen_riah_laptop_end");

  while(!iscinematicplaying())
    wait 0.05;

  while(iscinematicplaying())
    wait 0.05;

  stopcinematicingame();
  thread _id_9248();
}

_id_9248() {
  var_0 = getEnt("heist_church_laptop_screen", "targetname");

  if(isDefined(var_0))
    var_0 delete();
}

_id_9246() {
  thread _id_9223();
  thread _id_D757();
  thread _id_9249();

  if(level.script == "heist" && getdvarint("bink_capture") == 0) {
    var_0 = getnotetracktimes(level._id_920F scripts\sp\utility::_id_7DC1("churchfall_door_open"), "punch_heist_start");
    level._id_920F scripts\engine\utility::delaythread(0.05, scripts\sp\anim::_id_1F2A, [level._id_920F], "churchfall_door_open", var_0[0]);
    level notify("punch_heist_start");
  }

  var_1 = scripts\sp\utility::_id_10639("knife");
  level._id_920F attach("tactical_knife_iw7_wm", "TAG_ACCESSORY_RIGHT", 1);
  level._id_9265 scripts\sp\anim::_id_1F35(level._id_920F, "churchfall_door_open");
  level._id_9265 thread scripts\sp\anim::_id_1F35(level._id_920F, "churchfall_death_a");
  level waittill("bloody_body_swap");
  level._id_9265 waittill("churchfall_death_a");
  scripts\engine\utility::flag_set("hvt_stabs_self");
  level._id_920F delete();
  wait 0.05;
  _id_1073C();
  [var_3, var_4, var_5, var_6] = _id_107AC();
  var_1 delete();
  thread _id_5422();
  level._id_9265 thread scripts\sp\anim::_id_1F35(level._id_920F, "churchfall_death_b");
  level._id_9265 thread scripts\sp\anim::_id_1F35(var_3, "churchfall_death_b");
  level._id_9265 thread scripts\sp\anim::_id_1F35(var_4, "churchfall_death_b");
  level._id_9265 thread scripts\sp\anim::_id_1F35(var_5, "churchfall_death_b");
  level._id_9265 thread scripts\sp\anim::_id_1F35(var_6, "churchfall_death_b");
  level._id_9265 thread scripts\sp\anim::_id_1F2C([level._id_E6C3, level._id_E690], "mons_rumble");
  level waittill("churchfall_stab_transponder");
  var_3 delete();
  var_4 show();
  var_5 unlink();
  var_5.origin = level._id_920F gettagorigin("TAG_ACCESSORY_RIGHT");
  var_5.angles = level._id_920F gettagangles("TAG_ACCESSORY_RIGHT");
  level._id_9265 waittill("churchfall_death_b");
  scripts\engine\utility::flag_set("hvt_anim_done");
  setomnvar("ui_hide_hud", 0);
  wait 9.0;
  playFX(scripts\engine\utility::getfx("heist_riah_bloodpool"), (-4552, -14389, 696));
}

_id_107AC() {
  var_0 = spawn("script_model", level._id_920F gettagorigin("TAG_ACCESSORY_RIGHT"));
  var_0 setModel("equipment_sp_transponder");
  var_0._id_1FBB = "transponder";
  var_0 scripts\sp\utility::_id_23B7();
  var_1 = spawn("script_model", level._id_920F gettagorigin("TAG_ACCESSORY_LEFT"));
  var_1 setModel("equipment_sp_transponder_broken");
  var_1._id_1FBB = "transponder_broken";
  var_1 scripts\sp\utility::_id_23B7();
  var_2 = spawn("script_model", level._id_920F gettagorigin("TAG_ACCESSORY_RIGHT"));
  var_2 setModel("tactical_knife_iw7_wm_bloody");
  var_2._id_1FBB = "knife_bloody";
  var_2 scripts\sp\utility::_id_23B7();
  var_3 = getEnt("heist_church_laptop_base", "targetname");
  var_4 = getEnt(var_3.target, "targetname");
  var_4 linkTo(var_3);
  var_3 scripts\sp\utility::_id_23B7("laptop");
  return [var_0, var_1, var_2, var_3];
}

#using_animtree("generic_human");

_id_9249() {
  level waittill("hvt_mayhem_start");
  level._id_920F hidepart("j_head", level._id_920F.headmodel);
  level._id_920F hidepart("j_eyeball_le");
  level._id_920F hidepart("j_eyeball_ri");
  level._id_920F hidepart("j_tongue_1");
  level._id_920F _meth_82A2(%mayhem_pnr_churchfall_hvt_death_a_hvt, 1.0, 0.0, 1.0);
  level waittill("hvt_mayhem_start");
  level._id_920F hidepart("j_head", level._id_920F.headmodel);
  level._id_920F hidepart("j_eyeball_le");
  level._id_920F hidepart("j_eyeball_ri");
  level._id_920F hidepart("j_tongue_1");
  level._id_920F _meth_82A2(%mayhem_pnr_churchfall_hvt_death_b_hvt, 1.0, 0.0, 1.0);
  level waittill("hvt_mayhem_end");
  level._id_920F _meth_82A2(%mayhem_pnr_churchfall_hvt_death_b_hvt, 0.0, 3.0, 1.0);
  level._id_920F clearanim(%mayhem_pnr_churchfall_hvt_death_b_hvt, 0.0);
  level._id_920F showpart("j_head", level._id_920F.headmodel);
  level._id_920F showpart("j_eyeball_le");
  level._id_920F showpart("j_eyeball_ri");
  level._id_920F showpart("j_tongue_1");
}

_id_9223() {
  level waittill("punch_heist_start");
  setsaveddvar("r_dof_hq", 1);
  _id_0B0A::_id_583F(0, 0, 1, 0, 0, 0, 0.1);
  wait 1.5;
  _id_0B0A::_id_583F(10.0, 200, 4.0, 400, 30000, 2.0, 1.0);
  wait 4.5;
  thread _id_0B0A::_id_583F(10.8, 512, 3.9, 0, 0, 0, 0.5);
  level waittill("dof_intro_det");
  thread _id_0B0A::_id_583F(10.8, 512, 3.9, 0, 0, 0, 0.5);
  wait 2.6;
  thread _id_0B0A::_id_583F(10, 20, 6, 1000, 7000, 2.0, 0);
  wait 1.5;
  thread _id_0B0A::_id_583F(0, 0, 0, 1000, 7000, 2.0, 1.5);
  wait 3;
  level waittill("dof_knees_start");
  thread _id_0B0A::_id_583F(0, 0, 0, 1000, 7000, 2.0, 0.55);
  level waittill("dof_stab_transponder");
  wait 18.0;
  _id_0B0A::_id_583D(4.0);
  setsaveddvar("r_dof_hq", 0);
}

_id_59DB() {
  level endon("door_peek_finished");

  while(level._id_5A23["hvr_finale_door"]._id_5A21 < 80)
    scripts\engine\utility::waitframe();
}

_id_F270() {
  level._id_9225 = getEnt("fake_peek_church", "targetname");
  level._id_9225._id_1FBB = "churchfall_door";
  level._id_9225 scripts\sp\utility::_id_23B7();
  level._id_9265 = scripts\engine\utility::getStruct("hvr_finale_anim_origin", "targetname");
  level._id_9266 = level._id_9265 scripts\engine\utility::spawn_tag_origin();
  level._id_9267 = level._id_9265 scripts\engine\utility::spawn_tag_origin();
  level.player._id_E505 = scripts\sp\utility::_id_10639("player_rig", level._id_9265.origin, level._id_9265.angles);
  level.player._id_E505 hide();
}

_id_6C4C() {
  level.player giveweapon("iw7_gunless");
  level.player switchtoweapon("iw7_gunless");
  level.player _meth_84FE();
  level.player setstance("stand");
  level.player givemaxammo(level.player getcurrentweapon());

  if(level.script == "prisoner") {
    level.player disableweapons();
    level.player scripts\engine\utility::allow_weapon_switch(0);
    level.player scripts\engine\utility::allow_offhand_weapons(0);
    level.player disableoffhandprimaryweapons();
    level.player scripts\engine\utility::allow_offhand_secondary_weapons(0);
    level.player scripts\engine\utility::allow_prone(0);
    level.player scripts\engine\utility::allow_crouch(0);
    level.player scripts\engine\utility::allow_sprint(0);
    level.player scripts\engine\utility::allow_jump(0);
    level.player scripts\engine\utility::allow_melee(0);
  }

  _id_1073D();
  level._id_9262 = getdvarfloat("sv_znear", 0);
  setsaveddvar("sv_znear", 0.01);

  if(level.script == "heist" && getdvarint("bink_capture") == 0)
    level.player._id_8D24 = scripts\sp\hud_util::_id_48B7("black", 1);

  level._id_924B = 1;
}

_id_1073D() {
  if(isDefined(level._id_920F)) {
    return;
  }
  var_0 = getEnt("hvt", "targetname");
  var_0._id_EDB8 = "hvt";
  var_0._id_ED1B = 1;
  level._id_920F = var_0 scripts\sp\utility::_id_10619(1);
  level._id_920F._id_1FBB = "hvt";
  level._id_920F scripts\sp\utility::_id_86E4();
  level._id_920F notsolid();
  level._id_920F _meth_839E();
}

_id_1073C() {
  var_0 = getEnt("hvt_bloody", "targetname");
  var_0._id_EDB8 = "hvt";
  var_0._id_ED1B = 1;
  level._id_920F = var_0 scripts\sp\utility::_id_10619(1);
  level._id_920F._id_1FBB = "hvt";
  level._id_920F notsolid();
  level._id_920F _meth_839E();
}

struggle_hint() {
  scripts\engine\utility::flag_set("flag_hint_crawl");

  if(level.player scripts\engine\utility::is_player_gamepad_enabled())
    scripts\sp\utility::_id_56BE("hint_crawl");
  else
    scripts\sp\utility::_id_56BE("hint_crawl_pc");
}

_id_3F45() {
  var_0 = level._id_9267;

  if(level.script == "heist" && getdvarint("bink_capture") == 1 || level.script == "prisoner")
    var_0 scripts\sp\anim::_id_1F35(level.player._id_E505, "churchfall_door_open");
  else {
    scripts\engine\utility::delaythread(4, ::struggle_hint);
    var_0 scripts\sp\anim::_id_1EC1([level.player._id_E505], "churchfall_crawl");
    wait 1.5;
    level.player._id_8D24 fadeovertime(0.75);
    level.player._id_8D24.alpha = 0;
  }

  level.player endon("stop_crawl");
  thread _id_C863();
  level.player notify("start_crawl");
  level.player playSound("pnr_churchfall_hvt_plr_crawl_start");
  var_0 thread scripts\sp\anim::_id_1F35(level.player._id_E505, "churchfall_crawl");
  level waittill("stop");
  var_0 scripts\sp\anim::_id_1F27([level.player._id_E505], "churchfall_crawl", 0);

  while(level.player getnormalizedmovement()[0] <= 0)
    scripts\engine\utility::waitframe();

  scripts\engine\utility::flag_clear("flag_hint_crawl");
  level.player playSound("pnr_churchfall_hvt_plr_crawl_01");
  wait 0.5;
  var_0 scripts\sp\anim::_id_1F27([level.player._id_E505], "churchfall_crawl", 1);
  level waittill("stop");
  struggle_hint();
  var_0 scripts\sp\anim::_id_1F27([level.player._id_E505], "churchfall_crawl", 0);

  while(level.player getnormalizedmovement()[0] <= 0)
    scripts\engine\utility::waitframe();

  scripts\engine\utility::flag_clear("flag_hint_crawl");
  level.player playSound("pnr_churchfall_hvt_plr_crawl_02");
  wait 0.5;
  var_0 scripts\sp\anim::_id_1F27([level.player._id_E505], "churchfall_crawl", 1);
  level waittill("stop");
  struggle_hint();
  var_0 scripts\sp\anim::_id_1F27([level.player._id_E505], "churchfall_crawl", 0);

  while(level.player getnormalizedmovement()[0] <= 0)
    scripts\engine\utility::waitframe();

  scripts\engine\utility::flag_clear("flag_hint_crawl");
  level.player playSound("pnr_churchfall_hvt_plr_crawl_03");
  wait 0.5;
  var_0 scripts\sp\anim::_id_1F27([level.player._id_E505], "churchfall_crawl", 1);
}

_id_3F51() {
  self endon("trigger");
  level waittill("churchfall_grab_end");
  scripts\sp\utility::_id_10322();
  scripts\engine\utility::flag_set("flag_missionfail");
  scripts\sp\utility::_id_B8D1();
}

_id_5422() {
  wait 5.75;
  scripts\sp\utility::_id_1034D("prisoner_plr_dont");
}

_id_5444() {
  thread scripts\sp\utility::_id_10350("prisoner_plr_fightingwithria");
  wait 5.1;
  scripts\sp\utility::_id_10352("prisoner_ria_fightingwithrey");
}

_id_5442() {
  wait 15;
  level._id_920F scripts\sp\utility::_id_10346("prisoner_ria_laughsyouvegotc");
  level._id_920F scripts\sp\utility::_id_10346("prisoner_ria_comingaftermeal");
  level._id_920F scripts\sp\utility::_id_10346("prisoner_ria_itsalmostashame");
}

_id_100C5(var_0) {
  foreach(var_2 in var_0)
  var_2 show();
}

_id_8E6E(var_0) {
  foreach(var_2 in var_0)
  var_2 hide();
}

_id_8E83(var_0) {
  foreach(var_2 in var_0)
  var_2 hide();

  wait 0.05;

  foreach(var_2 in var_0)
  var_2 show();

  wait 0.05;

  foreach(var_2 in var_0)
  var_2 hide();
}

_id_6F09(var_0) {
  level endon("stop_flicker_city_lights");
  var_1 = randomfloatrange(0.05, 0.4);
  wait(var_1);

  for(;;) {
    foreach(var_3 in var_0)
    var_3 hide();

    wait 0.05;

    foreach(var_3 in var_0)
    var_3 show();

    var_1 = randomfloatrange(0.05, 0.4);
    wait(var_1);
  }
}

_id_D75A() {
  scripts\engine\utility::delaythread(0.0, scripts\engine\utility::exploder, "powersurge1a");
  scripts\engine\utility::delaythread(0.0, scripts\engine\utility::exploder, "powersurge1b");
  scripts\engine\utility::delaythread(0.0, scripts\engine\utility::exploder, "powersurge1c");
  thread _id_D755();
}

_id_91F9() {
  scripts\engine\utility::delaythread(0.0, scripts\engine\utility::exploder, "powersurgeloop1");

  if(scripts\sp\utility::_id_79A6("runvirus").size > 0)
    scripts\engine\utility::delaythread(0.0, scripts\sp\utility::_id_10FEC, "runvirus");

  level notify("stop_flicker_city_lights");
  thread _id_D756();
  _id_D75B();
  wait 0.25;
  level.player playRumbleOnEntity("heavy_2s");
  wait 1.0;
  _id_D754();
}

_id_D756() {
  var_0 = [];

  for(var_1 = 1; var_1 < 15; var_1++) {
    var_2 = "" + var_1;

    if(var_1 < 10)
      var_2 = "0" + var_2;

    var_0[var_0.size] = getEntArray("citylights" + var_2, "targetname");
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    thread _id_100C5(var_0[var_1]);
}

_id_D75B() {
  scripts\engine\utility::delaythread(0.0, scripts\sp\utility::_id_10FEC, "powersurge1c");
  scripts\engine\utility::delaythread(0.3, scripts\sp\utility::_id_10FEC, "powersurge1b");
  scripts\engine\utility::delaythread(0.6, scripts\sp\utility::_id_10FEC, "powersurge1a");
}

_id_D757(var_0) {
  if(!scripts\engine\utility::is_true(var_0))
    level waittill("punch_heist_start");

  scripts\engine\utility::delaythread(0.0, scripts\sp\utility::_id_10FEC, "powersurgeloop1");

  for(var_1 = 0; var_1 < level._id_871C.size; var_1++) {
    if(scripts\engine\utility::is_true(var_0)) {
      scripts\engine\utility::exploder("powersurge" + (3 - var_1) + "_smoulder");
      level._id_871C[var_1] scripts\sp\anim::_id_1EE0(level._id_871C[var_1], "aatis_destroy");
      continue;
    }

    level._id_871C[var_1] thread scripts\sp\anim::_id_1F35(level._id_871C[var_1], "aatis_destroy");
  }
}

_id_D754() {
  var_0 = [];

  for(var_1 = 1; var_1 < 15; var_1++) {
    var_2 = "" + var_1;

    if(var_1 < 10)
      var_2 = "0" + var_2;

    var_0[var_0.size] = getEntArray("citylights" + var_2, "targetname");
  }

  scripts\engine\utility::delaythread(0.0, ::_id_8E83, var_0[0]);
  scripts\engine\utility::delaythread(0.35, ::_id_8E83, var_0[1]);
  scripts\engine\utility::delaythread(0.7, ::_id_8E83, var_0[2]);
  scripts\engine\utility::delaythread(1.2, ::_id_8E83, var_0[3]);
  scripts\engine\utility::delaythread(1.6, ::_id_8E83, var_0[4]);
  scripts\engine\utility::delaythread(1.9, ::_id_8E83, var_0[5]);
  scripts\engine\utility::delaythread(2.3, ::_id_8E6E, var_0[6]);
  scripts\engine\utility::delaythread(2.9, ::_id_8E6E, var_0[7]);
  scripts\engine\utility::delaythread(3.2, ::_id_8E6E, var_0[8]);
  scripts\engine\utility::delaythread(3.6, ::_id_8E6E, var_0[9]);
  scripts\engine\utility::delaythread(4.0, ::_id_8E6E, var_0[10]);
  scripts\engine\utility::delaythread(4.3, ::_id_8E6E, var_0[11]);
  scripts\engine\utility::delaythread(4.7, ::_id_8E6E, var_0[12]);
  scripts\engine\utility::delaythread(5.1, ::_id_8E6E, var_0[13]);
}

_id_D755() {
  var_0 = [];

  for(var_1 = 1; var_1 < 15; var_1++) {
    var_2 = "" + var_1;

    if(var_1 < 10)
      var_2 = "0" + var_2;

    var_0[var_0.size] = getEntArray("citylights" + var_2, "targetname");
  }

  scripts\engine\utility::delaythread(0.0, ::_id_6F09, var_0[0]);
  scripts\engine\utility::delaythread(0.35, ::_id_6F09, var_0[1]);
  scripts\engine\utility::delaythread(0.7, ::_id_6F09, var_0[2]);
  scripts\engine\utility::delaythread(1.2, ::_id_6F09, var_0[3]);
  scripts\engine\utility::delaythread(1.6, ::_id_6F09, var_0[4]);
  scripts\engine\utility::delaythread(1.9, ::_id_6F09, var_0[5]);
  scripts\engine\utility::delaythread(2.3, ::_id_6F09, var_0[6]);
  scripts\engine\utility::delaythread(2.9, ::_id_6F09, var_0[7]);
  scripts\engine\utility::delaythread(3.2, ::_id_6F09, var_0[8]);
  scripts\engine\utility::delaythread(3.6, ::_id_6F09, var_0[9]);
  scripts\engine\utility::delaythread(4.0, ::_id_6F09, var_0[10]);
  scripts\engine\utility::delaythread(4.3, ::_id_6F09, var_0[11]);
  scripts\engine\utility::delaythread(4.7, ::_id_6F09, var_0[12]);
  scripts\engine\utility::delaythread(5.1, ::_id_6F09, var_0[13]);
}

_id_C0C7(var_0) {
  if(isDefined(var_0._id_B14F))
    var_0 scripts\sp\utility::_id_1101B();

  if(!isDefined(var_0._id_EE5F) || !var_0._id_EE5F)
    var_0.forceragdollimmediate = 1;

  var_0 scripts\sp\utility::_id_F2A8(1);
  var_0._id_10265 = 1;
  var_0._id_4E46 = _id_0C60::_id_58CB;
  var_0 scripts\sp\utility::_id_54C6();
}