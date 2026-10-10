/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_9feb66b51ab34e8.gsc
************************************************/

#using script_10bb9f045d0c567a;
#using script_53f4e6352b0b2425;
#using script_73e89fcb51b31802;
#using scripts\anim\dialogue;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_paths;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\door;
#using scripts\sp\hud_util;
#using scripts\sp\maps\sp_jup_silo\sp_jup_silo_lighting;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_rig;
#using scripts\sp\utility;
#using scripts\stealth\threat_sight;
#using scripts\stealth\utility;
#namespace namespace_1542dec1529315d1;

function function_63a5492602bdb505() {
  utility::flag_init("drone_intro");
  utility::flag_init("locate_gate");
  utility::flag_init("gate_spotted");
  utility::flag_init("locate_hill");
  utility::flag_init("hill_spotted");
  utility::flag_init("locate_huts");
  utility::flag_init("boss_spotted");
  utility::flag_init("drone_intro_keycard");
  utility::flag_init("drone_intro_done");
  utility::flag_init("keycard_picked_up");
  utility::flag_init("silo_door_opened");
  utility::flag_init("player_is_underground");
  utility::flag_init("alarm_tripped");
  utility::flag_init("force_autosave");
  utility::flag_init("baseBoss_spotted");
  utility::flag_init("player_in_dialogue");
  utility::flag_init("price_going_dark_linger");
  utility::flag_init("audio_final_expl");
  utility::flag_init("finish_upper_base_spawn");
  precachemodel("green::veh9_mil_lnd_cargo_truck_cover_open_vehphys_sp");
  precachemodel("un_military_backpack_01");
  precachemodel("electronics_keycard_office_01");
  precachemodel("tool_spray_paint_can_01_bottle_black");
  precachemodel("electronics_walkie_talkie_01");
  precachemodel("parts_jup_misc_crowbar");
  precachemodel("offhand2h_wm_tablet_dmz");
  precachemodel("clk_light_plasticcase_red_on");
  precachemodel("clk_light_plasticcase_red");
  precachemodel("electrical_cell_door_button_green");
  precachemodel("electrical_cell_door_button_red");
  precachemodel("vb_c_jup_sp_hero_price_desert");
  precache_drone();
  level.var_a267818b73bf19f2 = utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  level.var_a267818b73bf19f2.team = "allies";
  level.var_a267818b73bf19f2.name = "Farah";
  level.var_a267818b73bf19f2.animname = "partner";
  level.var_c624b90069b9ab7c = utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  level.var_c624b90069b9ab7c.team = "axis";
  level.var_c624b90069b9ab7c.name = "Konni Soldier";
  level.var_c624b90069b9ab7c.animname = "enemy";
  level.var_cb719db520fa8b8b = spawnStruct();
  level.var_cb719db520fa8b8b.org = utility::spawn_script_origin((2841, 1742, 764), (0, 0, 0));
  level.var_cb719db520fa8b8b.set = 0;
  level.var_cb719db520fa8b8b.active = 0;
  level.var_cb719db520fa8b8b.num = 0;
  level.var_7a780c92ddac13e6 = spawnStruct();
  level.var_7a780c92ddac13e6.num = 0;
  level.var_7a780c92ddac13e6.cooldown = gettime();
  level.var_7a780c92ddac13e6.aliases = [];
  level.var_7a780c92ddac13e6.aliases[0] = "dx_sp_jslo_inex_pric_minusone";
  level.var_7a780c92ddac13e6.aliases[1] = "dx_sp_jslo_inex_pric_thatsonemore";
  level.var_7a780c92ddac13e6.aliases[2] = "dx_sp_jslo_inex_pric_anotheronedown";
  level.var_7a780c92ddac13e6.aliases[3] = "dx_sp_jslo_inex_pric_heneversawitcoming";
  level.var_7a780c92ddac13e6.aliases[4] = "dx_sp_jslo_inex_pric_anotheronedown";
  level.var_7a780c92ddac13e6.var_2c8dc88ff5bb5ee5 = "dx_sp_jslo_inex_fara_youremakingthisseeme";
  level.alarm = 0;
  level.var_9a051d6e6fe05708 = [];
  level.var_6ac31ccf4184eb5e = [];
  level.var_1b1490e6f931ecd6 = [];
  level.reinforcements = [];
  level.var_51729ce379271e4 = [];
  level.var_937981019a8768f6 = [];
  level.var_bae0e0b3c3ce64a3 = 1;
  level.foliagecontent = trace::function_416688b9ffe933c4();
  struct = utility::getStruct("upper_base_keycard_struct", "targetname");
  level.var_db651727864d30d6 = utility::spawn_tag_origin(struct.origin, struct.angles);
  level.var_db651727864d30d6.string = &"SP_JUP_SILO/UI_MOUND";
  level.var_db651727864d30d6.priority = 1;
  struct = utility::getStruct("gate", "script_noteworthy");
  level.var_8f56f1cccef39846 = utility::spawn_tag_origin(struct.origin, struct.angles);
  level.var_8f56f1cccef39846.string = &"SP_JUP_SILO/UI_GATE";
  level.var_8f56f1cccef39846.priority = 1;
  struct = utility::getStruct("obj_final", "script_noteworthy");
  level.var_f6d78c5bef7a368b = utility::spawn_tag_origin(struct.origin, struct.angles);
  level.var_f6d78c5bef7a368b.string = &"SP_JUP_SILO/UI_FINAL";
  level.var_f6d78c5bef7a368b.priority = 1;
  struct1 = utility::getStruct("obj_comm_1", "script_noteworthy");
  struct2 = utility::getStruct("obj_comm_2", "script_noteworthy");
  struct3 = utility::getStruct("obj_comm_3", "script_noteworthy");
  level.objstruct = [];
  level.objstruct["obj_comm_1"] = utility::spawn_tag_origin(struct1.origin, struct1.angles);
  level.objstruct["obj_comm_1"].string = &"SP_JUP_SILO/UI_POI";
  level.objstruct["obj_comm_1"].priority = 1;
  level.objstruct["obj_comm_2"] = utility::spawn_tag_origin(struct2.origin, struct2.angles);
  level.objstruct["obj_comm_2"].string = &"SP_JUP_SILO/UI_POI";
  level.objstruct["obj_comm_2"].priority = 2;
  level.objstruct["obj_comm_3"] = utility::spawn_tag_origin(struct3.origin, struct3.angles);
  level.objstruct["obj_comm_3"].string = &"SP_JUP_SILO/UI_POI";
  level.objstruct["obj_comm_3"].priority = 3;
  utility::trigger_off("final_fight_stairs", "targetname");
  utility::trigger_off("second_floor_stairs_trigger", "script_noteworthy");
  utility::trigger_off("silo_hatch_kill_trigger", "script_noteworthy");
  level.objnum = 0;
  level.var_ada33822cf257bec = getEnt("silo_hatch_01", "targetname");
  level.var_ada33822cf257bec assign_animtree("silo_hatch");
  level.var_ada33822cf257bec notsolid();
  clip = getEnt("silo_door_clip", "targetname");
  clip linkTo(level.var_ada33822cf257bec, "j_lid");
  level.var_f26e6e3645b55820 = getEnt("silo_hatch_lever", "targetname");
  level.var_f26e6e3645b55820 assign_animtree("silo_lever");
}

function cinematic_mode(bool, disablehud, var_e986b0b7b7717ea7) {
  registered = "igc";

  if(bool) {
    level.player player::remove_damage_effects_instantly();
    level context_melee_enable(0);
    level.player setstance("stand", 1, 1, 1);
    level.player val::set(registered, "freezecontrols", 1);
    level.player val::set(registered, "cinematic_motion", 0);
    level.player val::set(registered, "weapon", 0);
    level.player val::set(registered, "damage", 0);
    level.player val::set(registered, "breath_system", 0);
    setDvar(@ "hash_c815d5683eea5b67", 1);
    setomnvar("ui_hide_weapon_info", 1);
    level.player notifyonplayercommandremove("actionslot4", "+actionslot 4");

    if(istrue(disablehud)) {
      level.player val::set(registered, "show_hud", 0);
    }

    level.player cleardamageindicators();
    anim_sp::letterbox_enable(1, 0);
    level.player hideviewmodel();
    level.player setcinematicmotionoverride("disabled");
    level.player player::focusdisable();
    return;
  }

  level context_melee_enable(1);
  setDvar(@ "hash_c815d5683eea5b67", 0);
  setomnvar("ui_hide_weapon_info", 0);
  level.player notifyonplayercommand("actionslot4", "+actionslot 4");
  level.player val::reset_all(registered);

  if(!isDefined(var_e986b0b7b7717ea7)) {
    anim_sp::letterbox_enable(0, 0);
  }

  level.player showviewmodel();
  level.player clearcinematicmotionoverride();
  level.player player::focusenable();
}

function function_26177122c2752196() {
  level hud_util::fade_out(0, "black");
  animnode = utility::getStruct("intro_animnode", "targetname");
  utility::flag_set("intro_playing");
  thread cinematic_mode(1, 1);
  function_ba9124f49b35a414(animnode);
  function_470b94a83eee8821(animnode);
  thread cinematic_mode(0);
  utility::flag_clear("intro_playing");
  utility::flag_clear("intro_skipped");
}

function function_ba9124f49b35a414(animnode) {
  level endon("intro_skipped");
  level.player hideviewmodel();
  level.fakedrone = utility::spawn_anim_model("intro_drone");
  level.var_382f3cb167130d89 = snd::snd_play("scn_jup_silo_intro_drone_flyby", level.player);
  function_e1e514f78b9c9356();
  level thread hud_util::fade_in(0.05, "black");
  childthread function_e088202aea92dda0();
  childthread function_b08b8b316854ad16();
  thread function_172723a00a2e2cb0();
  animnode animation::anim_single_solo(level.fakedrone, "infil_1");
  utility::userskip_stop();
}

function function_e1e514f78b9c9356() {
  var_e86b24000c0faedb = utility::getStruct("drone_view_1_animnode", "targetname");
  var_e86b25000c0fb10e = utility::getStruct("drone_view_2_animnode", "targetname");
  level.var_12238bb4afdda48e = [];
  level.var_4344fdb3e003d8a8 = spawn_anim_model("drone_truck");
  level.var_4344fdb3e003d8a8.animnode = var_e86b24000c0faedb;
  var_e86b24000c0faedb anim_first_frame_solo(level.var_4344fdb3e003d8a8, "drone_view_1");

  for(i = 1; i <= 6; i++) {
    ai = utility::spawn_targetname("reinforcement_spawner");
    ai.animname = "drone_guy_" + i;
    ai.animnode = var_e86b24000c0faedb;

    if(i >= 5) {
      ai.animnode = var_e86b25000c0fb10e;
    }

    ai.animnode anim_first_frame_solo(ai, "drone_view_1");
    level.var_12238bb4afdda48e[level.var_12238bb4afdda48e.size] = ai;
    waitframe();
  }
}

function function_e088202aea92dda0() {
  level notify("infil_1_started");
}

function function_470b94a83eee8821(animnode) {
  if(isDefined(level.fakeplayer)) {
    level.fakeplayer delete();
  }

  if(isDefined(level.fakedrone)) {
    level.fakedrone delete();
  }
}

