/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\rogue\civilians.gsc
***********************************************/

_id_3FE0() {
  scripts\sp\maps\rogue\rogue_util::_id_BC53("civilian_start_player");
  level._id_10AC8 = scripts\sp\maps\rogue\rogue_util::_id_10626("civilian_start", ["Salter"]);

  foreach(var_1 in level._id_10AC8)
  var_1 thread scripts\sp\utility::_id_7226(getnode("enter_civ" + var_1._id_111B7, "targetname"));

  scripts\engine\utility::flag_set("sun_safe_zone");
  scripts\engine\utility::flag_set("interior_quakes");
  scripts\engine\utility::flag_set("depot_finished");
  scripts\engine\utility::flag_set("force_flashlights_on");
  scripts\engine\utility::flag_set("flag_dialogue_pit_done");
}

_id_F0D1() {}

_id_F0CB() {
  scripts\engine\utility::flag_init("flag_cvl_door");
  scripts\engine\utility::flag_init("flag_cvl_start");
  scripts\engine\utility::flag_init("flag_cvl_casual");
  scripts\engine\utility::flag_init("civilian_scene_1_complete");
  scripts\engine\utility::flag_init("civoutpost_omar_nags");
  scripts\engine\utility::flag_init("lee_lever_approach");
  scripts\engine\utility::flag_init("civs_over");
  scripts\engine\utility::flag_init("flag_dialogue_pre_buddy_door");
  scripts\engine\utility::flag_init("lever_setup_complete");
  scripts\engine\utility::flag_init("civs_small_quakes");
}

_id_F0D2() {}

_id_3FDE() {
  if(getdvarint("civ_cam_scripting", 0) == 1)
    _id_3F96();

  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\maps\rogue\rogue_util::_id_12984);
  thread _id_F90F();
  thread _id_57C1();
  _id_F911();
  thread _id_541F();
  scripts\engine\utility::flag_set("flag_lgt_underground_start");
  _id_BCF7();
  setglobalsoundcontext("atmosphere", "helmet", 1);
  scripts\engine\utility::flag_wait("flag_cvl_door");
  scripts\engine\utility::flag_clear("force_flashlights_on");
  scripts\sp\utility::_id_2669("civilian");
  thread _id_5647();
  thread _id_3FBD();
  thread scripts\sp\maps\rogue\rogue_util::_id_9A6C(30, 30, 1, "forever");
  scripts\engine\utility::flag_clear("no_power_sfx");
  _id_3FCC();
  _id_3FD0();
  scripts\engine\utility::flag_set("civs_over");
}

_id_BCF7() {
  foreach(var_1 in level._id_10AC8)
  var_1 thread scripts\sp\utility::_id_7226(getnode("enter_civ" + var_1._id_111B7, "targetname"));
}

_id_541F() {
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_wait("depot_finished");
  scripts\engine\utility::flag_wait("flag_dialogue_pit_done");
  level._id_B33E scripts\sp\utility::_id_10346("asteroid_ksh_theydontknowwer");
  level.player scripts\sp\utility::_id_10350("asteroid_plr_maintaintrigger");
  scripts\engine\utility::flag_set("flag_dialogue_pre_buddy_door");
}

_id_5647() {
  thread _id_1689();
  level endon("buddydoor_player_intro");
  scripts\engine\utility::flag_wait("flag_dialogue_pre_buddy_door");
  level._id_B4F9 scripts\sp\utility::_id_10346("rogue_usf_stackup");
}

_id_3FCC(var_0, var_1) {
  _id_4070();
  _id_F913();
  _id_F912();
  level.doors["civilian_buddydoor"] waittill("buddydoor_pull_complete");
  scripts\engine\utility::delaythread(2.9, scripts\engine\utility::play_sound_in_space, "scn_rogue_civ_door_close", (35008, 45743, 5));
  thread scripts\sp\maps\rogue\rogue_util::remove_navigating_equipment();
  scripts\engine\utility::flag_set("civs_small_quakes");
  _id_CCC9();
}