function function_172723a00a2e2cb0() {
  wait 0.1;
  userskipped = utility::userskip_wait();

  if(!userskipped) {
    return;
  }

  flag_set("intro_skipped");
  level notify("intro_skipped");
  utility::userskip_stop();
  level hud_util::fade_out(0, "black");
  level.player stopxcam();
  level.fakedrone utility::anim_stopanimScripted();
  level thread hud_util::fade_in(0.05, "black");
  level.player dialogue::stop_dialogue();
  level.player stopsounds();
  level.var_a267818b73bf19f2 dialogue::stop_dialogue();
  level.var_a267818b73bf19f2 stopsounds();
  snd::snd_stop(level.var_382f3cb167130d89, 0.1);
}

function function_b08b8b316854ad16() {
  level notify("new_key_vo");
  level endon("new_key_vo");
  level endon("intro_skipped");
  wait 0.2;
  thread drone_music();
  level.player dialogue::say_team("dx_sp_jslo_indr_pric_allstationsbravo6ont");
  wait 0.3;
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_indr_fara_kiloset");
  wait 0.4;
  level.player dialogue::say_team("dx_sp_jslo_indr_gazz_copyyourdronesonstat");
}

function drone_music() {
  setmusicstate("mx_silo_drone");
}

function function_62b4751385efd14b() {
  thread namespace_318af18595992d06::function_4b119908bdf12329(undefined, 0.1, 3.5);
  utility::flag_set("drone_intro");
  function_c72954d5fa42e79(1);
  function_e02cc5b67169a004();
  function_c72954d5fa42e79(0);
  function_549595a730a5d6c4(1);
  thread function_1bddde5888c520df();
  function_18032efc5002f412();
  utility::flag_set("locate_mound");
  utility::flag_set("hill_spotted");
  utility::flag_set("locate_huts");
  utility::flag_set("boss_spotted");
  thread function_549595a730a5d6c4(0);
  function_c72954d5fa42e79(1);
  function_e02cc5b67169a004();
  function_c72954d5fa42e79(0);
  delaythread(2, &utility::flag_clear, "drone_intro");
}

function function_549595a730a5d6c4(bool) {
  truck = getEnt("hide_intro_trucks", "targetname");
  array = truck get_linked_ents();

  if(istrue(bool)) {
    foreach(g in array) {
      g hide();
    }

    level.var_4344fdb3e003d8a8 thread function_533b6216897df4b1(0);

    foreach(guy in level.var_12238bb4afdda48e) {
      guy thread function_533b6216897df4b1(1);
    }

    waitframe();
    return;
  }

  level notify("stop_drone_view_anims");
  waitframe();

  foreach(guy in level.var_12238bb4afdda48e) {
    if(isDefined(guy) && isalive(guy)) {
      guy delete();
    }
  }

  if(isDefined(level.var_4344fdb3e003d8a8)) {
    level.var_4344fdb3e003d8a8 delete();
  }

  foreach(g in array) {
    g show();
  }

  utility::flag_set("finish_upper_base_spawn");
  level.var_4344fdb3e003d8a8 = undefined;
  level.var_12238bb4afdda48e = undefined;
}

function function_533b6216897df4b1(var_e95b708b21251612) {
  level endon("stop_drone_view_anims");
  self endon("death");
  self.animnode animation::anim_single_solo(self, "drone_view_1");

  if(istrue(var_e95b708b21251612)) {
    struct = utility::getStruct(self.animname + "_struct", "targetname");

    if(isDefined(struct)) {
      self.goalradius = 64;
      self setgoalpos(struct.origin);
    } else {
      self.goalradius = 64;
      self setgoalpos(self.origin);
    }

    return;
  }

  self.animnode anim_last_frame_solo(self, "drone_view_1");
}

function function_1bddde5888c520df() {
  level endon("stop_intro_skipped");
  level waittill("drone_activated");
  waitframe();
  level.player dialogue::stop_dialogue();
  level.var_a267818b73bf19f2 dialogue::stop_dialogue();
}

function function_18032efc5002f412() {
  level notify("new_key_vo");
  level endon("new_key_vo");
  level endon("drone_activated");
  wait 1;
  level.player dialogue::stop_dialogue();
  level.var_a267818b73bf19f2 dialogue::stop_dialogue();
  level.player dialogue::say_team("dx_sp_jslo_indr_pric_affirm");
  wait 1.4;
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_indr_gazz_lottarussianskonnisb");
  wait 2.3;
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_indr_ghos_nomissilesinsight");
  wait 0.6;
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_indr_soap_theyreinthebunkersth");
  wait 1.6;
  utility::flag_set("locate_mound");
  utility::flag_set("hill_spotted");
  level.var_db651727864d30d6 mark_location(1);
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_indr_fara_iseeanentrypointmark");
  wait 0.5;
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_indr_fara_youllneedakeycardtog");
  utility::flag_set("drone_intro_keycard");
  wait 1.4;
  level.player dialogue::say_team("dx_sp_jslo_indr_soap_farahsrightwetookdow");
  wait 0.7;
  level.player dialogue::say_team("dx_sp_jslo_indr_pric_rogerredberet");
  wait 1;
  utility::flag_set("locate_huts");
  array = ["obj_comm_1", "obj_comm_2", "obj_comm_3"];

  foreach(eflag in array) {
    if(!utility::flag(eflag)) {
      level.objstruct[eflag] mark_location(i + 1);
    }
  }

  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_indr_fara_ispottedonenearthest");
  wait 1.2;
  level.player dialogue::say_team("dx_sp_jslo_indr_pric_redberetthatsmytarge");
  wait 0.8;
  utility::flag_set("boss_spotted");
  aliases = [];
  aliases[aliases.size] = "dx_sp_jslo_indr_fara_youcancheckthedronef";
  aliases[aliases.size] = "dx_sp_jslo_indr_fara_dronesnotgoinganywhe";
  aliases[aliases.size] = "dx_sp_jslo_indr_fara_youneedtomovecaptain";
  aliases[aliases.size] = "dx_sp_jslo_indr_fara_timetogetstarted";
  aliases[aliases.size] = "dx_sp_jslo_indr_fara_wehavetokickthismiss";
  level.var_a267818b73bf19f2 childthread nagtill("drone_activated", aliases, 15, 13);
  utility::flag_set("drone_intro_done");
  level notify("stop_intro_skipped");
  display_hint_forced("exit_drone");
  level waittill("drone_activated");
}

function function_572fc8cecff2d089(struct, cosnum) {
  if(within_fov(level.player.origin, level.player getplayerangles(), struct.origin, cosnum)) {
    timemax = gettime() + 500;

    while(true) {
      waitframe();

      if(!within_fov(level.player.origin, level.player getplayerangles(), struct.origin, cosnum)) {
        return false;
      }

      if(gettime() >= timemax) {
        return true;
      }
    }
  }

  return false;
}

function function_cba81cd7e4b0a947() {
  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_intro_igc_price", 3.5, 3.5);
  level hud_util::fade_out(0, "black");
  animnode = utility::getStruct("intro_animnode", "targetname");
  utility::flag_set("intro_playing");
  thread cinematic_mode(1, 0);
  function_d089a943c47f472b(animnode);
  function_286ed947c5778970(animnode);
  thread cinematic_mode(0);
  utility::flag_clear("intro_playing");
  level.player clearsoundsubmix("iw8_remove_plr_weap_foley", 0);
}

function function_d089a943c47f472b(animnode) {
  level endon("intro_skipped");
  fakeplayer = utility::spawn_targetname("fakePlayer");
  fakeplayer attach("offhand2h_tablet_static_v0_silo", "tag_accessory_left");
  thread silo_lighting::function_4dfe4cb7805442c3();
  thread function_1109eeeeb66916ad();
  anime = "infil_2";
  animnode animation::anim_first_frame_solo(fakeplayer, anime);
  level.player dontinterpolate();
  rig = animnode player_rig::link_player_to_rig(anime, "stand", 0, undefined, 1);
  level thread hud_util::fade_in(0.05, "black");
  childthread function_51f345549aaa0fbc();
  thread function_b3612eb4b7621965(fakeplayer);
  thread function_38c08175d7dae0ef(animnode, [rig, fakeplayer]);
  animnode animation::anim_single([rig, fakeplayer], anime);
  utility::userskip_stop();
}

function function_1109eeeeb66916ad() {
  setsaveddvar(@ "hash_d3ee5a6578fe61de", "0");
  setsaveddvar(@ "hash_b9ff37d084074df3", "1");
  level waittill("infil_2_started");
  cinematicingame("jup_sp_silo_dronetablet");
  level waittill("intro_playing");
  stopcinematicingame();
}

function function_51f345549aaa0fbc() {
  level notify("new_key_vo");
  level endon("new_key_vo");
  level.player dialogue::stop_dialogue();
  level.var_a267818b73bf19f2 dialogue::stop_dialogue();
  wait 0.76;

  if(utility::flag("drone_intro_done")) {
    level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_indr_fara_findthecaptainthereg");
    return;
  }

  if(utility::flag("drone_intro_keycard")) {
    level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_indr_fara_theircaptainwillhave");
    return;
  }

  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_indr_fara_konnimissilesareinth");
}

function function_b3612eb4b7621965(fakeplayer) {
  level notify("infil_2_started");
  level endon("intro_skipped");
  thread function_f4b1d3388a90f2bd();
  level.player enablephysicaldepthoffieldscripting();
  wait 2;
  level.player dof_enable(4, 30);
  wait 2;
  level.player dof_enable_autofocus(2.8, level.fakeplayer, 10, 10);
  wait 7.5;
  level.player dof_enable(4, 300);
  level waittill("intro_playing");
  level.player dof_disable();
  level.player dof_disable_autofocus();
}

function function_f4b1d3388a90f2bd() {
  stopmusicstate("mx_silo_drone");
}

function function_286ed947c5778970(animnode) {
  level notify("price_intro_done");
  level.player dof_disable();
  level.player dof_disable_autofocus();

  if(flag("intro_skipped")) {
    level.player_rig waittillmatch("single anim", "end");
  }

  animnode thread player_rig::unlink_player_from_rig();

  if(isDefined(level.fakeplayer)) {
    level.fakeplayer delete();
  }
}

function function_38c08175d7dae0ef(animnode, guys) {
  wait 0.1;
  userskipped = utility::userskip_wait();

  if(!userskipped) {
    return;
  }

  flag_set("intro_skipped");
  level notify("intro_skipped");
  utility::userskip_stop();
  level hud_util::fade_out(0, "black");

  foreach(guy in guys) {
    animation = guy getanim("infil_2");
    guy setanimtime(animation, 0.88);
  }

  level thread hud_util::fade_in(0.05, "black");
  silo_lighting::function_4b65276da49e2658();
  level.player dialogue::stop_dialogue();
  level.player stopsounds();
  level.var_a267818b73bf19f2 dialogue::stop_dialogue();
  level.var_a267818b73bf19f2 stopsounds();
  anim_sp::letterbox_enable(0, 0);
}

function function_e1ffc56a9d16f161(var_c97122624ed197dd, var_f656bbe1f46ea526) {
  if(var_c97122624ed197dd) {
    array_spawn_targetname("stealth_fields_1", 1);
    array_spawn_targetname("stealth_fields_2", 1);
    array_spawn_targetname("stealth_fields_3", 1);
    array_spawn_targetname("stealth_fields_4", 1);
  }

  if(var_f656bbe1f46ea526) {
    array_spawn_targetname("upper_base_main", 1);
    array_spawn_targetname("upper_base_door", 1);
    array_spawn_targetname("upper_base_entry_1", 1);
    array_spawn_targetname("upper_base_alarm_enemy", 1);
    array_spawn_targetname("upper_base_security_enemy", 1);
    spawn_targetname("upper_base_boss", 1);
    spawn_targetname("upper_base_sniper", 1);
    thread function_50e77e91a11b024d();
  }
}