_id_F913() {
  _id_FA4B();
  level._id_71B0 = scripts\sp\utility::_id_22CD("civ_fnl", 1);
  level._id_71B3 = scripts\sp\utility::_id_22CD("civ_fnl_guard", 1);
}

_id_F912() {
  level._id_3FA7 = scripts\sp\utility::_id_107EA("civ_fnl_owens", 1);
  level._id_3FA0 = scripts\sp\utility::_id_107EA("civ_fnl_jones", 1);
  level._id_3FA0 scripts\sp\utility::_id_51E1("casual");
  level._id_3FA7 scripts\sp\utility::_id_B14F();
  level._id_3FA0 scripts\sp\utility::_id_B14F();
  level._id_71B4 = [level._id_3FA7, level._id_3FA0];
}

_id_F911() {
  level._id_3FC2 = level.doors["civilian_buddydoor"];
  level._id_3FC2._id_9333 = 1;
  level._id_3FC2._id_10247 = 1;
  level._id_3FC2 _id_0B1F::_id_5982(scripts\sp\maps\rogue\rogue_anim::_id_3FC3, scripts\sp\maps\rogue\rogue_anim::_id_3FC5, scripts\sp\maps\rogue\rogue_anim::_id_3FC4);
  level._id_3FC2 _id_0B1F::_id_59EB("scn_europa_bddy_door_open_grab", "scn_rogue_civ_door_open", "scn_europa_bddy_door_open_lp", "scn_europa_bddy_door_shut", "scn_europa_bddy_door_open_finish");
  level._id_3FC2._id_28B6 = "tag_ui_back";
  level._id_3FC2._id_9027 = "tag_ui_back";
  level._id_3FC2 scripts\sp\utility::_id_65E1("flag_cvl_door");
}

_id_1689() {
  var_0 = [level._id_B33B, level._id_B4F9, level._id_B33E];
  level._id_3FC2 thread _id_0B1F::_id_168A(var_0);
  level._id_B33B thread _id_3F93();
}

_id_3F93() {
  level endon("brooks_in_outpost_scene");
  scripts\engine\utility::waitframe();
  var_0 = level._id_3FC2;
  var_0 scripts\sp\utility::_id_65E3(self._id_1FBB + "_at_door");

  if(!var_0 scripts\sp\utility::_id_65DB("player_used_door")) {
    var_1 = spawn("trigger_radius", self.origin, 0, 250, 56);
    var_1 waittill("trigger");
    var_1 delete();
    var_0 notify("stop_loop_" + self._id_1FBB);
    var_0 scripts\sp\anim::_id_1F35(self, "civ_buddy_door_nag");
    var_0 thread _id_0B1F::_id_59DE(self, var_0 _id_0B1F::_id_5997("idle"), 0);
  }
}

_id_BE33() {
  level endon("flag_cvl_start");
  var_0 = 8;
  var_1 = 12;

  for(;;) {
    wait(randomfloatrange(var_0, var_1));
    level._id_B33B scripts\sp\utility::_id_10347("rogue_brk_givemeahand");
    var_0 = var_0 + 3;
    var_1 = var_1 + 3;
  }
}

_id_F910(var_0) {
  wait 3;
  var_1 = spawn("script_origin", (34652, 45924, 45));
  var_1 playSound("rogue_security_bink");
  thread scripts\sp\maps\rogue\rogue_util::_id_75D5("rogue_world_olympus_attack");
  scripts\sp\maps\rogue\rogue_util::_id_F0D0("finale");
  scripts\engine\utility::flag_wait("civilian_scene_1_complete");
  var_1 stopsounds();
  scripts\sp\maps\rogue\rogue_util::_id_75D6();
  var_1 delete();
}

_id_4070() {
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(isDefined(var_2._id_B14F) && var_2._id_B14F)
      var_2 scripts\sp\utility::_id_1101B();

    var_2 delete();
  }
}

_id_CCC9() {
  setmusicstate("mx_080_civilians");
  var_0 = getEnt("civilian_animnode", "targetname");
  scripts\engine\utility::flag_set("flag_cvl_start");
  scripts\engine\utility::array_thread(level._id_71B4, ::_id_8E30);
  var_0 thread _id_CD8A();
  var_0 thread _id_CD3E();
  var_0 thread _id_CCC8();
  level.player notify("depot_cleanup");
  thread scripts\sp\maps\rogue\rogue::_id_E65D();
}