function function_50e77e91a11b024d() {
  utility::flag_wait("finish_upper_base_spawn");
  array_spawn_targetname("upper_base_gate", 1);
  spawn_targetname("upper_base_heavy", 1);
}

function function_b78f945ee84591f1(targetname, nodename) {
  level endon("stop_current_truck");
  node = getvehiclenode(nodename, "targetname");
  nodes = function_d556ef26b54e31ac(node);
  spawner = utility::getvehiclespawner(targetname, "targetname");
  truck = spawner utility::spawn_vehicle();
  truck endon("death");
  truck vehicle_turnengineoff();
  truck thread truck_setup();
  truck thread driver_watcher();
  truck childthread function_c4949dfad5a6fc3e();
  truck function_b61f675503083701();
  truck function_32b8c2252d5ec952(node, 20, 1);
  truck function_77320e794d35465a("path", "radiusToStep", 400);
  truck function_77320e794d35465a("p2p", "goalThreshold", 200);
  truck thread function_2a7ee806890043e2();
  truck thread function_448327211a86cf3e();
  distmax = squared(1000);
  node = getvehiclenode("truck_path_final_node", "targetname");
  origin = node.origin;

  while(true) {
    waitframe();
    dist = distancesquared(truck.origin, origin);

    if(dist <= distmax) {
      break;
    }
  }

  truck function_1399c3c8b823ef08(0);
  truck function_77320e794d35465a("p2p", "brake", 0.2);
  wait 6;
  truck function_77320e794d35465a(function_906e53c2fb9d3f9c("path", "pause"), 1);
  waitframe();
  truck function_65aa053c077c003a(1);
  truck playLoopSound("scn_jup_silo_intro_truck_grnd_idle_lp");
  level notify("sfx_truck_at_gate");
  wait 0.3;
  utility::flag_wait("gate_driver_moveup");
  truck function_77320e794d35465a("path", "radiusToStep", 400);
  truck function_77320e794d35465a("p2p", "goalThreshold", 50);
  truck function_77320e794d35465a(function_906e53c2fb9d3f9c("path", "pause"), 0);
  waitframe();
  truck function_65aa053c077c003a(0);
  truck function_77320e794d35465a("p2p", "brake", 0);
  node = getvehiclenode("truck_path_gate", "targetname");
  nodes = function_d556ef26b54e31ac(node);
  truck function_32b8c2252d5ec952(node, 8, 0);
  truck function_77320e794d35465a("path", "radiusToStep", 150);
  truck function_77320e794d35465a("p2p", "goalThreshold", 20);
  wait 0.1;
  truck waittill("reached_end_node");
  truck function_1399c3c8b823ef08(0);
  truck function_77320e794d35465a("p2p", "brake", 0.8);

  while(truck vehicle_getspeed() > 1) {
    waitframe();
  }

  truck function_77320e794d35465a(function_906e53c2fb9d3f9c("path", "pause"), 1);
  waitframe();
  truck function_65aa053c077c003a(1);
  truck thread function_11449aa39e92d401();
  truck vehicle::vehicle_unload();
  level utility::notify_delay("truck_driver_unloaded", 3);
}

function truck_setup() {
  clip = getEnt("intro_truck_clip", "targetname");
  var_f9854eea8aed3a67 = getEnt("intro_truck_box_01", "targetname");
  var_f9854fea8aed3c9a = getEnt("intro_truck_box_02", "targetname");
  var_f98550ea8aed3ecd = getEnt("intro_truck_box_03", "targetname");
  clip linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_f9854eea8aed3a67 linkTo(self, "tag_origin", (-20, -18, 10), (0, 0, 0));
  var_f9854fea8aed3c9a linkTo(self, "tag_origin", (-70, 18, 10), (0, 0, 0));
  var_f98550ea8aed3ecd linkTo(self, "tag_origin", (-120, -10, 10), (0, 0, 0));
  self waittill("death");

  if(isDefined(clip)) {
    clip delete();
  }

  if(isDefined(var_f9854eea8aed3a67)) {
    var_f9854eea8aed3a67 delete();
  }

  if(isDefined(var_f9854fea8aed3c9a)) {
    var_f9854fea8aed3c9a delete();
  }

  if(isDefined(var_f98550ea8aed3ecd)) {
    var_f98550ea8aed3ecd delete();
  }
}

function driver_watcher() {
  level endon("truck_driver_unloaded");
  self endon("death");
  level waittill("truck_driver_stopped", reason);
  level notify("stop_current_truck");
  wait 0.1;
  function_1399c3c8b823ef08(0);
  self function_77320e794d35465a("p2p", "brake", 0.8);

  while(self vehicle_getspeed() > 1) {
    waitframe();
  }

  self function_77320e794d35465a(function_906e53c2fb9d3f9c("path", "pause"), 1);
  waitframe();
  self function_65aa053c077c003a(1);

  if(utility::is_equal(reason, "unload")) {
    vehicle::vehicle_unload();
    thread function_11449aa39e92d401();
  }
}

function function_c4949dfad5a6fc3e() {
  level endon("truck_driver_unloaded");

  while(!isDefined(level.var_a6670846479f0f87)) {
    waitframe();
  }

  level.var_a6670846479f0f87 endon("death");

  while(true) {
    waitframe();
    self waittill("damage", dmg, attacker);

    if(isDefined(attacker) && isPlayer(attacker)) {
      break;
    }
  }

  level notify("truck_shot_at");
}

function function_d556ef26b54e31ac(var_987218b37ddff50d, using_structs) {
  apathnodes = [];
  estartnode = var_987218b37ddff50d;

  if(!isDefined(var_987218b37ddff50d)) {
    return apathnodes;
  }

  nextnode = var_987218b37ddff50d;

  while(isDefined(nextnode)) {
    apathnodes = array_add(apathnodes, nextnode);

    if(!isDefined(nextnode.target)) {
      break;
    }

    if(istrue(using_structs)) {
      nextnode = getent_or_struct(nextnode.target, "targetname");
    } else {
      nextnode = getvehiclenode(nextnode.target, "targetname");
    }

    if(is_equal(nextnode, var_987218b37ddff50d)) {
      break;
    }
  }

  return apathnodes;
}

function function_b61f675503083701() {
  if(!self hascomponent("p2p")) {
    self addcomponent("p2p");
  }

  if(!self hascomponent("path")) {
    self addcomponent("path");
  }

  if(!self hascomponent("animator")) {
    self addcomponent("animator");
  }

  self function_77320e794d35465a("p2p", "brakeAtGoal", 0);
  self function_77320e794d35465a("p2p", "automaticFast", 1);
  self function_77320e794d35465a("p2p", "brakeOnGoalGasbrake", 1);
  self function_77320e794d35465a("p2p", "goalPoint", self.origin);
  self function_77320e794d35465a("p2p", "goalThreshold", 200);
  self function_77320e794d35465a("p2p", "throttleSpeedThreshold", 0.1);
  self function_77320e794d35465a("p2p", "automaticFastTopspeedFraction", 1);
  self function_77320e794d35465a("p2p", "throttleSpeedFarBelow", 7);
  self function_77320e794d35465a("p2p", "throttleSpeedFarAbove", 7);
  self function_77320e794d35465a("p2p", "throttleSpeedClose", 1);
  self function_77320e794d35465a("p2p", "gasToStopMovement", 1);
  self function_77320e794d35465a("p2p", "steeringMultiplier", 1);
  self function_77320e794d35465a("path", "radiusToStep", 500);
}

function function_32b8c2252d5ec952(node, mph, teleport_vehicle) {
  teleport_vehicle = default_to(teleport_vehicle, 1);

  if(teleport_vehicle) {
    self dontinterpolate();
    self vehicle_teleport(node.origin + (0, 0, 45), node.angles);
  }

  nodeindex = getvehiclenodeindex(node.targetname, "targetname");
  self function_77320e794d35465a("path", "radiantId", nodeindex);
  function_1399c3c8b823ef08(mph);
  self.currentnode = node;
}

function function_1399c3c8b823ef08(mph) {
  mph = default_to(mph, 0);
  var_76401ace2b3f590a = mph_to_ips(mph);
  self function_77320e794d35465a("p2p", "manualSpeed", var_76401ace2b3f590a);
  self.basespeed = var_76401ace2b3f590a;
}

function function_11449aa39e92d401() {
  level endon("sfx_veh_driver_dead");

  if(utility::flag("sfx_veh_driver_dead")) {
    return;
  }

  level notify("sfx_veh_unload");
  delaycall(1, &stoploopsound);
  delaythread(1.3, &play_sound_on_tag, "scn_jup_silo_intro_truck_grnd_door", "tag_door_front_left");
}

function function_2a7ee806890043e2() {
  level endon("sfx_veh_unload");
  self endon("entitydeleted");
  soundorg = spawn("script_origin", self.origin);
  soundorg linkTo(self);
  soundorg playSound("scn_jup_silo_intro_truck_grnd_01");
  level waittill_any_2("stop_current_truck", "sfx_truck_at_gate");
  soundorg delaythread(3, &sound_fade_and_delete, 4);
  utility::flag_wait("gate_driver_moveup");

  if(utility::flag("sfx_veh_driver_dead")) {
    return;
  }

  self stoploopsound();
  var_8f140e0a51f8236c = spawn("script_origin", self.origin);
  var_8f140e0a51f8236c linkTo(self);
  var_8f140e0a51f8236c playSound("scn_jup_silo_intro_truck_grnd_02");
  level waittill("stop_current_truck");
  var_8f140e0a51f8236c sound_fade_and_delete(3);
}

function function_448327211a86cf3e() {
  level endon("sfx_veh_unload");
  level endon("truck_driver_unloaded");
  self endon("entitydeleted");

  while(true) {
    level waittill("truck_driver_stopped", reason);

    if(utility::is_equal(reason, "death")) {
      utility::flag_set("sfx_veh_driver_dead");
      level notify("sfx_veh_driver_dead");
      self playLoopSound("scn_jup_silo_intro_truck_grnd_idle_lp");
      break;
    }
  }

  utility::flag_wait("player_in_elevator");
  self stoploopsound();
}

function function_3fcee29c220f5f88(targetname, msg) {
  level endon(msg);
  struct = utility::getStruct(targetname, "targetname");
  maxdist = squared(2000);
  mindist = squared(1100);
  cosnum = cos(50);

  while(true) {
    waitframe();

    if(utility::flag("drone_in_use")) {
      continue;
    }

    dist = distance2dsquared(struct.origin, level.player.origin);

    if(dist <= mindist) {
      break;
    }

    if(dist <= maxdist) {
      if(utility::within_fov(level.player getEye(), level.player getplayerangles(), struct.origin, cosnum)) {
        break;
      }
    }
  }

  utility::flag_set(msg);
}

function stealth_music() {
  wait 4;
  setmusicstate("mx_silo_stealthmoods");
}

function function_fe8e9f86a6795da() {
  structs = utility::getStructArray("heavily_armored", "targetname");

  foreach(struct in structs) {
    thread function_a91d8cfaefc4351c(struct);
  }
}