_id_CD8A() {
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\utility::_id_51E1, "casual_gun");
  thread _id_CCBA();
  thread _id_CD61();
  thread _id_CDB7();
}

_id_CCBA() {
  level notify("brooks_in_outpost_scene");
  level._id_3FC2 notify("stop_loop_" + level._id_B33B._id_1FBB);
  scripts\sp\anim::_id_1F35(level._id_B33B, "civ_scene");
  level._id_B33B.goalradius = 32;
  level._id_B33B _meth_82EE(getnode("finale_start_marine1", "targetname"));
}

_id_CD61() {
  scripts\sp\anim::_id_1F35(level._id_B33E, "civ_scene");
  level._id_B33E.goalradius = 32;
  level._id_B33E _meth_82EE(getnode("finale_start_marine2", "targetname"));
}

_id_CDB7() {
  scripts\sp\anim::_id_1F35(level._id_B4F9, "civ_scene_a");
  _id_0E73::main();
  level._id_B4F9 thread scripts\sp\interaction::_id_CD4F("rogue_civoutpost_omar_reaction");
  level._id_B4F9 waittill("interaction_done");
  scripts\sp\anim::_id_1F35(level._id_B4F9, "civ_scene_b");
  scripts\sp\anim::_id_1F0D(level._id_B4F9, "civ_lever_idle");
  thread scripts\sp\anim::_id_1EEA(level._id_B4F9, "civ_lever_idle", "end_idle");
  scripts\engine\utility::flag_set("civoutpost_omar_nags");
}

_id_8E30() {
  var_0 = "j_gun";
  var_1 = self gettagorigin(var_0);
  var_2 = self gettagangles(var_0);
  self._id_86E1 = spawn("script_model", var_1);
  self._id_86E1.angles = var_2;
  self._id_86E1 linkTo(self, var_0, (0, 0, 0), (0, 0, 0));
  scripts\sp\utility::_id_86E4();
  scripts\sp\utility::_id_72EC("iw7_g18", "primary");
}

_id_CD3E() {
  thread _id_CDB9();
  thread _id_CD6F();
}

_id_CDB9() {
  scripts\sp\anim::_id_1F35(level._id_3FA7, "civ_scene");
  level._id_3FA7 thread scripts\sp\anim::_id_1EEA(level._id_3FA7, "owens_idle");
}

_id_CD6F() {
  scripts\sp\anim::_id_1F35(level._id_3FA0, "civ_scene");
  scripts\engine\utility::flag_set("lee_lever_approach");
}

_id_CCC8() {
  foreach(var_1 in level._id_71B3) {
    var_1._id_1FBD = spawnStruct();
    var_1._id_1FBD.origin = self.origin;
    var_1._id_1FBD.angles = self.angles;
    var_1._id_1FBD thread _id_3FBE([var_1]);
  }

  _id_3FBE(level._id_71B0);
}

_id_3FBE(var_0) {
  foreach(var_2 in var_0)
  var_2 thread _id_CEC4("civ_scene", "civ_idle", self, "civ_stop_loop");
}

_id_CEC4(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = self;

  var_2 scripts\sp\anim::_id_1F35(self, var_0);
  var_2 thread scripts\sp\anim::_id_1EEA(self, var_1, var_3);
}

_id_CDFC(var_0) {
  var_1 = getEntArray("model_salter_pipship", "targetname");
  scripts\engine\utility::array_call(var_1, ::show);

  if(!isDefined(level._id_13E12))
    scripts\sp\maps\rogue\rogue_util::_id_10626(undefined, ["Omar", "Kashima", "Brooks"]);

  level.player scripts\sp\utility::_id_D090("ges_radio");
  level.player scripts\engine\utility::delaycall(0.5, ::playsound, "ges_plr_radio_on");
  level.player allowsprint(0);
  var_1[0] thread scripts\sp\anim::_id_1F35(level._id_13E12, "salter_civ_pip");
  level waittill("pip_closed");
  level.player playSound("ges_plr_radio_off");
  level.player scripts\sp\utility::_id_1102B();
  level.player allowsprint(1);
  scripts\engine\utility::array_call(var_1, ::delete);

  if(isDefined(level._id_13E12._id_B14F))
    level._id_13E12 scripts\sp\utility::_id_1101B();

  level._id_13E12 delete();
  level.allies["Salter"] = undefined;
}