function function_a91d8cfaefc4351c(struct) {
  level endon("player_in_base");
  struct endon("callout_played");
  cosnum = cos(2);

  while(true) {
    wait 0.2;

    if(!namespace_5643a6b7e3dcbf23::function_408263f999f41641()) {
      continue;
    }

    if(level.player isads()) {
      playereye = level.player getEye();
      playerangles = level.player getplayerangles();

      if(utility::within_fov(playereye, playerangles, struct.origin, cosnum)) {
        endtime = gettime() + 250;

        while(true) {
          waitframe();

          if(gettime() >= endtime) {
            if(trace::ray_trace_passed(playereye, struct.origin, [level.player])) {
              if(namespace_5643a6b7e3dcbf23::function_408263f999f41641()) {
                namespace_5643a6b7e3dcbf23::function_4e7b3c7c40803a95();
                function_f68f8ecbf81c0012(struct);
                namespace_5643a6b7e3dcbf23::function_596ce1ff779d36a7();
                struct notify("callout_played");
              }
            }

            break;
          }

          playereye = level.player getEye();
          playerangles = level.player getplayerangles();

          if(!utility::within_fov(playereye, playerangles, struct.origin, cosnum)) {
            break;
          }
        }
      }
    }
  }
}

function function_f68f8ecbf81c0012(struct) {
  type = struct.script_noteworthy;

  switch (type) {
    case #"hash_317356ff28764880":
      level.player dialogue::say_team("dx_sp_jslo_inex_pric_sniperuponthetower");
      wait 0.5;
      level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_fara_yourshotyourcall");
      break;
    case #"hash_f72238940f725ac6":
      level.player dialogue::say_team("dx_sp_jslo_inex_pric_nocoverontheright");
      break;
    case #"hash_7f571c0f12b81e72":
      level.player dialogue::say_team("dx_sp_jslo_indr_pric_konnisguardingthemai");
      wait 0.5;
      level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_indr_fara_searchtheperimeterth");
      break;
  }

  wait 1;
}

function function_b491bad79c67c802() {
  level endon("player_in_elevator");
  level endon("silo_door_opened");
  endtime = gettime() + 15000;
  var_6550a20bc1c0831c = 0;

  while(true) {
    waitframe();

    if(utility::flag("drone_in_use")) {
      var_6550a20bc1c0831c = 1;
      break;
    }

    if(gettime() >= endtime) {
      break;
    }
  }

  while(utility::flag("player_in_dialogue")) {
    waitframe();
  }

  if(!var_6550a20bc1c0831c) {
    namespace_5643a6b7e3dcbf23::function_4e7b3c7c40803a95();
    utility::flag_set("drone_hint_active");
    wait 0.2;
    utility::display_hint_forced("use_drone", 10);
    level.var_a267818b73bf19f2 childthread dialogue::say_team("dx_sp_jslo_inex_fara_sixdronesstillupusei");
    delaythread(1.5, &namespace_5643a6b7e3dcbf23::function_596ce1ff779d36a7);
    level waittill_notify_or_timeout("drone_enter", 10);
    utility::flag_clear("drone_hint_active");
  }

  var_95c8924524511164 = 120;
  starttime = gettime();

  for(endtime = starttime + var_95c8924524511164 * 1000; true; endtime = gettime() + var_95c8924524511164 * 1000) {
    wait 1;

    if(utility::flag("drone_in_use")) {
      while(utility::flag("drone_in_use")) {
        wait 0.3;
      }

      endtime = gettime() + var_95c8924524511164 * 1000;
    }

    if(gettime() >= endtime) {
      utility::flag_set("drone_hint_active");
      utility::display_hint_forced("use_drone", 10);
      level waittill_notify_or_timeout("drone_enter", 10);
      utility::flag_clear("drone_hint_active");
      var_95c8924524511164 = 180;
    }
  }
}

function function_74e3be3043e9b813() {
  level endon("player_in_base");
  utility::flag_wait("start_story_beat");

  if(utility::flag("drone_hint_active") || utility::flag("drone_in_use")) {
    while(utility::flag("drone_hint_active") || utility::flag("drone_in_use")) {
      wait 0.1;
    }

    wait 1;
  }

  namespace_5643a6b7e3dcbf23::function_3bb94732214d7da7();
  level notify("new_key_vo");
  level endon("new_key_vo");
  level.player dialogue::say_team("dx_sp_jslo_inex_pric_pushingdownfromthemo");
  wait 0.8;
  utility::display_hint_forced("use_grass", 6);
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_fara_thefieldmayconcealyo");
  wait 0.4;

  if(!function_1e4aaaddfd5236ca()) {
    level.player dialogue::say_team("dx_sp_jslo_inex_pric_rightsilentandviolen");
    wait 0.2;
  }

  namespace_5643a6b7e3dcbf23::function_596ce1ff779d36a7();
}

function function_c6856589af842ac1() {
  level endon("baseBoss_spotted");

  if(utility::flag("baseBoss_spotted")) {
    return;
  }

  utility::flag_wait("player_in_base");

  if(namespace_5643a6b7e3dcbf23::function_1e4aaaddfd5236ca()) {
    while(namespace_5643a6b7e3dcbf23::function_1e4aaaddfd5236ca()) {
      waitframe();
    }

    wait 0.2;
  }

  namespace_5643a6b7e3dcbf23::function_3bb94732214d7da7(0.3);
  level.player dialogue::say_team("dx_sp_jslo_inex_pric_clearedtheperimeter");
  wait 0.3;

  if(utility::flag("drone_intro_keycard")) {
    level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_fara_copyfindthecaptainge");
    wait 1;
  } else {
    level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_indr_fara_theircaptainwillhave");
    wait 0.4;

    if(!namespace_5643a6b7e3dcbf23::function_1e4aaaddfd5236ca()) {
      level.player dialogue::say_team("dx_sp_jslo_indr_pric_rogerredberet");
      wait 0.7;
    }
  }

  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_gazz_beadvisedsoapandghos");
  wait 0.5;

  if(!namespace_5643a6b7e3dcbf23::function_1e4aaaddfd5236ca()) {
    level.player dialogue::say_team("dx_sp_jslo_inex_pric_copywefindthemissile");
    wait 0.3;
    level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_gazz_check");
    wait 0.3;
  }

  namespace_5643a6b7e3dcbf23::function_596ce1ff779d36a7();
}

function function_f2910a2af259ff04() {
  level endon("player_in_elevator");
  var_66810fa4ff7c239c = utility::getStructArray("farah_logo", "script_noteworthy");
  var_668112a4ff7c2a35 = utility::getStructArray("farah_flag", "script_noteworthy");
  structs = array_combine(var_66810fa4ff7c239c, var_668112a4ff7c2a35);
  distmax = squared(450);
  var_f1164c9278998e51 = squared(4000);
  var_586550f0f7336ea7 = squared(3000);
  var_24422b134b0ddab8 = cos(18);
  var_6ba5e5d44318885a = cos(4);
  toofar = 1;
  breakout = 0;

  while(true) {
    wait 0.15;

    if(function_5655f020afb49f1b()) {
      continue;
    }

    playereye = level.player getEye();
    playerangles = level.player getplayerangles();

    foreach(struct in structs) {
      dist = distance2dsquared(level.player.origin, struct.origin);
      ads = level.player isads();
      var_3c9f8e478fbc4051 = var_586550f0f7336ea7;

      if(!utility::flag("start_story_beat")) {
        var_3c9f8e478fbc4051 = var_f1164c9278998e51;
      }

      if(dist <= distmax || istrue(ads) && dist <= var_3c9f8e478fbc4051) {
        cosnum = var_24422b134b0ddab8;

        if(istrue(ads)) {
          cosnum = var_6ba5e5d44318885a;
        }

        if(utility::within_fov(playereye, playerangles, struct.origin, cosnum)) {
          endtime = gettime() + 350;

          while(true) {
            waitframe();

            if(gettime() >= endtime) {
              if(ray_trace_passed(playereye, struct.origin, [level.player])) {
                if(dot_check(struct, level.player, 0.15) && !function_5655f020afb49f1b()) {
                  if(!utility::flag("start_story_beat")) {
                    if(istrue(toofar)) {
                      toofar = 0;
                      thread function_a8d3197311ac00e9();
                    }
                  } else {
                    breakout = 1;
                  }
                }
              }

              break;
            }

            if(istrue(ads) && !level.player isads()) {
              break;
            }

            if(!utility::within_fov(playereye, playerangles, struct.origin, cosnum)) {
              break;
            }
          }
        }
      }
    }

    if(breakout && !function_5655f020afb49f1b()) {
      break;
    }
  }

  if(utility::flag("player_in_base")) {
    thread function_e73f599805a10874();
    return;
  }

  thread function_6b4a6ba22bf3b79b();
}

function function_5655f020afb49f1b() {
  if(utility::flag("drone_in_use")) {
    return true;
  }

  if(!namespace_5643a6b7e3dcbf23::function_408263f999f41641()) {
    return true;
  }

  return false;
}

function dot_check(ent1, ent2, fov) {
  angles = ent1.angles;

  if(!isDefined(angles)) {
    angles = (0, 0, 0);
  }

  normal = vectorNormalize(ent2.origin - ent1.origin);
  forward = anglesToForward(angles);
  dot = vectordot(forward, normal);

  if(dot >= fov) {
    return true;
  }

  return false;
}

function function_a8d3197311ac00e9() {
  namespace_5643a6b7e3dcbf23::function_4e7b3c7c40803a95();
  wait 0.2;
  level.player dialogue::say_team("dx_sp_jslo_inex_pric_farahimseeingulfflag");
  wait 0.5;
  level.player dialogue::say_team("dx_sp_jslo_inex_pric_illgetacloserlook");
  wait 0.2;
  namespace_5643a6b7e3dcbf23::function_596ce1ff779d36a7();
}

function function_6b4a6ba22bf3b79b() {
  namespace_5643a6b7e3dcbf23::function_4e7b3c7c40803a95();
  wait 0.25;
  level.player dialogue::say_team("dx_sp_jslo_inex_pric_6toallstationskonnis");
  wait 0.7;
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_gazz_makarovslaunchingafa");
  wait 0.5;
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_gazz_thosemissilesareamer");
  wait 0.6;
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_fara_hewantstheworldtothi");
  wait 0.6;
  level.player dialogue::say_team("dx_sp_jslo_inex_pric_weneedtofindoutwhatt");
  wait 0.2;
  namespace_5643a6b7e3dcbf23::function_596ce1ff779d36a7();
}

function function_e73f599805a10874() {
  namespace_5643a6b7e3dcbf23::function_4e7b3c7c40803a95();
  wait 0.4;
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_gazz_62toactual");
  wait 0.4;
  level.player dialogue::say_team("dx_sp_jslo_inex_pric_gogaz");
  wait 0.3;
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_gazz_konnisplantingsignso");
  wait 0.5;
  level.player dialogue::say_team("dx_sp_jslo_inex_pric_makarovslaunchingafa");
  wait 0.4;
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_gazz_fuckingliterally");
  wait 0.2;
  namespace_5643a6b7e3dcbf23::function_596ce1ff779d36a7();
}