_id_3FBD() {
  scripts\engine\utility::flag_wait("flag_dialogue_pre_buddy_door");
  wait 1.5;

  while(!isDefined(level._id_3FA7))
    wait 0.05;

  var_0 = level._id_3FA7.origin + (0, 0, 50);
  var_1 = ["rogue_civ2_somethingsoutsi", "rogue_civ1_shhh", "rogue_civ3_dontletthemin", "rogue_civ1_quietstayhidden"];

  foreach(var_3 in var_1) {
    scripts\engine\utility::play_sound_in_space(var_3, var_0);
    wait(randomfloatrange(0.25, 0.45));
  }

  scripts\engine\utility::flag_wait("lee_lever_approach");
  wait 6;
  var_1 = ["rogue_civ1_theyreunsa", "rogue_civ2_howdtheymakei", "rogue_civ3_arewegettingouto", "rogue_civ2_ithinkso", "rogue_civ3_itsonlythemwhere"];

  foreach(var_3 in var_1) {
    var_6 = getsubstr(var_3, 9, 10);
    level._id_71B0[int(var_6)] scripts\sp\utility::_id_10347(var_3);
    wait(randomfloatrange(0.05, 0.15));
  }

  scripts\engine\utility::flag_wait("lever_setup_complete");
  wait 2;
  var_1 = ["rogue_civ2_imnotgoingoutther", "rogue_civ1_hesaidtheyha", "rogue_civ3_butthosemachine", "rogue_civ1_dowhatyouwantimg", "rogue_civ2_whyisthishappe"];

  foreach(var_3 in var_1) {
    var_6 = getsubstr(var_3, 9, 10);
    level._id_71B0[int(var_6)] scripts\sp\utility::_id_10347(var_3);
    wait(randomfloatrange(0.05, 0.15));
  }
}

_id_3FD0() {
  scripts\engine\utility::flag_wait("lee_lever_approach");
  var_0 = getEnt("civilian_animnode", "targetname");
  var_0 thread _id_DB79();
  var_0 thread _id_CD72();
  level waittill("turn_on_civ_button");
  var_0 _id_61F9();
}

_id_DB79() {
  level waittill("turn_on_civ_button");
  level _id_C489();
  self notify("end_idle");
  level._id_B4F9 scripts\sp\utility::_id_51E1("combat");
}

_id_C489() {
  level endon("used_lever");
  var_0 = "asteroid_omr_werereadywheny";
  var_1 = "asteroid_omr_gowithhimcaptai";
  var_2 = var_0;
  wait 5;

  for(;;) {
    while(distance2d(level._id_3FA0.origin, level.player.origin) < 300)
      wait 0.05;

    level._id_B4F9 scripts\sp\utility::_id_10346(var_2);
    var_2 = scripts\engine\utility::ter_op(var_2 == var_0, var_1, var_0);
    wait(randomintrange(18, 27));
  }
}

_id_DB61(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon(var_1);
  wait(var_0);
  var_2 notify("end_idle");
  var_2 scripts\sp\anim::_id_1F35(var_3, var_4);
  var_2 thread scripts\sp\anim::_id_1EEA(var_3, var_5, "end_idle");
  level waittill(var_1);
}

_id_CD72() {
  level endon("used_lever");
  var_0 = level._id_3FA0._id_86E1;
  var_0 unlink();
  var_0 linkTo(level._id_3FA0, "j_wrist_ri");
  scripts\sp\anim::_id_1F17(level._id_3FA0, "civ_lever_approach2");
  scripts\sp\anim::_id_1F35(level._id_3FA0, "civ_lever_approach2");
  thread scripts\sp\anim::_id_1EEA(level._id_3FA0, "civ_lever_idle2", "civ_jones_stop_loop");
  scripts\engine\utility::flag_set("lever_setup_complete");
}