function function_9d1aeef22a3c795c() {
  animnode = getStruct("keycard_animnode", "targetname");
  struct = utility::getStruct("upper_base_keycard_struct", "targetname");
  door = getEnt("upper_silo_sliding_door", "targetname");
  clip = getEnt(door.target, "targetname");
  clip linkTo(door);
  endstruct = utility::getStruct(clip.target, "targetname");
  first = 1;

  while(true) {
    waitframe();
    struct cursor_hint::create_cursor_hint(undefined, undefined, &"SP_JUP_SILO/CURSOR_KEYCARD_DOOR", 180, 250, 50, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 180);
    struct waittill("trigger");

    if(utility::flag("drone_in_use") || utility::flag("drone_transitioning")) {
      continue;
    }

    if(utility::flag("keycard_picked_up")) {
      break;
    }

    utility::display_hint_forced("need_keycard", 4);
    wait 0.3;

    if(first) {
      first = 0;
      thread function_c1ab763eb36fa1a2();
    }
  }

  function_c72954d5fa42e79(0);
  utility::flag_set("silo_door_opened");

  if(level.player getstance() == "prone") {
    level.player freezecontrols(1);
    level.player setstance("stand", 1);
    wait 0.28;
    level.player freezecontrols(0);
  }

  thread function_ee7febf18a3b917f();
  thread function_4aaa66edef47c795(door, endstruct);
  thread namespace_318af18595992d06::function_4b119908bdf12329(undefined, 0, 3.5);
  function_aac3eef1f98468ad();
  utility::delaythread(2.8, &function_a639551b77005a8a);
  rig = animnode player_rig::link_player_to_rig("keycard_interact", "stand", 1, 0.3, 1, 0, 0, 0, 0);
  animnode animation::anim_single_solo(rig, "keycard_interact");
  animnode player_rig::unlink_player_from_rig();
  function_c72954d5fa42e79(1);
  level notify("keycard_done");
}

function function_ee7febf18a3b917f() {
  stopmusicstate("mx_silo_stealthmoods");
  stopmusicstate("mx_silo_exposed");
}

function function_aac3eef1f98468ad() {
  level.player lerpfovscalefactor(0, 0.5);
  level.player.var_f296f7e55b9e9150 = getdvarint(@ "hash_b38fcf293d1e91a8");
  level.player modifybasefov(65, 0.5);
}

function function_a639551b77005a8a() {
  level.player lerpfovscalefactor(1, 2.5);

  if(isDefined(level.player.var_f296f7e55b9e9150)) {
    level.player modifybasefov(level.player.var_f296f7e55b9e9150, 1);
  }
}

function function_4aaa66edef47c795(door, endstruct) {
  origin = door.origin;
  wait 3;
  door moveTo(endstruct.origin, 1.2);
  door playSound("scn_jup_lower_base_security_door_open");
  utility::flag_wait("player_in_elevator");
  door moveTo(origin, 1.2);
}

function function_c1ab763eb36fa1a2() {
  level notify("new_key_vo");
  level endon("new_key_vo");
  level endon("player_in_elevator");
  wait 0.2;
  level.player dialogue::stop_dialogue();
  level.var_a267818b73bf19f2 dialogue::stop_dialogue();
  thread player::focus_display_hint(5, 1);

  if(namespace_5643a6b7e3dcbf23::function_1e4aaaddfd5236ca()) {
    level.player dialogue::say_team("dx_sp_jslo_inex_pric_doorslocked");
    wait 0.3;
    level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_fara_youneedthekeycardfin");
    return;
  }

  level.player dialogue::say_team("dx_sp_jslo_inex_pric_imatthedooritslocked");
  wait 0.3;
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_fara_youllneedthekeycardt");
}

function function_410e78baa4974258() {
  level notify("new_key_vo");
  level endon("new_key_vo");
  level endon("player_in_elevator");
  wait 0.5;
  level.player dialogue::stop_dialogue();
  level.var_a267818b73bf19f2 dialogue::stop_dialogue();

  if(function_cc3bc45cee803ba0()) {
    level.player dialogue::say_team("dx_sp_jslo_inel_pric_imin");
    wait 0.5;
    level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inex_fara_watchyoursixoldmanth");
    wait 0.3;
    level.player dialogue::say_team("dx_sp_jslo_inel_pric_affirmativeletsfindt");
  } else {
    level.player dialogue::say_team("dx_sp_jslo_inel_pric_allstationsmovingint");
    wait 0.6;
    level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inel_gazz_actualbeadvisedweveg");
    wait 0.3;
    level.player dialogue::say_team("dx_sp_jslo_inel_pric_letsfindembeforethey");
    wait 0.5;
    level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_inel_gazz_solidcopysirwereit");
  }

  wait 2;
  utility::flag_set("price_going_dark_linger");
  aliases = ["dx_sp_jslo_inel_gazz_hurrycaptain", "dx_sp_jslo_inel_gazz_konniispushinginonou", "dx_sp_jslo_inel_gazz_konnismobilizingweha"];
  level.var_a267818b73bf19f2 childthread nagtill("player_in_elevator", aliases, 12, 10);
}

function function_adb8f2f280de1b09(time) {
  hatch = getEnt("exit_hatch_01", "targetname");
  clip = getEnt(hatch.target, "targetname");
  clip linkTo(hatch);
  wait 0.05;
  hatch rotateby((0, 0, -170), time);
}

function function_f0f47cc310daabd9() {
  utility::flag_wait("jugg_half_health");
  namespace_5643a6b7e3dcbf23::function_3bb94732214d7da7();
  level notify("new_key_vo");
  level endon("new_key_vo");
  wait 0.2;
  level.player dialogue::stop_dialogue();
  level.var_a267818b73bf19f2 dialogue::stop_dialogue();
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_defs_fara_theresstilltimegetup");
  wait 2;
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_xfil_soap_allstationskonnisini");
  wait 1;
  level.player dialogue::say_team("dx_sp_jslo_xfil_pric_fuckwhatisthetarget");
  wait 1;
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_xfil_soap_arclovbaseinkastovia");
  wait 0.6;
  level.player dialogue::say_team("dx_sp_jslo_xfil_pric_ohnolaswell");
  aliases = [];
  aliases[aliases.size] = "dx_sp_jslo_xfil_fara_captainwererunningou";
  aliases[aliases.size] = "dx_sp_jslo_xfil_fara_letmeknowwhenyoureto";
  aliases[aliases.size] = "dx_sp_jslo_xfil_fara_icantholdthelaunchmu";
  aliases[aliases.size] = "dx_sp_jslo_xfil_fara_timeisnotourfriendhe";
  level.var_a267818b73bf19f2 childthread nagtill("player_exiting_tunnels", aliases, 12, 18);
  namespace_5643a6b7e3dcbf23::function_596ce1ff779d36a7();
}

function function_e89741f90abbed17() {
  namespace_5643a6b7e3dcbf23::function_3bb94732214d7da7(0.3);
  level notify("new_key_vo");
  level endon("new_key_vo");
  level.player dialogue::stop_dialogue();
  level.var_a267818b73bf19f2 dialogue::stop_dialogue();
  level.player dialogue::say_team("dx_sp_jslo_xfil_pric_kiloascendingnow");
  wait 0.7;
  thread countdown_music();
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_xfil_fara_copygotothetowergett");
  endtime = gettime() + 800;

  while(true) {
    waitframe();

    if(gettime() >= endtime) {
      break;
    }

    if(utility::flag("player_is_exiting_hatch") && level.player isonladder()) {
      break;
    }
  }

  thread namespace_5643a6b7e3dcbf23::function_97ea6ab4a7bac67e(6);
  thread namespace_5643a6b7e3dcbf23::function_f5afce4fbdde1fd8();
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_xfil_gazz_capivegotvisualonako");
  wait 0.2;
  namespace_5643a6b7e3dcbf23::function_596ce1ff779d36a7();
}

function function_5e109671e55c38ac() {
  utility::flag_wait("level_doors_finished");
  doors = door::get_interactive_door_array("tunnel_exit_door");

  foreach(door in doors) {
    door door::door_close(level.player, 0.1);
  }
}

function function_19a44b1f37ab195d() {
  flag_wait("scriptables_ready");
  node = getStruct("heli_node", "targetname");
  level.heli = vehicle::spawn_vehicle_from_targetname("topside_heli");
  level.heli vehicle_teleport(node.origin + (0, 0, -100), node.angles);
  level.heli thread function_a0dfb74e77834022();
  utility::array_spawn_noteworthy("final_fight_enemy");
  utility::array_spawn_noteworthy("final_fight_enemy_aggr");
  utility::flag_clear("stealth_enabled");
  utility::flag_wait("player_is_exiting_hatch");
  silo_lighting::function_e5d8995bd86eabe6();
  trigger = getEnt("final_fight_trigger", "targetname");
  thread namespace_5643a6b7e3dcbf23::function_d5eb6ecac5c4d41f("tunnel_ladder", 75);
  utility::trigger_on("silo_hatch_kill_trigger", "script_noteworthy");

  while(true) {
    if(!level.player istouching(trigger)) {
      break;
    }

    if(level.player isfiring()) {
      break;
    }

    waitframe();
  }

  level.heli thread vehicle_paths(node);
  scripts\common\vehicle_paths::gopath(level.heli);
  utility::flag_set("start_upper_ambush");
  utility::trigger_on("final_fight_stairs", "targetname");
  utility::spawn_script_noteworthy("final_fight_enemy_jugg", 1);
  utility::array_spawn_noteworthy("final_fight_enemy_heli", 1);
  thread function_d5ca2a2fcc0abd82();
  delaythread(5, &vehicle::godoff);
}

function countdown_music() {
  setmusicstate("mx_silo_countdown");
}

function function_a0dfb74e77834022() {
  self endon("death");
  self endon("entitydeleted");
  self.preferred_crash_style = 4;
  self.crash_speed = 500;
  self.heli_crash_indirect_zoff = 100;
  self.script_allow_driver_death = 1;
  self.unload_land_offset = 160;
  self.unload_hover_land_height = 160;
  self.unload_hover_offset_max = 160;
  utility::array_spawn_noteworthy("final_fight_enemy_pilots", 1);
  thread function_21e8e312248e00bf();
  vehicle::godon();
  self.script_bulletshield = undefined;
  self.health = 2000;
  self.maxhealth = self.health;
  childthread function_cd64a32f1b0d7a48();
  thread function_9e08f88e8d3b3a37();
  self hidepart("side_door_l_jnt", self.model);
  self hidepart("side_door_r_jnt", self.model);
  utility::flag_wait_either("start_upper_ambush", "force_move_heli");

  if(!utility::flag("force_move_heli")) {
    utility::flag_wait_or_timeout("force_move_heli", 2);
  }

  utility::flag_set("move_heli");
}

function function_21e8e312248e00bf() {
  self waittill("death");
  level notify("heli_death");
}

function function_cd64a32f1b0d7a48() {
  self waittill("damage");
  utility::flag_set("force_move_heli");
}

function function_9e08f88e8d3b3a37() {
  origin = self gettagorigin("tag_origin");
  org = utility::spawn_tag_origin(origin, (0, 0, 0));
  org linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  utility::waittill_either("vehicle_crashDone", "in_air_explosion");
  playFXOnTag(utility::getfx("vfx_heli_death"), org, "tag_origin");
}

function function_d5ca2a2fcc0abd82() {
  namespace_5643a6b7e3dcbf23::function_3bb94732214d7da7(1);
  level notify("new_key_vo");
  level endon("new_key_vo");
  wait 0.3;
  level.player dialogue::stop_dialogue();
  level.var_a267818b73bf19f2 dialogue::stop_dialogue();
  level.player dialogue::say_team("dx_sp_jslo_roof_pric_fuckmekonnisallovert");
  wait 0.8;
  level.var_a267818b73bf19f2 dialogue::say_team("dx_sp_jslo_roof_fara_cutthroughthemillhol");
  wait 0.6;
  level.player dialogue::say_team("dx_sp_jslo_roof_pric_togetherthen");
  wait 0.2;
  namespace_5643a6b7e3dcbf23::function_596ce1ff779d36a7();
}

function function_fe76a772546800d0(bool) {
  if(bool) {
    level.player setcinematicmotionoverride("disabled");
    scripts\sp\anim::igc_camera(1);
    scripts\sp\anim::letterbox_enable(1, 1.5);
    setDvar(@ "hash_c815d5683eea5b67", 1);
    setomnvar("ui_hide_weapon_info", 1);
    level.player player::focusdisable();
    return;
  }

  level.player clearcinematicmotionoverride();
  scripts\sp\anim::letterbox_enable(0, 0);
}

function function_568859054f402d9f() {
  animnode = getStruct("outro_animnode", "targetname");
  animnode anim_first_frame_solo(level.var_f26e6e3645b55820, "outro_1");
}

function function_941171e175abcc49() {
  animnode = utility::getStruct("outro_animnode", "targetname");
  animnode.angles = (0, 0, 0);
  interact = utility::getStruct("ending_button", "targetname");
  trigger = getEnt("tower_trigger", "targetname");
  distmax = squared(700);

  while(true) {
    interact cursor_hint::function_fa06de21f8aaee3b("outro_1", animnode, undefined, undefined, &"SP_JUP_SILO/CURSOR_SILO_HATCH", 180, 600, 0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 180);
    interact waittill("trigger");

    if(utility::flag("drone_in_use") || utility::flag("drone_transitioning")) {
      continue;
    }

    utility::flag_clear("drone_usable");

    if(utility::flag("command_tower_death")) {
      enemies = getaiarray("axis");
      var_a78a9cc8ff8b8439 = 1;

      foreach(enemy in enemies) {
        if(isDefined(enemy) && isalive(enemy)) {
          result = enemy function_2dd2067e78cd6ede(trigger, distmax, interact);
        }

        if(!istrue(result)) {
          var_a78a9cc8ff8b8439 = 0;
        }
      }

      if(istrue(var_a78a9cc8ff8b8439)) {
        break;
      }
    }

    utility::flag_set("drone_usable");
    display_hint_forced("full_enemies", 4);
    wait 1;
  }

  thread namespace_5643a6b7e3dcbf23::despawn_enemies();
  utility::flag_set("final_button_pushed");
  thread function_1a54a962db7fcc38();

  if(isDefined(level.var_398625fd66048065)) {
    level.var_398625fd66048065 delaythread(8, &sound_fade_and_delete, 5);
  }

  thread namespace_318af18595992d06::function_4b119908bdf12329("sp_jup_silo_topside_exfil_outro_igc", 3.5, 3.5);
  thread delete_corpse(interact);
  thread function_fe76a772546800d0(1);
  function_9836629a35251425(animnode);
  level hud_util::fade_out(0, "black");
  thread function_b5c57800cc07fd95();
}

function function_b5c57800cc07fd95() {
  if(isDefined(level.fakeplayer)) {
    level.fakeplayer delete();
  }

  function_fe76a772546800d0(0);
  thread function_a7a3b4907d39e7e3();
}

function function_a7a3b4907d39e7e3() {
  level.player dialogue::stop_dialogue();
  level.var_a267818b73bf19f2 dialogue::stop_dialogue();
  level.player stopsounds();
  level.var_a267818b73bf19f2 stopsounds();
  utility::battlechatter_off();
}

function function_2dd2067e78cd6ede(trigger, distmax, interact) {
  self endon("death");

  if(self istouching(trigger)) {
    return false;
  }

  dist = distancesquared(self.origin, interact.origin);

  if(dist <= distmax) {
    return false;
  }

  return true;
}

function function_1a54a962db7fcc38() {
  setmusicstate("mx_silo_countdown_end");
}

function delete_corpse(interact) {
  level waittill("start_explosion_bink");
  corpses = getcorpsearrayinradius(interact.origin, 100);

  if(isDefined(corpses) && corpses.size > 0) {
    foreach(corpse in corpses) {
      corpse delete();
    }
  }
}

function function_9836629a35251425(animnode) {
  level endon("intro_skipped");
  level.fakeplayer = utility::spawn_targetname("fakePlayer");
  level.fakeplayer hide();
  og_zplanes = getDvar(@ "hash_5025653b60878a96");
  setsaveddvar(@ "hash_5025653b60878a96", "0.1 400 1 1000");
  level notify("new_main_vo_scene");
  level notify("new_key_vo");
  level.player dialogue::stop_dialogue();
  level.var_a267818b73bf19f2 delaythread(1.2, &dialogue::stop_dialogue);
  childthread finale_vfx();
  thread function_e0c2da746a6e1134();
  function_2989c8e922883a5b(animnode);
  function_2989c9e922883c8e(animnode);
  function_2989cae922883ec1(animnode);
  function_2989cbe9228840f4(animnode);
  function_2989cce922884327(animnode);
  utility::userskip_stop();
}

function function_2989c8e922883a5b(animnode) {
  level.fakeplayer delaycall(0.4, &show);
  level.player delaycall(0.42, &hideviewmodel);
  thread silo_lighting::function_f3275439c2ea3a58("outro_0");
  level.fakeplayer delaythread(0.2, &enable_procedural_bones);

  if(!isDefined(level.player_rig)) {
    level.player_rig = spawn_anim_model("player_rig", (0, 0, 0), (0, 0, 0));
    level.player_rig hide();
  }

  thread function_82ebb1ca084fdd1b();
  anime = "outro_1";
  animnode animation::anim_first_frame([level.fakeplayer, level.player_rig], anime);
  namespace_5643a6b7e3dcbf23::function_8da3daaa6d7ab1a1();
  animnode animation::anim_single([level.player_rig, level.fakeplayer, level.var_f26e6e3645b55820, level.var_ada33822cf257bec], anime);
}

function function_82ebb1ca084fdd1b() {
  level.player_rig delaycall(0.2, &hide);
  level.fakeplayer delaythread(0.2, &enable_procedural_bones);
  thread silo_lighting::function_f3275439c2ea3a58("outro_1");
  level.player function_bc667001f9dd3808(level.fakeplayer.origin);
  level.fakeplayer function_af96f7c8819ae854(level.player, 2000);
  wait 2;
  level.player dof_enable_autofocus(3, level.fakeplayer, 10, 10);
}

function function_2989c9e922883c8e(animnode) {
  level.player playSound("scn_jup_silo_outro_silo_close_lr");
  thread function_a23dd89e1a4265e4();
  animnode animation::anim_single([level.var_ada33822cf257bec, level.var_f26e6e3645b55820, level.fakeplayer], "outro_2");
}

function function_a23dd89e1a4265e4() {
  level.player dof_disable();
  level notify("start_explosion_bink");
  thread silo_lighting::function_f3275439c2ea3a58("outro_2");
}

function function_2989cae922883ec1(animnode) {
  thread function_2ec121a2a550b1();
  animnode animation::anim_single([level.var_ada33822cf257bec, level.var_f26e6e3645b55820, level.fakeplayer], "outro_3");
}

function function_2ec121a2a550b1() {
  thread silo_lighting::function_f3275439c2ea3a58("outro_3");
}

function function_2989cbe9228840f4(animnode) {
  thread function_ee0469280dfdb36a();
  animnode animation::anim_single([level.var_ada33822cf257bec, level.var_f26e6e3645b55820, level.fakeplayer], "outro_4");
}

function function_ee0469280dfdb36a() {
  thread silo_lighting::function_f3275439c2ea3a58("outro_4");
}

function function_2989cce922884327(animnode) {
  thread function_ec5069a1eba10f87();
  animnode animation::anim_single([level.var_ada33822cf257bec, level.var_f26e6e3645b55820, level.fakeplayer], "outro_5");
}

function function_ec5069a1eba10f87() {
  thread silo_lighting::function_f3275439c2ea3a58("outro_5");
}

function function_e0c2da746a6e1134() {
  wait 0.1;
  userskipped = utility::userskip_wait();

  if(!userskipped) {
    return;
  }

  flag_set("intro_skipped");
  level notify("intro_skipped");
  utility::userskip_stop();
  level.player stop_dialogue();
}

function finale_vfx() {
  exploder("finale_dust_haze");
  wait 8.75;
  exploder("finale_door_puff");
  wait 2.25;
  utility::flag_set("audio_final_expl");
  level.player playSound("scn_jup_silo_outro_expl_lr");
  exploder("finale_exploder");
  thread end_pulse();
}

function end_pulse() {
  wait 0.5;
  structs = utility::getStructArray("end_pulse", "targetname");

  foreach(struct in structs) {
    physicsexplosionsphere(struct.origin, 80, 35, 12);
    waitframe();
  }
}

function function_2489a54543e0f936() {
  level notify("start_new_bink");
  waittillframeend();
  setsaveddvar(@ "hash_d3ee5a6578fe61de", "0");
  setsaveddvar(@ "hash_b9ff37d084074df3", "1");
  cinematicingame("jup_sp_silo_misslesmokeidle", 2);
  level waittill("start_explosion_bink");
  wait 0.35;
  stopcinematicingame();
  setsaveddvar(@ "hash_d3ee5a6578fe61de", "0");
  setsaveddvar(@ "hash_b9ff37d084074df3", "1");
  cinematicingame("jup_sp_silo_cctv_missleexplosion");
}

function function_73cbe7e4760e5b90() {
  level endon("intro_skipped");
  setsaveddvar(@ "hash_d3ee5a6578fe61de", "1");
  setsaveddvar(@ "hash_b9ff37d084074df3", "1");
  cinematicingame("sp_jup_silo_cine_outro");
  level.player setsoundsubmix("jup_loading_screen", 1);
  level thread hud_util::fade_in(0.05, "black");
  wait 0.1;
  thread function_1a3669811b969e32();
  wait 28.9;
  level.player clearsoundsubmix("jup_loading_screen");
  level hud_util::fade_out(0, "black");
  utility::userskip_stop();
}

function function_1a3669811b969e32() {
  wait 0.1;
  userskipped = utility::userskip_wait();

  if(!userskipped) {
    return;
  }

  flag_set("intro_skipped");
  level notify("intro_skipped");
  utility::userskip_stop();
  level.player clearsoundsubmix("jup_loading_screen", 1);
  level hud_util::fade_out(0, "black");

  if(iscinematicplaying()) {
    stopcinematicingame(1);
  }

  waitframe();
}

function precache_drone() {
  precacheshader("icon_waypoint_ally_marker");
  precacheshader("icon_waypoint_enemy_marker");
}