_id_137F4(var_0) {
  while(distance2d(level.player.origin, self.origin) > var_0)
    wait 0.1;
}

_id_61F9() {
  thread _id_876F();
  level._id_6C43 = scripts\engine\utility::getStruct("button_fnl_roof", "targetname");

  if(!isDefined(level._id_6C43))
    level._id_6C43 = getEnt("button_fnl_roof", "targetname");

  level._id_6C43 _id_0E46::_id_48C4(undefined, undefined, &"ROGUE_HANGAR_PROMPT");
  level._id_6C43 waittill("trigger");
  level notify("used_lever");
  scripts\engine\utility::flag_clear("civs_small_quakes");
  self notify("civ_jones_stop_loop");
  scripts\engine\utility::array_thread(level._id_10AC8, scripts\sp\utility::_id_51E1, "combat");

  if(level._id_10CDA != "finale_combat")
    thread scripts\sp\maps\rogue\finale::_id_33B3();

  if(!level.console)
    waitforalltransients();

  _id_CD71();
}

_id_876F() {
  var_0 = [level._id_B4F9, level._id_3FA0, level._id_B33E];

  foreach(var_2 in var_0) {
    var_2 thread scripts\sp\utility::_id_7799(level.player, 2, 0.5);
    var_2 thread scripts\sp\utility::_id_7792(level.player);
  }

  while(!isDefined(level._id_6C43))
    wait 0.1;

  scripts\engine\utility::flag_wait("civs_over");

  foreach(var_2 in var_0)
  var_2 scripts\sp\utility::_id_77B9(0.25);
}

_id_CD71() {
  var_0 = _id_49FE(self, "civ_lever", 0);
  var_1 = getEnt("civ_depot_lever", "targetname");
  var_0 hide();
  scripts\sp\anim::_id_1EC3(var_0, "civ_lever");
  scripts\sp\maps\rogue\rogue_util::_id_DB2E(var_0, 0.5, 25, 25, 25, 25);
  thread scripts\sp\anim::_id_1F35(var_1, "civ_lever");
  scripts\sp\anim::_id_1F35(var_0, "civ_lever");
  scripts\sp\maps\rogue\rogue_util::_id_DAE1(var_0);
  scripts\engine\utility::flag_clear("interior_quakes");
  scripts\engine\utility::flag_set("sun_vision_blend");
  scripts\engine\utility::flag_set("combat_section_active");
}

_id_F90F() {
  var_0 = getEnt("civ_depot_lever", "targetname");
  var_0._id_1FBB = "civ_lever";
  var_1 = getEnt("civilian_animnode", "targetname");
  var_0 scripts\sp\anim::_id_F64A();
  var_1 scripts\sp\anim::_id_1EC3(var_0, "civ_lever");
}

_id_49FE(var_0, var_1, var_2) {
  var_3 = scripts\sp\utility::_id_10639("player_rig");
  var_0 thread scripts\sp\anim::_id_1EC3(var_3, var_1);

  if(!isDefined(var_2))
    var_2 = 1;

  if(var_2)
    var_3 hide();

  return var_3;
}

_id_BCD8(var_0) {
  _id_CF95(var_0, "tag_player", 4, 5, 30);
}

_id_CF95(var_0, var_1, var_2, var_3, var_4) {
  var_5 = _id_AD0F();
  level.player _meth_823C(var_0, var_1, var_2, var_2 * 0.25, var_2 * 0.25);
  wait(var_2);
  level.player playerlinktodelta(var_0, var_1, 0, var_3, var_3, var_3, var_3);
  level.player setviewangleresistance(var_4, var_4, var_4, var_4);
  var_5 delete();
}

_id_AD0F() {
  var_0 = scripts\engine\utility::spawn_tag_origin();
  var_0.origin = level.player.origin;
  var_0.angles = level.player getplayerangles();
  level.player _meth_823B(var_0, "tag_origin");
  scripts\engine\utility::waitframe();
  return var_0;
}