function drone_init() {
  precacheshader("jup_hud_icon_killstreaks_switchblade_drone");
  var_642de15f9441e32e = utility::getStruct("level_drone", "targetname");
  structpath = utility::getStruct("level_drone_path", "targetname");
  var_5663934ae1ec27e1 = utility::getStruct("level_drone_base", "targetname");
  level.drone = spawnStruct();
  level.drone.ent = utility::spawn_tag_origin(var_642de15f9441e32e.origin, var_642de15f9441e32e.angles);
  level.drone.var_9e0b4cc4df6538c1 = utility::spawn_tag_origin(var_5663934ae1ec27e1.origin, var_5663934ae1ec27e1.angles);
  level.drone.focusent = utility::spawn_tag_origin(var_5663934ae1ec27e1.origin, var_5663934ae1ec27e1.angles);
  level.drone.soundent = utility::spawn_tag_origin(var_642de15f9441e32e.origin, var_642de15f9441e32e.angles);
  level.drone.ent linkTo(level.drone.var_9e0b4cc4df6538c1, "tag_origin");
  level.drone.soundent linkTo(level.drone.ent, "tag_origin", (0, 0, 0), (0, 0, 0));
  wait 0.05;
  level.drone.fov = getdvarint(@ "hash_b38fcf293d1e91a8");
  level.drone.var_ddd3e18e0bdc9cf1 = undefined;
  level.drone.thermal = 0;
  level.drone.var_e3f4162b4edb1e8f = gettime();
  level.drone.animnode = spawnStruct();
  level.drone.crouch = 1;
  level.drone.return_damage = undefined;
  function_74234aca13ccc5b7();
  level.player thread utility::actionslotoverride(4, "jup_hud_icon_killstreaks_switchblade_drone", undefined, &function_e02cc5b67169a004);
  thread function_8b17b54884eb4244(var_5663934ae1ec27e1);
  thread function_867cc39d13dc6e55(structpath, var_5663934ae1ec27e1);
}

function function_e02cc5b67169a004() {
  level notify("drone_activated");

  if(function_56ff3f4058660fd6()) {
    return;
  }

  utility::flag_set("drone_transitioning");

  if(!utility::flag("drone_in_use")) {
    thread function_fccbdb83a837c7a1();

    if(!utility::flag("drone_intro")) {
      function_255b970769c84a1e();
    }

    drone_notifies(1);
    thread namespace_318af18595992d06::function_fcdf5a0628a1911a("sp_jup_silo_topside_infil_scout_drone", 0.5, 0.5);
    level hud_util::fade_out(0, "black");
    function_e8c5cb1a1a032dfb();
    function_31cb6828ea116903(1);
    level thread hud_util::fade_in(0.05, "black");
    thread function_c477de5775b6f437();
    thread function_4f5bc6d0ad082c4a();
    thread function_128dbf446da5e6c6();
    thread function_1ce768ba0c9e5780();
    thread function_203be5da1a428ee4();
    thread function_46bdc5e29bab9146();
    exploder("drone_pov");
  } else {
    drone_notifies(0);
    thread namespace_318af18595992d06::function_c7c5c2ca61454c41("sp_jup_silo_topside_infil_scout_drone", 0.5, 0.5);
    level hud_util::fade_out(0, "black");
    level.player function_bc667001f9dd3808(level.fakeplayer.origin);
    level.fakeplayer function_af96f7c8819ae854(level.player, 1000);
    function_8b2ac8521c16b9e1();
    function_31cb6828ea116903(0);
    level thread hud_util::fade_in(0.1, "black");
    kill_exploder("drone_pov");
  }

  wait 0.1;
  level.player function_bab9acc2cf205a62();
  utility::flag_clear("drone_transitioning");
}

function function_255b970769c84a1e() {
  tablet = spawn("script_model", level.player.origin);
  tablet setModel("offhand2h_wm_tablet_dmz");
  tablet notsolid();
  tablet linktoplayerview(level.player, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 1, "none");
  tablet dontinterpolate();
  level.player forceplaygestureviewmodel("jup_silo_ges_remote_drone_pullout", undefined, 0.1, 0.1);
  wait 0.56;
  thread function_47615e120b154238(tablet);
}

function function_47615e120b154238(tablet) {
  wait 0.1;
  level.player stopgestureviewmodel("jup_silo_ges_remote_drone_pullout");
  tablet delete();
}

function function_c72954d5fa42e79(bool) {
  if(bool) {
    utility::flag_set("drone_usable");
    return;
  }

  utility::flag_clear("drone_usable");
}

function function_56ff3f4058660fd6() {
  if(utility::flag("drone_transitioning") || !utility::flag("drone_usable")) {
    return true;
  }

  if(utility::flag("player_is_underground")) {
    display_hint_forced("drone_not_available", 4);
    return true;
  }

  if(level.player isonladder() || level.player function_9cc921a57ff4deb5() || level.player isjumping() || level.player ismantling() || level.player ishanging() || level.player playermount() >= 0.1) {
    return true;
  }

  if(!utility::flag("drone_in_use")) {
    if(!level.player isonground()) {
      return true;
    }
  }

  if(level.player isscriptedmeleeactive() || istrue(level.player utility::function_bbebfbddd1b77a34())) {
    return true;
  }

  return false;
}

function drone_notifies(bool) {
  if(bool) {
    utility::flag_set("drone_in_use");
    level notify("drone_enter");
    return;
  }

  utility::flag_clear("drone_in_use");
  level notify("drone_exit");
}

function function_867cc39d13dc6e55(structpath, var_5663934ae1ec27e1) {
  level.drone.var_9e0b4cc4df6538c1.origin = structpath.origin;
  level.drone.var_9e0b4cc4df6538c1.angles = structpath.angles;
  structend = utility::getStruct(structpath.target, "targetname");
  var_6ecca3ae9cba6398 = utility::getStruct("level_drone_focus", "targetname");

  while(true) {
    wait 0.1;

    if(utility::flag("drone_intro")) {
      level.drone.var_9e0b4cc4df6538c1.origin = var_5663934ae1ec27e1.origin;
      continue;
    }

    if(!utility::flag("drone_in_use")) {
      origin = pointonsegmentnearesttopoint(structpath.origin, structend.origin, level.player.origin);
      level.drone.var_9e0b4cc4df6538c1 moveTo(origin, 0.1);
    }
  }
}

function function_8b17b54884eb4244(var_5663934ae1ec27e1) {
  utility::flag_wait("drone_in_use");

  while(true) {
    level.drone.var_9e0b4cc4df6538c1 rotateTo(level.drone.var_9e0b4cc4df6538c1.angles + (0, 90, 0), 20);
    wait 20;
  }
}

function function_4f5bc6d0ad082c4a() {
  while(!isDefined(level.drone.fakeplayer)) {
    waitframe();
  }

  fakeplayer = newhudelem();
  fakeplayer setshader("icon_waypoint_ally_marker", 64, 64);
  fakeplayer setwaypoint(1, 1, 1, 0);
  fakeplayer linkwaypointtotargetwithoffset(level.drone.fakeplayer, (0, 0, 0));

  if(!utility::flag("drone_intro")) {
    if(utility::flag("player_is_exiting_hatch")) {
      level.var_f6d78c5bef7a368b mark_location(1);
    } else if(!utility::flag("baseboss_death")) {
      array = ["obj_comm_1", "obj_comm_2", "obj_comm_3"];

      foreach(eflag in array) {
        if(!utility::flag(eflag)) {
          level.objstruct[eflag] mark_location(i + 1);
        }
      }
    } else {
      level.var_db651727864d30d6 mark_location(1);
    }
  }

  if(utility::flag("drone_in_use")) {
    level waittill("drone_exit");
  }

  level notify("waypoints_destroyed");
  function_74234aca13ccc5b7();

  if(isDefined(fakeplayer)) {
    fakeplayer destroy();
  }
}

function function_74234aca13ccc5b7() {
  setomnvar("ui_gunship_target_current_location_name", "none");
  setomnvar("ui_gunship_target_marker_name_1", "none");
  setomnvar("ui_gunship_target_marker_name_2", "none");
  setomnvar("ui_gunship_target_marker_name_3", "none");
  level.player setclientomnvar("ui_killstreak_zoom_fov", 20);
}

function mark_location(slot) {
  setomnvar("ui_gunship_target_marker_ent_" + slot, self);
  setomnvar("ui_gunship_target_marker_name_" + slot, self.string);
  level.player playSound("ui_silo_drone_poi_in");
}

function clear_location(slot) {
  setomnvar("ui_gunship_target_marker_ent_" + slot, undefined);
  setomnvar("ui_gunship_target_marker_name_" + slot, "none");
  level.player playSound("ui_silo_drone_poi_out");
}

function function_66b7373ba05dd69d() {
  level endon("drone_exit");

  if(utility::flag("drone_intro")) {
    return;
  }

  wait 5;
  utility::display_hint_forced("exit_drone");
}

function function_c477de5775b6f437() {
  level endon("drone_exit");
  wait 0.1;

  if(utility::flag("drone_intro")) {
    struct = utility::getStruct("upper_base_keycard_struct", "targetname");
    fwd = anglesToForward(struct.angles) * 900;
    level.drone.focusent.origin = struct.origin + fwd;
  } else {
    fwd = anglesToForward(level.drone.animnode.angles) * 900;
    level.drone.focusent.origin = level.drone.animnode.origin + fwd;
  }

  var_34743d0c04f178ef = vectortoangles(level.drone.focusent.origin - level.player getvieworigin());
  level.player setplayerangles(var_34743d0c04f178ef);
  level.drone.oldangles = var_34743d0c04f178ef;

  while(true) {
    waitframe();
    newangles = vectortoangles(level.drone.focusent.origin - level.player getvieworigin());
    var_b5b3431a0126e171 = (level.drone.oldangles[0] - newangles[0], level.drone.oldangles[1] - newangles[1], 0);
    var_47eb6724c1e4e7a4 = level.player getplayerangles() - var_b5b3431a0126e171;
    level.player setplayerangles(var_47eb6724c1e4e7a4);
    level.drone.focusent.origin = level.drone.ent function_6b7ff0cd994a7fe(level.player)["position"];
    level.drone.oldangles = vectortoangles(level.drone.focusent.origin - level.player getvieworigin());
  }
}

function function_6b7ff0cd994a7fe(player) {
  ignorearray = [player, self];
  forward = anglesToForward(player getplayerangles());
  start = player getvieworigin();
  end = start + forward * 10000;
  trace = scripts\engine\trace::ray_trace_detail(start, end, ignorearray);

  if(getdvarint(@ "hash_d08a5047ea23e363")) {
    childthread utility::draw_line_for_time(start, trace["<dev string:x1c>"], 1, 0, 1, 10);
  }

  return trace;
}

function function_128dbf446da5e6c6() {
  level endon("drone_exit");

  if(level.player utility::isads()) {
    level.player modifybasefov(17, 0);

    while(level.player adsButtonPressed()) {
      waitframe();
    }

    level.player modifybasefov(65, 0.2);
    wait 0.1;
  }

  while(true) {
    level.player waittill("ads_pressed");
    level.drone.soundent playSound("ui_silo_drone_zoom_in", "skipped", 1);
    level.player modifybasefov(17, 0.5);
    wait 0.1;

    while(level.player adsButtonPressed()) {
      waitframe();
    }

    level.drone.soundent playSound("ui_silo_drone_zoom_out", "skipped", 1);
    level.player modifybasefov(65, 0.2);
    wait 0.1;
  }
}

function function_1ce768ba0c9e5780() {
  level endon("drone_exit");

  while(true) {
    start = level.player getEye();
    end = start + anglesToForward(level.player getplayerangles()) * 10000;
    trace = trace::ray_trace(start, end, [level.player, level.drone.ent]);
    enemies = getaiarray("axis");

    if(isDefined(trace["position"])) {
      enemies = sortbydistancecullbyradius(enemies, trace["position"], 800);
    }

    if(isDefined(enemies) && enemies.size >= 1) {
      foreach(enemy in enemies) {
        if(isDefined(enemy) && isalive(enemy)) {
          enemy thread function_efc3218c25d6c27e();
        }

        wait 0.1;
      }
    }

    waitframe();
  }
}

function function_efc3218c25d6c27e() {
  self endon("death");
  cosnum = 0.984808;

  if(level.player utility::isads()) {
    cosnum = 0.906308;
  }

  if(!within_fov(level.player.origin, level.player getplayerangles(), self.origin, cosnum)) {
    return;
  }

  if(istrue(self.pingactive)) {
    self.var_3142155dab837c22 = gettime() + 20000;
  }

  if(!istrue(self.pingactive)) {
    maxtime = gettime() + 120;

    while(true) {
      if(gettime() >= maxtime) {
        if(within_fov(level.player.origin, level.player getplayerangles(), self.origin, cosnum)) {
          break;
        }

        return;
      }

      waitframe();
    }

    function_4fd494c6e571ebfd();
  }
}

function function_4fd494c6e571ebfd() {
  self.pingactive = 1;
  self.var_3142155dab837c22 = gettime() + 20000;

  if(!isDefined(self.var_acbe6b1f12bab7b7)) {
    level notify("new_target_pinged");
    self.var_acbe6b1f12bab7b7 = newhudelem();
    self.var_acbe6b1f12bab7b7 setshader("icon_waypoint_enemy_marker", 64, 64);
    self.var_acbe6b1f12bab7b7 setwaypoint(1, 1, 1, 0);
    self.var_acbe6b1f12bab7b7 linkwaypointtotargetwithoffset(self, (0, 0, 0));
    level.drone.soundent playSound("ui_silo_drone_mark", "marking", 1);
  }

  thread function_8e9aee0fda1ce394();
  childthread function_5b26f430d0677cf6();
}

function function_5b26f430d0677cf6() {
  onexit = 0;

  while(true) {
    if(gettime() >= self.var_3142155dab837c22) {
      break;
    }

    if(!utility::flag("drone_in_use")) {
      if(utility::flag("drone_intro")) {
        childthread function_35689112fb6bfbe4();
      }

      if(!onexit) {
        onexit = 1;
        self.var_3142155dab837c22 = gettime() + 20000;
      }
    }

    wait 0.1;
  }

  if(isDefined(self.var_acbe6b1f12bab7b7)) {
    self notify("start_marker_destroy");
    self.var_acbe6b1f12bab7b7 fadeovertime(0.8);
    self.var_acbe6b1f12bab7b7.alpha = 0;
    wait 0.8;

    if(isDefined(self.var_acbe6b1f12bab7b7)) {
      self.var_acbe6b1f12bab7b7 destroy();
    }

    self.var_acbe6b1f12bab7b7 = undefined;
  }

  self.pingactive = 0;
}

function function_35689112fb6bfbe4() {
  self endon("start_marker_destroy");

  if(isDefined(self.var_acbe6b1f12bab7b7)) {
    self.var_acbe6b1f12bab7b7.alpha = 0;
    level waittill("price_intro_done");

    if(isDefined(self.var_acbe6b1f12bab7b7)) {
      self.var_acbe6b1f12bab7b7 fadeovertime(0.8);
      self.var_acbe6b1f12bab7b7.alpha = 1;
    }
  }
}

function function_8e9aee0fda1ce394() {
  self notify("new_death_watcher");
  self endon("new_death_watcher");
  waittill_either("death", "force_delete");

  if(isDefined(self.var_acbe6b1f12bab7b7)) {
    self.var_acbe6b1f12bab7b7 destroy();
    self.var_acbe6b1f12bab7b7 = undefined;
  }
}

function function_203be5da1a428ee4() {
  level endon("drone_exit");

  for(;;) {
    if(level.player getlocalplayerprofiledata("gpadEnabled")) {
      var_1b76d5208a3eb6d0 = level.player getlocalplayerprofiledata("ViewHorzSensitivity");
      var_1b76d5208a3eb6d0 = math::remap(var_1b76d5208a3eb6d0, 0.6, 4, 0.6, 0.2);
      var_1b76d3208a3eb26a = level.player getlocalplayerprofiledata("ViewVertSensitivity");
      var_1b76d3208a3eb26a = math::remap(var_1b76d3208a3eb26a, 0.6, 4, 0.6, 0.2);
      level.player enableslowaim(var_1b76d3208a3eb26a, var_1b76d5208a3eb6d0);
    } else {
      sensitivity = level.player getlocalplayerprofiledata("ViewMouseHorzSensitivity");

      if(sensitivity > 5) {
        sensitivity = math::remap(sensitivity, 0.01, 99, 0.5, 0.05);
        level.player enableslowaim(sensitivity, sensitivity);
      } else {
        level.player enableslowaim(1, 1);
      }
    }

    waitframe();
  }
}

function function_31cb6828ea116903(enable) {
  if(enable) {
    level.player setclientomnvar("ui_killstreak_controls", 9);
    setDvar(@ "hash_c815d5683eea5b67", 1);
    setomnvar("ui_hide_weapon_info", 1);
    visionsetnaked("gunship_color_jup_sp_silo", 0);
    level.drone.ent playLoopSound("scn_silo_drone_lp");
    return;
  }

  level.player setclientomnvar("ui_killstreak_controls", 0);
  setDvar(@ "hash_c815d5683eea5b67", 0);
  setomnvar("ui_hide_weapon_info", 0);
  visionsetnaked("", 0);
  level.drone.ent stoploopsound("scn_silo_drone_lp", 1);
}

function function_46bdc5e29bab9146() {
  level endon("drone_exit");
  level.player waittill("stance_pressed");
  thread function_e02cc5b67169a004();
}

function function_e8c5cb1a1a032dfb() {
  thread function_c6810698bd13ff6f();
  function_ac0ad75f7a32aa5b();
}

function function_c6810698bd13ff6f() {
  level.drone.animnode.origin = level.player.origin;
  level.drone.animnode.angles = level.player.angles;
  spawner = getspawner("fakePlayer", "targetname");
  spawner.count++;
  level.drone.crouch = 1;
  anime = "crouch_pose";

  if(level.player getstance() == "prone") {
    level.drone.crouch = 0;
    anime = "prone_pose";
  }

  level.drone.fakeplayer = spawner utility::spawn_ai(1);
  level.drone.fakeplayer thread function_414d9b49545b0296(anime);
  level.drone.fakeplayer thread function_32f8b4e90ea58fa4();
}

function function_414d9b49545b0296(anime) {
  self endon("death");
  level endon("drone_exit");
  self.allowdeath = 0;
  thread deletable_magic_bullet_shield();
  thread function_b67c4f58da9fcced();
  level.drone.animnode childthread animation::anim_loop_solo(self, anime);
  self attach("offhand2h_wm_tablet_dmz", "tag_accessory_left");
}

function function_32f8b4e90ea58fa4() {
  self endon("death");
  level endon("drone_exit");
  enemies = getaiarray("axis");

  if(!isDefined(enemies)) {
    return;
  }

  foreach(enemy in enemies) {
    if(isDefined(enemy) && isalive(enemy)) {
      enemy childthread function_7bdfe210af5ac36c();
    }
  }
}

function function_7bdfe210af5ac36c() {
  self endon("death");

  if(istrue(self.bisincombat)) {
    if(is_equal(self.enemy, level.player)) {
      self getenemyinfo(level.drone.fakeplayer);
      set_favoriteenemy(level.drone.fakeplayer);
    }
  }
}

function function_b67c4f58da9fcced() {
  level endon("drone_exit");
  wait 0.1;
  self waittill("damage", damage, attacker, direction, damagelocation, meansofdeath, modelname, attachtagname, partname, dflags, objweapon, origin, angles, normal, inflictor, time);
  level.drone.return_damage = [damage, direction];
  thread function_e02cc5b67169a004();
}

function function_ac0ad75f7a32aa5b() {
  level.player.ignoreme = 1;
  level.player setOrigin(level.drone.ent.origin);
  level.player setplayerangles(level.drone.ent.angles);
  level.player setstance("stand");
  waitframe();
  level.player playerlinktodelta(level.drone.ent, "tag_origin", 0, 0, 0, 0, 0, 0);
  level.player lerpviewangleclamp(0.1, 0, 0, 180, 180, 100, 180);
  level.player hideviewmodel();
  level.player lerpfovscalefactor(0, 0);
}

function function_fccbdb83a837c7a1() {
  level endon("drone_exit");
  level.player val::set("remote_drone", "mantle", 0);
  level.player val::set("remote_drone", "allow_jump", 0);
  level.player val::set("remote_drone", "melee", 0);
  level.player val::set("remote_drone", "sprint", 0);
  level.player val::set("remote_drone", "slide", 0);
  level.player val::set("remote_drone", "offhand_weapons", 0);
  level.player val::set("remote_drone", "ads", 0);
  level.player val::set("remote_drone", "reload", 0);
  level.player val::set("remote_drone", "fire", 0);
  level.player val::set("remote_drone", "autoreload", 0);
  level.player val::set("remote_drone", "weapon_switch", 0);
  level.player val::set("remote_drone", "offhand_throwback", 0);
  level.player utility::function_b6a59f7759a30482(0);
  utility::flag_wait("drone_in_use");
  level.player val::set("remote_drone", "weapon", 0);
  level.player val::set("remote_drone", "damage", 0);
  level.player val::set("remote_drone", "breath_system", 0);
  level.player val::set("remote_drone", "cg_drawcrosshair", 0);
  level.player val::set("remote_drone", "show_weapon_hud", 0);
  level.player val::set("remote_drone", "ads", 1);
}

function function_1dbebb429f23d0c9(ent) {
  lookangles = vectortoangles(level.player.origin - ent.origin);
  ent.angles = lookangles;
  level.player setOrigin(ent.origin);
  level.player setplayerangles(lookangles);
  return lookangles;
}

function function_8b2ac8521c16b9e1() {
  level.player.ignoreme = 0;
  level.player function_68889aa20320bd04();
  level.drone.fakeplayer delete();
  level.player unlink();
  level.player setOrigin(level.drone.animnode.origin);
  level.player setplayerangles(level.drone.animnode.angles);
  level.player modifybasefov(level.drone.fov, 0);
  level.player lerpfovscalefactor(1, 0);
  level.player showviewmodel();
  level.player val::reset_all("remote_drone");
  level.player disableslowaim();
  level.player utility::function_b6a59f7759a30482(1);
  stance = "crouch";

  if(!level.drone.crouch) {
    stance = "prone";
  }

  level.player setstance(stance, 1, 1, 1);

  if(isDefined(level.drone.return_damage) && level.drone.return_damage.size > 0) {
    if(!isDefined(level.drone.return_damage[0])) {
      return;
    }

    if(!isDefined(level.drone.return_damage[1]) || !isvector(level.drone.return_damage[1])) {
      return;
    }

    thread function_d8670e9ad7607e49();
  }
}

function function_68889aa20320bd04() {
  self endon("death");
  level endon("drone_enter");
  enemies = getaiarray("axis");

  if(!isDefined(enemies)) {
    return;
  }

  foreach(enemy in enemies) {
    if(isDefined(enemy) && isalive(enemy)) {
      enemy childthread function_bf3d83d8a6c98f95();
    }
  }
}

function function_bf3d83d8a6c98f95() {
  self endon("death");

  if(istrue(self.bisincombat)) {
    if(is_equal(self.enemy, level.drone.fakeplayer)) {
      self getenemyinfo(level.player);
      set_favoriteenemy(level.player);
    }
  }
}

function function_d8670e9ad7607e49() {
  wait 0.1;
  level.player do_damage(level.drone.return_damage[0], level.drone.return_damage[1]);
  level.drone.return_damage = undefined;
}