_id_5569() {
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player allowsprint(0);
  level.player _meth_80D1();
  scripts\engine\utility::flag_set("player_in_scene");
}

_id_6229() {
  level.player enableweapons();
  level.player freezecontrols(0);
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowsprint(1);
  level.player _meth_80A1();
  scripts\engine\utility::flag_clear("player_in_scene");
}

_id_FA4B() {
  var_0 = getEnt("civilian_animnode", "targetname");
  scripts\sp\utility::_id_22C9("civ_fnl", ::_id_3F9C, var_0);
}

_id_3F9C(var_0) {
  self endon("death");
  self._id_1FBB = self.script_parameters;

  if(self._id_1FBB == "civ_jones")
    self._id_1FBB = "civ_lee";

  self._id_111B7 = "_" + scripts\sp\utility::string(self.script_parameters);
  self.combat = self.spawner.targetname != "civ_fnl";
  scripts\sp\utility::_id_F415(1);
  scripts\sp\utility::_id_F416(1);
  self.grenadeammo = 0;
  self.dropweapon = 0;
  scripts\sp\utility::_id_86E4();
  self.dontmelee = 1;
  self.goalradius = 32;

  if(!self.combat)
    scripts\sp\utility::_id_51E1("casual");
  else
    scripts\sp\utility::_id_51E1("casual_gun");

  if(self._id_1FBB == "civ_lee")
    var_1 = "lee_stop_loop";
  else if(self.combat)
    var_1 = "combat_stop_loop";

  if(getdvarint("debug_finale_anims"))
    thread scripts\sp\maps\rogue\rogue_util::_id_D8E9(self._id_1FBB);

  self.team = "allies";
}

_id_3FAA(var_0, var_1) {
  self endon("death");
  scripts\engine\utility::flag_wait("flag_cvl_start");
  var_0 scripts\sp\anim::_id_1F35(self, "civ_scene");

  if(isDefined(level._id_EC85[self._id_1FBB]["civ_idle"]))
    var_0 scripts\sp\anim::_id_1EEA(self, "civ_idle", var_1);
}

_id_167A() {
  level._id_71B0 = scripts\sp\utility::array_removedeadvehicles(level._id_71B0);
  level._id_71B3 = scripts\sp\utility::array_removedeadvehicles(level._id_71B3);
  level._id_71B4 = scripts\sp\utility::array_removedeadvehicles(level._id_71B4);
}

_id_57C1() {
  level._id_3FE2 = _id_DC70();
  var_0 = getspawnerarray("civ_fnl");
  var_1 = getspawnerarray("civ_fnl_guard");
  var_2 = scripts\sp\utility::_id_22A2(var_0, var_1);

  foreach(var_4 in var_2) {
    var_4 _id_23D3(level._id_3FE2);
    waittillframeend;
  }
}

_id_DC70() {
  var_0 = ["Geer", "McDonald", "Marvin", "Holmes", "Savage", "Simms", "Valdivia", "Kimmich", "Scuria", "Haun", "Fay", "Paik", "Herrera", "Pan", "Johnson", "Stromvall", "Drown", "Findley"];
  return var_0;
}

_id_23D3(var_0) {
  var_1 = randomintrange(0, var_0.size);
  self._id_EDB8 = var_0[var_1];
  level._id_3FE2 = scripts\sp\utility::array_remove_index(var_0, var_1);
}

_id_3F96() {
  thread scripts\sp\maps\rogue\rogue_util::_id_9A6C(12, 12, 1, "enetered_dorm");
  var_0 = getspawnerarray("civ_cam_spawner");

  foreach(var_2 in var_0) {
    var_2._id_EDB8 = "";
    var_3 = spawnStruct();
    var_3.origin = var_2.origin;
    var_3.angles = var_2.angles;
    var_4 = var_2 scripts\sp\utility::_id_10619(1);
    var_4._id_1FBB = "cam_miner";
    var_3 thread scripts\sp\anim::_id_1EEA(var_4, var_2.animation, "forever");
  }

  level waittill("forever");
}