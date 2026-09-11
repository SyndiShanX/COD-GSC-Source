/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\stpetersburg\stpetersburg_interrogation.gsc
***********************************************************************/

function interrogation_init() {
  scripts\engine\utility::flag_init("interrogation_start");
  scripts\engine\utility::flag_init("interrogation_failed");
  scripts\engine\utility::flag_init("interrogation_abandoned");
  scripts\engine\utility::flag_init("interrogation_end");
  scripts\engine\utility::flag_init("intro_butcher_mayhem_b");
  scripts\engine\utility::flag_init("intro_yegor_mayhem_b");
  scripts\engine\utility::flag_init("van_retrieve_package");
  scripts\engine\utility::flag_init("van_interact_available");
  scripts\engine\utility::flag_init("nikolai_intro_vo");
  scripts\engine\utility::flag_init("nikolai_nag_ready");
  scripts\engine\utility::flag_init("escort_slowdown");
  scripts\engine\utility::flag_init("interrogation_escort_idle");
  scripts\engine\utility::flag_init("interrogation_escort_done");
  scripts\engine\utility::flag_init("warning_accepted");
  scripts\engine\utility::flag_init("warning_declined");
  scripts\engine\utility::flag_init("revolver_offered");
  scripts\engine\utility::flag_init("revolver_picked_up");
  scripts\engine\utility::flag_init("dry_fire_complete");
  scripts\engine\utility::flag_init("dry_fire_react");
  scripts\engine\utility::flag_init("bullets_offered");
  scripts\engine\utility::flag_init("final_phase");
  scripts\engine\utility::flag_init("family_spooked");
  scripts\engine\utility::flag_init("intel_revealed");
  scripts\engine\utility::flag_init("defeated_state_active");
  scripts\engine\utility::flag_init("scripted_performance");
  scripts\engine\utility::flag_init("police_car_nag_spoken");
  scripts\engine\utility::flag_init("pause_butcher_vo");
  scripts\engine\utility::flag_init("pause_family_vo");
  scripts\engine\utility::flag_init("pause_nikolai_vo");
  scripts\engine\utility::flag_init("pause_price_vo");
  scripts\engine\utility::flag_init("pause_inactive_vo");
  scripts\engine\utility::flag_init("enforcer_dead");
  scripts\engine\utility::flag_init("wife_dead");
  scripts\engine\utility::flag_init("son_dead");
  var0 = getEnt("revolver", "targetname");
  var0 hidepart("tag_rail");
  var0 attach("attachment_wm_pi_cpapa_barrel");
  var0 hidepart("tag_laser_show");
  var0 hide();
  var1 = getEntArray("bullets", "targetname");
  scripts\engine\utility::array_call(var1, &hide);
  var2 = getEntArray("outro_gas_barrel", "targetname");
  scripts\engine\utility::array_call(var2, &hide);
  setDvar("stp_family_deaths", 0);
}

function interrogation_main() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::transient_waittill("van_interact_available", undefined, "stpetersburg_interrogation_escort_script_tr");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::transient_waittill("warning_accepted", "stpetersburg_interrogation_intro_script_tr", "stpetersburg_interrogation_main_script_tr");
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::transient_waittill("revolver_offered", "stpetersburg_interrogation_escort_script_tr", undefined);
  level endon("missionfailed");
  level endon("interrogation_abandoned");
  scripts\engine\utility::flag_set("interrogation_start");
  thread scripts\sp\analytics::analytics_kleenex_update("Interrogation to end");
  interrogation_setup();
  thread scripts\engine\sp\utility::autosave_by_name("interrogation_start");

  if(getdvarint("stp_interrogation_phase") < 2) {
    interrogation_intro();
  } else {
    level.player allowmovement(1);
    scripts\engine\utility::flag_set("interrogation_escort_done");
    scripts\engine\utility::flag_set("warning_accepted");
    scripts\engine\utility::flag_set("lighting_interrogation_gameplay");
    level.blackoverlay fadeovertime(1);
    level.blackoverlay.alpha = 0;
    var0 = getEntArray("interrogation_handoff_clip", "targetname");
    scripts\engine\utility::array_delete(var0);
    var1 = getEnt("interrogation_hallway_intro_clip", "targetname");
    var1 delete();
    blendshape_enable(level.enforcer);
    blendshape_enable(level.price);
    level.familychair show();

    if(getdvarint("stp_interrogation_phase") == 2) {
      interrogation_rig_enable("family_handoff", "viewhands_hero_kyle_urban", 0.5, undefined, 1, 10, 10, 10, 10);
      thread interrogation_rig_disable("family_handoff");
      level.sonanimnode thread scripts\common\anim::anim_single_solo(level.player.rig, "family_handoff");
    }

    level.interrogationdoor thread scripts\engine\sp\utility::notify_delay("create_abandon_interact", 5);
  }

  player_post_escort_setup();
  interrogation_phase_revolver();
  interrogation_phase_dry_fire();
  interrogation_phase_final();
  interrogation_end();
}

function interrogation_setup() {
  player_setup();
  family_setup();
  interrogation_anim_setup();
  intimidate_setup();
  dialogue_setup();
  GscBinSkip4(0x35);
}

function player_setup() {
  player_give_gunless_loadout();
  player_interrogation_speed_setup();
  level.player setstance("stand");
  level.player scripts\common\utility::allow_offhand_weapons(0);
  level thread scripts\sp\utility::context_melee_enable(0);
  level.player modifybasefov(55, 0.2);
  setsaveddvar("MLMROTLMO", 0);
}

function family_setup() {
  var0 = getspawner("enforcer_wife", "targetname");
  var1 = getspawner("enforcer_son", "targetname");
  var2 = getdvarint("stp_interrogation_phase") > 1;

  if(!isDefined(level.enforcerwife)) {
    level.enforcerwife = var0 scripts\engine\sp\utility::spawn_ai(1);
    level.enforcerwife.name = "Ousa";
    level.enforcerwife.animname = "interrogation_mother";
    level.enforcerwife.skip_friendly_fire_check = 1;
    level.enforcerwife.allowdeath = 0;
    level.wifeanimnode = scripts\engine\utility::getStruct("wife_anim_node", "targetname");
    level.enforcerwife.anim_playvo_func = &scripts\engine\utility::playsoundontag;
  }

  if(!isDefined(level.enforcerson)) {
    level.enforcerson = var1 scripts\engine\sp\utility::spawn_ai(1);
    level.enforcerson.name = "Amon";
    level.enforcerson.animname = "interrogation_son";
    level.enforcerson.skip_friendly_fire_check = 1;
    level.enforcerson.allowdeath = 0;
    level.sonanimnode = scripts\engine\utility::getStruct("son_anim_node", "targetname");
    level.enforcerson.anim_playvo_func = &scripts\engine\utility::playsoundontag;
  }

  if(var2) {
    level.enforcerwife.civiliannameplate = 1;
    level.enforcerson.civiliannameplate = 1;
    level.enforcerwife notify("stop_civ_stationary_ff_penalty");
    level.enforcerson notify("stop_civ_stationary_ff_penalty");
    level.wifeanimnode notify("stop_loop");
    level.wifeanimnode thread scripts\common\anim::anim_loop_solo(level.enforcerwife, "idle_interrogate");
    level.sonanimnode notify("stop_loop");
    level.sonanimnode thread scripts\common\anim::anim_loop_solo(level.enforcerson, "idle_interrogate");

    if(!isDefined(level.enforcerwife.magic_bullet_shield)) {
      level.enforcerwife scripts\common\ai::magic_bullet_shield(1);
    }

    if(!isDefined(level.enforcerson.magic_bullet_shield)) {
      level.enforcerson scripts\common\ai::magic_bullet_shield(1);
      return;
    }

    return;
  }
}

function interrogation_anim_setup() {
  if(isDefined(level.enforcer.weapon)) {
    level.enforcer scripts\common\ai::gun_remove();
  }

  if(!isDefined(level.enforcer.magic_bullet_shield)) {
    level.enforcer scripts\common\ai::magic_bullet_shield();
  }

  level.enforcer actoraimassistoff();
  level.enforcer.animname = "interrogation_enforcer";
  level.enforcer setModel("body_villain_enforcer_interrogation");
  level.enforcer detach(level.enforcer.headmodel);
  level.enforcer.headmodel = "head_villain_enforcer_damage";
  level.enforcer attach(level.enforcer.headmodel);
  level.nikolai.ignoreall = 1;
  level.nikolai.animname = "nikolai";
  level.yegor.animname = "yegor";
  level.yegor scripts\common\ai::gun_remove();
  level.price.script_pushable = 0;
  level.price pushplayer(1);
  var0 = scripts\sp\utility::make_weapon("iw8_pi_cpapa");
  level.price scripts\anim\shared::forceuseweapon(var0, "primary");
  level.price scripts\common\ai::gun_remove();
  level.enforceranimnode = scripts\engine\utility::getStruct("enforcer_anim_node", "targetname");
  level.priceanimnode = scripts\engine\utility::getStruct("price_anim_node", "targetname");
  level.yegoranimnode = scripts\engine\utility::getStruct("yegor_anim_node", "targetname");
  level.outeranimnode = scripts\engine\utility::getStruct("outer_anim_node", "targetname");
  level.enforceranimnode notify("stop_loop");
  level.enforceranimnode thread scripts\common\anim::anim_loop_solo(level.enforcer, "idle_interrogate");
  level.yegoranimnode notify("stop_loop");
  level.yegoranimnode thread scripts\common\anim::anim_loop_solo(level.yegor, "idle_loop");
  interrogation_door_anim_setup();
  interrogation_chair_anim_setup();
  police_car_anim_setup();
  nikolai_van_anim_setup();
  script_lookat_setup();
}

function interrogation_door_anim_setup() {
  level.interrogationdoor = scripts\sp\door::get_interactive_door("interrogation_door");
  level.interrogationdoor scripts\sp\door::remove_open_prompts();
  level.interrogationdoor.animname = "interrogation_door";
  level.interrogationdoor useanimtree(level.scr_animtree["interrogation_door"]);
  var0 = getEnt("interrogation_door_clip", "targetname");
  var0 linkTo(level.interrogationdoor);
  level.garagedoor = getEnt("interrogation_garage_door", "targetname");
  level.garagedoor.animname = "garage_door";
  level.garagedoor useanimtree(level.scr_animtree["garage_door"]);
  var1 = getEnt("interrogation_garage_door_clip", "targetname");
  var1 linkTo(level.garagedoor);
}

function interrogation_chair_anim_setup() {
  level.enforcerchair = getEnt("enforcer_chair", "targetname");
  level.enforcerchair.animname = "interrogation_chair_enforcer";
  level.enforcerchair useanimtree(level.scr_animtree["interrogation_chair_enforcer"]);
  level.enforceranimnode thread scripts\common\anim::anim_loop_solo(level.enforcerchair, "chair_idle", "enforcer_chair_loop_end");
  level.familychair = getEnt("family_chair", "targetname");
  level.familychair.animname = "interrogation_chair_family";
  level.familychair useanimtree(level.scr_animtree["interrogation_chair_family"]);
  level.wifeanimnode thread scripts\common\anim::anim_loop_solo(level.familychair, "chair_idle", "family_chair_loop_end");
  level.familychair hide();
}

function police_car_anim_setup() {
  level.policecar = getEnt("interrogation_end_police_car", "targetname");
  level.policecar.animname = "skilo";
  level.policecar useanimtree(level.scr_animtree["skilo"]);
}

function nikolai_van_anim_setup() {
  level.nikolaivan = getEnt("interrogation_van", "script_noteworthy");
  level.nikolaivan.animname = "van";
  level.nikolaivan useanimtree(level.scr_animtree["van"]);
  var0 = getEnt("nikolai_van_light", "targetname");
  var0 linkTo(level.nikolaivan);
  var1 = getEnt("clip_van_door_rear_left", "targetname");
  var1 linkTo(level.nikolaivan, "tag_door_rear_left");
  var2 = getEnt("clip_van_door_rear_right", "targetname");
  var2 linkTo(level.nikolaivan, "tag_door_rear_right");
  playFXOnTag(scripts\engine\utility::getfx("vfx_stpburg_backup_lights_utility_van"), level.nikolaivan, "tag_hood");
}

function script_lookat_setup() {
  var0 = scripts\engine\utility::spawn_tag_origin(level.player getEye() + (0, 0, 15), level.player.angles);
  var0 linkTo(level.player);
  var1 = level.player getplayerangles();
  var2 = level.player getEye() + anglestoleft(var1) * 25 + anglestoup(var1) * -15;
  var3 = scripts\engine\utility::spawn_tag_origin(var2, level.player.angles);
  var3 linkTo(level.player);
  var4 = anglesToForward(level.enforcer.angles);
  var5 = scripts\engine\utility::spawn_tag_origin(level.enforcer.origin + (0, 0, -64) + var4 * 64, level.enforcer.angles);
  var6 = getEnt("revolver", "targetname");
  var7 = scripts\engine\utility::spawn_tag_origin(var6.origin + (0, 0, 10), var6.angles);
  level.player.headlookatoffset = var0;
  level.player.escortlookatoffset = var3;
  level.enforcer.defeatedlookat = var5;
  level.proptablelookat = var7;
}

function intimidate_setup() {
  level.enforcer.currentanimpriority = -1;
  level.currentrelativeanimpriority = -1;
  level.enforcer.health = 8;
  level.enforcerwife.health = 6;
  level.enforcerson.health = 4;
  level.actioncount = 0;
  level.alivestates = [1, 1, 1];
  level.animpriority["idle"] = 0;
  level.animpriority["ads"] = 10;
  level.animpriority["react_aim"] = 20;
  level.animpriority["react_ads"] = 20;
  level.animpriority["whizby"] = 30;
  level.animpriority["dry_fire"] = 40;
  level.animpriority["react_dry_fire"] = 40;
  level.animpriority["shot"] = 50;
  level.animpriority["react_shot"] = 50;
  level.animpriority["scene"] = 70;
  level.animpriority["react_death"] = 90;
  level.animpriority["death"] = 99;
  level.previousanim["The Butcher"] = "idle_interrogate";
  level.previousanim["Ousa"] = "idle_interrogate";
  level.previousanim["Amon"] = "idle_interrogate";
}

function dialogue_setup() {
  scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_lines_setup();
  dialogue_cooldown_setup();
  thread dialogue_cooldown_timer();
  level.revolvervodone["ads_enforcer"] = 0;
  level.revolvervodone["aim_family"] = 0;
  level.revolvervodone["ads_family"] = 0;
}

function dialogue_cooldown_setup() {
  level.dialoguecooldowns["idle"] = [1, 0];
  level.dialoguecooldowns["inactive"] = [1, 0];
  level.dialoguecooldowns["price_ads"] = [7, 0];
  level.dialoguecooldowns["enforcer_ads"] = [11, 0];
  level.dialoguecooldowns["enforcer_defeated"] = [999, 0];
  level.dialoguecooldowns["enforcer_melee"] = [1, 0];
  level.dialoguecooldowns["enforcer_whiz"] = [5, 0];
  level.dialoguecooldowns["enforcer_shot"] = [3, 0];
  level.dialoguecooldowns["family_melee"] = [5, 0];
  level.dialoguecooldowns["family_ads"] = [10, 0];
  level.dialoguecooldowns["family_shot"] = [2, 0];
  level.dialoguecooldowns["enforcer_death"] = [1, 0];
  level.dialoguecooldowns["wife_death"] = [1, 0];
  level.dialoguecooldowns["son_death"] = [1, 0];
  level.dialoguecooldowns["family_death"] = [1, 0];
}

function monitor_setup() {
  scripts\engine\utility::flag_wait("revolver_picked_up");
  GscBinSkip4(0x35);
}

function interrogation_intro() {
  interrogation_intro_init();
  thread nikolai_intro_handler();
  door_intro_performance();
  scripts\engine\utility::flag_wait("van_interact_available");
  van_acquire_interact();
  thread interrogation_family_escort();
  scripts\engine\utility::trigger_on("escort_hallway_trigger", "targetname");
  scripts\engine\sp\utility::trigger_wait_targetname("escort_hallway_trigger");
  thread scripts\engine\sp\utility::autosave_by_name("content_warning");
  price_content_warning();
  scripts\engine\utility::flag_wait("interrogation_escort_done");
  level.outeranimnode scripts\engine\utility::delaythread(5.7, &scripts\common\anim::anim_last_frame_solo, level.interrogationdoor, "decline_exit");
  var0 = getEnt("interrogation_hallway_clip", "targetname");
  var0 show();
  level.interrogationdoor thread scripts\engine\sp\utility::notify_delay("create_abandon_interact", 6);
}

function interrogation_intro_init() {
  scripts\engine\utility::trigger_off("escort_slowdown_trigger", "targetname");
  scripts\engine\utility::trigger_off("escort_hallway_trigger", "targetname");
  scripts\engine\utility::trigger_off("escort_handoff_trigger", "targetname");
  var0 = getEnt("interrogation_hallway_clip", "targetname");
  var0 hide();
  var1 = getEnt("interrogation_nikolai_clip", "targetname");
  var1 hide();
  thread scripts\sp\maps\stpetersburg\stpetersburg_utility::interrogation_room_door_open("interrogation_garage_door", 0.05);
  level.nikolaivan scripts\engine\sp\utility::anim_stopanimScripted();
  level.wifeanimnode notify("stop_loop");
  level.sonanimnode notify("stop_loop");
  level.outeranimnode thread scripts\common\anim::anim_loop_solo(level.nikolaivan, "acquire_idle");
  level.player allowmovement(1);
  blendshape_enable(level.nikolai);
  blendshape_enable(level.enforcerwife);
}

function interrogation_intro_catchup() {
  level.player allowmelee(0);
}

function door_intro_performance() {
  if(getdvarint("stp_interrogation_phase") == 0) {
    scripts\engine\utility::exploder("blood_fx");
    scripts\engine\utility::exploder("spit_fx");
    thread delay_fade(10, 0);
    interrogation_intro_camera();
    thread scripts\engine\sp\utility::autosave_now_silent();
  } else {
    level.blackoverlay fadeovertime(1);
    level.blackoverlay.alpha = 0;
    level notify("van_intro_trigger_startpoint");
  }

  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_door_intro_linger();
  scripts\engine\utility::flag_set("van_retrieve_package");
  scripts\engine\utility::flag_set("lighting_interrogation_gameplay");
  thread door_intro_end();
}

function delay_fade(var0, var1) {
  wait var0;
  level.blackoverlay fadeovertime(3.5);
  level.blackoverlay.alpha = var1;
}

function interrogation_intro_camera() {
  level.player lerpfovscalefactor(0, 0);
  level.player enableinvulnerability();
  level.player playerdisabletriggers();
  level.player cleardamageindicators();
  level.player freezecontrols(1);
  level.player hidelegsandshadow();
  level.player scripts\common\utility::allow_cinematic_motion(0, "intro");
  setomnvar("ui_hide_hud", 1);
  scripts\engine\utility::flag_set("lighting_interrogation_intro_cinematic");
  interrogation_rig_enable("interrogation_intro", undefined, 0.1, undefined, 0);
  thread interrogation_cine_letterboxing();
  var0 = getspawner("stakeout_fake_player", "targetname");
  var0.count = 1;
  var1 = var0 scripts\engine\sp\utility::spawn_ai(1);
  var1.animname = "fake_player";
  var1 scripts\common\ai::gun_remove();
  var1 visiblenotsolid();
  name_hide_array([level.enforcer, level.yegor, level.price]);
  scripts\engine\utility::flag_set("flag_bink_active");
  var2 = level.enforceranimnode;
  var3 = getanimlength(level.player.rig scripts\engine\utility::getanim("interrogation_intro"));
  level thread scripts\engine\sp\utility::notify_delay("stop_cine_letterboxing", var3 - 1.5);
  level thread scripts\engine\sp\utility::notify_delay("van_intro_trigger", var3 - 3);
  thread interrogation_dof_settings(var1);
  level.yegoranimnode thread scripts\common\anim::anim_single_solo(level.interrogationdoor, "interrogation_intro");
  var4 = [level.enforcer, level.yegor, level.price, level.player.rig, var1];
  var5 = scripts\engine\utility::array_combine(var4, [level.interrogationdoor]);
  thread interrogation_cine_skip(var5, "interrogation_intro", 1);
  thread interrogation_rig_disable("interrogation_intro");
  var2 scripts\common\anim::anim_single(var4, "interrogation_intro");
  scripts\sp\utility::userskip_stop();
  level.player showlegsandshadow();
  level.player freezecontrols(0);
  level.player playerenabletriggers();
  level.player disableinvulnerability();
  level.player scripts\common\utility::allow_cinematic_motion(1, "intro");
  setomnvar("ui_hide_hud", 0);
  var1 delete();
  name_show_array([level.enforcer, level.yegor, level.price]);
  scripts\engine\utility::flag_clear("flag_bink_active");
}

function interrogation_dof_settings(var0) {
  level endon("intro_skipped");
  setsaveddvar("SLSMSSTQP", ".1");
  level.player modifybasefov(65, 0.05);
  level.enforcer thread scripts\engine\sp\utility::dof_enable_autofocus(1.4, 5, undefined, undefined, "tag_eye", undefined, 1);
  wait 17;
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(1.4, 1, undefined, undefined, "tag_eye", undefined, 1);
  wait 10;
  level.player modifybasefov(55, 10);
  var0 thread scripts\engine\sp\utility::dof_enable_autofocus(1, 3, undefined, undefined, "tag_eye", undefined, 1);
  wait 10;
  level.price thread scripts\engine\sp\utility::dof_enable_autofocus(1, 2, undefined, undefined, "tag_eye", undefined, 1);
  wait 6;
  var0 thread scripts\engine\sp\utility::dof_enable_autofocus(1.4, 2, undefined, undefined, "tag_eye", undefined, 1);
  wait 2;
  scripts\engine\sp\utility::dof_disable();
  setsaveddvar("SLSMSSTQP", "9");
}

function interrogation_cine_letterboxing() {
  hidecinematicletterboxing(2, 0);
  level waittill("stop_cine_letterboxing");
  getrandomnodedestination(1.5, 0);
}

#using_animtree("");

function interrogation_cine_skip(var0, var1, var2) {
  var3 = scripts\sp\utility::userskip_wait();

  if(!var3) {
    return;
  }

  scripts\sp\hud_util::fade_out(0);
  var4 = 0.5;

  foreach(var6 in var0) {
    if(!isDefined(var6)) {
      continue;
    }

    var7 = getanimlength(var6 scripts\engine\utility::getanim(var1));
    var8 = (var7 - var4) / var7;
    var6 setanimtime(var6 scripts\engine\utility::getanim(var1), var8);
  }

  if(istrue(var2)) {
    level.enforcer stopsounds();
    level.price stopsounds();
    level.yegor stopsounds();
    level.price scripts\sp\anim_notetrack::mayhem_end(%stp_wh_010_intro3p_price_face);
    var10 = scripts\engine\utility::ter_op(scripts\engine\utility::flag("intro_butcher_mayhem_b"), %stp_wh_010_intro3p_butcher_partb_face, $stp_wh_010_intro3p_butcher_parta_face);
    level.enforcer scripts\sp\anim_notetrack::mayhem_end(var10);
    var11 = scripts\engine\utility::ter_op(scripts\engine\utility::flag("intro_yegor_mayhem_b"), %stp_wh_010_intro3p_yegor_partb_face, %stp_wh_010_intro3p_yegor_parta_face);
    level.yegor scripts\sp\anim_notetrack::mayhem_end(var11);
    level notify("intro_skipped");
    level.blackoverlay.alpha = 0;
    level.player lerpfovscalefactor(1, 0);
    level.player modifybasefov(55, 0.2);
    wait 0.5;
    getrandomnodedestination(0.4, 0);
    scripts\sp\hud_util::fade_in(0.05);
    return;
  }

  level.player setclienttriggeraudiozone("fade_to_black", 0.1);
  scripts\engine\utility::delaythread(0.2, &scripts\sp\hud_util::fade_in, 0.05);
  scripts\engine\sp\utility::nextmission();
}

function door_intro_end() {
  level.yegoranimnode notify("stop_loop");
  level.yegoranimnode thread scripts\common\anim::anim_loop_solo(level.yegor, "room_idle");
  target_restore_idle_anim(level.enforcer);
  level.priceanimnode notify("stop_loop");
  level.priceanimnode thread scripts\common\anim::anim_loop_solo(level.price, "idle_loop");
  level.interrogationdoor.open_struct.no_open_interact = undefined;
  level.interrogationdoor.locked = 1;
  level.interrogationdoor.open_struct scripts\sp\door::create_open_interact_hint();
  level.interrogationdoor.open_struct.cursor_hint_ent sethintdisplayrange(375);
}

function nikolai_intro_handler() {
  level.nikolaivan endon("trigger");
  var0 = level scripts\engine\utility::waittill_any_return("van_intro_trigger", "intro_skipped", "van_intro_trigger_startpoint");
  GscBinSkip4(0x35);
}

function van_intro_anim(var0) {
  var1 = [level.nikolaivan, level.enforcerwife, level.enforcerson];
  level.outeranimnode thread scripts\common\anim::anim_single(var1, "acquire_intro");
  wait 0.1;

  if(istrue(var0)) {
    level.nikolaivan playSound("stp_wh_010_interrogation_van_back_in_skip_intro");
    var2 = getanimlength(level.nikolaivan scripts\engine\utility::getanim("acquire_intro"));

    foreach(var4 in var1) {
      var4 setanimtime(var4 scripts\engine\utility::getanim("acquire_intro"), 3 / var2);
    }
  } else {
    level.nikolaivan playSound("stp_wh_010_interrogation_van_back_in_full");
  }

  level.nikolaivan waittillmatch("single anim", "end");
  level.outeranimnode thread scripts\common\anim::anim_loop([level.enforcerwife, level.enforcerson], "acquire_idle", "family_loop_stop");
}

function nikolai_intro_nags() {
  scripts\engine\sp\utility::trigger_wait_targetname("nikolai_package_prompt");
  scripts\engine\utility::flag_wait("nikolai_intro_vo");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_nikolai_intro();
  var0 = 0;

  if(scripts\engine\utility::flag("nikolai_nag_ready")) {
    level.outeranimnode thread scripts\common\anim::anim_single_solo(level.nikolai, "acquire_intro_nag_far_1");
    var1 = getanimlength(level.nikolai scripts\engine\utility::getanim("acquire_intro_nag_far_1"));
    level.outeranimnode notify("stop_loop");
    level.outeranimnode scripts\engine\sp\utility::delaychildthread(var1, &scripts\common\anim::anim_loop_solo, level.nikolai, "acquire_intro_idle");
    var0 = var1;
  }

  var2 = scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_intro_nikolai_nags();
  var3 = ["acquire_intro_nag_near_1", "acquire_intro_nag_near_2"];
  var4 = ["acquire_intro_nag_far_1", "acquire_intro_nag_far_2"];
  var5 = 62500;
  scripts\engine\sp\utility::delaychildthread(var0, &nikolai_nag_handler, var2, var3, var4, "acquire_intro_idle", var5);
}

function nikolai_car_nags() {
  var0 = scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_acquire_nikolai_nags();
  var1 = ["acquire_nag_near_1", "acquire_nag_near_2"];
  var2 = ["acquire_nag_far_1", "acquire_nag_far_2"];
  var3 = 40000;
  nikolai_nag_handler(var0, var1, var2, "acquire_idle", var3, undefined, "van_retrieve_package");
}

function nikolai_escort_nags() {
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_acquire_nikolai_remark();
  var0 = scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_escort_nikolai_nags();
  var1 = ["acquire_nag_near_1", "acquire_nag_near_2"];
  var2 = ["acquire_nag_far_1", "acquire_nag_far_2"];
  var3 = 62500;
  wait 4;
  nikolai_nag_handler(var0, var1, var2, "acquire_idle", var3, "escort_slowdown", undefined, 1);
}

function nikolai_nag_handler(var0, var1, var2, var3, var4, var5, var6, var7) {
  level endon("escort_disengage");

  while(var0["near"].size > 0 || var0["far"].size > 0) {
    wait randomfloatrange(6, 8);

    if(istrue(var7)) {
      if(!scripts\engine\utility::flag("interrogation_escort_idle") && distance(level.player.origin, level.interrogationdoor.origin) < 700) {
        continue;
      }
    }

    var8 = undefined;
    var9 = undefined;
    var10 = distancesquared(level.player.origin, level.nikolai.origin);

    if(var10 <= var4 && var1.size > 0) {
      var8 = scripts\engine\utility::random(var1);
      var9 = "near";
    } else if(var10 > var4 && var2.size > 0) {
      var8 = scripts\engine\utility::random(var2);
      var9 = "far";
    }

    if(isDefined(var5) && scripts\engine\utility::flag_exist(var5) && scripts\engine\utility::flag(var5)) {
      break;
    }

    if(isDefined(var6) && scripts\engine\utility::flag_exist(var6) && !scripts\engine\utility::flag(var6)) {
      break;
    }

    if(isDefined(var8)) {
      level.outeranimnode thread scripts\common\anim::anim_single_solo(level.nikolai, var8);
      level waittill("nik_nag_trigger");
      thread scripts\sp\maps\stpetersburg\stpetersburg_utility::add_dialogue_line_nikolai(var0[var9][0][0], var0[var9][0][1]);
      level.nikolai waittillmatch("single anim", "end");
      level.outeranimnode notify("stop_loop");
      level.outeranimnode thread scripts\common\anim::anim_loop_solo(level.nikolai, var3);
      var0 = scripts\engine\utility::array_remove_index(var0["near"], 0);
      var0 = scripts\engine\utility::array_remove_index(var0["far"], 0);
    }
  }
}

function van_acquire_interact() {
  wait_for_van_interact();
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_nikolai_van_open_remark();
  level.player lerpfovscalefactor(0, 0.3);
  level.nikolai detach("decor_cigarette__01", "tag_accessory_right");
  turn_off_headtracking_solo(level.nikolai);
  thread scripts\sp\maps\stpetersburg\stpetersburg_lighting::dof_interrogation_van_open();
  interrogation_rig_enable("acquire_open", "viewhands_hero_kyle_urban", undefined, level.outeranimnode, undefined, 15, 15, 10, 0);
  level.outeranimnode notify("stop_loop");
  level.outeranimnode thread scripts\common\anim::anim_single_solo(level.nikolai, "acquire_open");
  var0 = getanimlength(level.nikolai scripts\engine\utility::getanim("acquire_open"));
  level.outeranimnode scripts\engine\utility::delaythread(var0, &scripts\common\anim::anim_loop_solo, level.nikolai, "acquire_idle");
  scripts\engine\utility::delaythread(var0, &nikolai_car_nags);
  var1 = [level.nikolaivan, level.player.rig, level.enforcerwife, level.enforcerson];
  thread interrogation_rig_disable("acquire_open");
  level.outeranimnode scripts\common\anim::anim_single(var1, "acquire_open");
  level.outeranimnode notify("family_loop_stop");
  level.outeranimnode thread scripts\common\anim::anim_loop([level.enforcerwife, level.enforcerson], "acquire_idle", "family_loop_stop");
  wait_for_package_interact();
  level.player lerpfovscalefactor(0, 0.3);
  scripts\engine\utility::flag_clear("van_retrieve_package");
  interrogation_rig_enable("acquire", "viewhands_hero_kyle_urban", undefined, level.outeranimnode, 1, 10, 10, 10, 10);
  thread acquire_player_anim();
  var1 = [level.enforcerwife, level.enforcerson];
  level.outeranimnode scripts\common\anim::anim_single(var1, "acquire");
  var2 = getEnt("interrogation_nikolai_clip", "targetname");
  var2 show();
  thread delete_on_level_notify(var2);
  thread nikolai_escort_nags();
}

function acquire_player_anim() {
  thread interrogation_rig_disable("acquire", undefined, 1);
  level.outeranimnode scripts\common\anim::anim_single_solo(level.player.rig, "acquire");
}

function wait_for_van_interact() {
  var0 = level.nikolaivan gettagorigin("tag_door_rear_right");
  var1 = level.nikolaivan gettagangles("tag_door_rear_right");
  var0 += rotatevector((-2.5, 27, -4.5), var1);
  var1 = anglestoaxis(var1);
  GscBinSkip0(0x2e, "forward", var1["forward"] * -1);
}

function wait_for_package_interact() {
  var0 = level.enforcerwife gettagorigin("j_cosmetic_3");
  var1 = anglestoaxis(level.nikolaivan.angles);
  GscBinSkip0(0x2e, "forward", var1["forward"] * -1);
}

function interrogation_family_escort() {
  level endon("warning_declined");
  blendshape_disable(level.enforcerwife);
  scripts\sp\maps\stpetersburg\stpetersburg_interrogation_escort::escort_init();
  scripts\sp\maps\stpetersburg\stpetersburg_interrogation_escort::escort_engage();
  level.player playRumbleOnEntity("damage_light");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_escort_start();
  level.player scripts\sp\player::focus_display_hint(40, undefined, level, "escort_hallway_trigger");
  scripts\engine\utility::trigger_on("escort_slowdown_trigger", "targetname");
  scripts\engine\utility::flag_wait("escort_slowdown");
  level.nikolai scripts\engine\utility::delaythread(1, &scripts\sp\maps\stpetersburg\stpetersburg_utility::dialogue_stop);
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_escort_halt();
  wait 0.2;
  scripts\sp\maps\stpetersburg\stpetersburg_interrogation_escort::set_escort_phase(1);
  scripts\engine\utility::trigger_on("escort_handoff_trigger", "targetname");
  scripts\engine\sp\utility::trigger_wait_targetname("escort_handoff_trigger");
  var0 = getEnt("escort_handoff_trigger", "targetname");
  var1 = 0.5;
  var2 = getEntArray("interrogation_handoff_clip", "targetname");

  for(;;) {
    if(level.player istouching(var0)) {
      if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.yegor getEye(), cos(25)) || scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.familychair.origin + (0, 0, 50), cos(35))) {
        var3 = vectorNormalize(level.familychair.origin + (0, 0, 50) - level.player getEye());
        var4 = anglesToForward(level.player getplayerangles());
        var5 = vectordot(var4, var3);
        var5 = clamp(abs(var5), 0.5, 1);
        var1 = 0.5 + 0.75 * (1 - var5) * 2;
        break;
      }
    }

    waitframe();
  }

  turn_off_headtracking_solo(level.yegor);
  thread interrogation_disengage(0, var1);
  interrogation_rig_enable("family_handoff", "viewhands_hero_kyle_urban", var1, undefined, 1, 15, 15, 15, 10);
  level.player.escortlookatoffset delete();
  scripts\engine\utility::array_delete(var2);
  scripts\engine\utility::flag_wait("interrogation_escort_done");
  thread interrogation_rig_disable("family_handoff");
  level.sonanimnode scripts\common\anim::anim_single_solo(level.player.rig, "family_handoff");
  level.player lerpfovscalefactor(1, 0.5);
}

function interrogation_disengage(var0, var1) {
  [level.enforcerwife] = scripts\sp\maps\stpetersburg\stpetersburg_interrogation_escort::trigger_escort_disengage(var0, var1);
  level.enforcerwife.name = "Ousa";
  level.enforcerwife.animname = "interrogation_mother";
  level.enforcerwife.civiliannameplate = 1;
  level.enforcerwife.skip_friendly_fire_check = 1;
  level.enforcerwife.allowdeath = 0;
  level.enforcerson = var2[1];
  level.enforcerson.name = "Amon";
  level.enforcerson.animname = "interrogation_son";
  level.enforcerson.civiliannameplate = 1;
  level.enforcerson.skip_friendly_fire_check = 1;
  GscBinSkip4(0x6e, level.enforcerwife, "wife_dead");
}

function price_content_warning() {
  level.interrogationdoor scripts\sp\door::remove_open_prompts();
  var0 = getEnt("interrogation_hallway_intro_clip", "targetname");
  var0 delete();
  var1 = getEnt("interrogation_hallway_clip", "targetname");
  var1 show();
  blendshape_disable(level.nikolai);
  blendshape_enable(level.price);
  level.price scripts\engine\utility::delaythread(2, &turn_on_headtracking_solo, level.player);
  level.priceanimnode scripts\common\anim::anim_single([level.interrogationdoor, level.price], "door_open");
  level.priceanimnode notify("stop_loop");
  level.priceanimnode thread scripts\common\anim::anim_loop_solo(level.price, "content_warning_idle");

  if(should_skip_interrogation()) {
    skip_interrogation();
    return;
  }

  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_price_content_warning_nags();
  content_warning_ui();
}

function skip_interrogation() {
  scripts\sp\analytics::analytics_event_upload("Player Skipped Interrogation", 1);
  scripts\engine\utility::flag_set("warning_declined");
  interrogation_rig_enable("warning_decline", "viewhands_hero_kyle_urban", 0.5, undefined, 1, 10, 10, 10, 10);
  interrogation_disengage(1);
  level.wifeanimnode thread scripts\common\anim::anim_single_solo(level.player.rig, "warning_decline");
  level.sonanimnode thread scripts\common\anim::anim_single_solo(level.interrogationdoor, "warning_decline");
  var0 = [level.price, level.enforcerwife, level.enforcerson, level.enforcer, level.yegor];
  level.priceanimnode thread scripts\common\anim::anim_single(var0, "warning_decline");
  level.price scripts\engine\utility::delaythread(1.5, &turn_off_headtracking_solo);
  scripts\engine\utility::delaythread(3, &interrogation_abandon_outro);
}

function content_warning_ui() {
  level endon("interrogation_escort_done");
  setomnvar("ui_dialogue_prompts_choice", 0);
  setomnvar("ui_dialogue_prompts_option_a", "stpetersburg/interrogation_accept");
  setomnvar("ui_dialogue_prompts_option_b", "none");
  setomnvar("ui_dialogue_prompts_option_c", "stpetersburg/interrogation_reject");
  setomnvar("ui_dialogue_prompts_option_d", "none");
  setomnvar("ui_dialogue_prompts_duration", 0);
  setomnvar("ui_dialogue_prompts_active", 0);
  var0 = 0;
  var1 = getEnt("content_warning_zone", "targetname");
  var1 waittill("trigger");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_price_kyle_content_warning();
  level notify("warning_nags_end");
  level.priceanimnode scripts\common\anim::anim_single_solo(level.price, "content_warning");
  level.priceanimnode notify("stop_loop");
  level.priceanimnode thread scripts\common\anim::anim_loop_solo(level.price, "content_warning_idle");

  for(;;) {
    if(level.player istouching(var1) && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.price getEye(), cos(35))) {
      if(!var0) {
        setomnvar("ui_dialogue_prompts_active", 1);
        var0 = 1;
      }

      if(level.player buttonPressed("BUTTON_X") || level.player buttonPressed("1")) {
        scripts\sp\analytics::analytics_event_upload("Player Skipped Interrogation", 0);
        setomnvar("ui_dialogue_prompts_choice", 1);
        setomnvar("ui_dialogue_prompts_active", 0);
        scripts\engine\utility::flag_set("warning_accepted");
        blendshape_enable(level.enforcer);
        thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_price_warning_accepted();
        wait 1;
        GscBinSkip4(0x35);
      }

      if(level.player buttonPressed("BUTTON_B") || level.player buttonPressed("2")) {
        if(level.player usinggamepad()) {
          setomnvar("ui_dialogue_prompts_choice", 3);
        } else {
          setomnvar("ui_dialogue_prompts_choice", 2);
        }

        setomnvar("ui_dialogue_prompts_active", 0);
        thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_price_warning_rejected();
        skip_interrogation();
        break;
      }
    } else {
      setomnvar("ui_dialogue_prompts_active", 0);
      var0 = 0;
    }

    waitframe();
  }
}

function room_enter_threads() {
  GscBinSkip4(0x35);
}

function room_enter_yegor() {
  level endon("escort_disengage");
  turn_on_headtracking_solo(level.yegor, level.player);
  GscBinSkip4(0x35);
}

function room_enter_chair_anim() {
  level.familychair show();
  level.wifeanimnode scripts\common\anim::anim_single_solo(level.familychair, "room_enter");
  level.wifeanimnode notify("family_chair_loop_end");
  level.wifeanimnode thread scripts\common\anim::anim_loop_solo(level.familychair, "chair_idle", "family_chair_loop_end");
}

function room_enter_enforcer() {
  level endon("escort_disengage");
  childthread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_room_enter();
  turn_on_headtracking_solo(level.enforcer, level.player.escortlookatoffset, "enforcer_dead");
  level.enforceranimnode scripts\common\anim::anim_single_solo(level.enforcer, "room_enter");
  target_restore_idle_anim(level.enforcer);
}

function room_enter_price() {
  level.price scripts\engine\utility::delaythread(1.5, &turn_off_headtracking_solo);
  level.priceanimnode thread scripts\common\anim::anim_single_solo(level.interrogationdoor, "warning_accept");
  level.priceanimnode scripts\common\anim::anim_single_solo(level.price, "warning_accept");
  level.priceanimnode notify("stop_loop");
  level.priceanimnode thread scripts\common\anim::anim_loop_solo(level.price, "warning_accept_idle");
  turn_off_headtracking_solo(level.price);
}

function interrogation_phase_revolver() {
  level.player endon("dry_fired");
  turn_off_headtracking();
  thread interrogation_abandon_handler();
  scripts\engine\utility::flag_clear("pause_nikolai_vo");

  if(getdvarint("stp_interrogation_phase") < 3) {
    thread pre_fire_performance();
    level waittill("mother_hood_switch");
    switch_head_to_hood(level.enforcerwife, "hat_civ_female_interrogation");
    level waittill("son_hood_switch");
    switch_head_to_hood(level.enforcerson, "hat_civ_child_interrogation");
    var0 = getEnt("revolver", "targetname");
    level waittill("gun_placed");
    level.price scripts\common\ai::gun_remove();
    var0 show();
    wait 0.75;
    scripts\engine\utility::flag_set("revolver_offered");
    var0 scripts\sp\player\cursor_hint::create_cursor_hint("j_trigger", undefined, &"STPETERSBURG/INTERROGATION_PISTOL", 360, 150, 60, 1, undefined, 0, undefined, "duration_medium");
    level.player scripts\sp\player::focus_display_hint(10, undefined, [var0, level], ["trigger", "interrogation_abandoned"]);
    var0 waittill("trigger");
    thread scripts\engine\sp\utility::autosave_now_silent();
  } else {
    interrogation_room_catchup();
  }

  scripts\engine\sp\utility::delaychildthread(3, &revolver_ads_hint);
  var1 = getEnt("player_handoff_clip", "targetname");
  var1 delete();
  thread player_gun_pickup();
  target_restore_idle_anim(level.enforcerson);
  level.enforceranimnode notify("stop_loop");
  level.enforceranimnode thread scripts\common\anim::anim_single_solo(level.enforcer, "scene_gun_pickup");
  var2 = getanimlength(level.enforcer scripts\engine\utility::getanim("scene_gun_pickup"));
  scripts\engine\sp\utility::delaychildthread(var2, &target_restore_idle_anim, level.enforcer);
  thread price_gun_pickup_anims();
  childthread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_weapon_pickup();
  level thread scripts\engine\sp\utility::notify_delay("enable_ads_reactions_family", 3);
}

function price_gun_pickup_anims() {
  level.player endon("dry_fired");
  level endon("interrogation_abandoned");
  level endon("price_ads_reaction");
  wait 1;
  level.priceanimnode notify("stop_loop");
  level.priceanimnode scripts\common\anim::anim_single_solo(level.price, "scene_gun_pickup");
  level.priceanimnode scripts\common\anim::anim_loop_solo(level.price, "idle_loop");
}

function player_gun_pickup() {
  var0 = getEnt("revolver", "targetname");
  var1 = distance2d(var0.origin, level.player.origin);
  var2 = 0.5 + 0.5 * (var1 - 21) * 0.042;
  interrogation_rig_enable("gun_pickup", "viewhands_hero_kyle_urban", var2, undefined, 1, 5, 5, 5, 5);
  var0 linkTo(level.player.rig, "tag_weapon_right");
  thread interrogation_rig_disable("gun_pickup", 0.25);
  level.yegoranimnode scripts\common\anim::anim_single_solo(level.player.rig, "gun_pickup");
  var0 unlink();
  var0 delete();
  scripts\engine\utility::flag_set("revolver_picked_up");
  level.revolver = scripts\sp\utility::make_weapon("iw8_pi_cpapa_stpetersburg", ["rec_cpapa", "front_cpapa", "backno_cpapa", "ammo_cpapa"]);
  level.player takeweapon("iw8_gunless_ik");
  level.player giveweapon(level.revolver, 0, 0, -1, 0);
  level.player setweaponammoclip(level.revolver, 6);
  level.player switchtoweapon(level.revolver);
  level.player setnextbulletdryfire(1);
  thread scripts\sp\maps\stpetersburg\stpetersburg_lighting::dof_interrogation_revolver_pickup();
}

function interrogation_abandon_handler() {
  level.interrogationdoor waittill("create_abandon_interact");
  level.interrogationdoor scripts\sp\door::reset_door();
  level.interrogationdoor.open_struct scripts\sp\door::create_open_interact_hint(&"STPETERSBURG/INTERROGATION_LEAVE");
  level.interrogationdoor.open_struct.origin = level.interrogationdoor gettagorigin("tag_door_handle");
  level.interrogationdoor.open_struct.origin -= (0, 1.5, 0);
  thread interrogation_abandon_price_nag();
  var0 = level.interrogationdoor scripts\engine\utility::waittill_any_return("trigger", "abandon_end");

  if(var0 == "trigger") {
    scripts\engine\utility::flag_set("interrogation_abandoned");
    scripts\sp\analytics::analytics_event_upload("Player Skipped Interrogation", 1);
    level.price stopsounds();
    level.enforcer stopsounds();
    level.enforcerwife stopsounds();
    level.enforcerwife stoploopsound();
    level.enforcerson stopsounds();

    if(isalive(level.yegor)) {
      level.yegor stopsounds();
    }

    level.player scripts\engine\utility::delaycall(0.25, &playrumbleonentity, "damage_light");
    level.player freezecontrols(1);
    level.interrogationdoor scripts\game\sp\door::remove_door_snake_cam_ability();
    level.interrogationdoor scripts\sp\door::remove_open_ability();
    level.interrogationdoor thread scripts\sp\door::door_open_completely(level.player, 2);
    level.priceanimnode notify("stop_loop");
    level.priceanimnode notify("single anim", "end");
    level.priceanimnode thread scripts\common\anim::anim_single_solo(level.price, "abandon_trigger");
    thread interrogation_abandon_outro();
    return;
  }

  level.interrogationdoor scripts\sp\door::remove_open_ability();
}

function interrogation_abandon_price_nag() {
  level endon("intel_revealed");
  level.interrogationdoor endon("abandon_end");
  var0 = 0;

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.interrogationdoor.origin + (29, 5, 35), cos(25))) {
      var0++;

      if(var0 > 2) {
        break;
      }
    } else {
      var0 = 0;
    }

    wait 0.5;
  }
}

function revolver_ads_hint() {
  level.player endon("ads_pressed");
  var0 = 0;
  var1 = 3;

  while(var0 < var1) {
    level.player waittill("attack_pressed");
    var0++;
  }
}

function interrogation_room_catchup() {
  if(isalive(level.yegor)) {
    level.yegor delete();
  }

  if(isDefined(level.player.escortlookatoffset)) {
    level.player.escortlookatoffset delete();
  }

  switch_head_to_hood(level.enforcerwife, "hat_civ_female_interrogation");
  switch_head_to_hood(level.enforcerson, "hat_civ_child_interrogation");
  var0 = getEnt("revolver", "targetname");

  if(isDefined(var0)) {
    var0 show();
    return;
  }
}

function switch_head_to_hood(var0) {
  self detach(self.headmodel);
  self.headmodel = var0;
  self attach(self.headmodel);
}

function pre_fire_performance() {
  level endon("interrogation_abandoned");
  level endon("revolver_picked_up");
  level.player endon("dry_fired");
  childthread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_room_intro();
  thread pre_fire_chair_anim();
  var0 = getEnt("interrogation_side_door", "targetname");
  var0.animname = "interrogation_side_door";
  var0 useanimtree(level.scr_animtree["interrogation_side_door"]);
  thread yegor_exit(var0);
  var1 = [level.enforcerwife, level.enforcerson, level.price, level.enforcer];
  level.wifeanimnode scripts\common\anim::anim_single(var1, "family_handoff");
  level.player notify("handoff_anims_complete");
  level.priceanimnode notify("stop_loop");
  level.priceanimnode thread scripts\common\anim::anim_loop_solo(level.price, "idle_loop");
  level.wifeanimnode notify("stop_loop");
  level.sonanimnode notify("stop_loop");
  target_restore_idle_anim(level.enforcer);
  target_restore_idle_anim(level.enforcerson);
}

function yegor_exit(var0) {
  level.yegoranimnode scripts\common\anim::anim_single([level.yegor, var0], "family_handoff");

  if(isalive(level.yegor)) {
    level.yegor delete();
    return;
  }
}

function pre_fire_chair_anim() {
  level.wifeanimnode scripts\common\anim::anim_single_solo(level.familychair, "family_handoff");
  level.wifeanimnode notify("family_chair_loop_end");
  level.wifeanimnode thread scripts\common\anim::anim_loop_solo(level.familychair, "chair_idle", "family_chair_loop_end");
}

function interrogation_phase_dry_fire() {
  level.player scripts\engine\utility::waittill_any("dry_fired", "weapon_fired");
  scripts\engine\utility::flag_set("dry_fire_complete");
  thread scripts\engine\sp\utility::autosave_now_silent();
  level.actioncount++;
  var0 = level.currentplayertarget;
  level.enforcerwife scripts\sp\maps\stpetersburg\stpetersburg_utility::dialogue_stop_and_clear_stack();
  level.enforcerson scripts\sp\maps\stpetersburg\stpetersburg_utility::dialogue_stop_and_clear_stack();
  level.enforcer scripts\sp\maps\stpetersburg\stpetersburg_utility::dialogue_stop_and_clear_stack();
  waitframe();

  if(isDefined(level.enforcer.scriptedtalkingknob)) {
    level.enforcer clearanim(level.enforcer.scriptedtalkingknob, 0.2);
    level.enforcer scripts\asm\shared\utility::disabledefaultfacialanims(0);
  }

  temp_performance_flag_set();
  scripts\engine\utility::flag_set("dry_fire_react");
  thread scripts\sp\maps\stpetersburg\stpetersburg_vo::mus_kyle_dryfire();
  thread target_play_anim(level.enforcerson, level.familyflinchanims[0], 0, 1);
  level.familyflinchanims = scripts\sp\maps\stpetersburg\stpetersburg_utility::array_rotate(level.familyflinchanims);
  enforcer_play_additive_anim("dry_fire_flinch");
  wait getanimlength(level.enforcer scripts\engine\utility::getanim("dry_fire_flinch"));

  if(var0 == 6) {
    var1 = randomint(2);
    var2 = ["scene_dry_fire_react_1", "scene_dry_fire_react_2"];
    thread target_play_anim(level.enforcer, "idle_interrogate", 1, 0, 1);
    level.priceanimnode scripts\common\anim::anim_single_solo(level.price, var2[var1]);
    level.priceanimnode notify("stop_loop");
    level.priceanimnode thread scripts\common\anim::anim_loop_solo(level.price, "idle_loop");
    thread target_play_anim(level.enforcer, "scene_dry_fire_price", 0, 1);
    level.priceanimnode notify("single anim", "end");
    level.priceanimnode thread scripts\common\anim::anim_single_solo(level.price, "scene_dry_fire_price");
  } else {
    thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_dry_fire();
    thread target_play_anim(level.enforcer, "scene_dry_fire", 0, 1);
    level.priceanimnode notify("single anim", "end");
    level.priceanimnode thread scripts\common\anim::anim_single_solo(level.price, "scene_dry_fire");
  }

  thread dry_fire_bullet_anims(var0);
  scripts\engine\utility::flag_clear("pause_family_vo");
  scripts\engine\utility::flag_clear("pause_butcher_vo");
}

function dry_fire_bullet_anims(var0) {
  var1 = getEntArray("bullets", "targetname");

  foreach(var5, var3 in var1) {
    var3.animname = "bullets";
    var3 useanimtree(level.scr_animtree["bullets"]);
    var4 = "dry_fire_bullet_" + var5 + 1;
    level.priceanimnode thread scripts\common\anim::anim_single_solo(var3, var4);
  }

  waitframe();

  if(var0 == 6) {
    foreach(var3 in var1) {
      var4 = "dry_fire_bullet_" + var5 + 1;
      var3 setanimtime(var3 scripts\engine\utility::getanim(var4), 0.0842);
    }

    return;
  }
}

function interrogation_phase_final() {
  level endon("interrogation_failed");
  scripts\engine\utility::delaythread(3, &turn_on_headtracking, level.price);
  var0 = getEntArray("bullets", "targetname");
  GscBinSkip4(0x35, var0);
}

function post_bullet_load_setup(var0) {
  wait var0;
  level.player allowads(1);
  level.player scripts\common\utility::allow_fire(1, "interrogation");
  thread player_demeanor_monitor();
  scripts\engine\utility::flag_wait("intel_revealed");

  if(!scripts\engine\utility::flag("enforcer_dead")) {
    scripts\engine\sp\utility::autosave_now_silent();
    return;
  }
}

function player_demeanor_monitor() {
  level endon("demeanor_monitor_end");
  var0 = 1;

  for(;;) {
    if(level.player getweaponammoclip(level.revolver) <= 0) {
      level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
      level.player setnextbulletdryfire(1);
      level.player setweaponammoclip(level.revolver, 1);
      setsaveddvar("MLMROTLMO", 0);
      break;
    }

    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.nikolai getEye(), cos(45))) {
      level.player scripts\engine\sp\utility::set_player_demeanor("relaxed");
      var0 = 0;
    } else if(!var0) {
      level.player scripts\engine\sp\utility::set_player_demeanor("normal");
      var0 = 1;
    }

    wait 0.25;
  }
}

function price_offer_bullets(var0) {
  level endon("final_phase");
  level waittill("bullets_placed");
  show_bullets(var0);
  childthread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_final_phase();
  level.price waittillmatch("single anim", "end");
  scripts\engine\utility::flag_clear("dry_fire_react");

  if(!scripts\engine\utility::flag("final_phase")) {
    level.priceanimnode notify("stop_loop");
    level.priceanimnode thread scripts\common\anim::anim_loop_solo(level.price, "idle_loop");
    return;
  }
}

function show_bullets(var0) {
  scripts\engine\utility::array_call(var0, &show);
  turn_on_headtracking_solo(level.enforcer, level.proptablelookat, "enforcer_dead");
  wait 1.5;
  turn_on_headtracking_solo(level.enforcer, level.player.headlookatoffset, "enforcer_dead");
}

function temp_kid_center_stage() {
  level endon("interrogation_end");
  thread switch_family_team_on_intel();
  temp_performance_flag_set();
  level.sonanimnode thread scripts\common\anim::anim_single_solo(level.enforcerchair, "scene_press_02");
  level.wifeanimnode thread scripts\common\anim::anim_single([level.enforcerwife, level.enforcerson], "scene_press_02");
  level.enforceranimnode scripts\common\anim::anim_single_solo(level.enforcer, "scene_press_02");
  scripts\engine\utility::flag_assert("defeated_state_active");
  scripts\engine\utility::flag_set("defeated_state_active");
  target_restore_idle_anim(level.enforcer);
  level notify("enable_ads_reactions_family");
  level notify("enable_ads_reactions_enforcer");
}

function switch_family_team_on_intel() {
  scripts\engine\utility::flag_wait("intel_revealed");
  level.enforcerwife.team = "allies";
  level.enforcerson.team = "allies";
  setsaveddvar("MLMROTLMO", 175);
  level.enforcerson waittillmatch("single anim", "end");
  target_restore_idle_anim(level.enforcerson);
  temp_performance_flag_clear();
}

function interrogation_abandon_outro() {
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_music_and_dx", 3.5);
  var0 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var0 fadeovertime(2);
  var0.alpha = 1;
  wait 3;

  if(should_skip_interrogation()) {
    level.player setclienttriggeraudiozone("fade_to_black", 0.1);
    level.player freezecontrols(1);
    var0.alpha = 0;
    scripts\engine\sp\utility::nextmission();
    return;
  }

  interrogation_room_catchup();
  interrogation_rig_disable_instant();
  level.player freezecontrols(1);
  var1 = scripts\engine\utility::getStruct("interrogation_decline_start", "targetname");
  level.player scripts\engine\sp\utility::teleport_player(var1);

  if(isDefined(level.revolver) && level.player hasweapon(level.revolver)) {
    player_give_gunless_loadout();
  }

  turn_off_headtracking_solo(level.price);
  turn_off_headtracking_solo(level.nikolai);
  level.outeranimnode thread scripts\common\anim::anim_last_frame_solo(level.nikolaivan, "acquire_intro");
  level.outeranimnode thread scripts\common\anim::anim_first_frame_solo(level.nikolai, "decline_exit");
  level.outeranimnode thread scripts\common\anim::anim_first_frame_solo(level.interrogationdoor, "decline_exit");
  target_restore_idle_anim(level.enforcer);
  target_restore_idle_anim(level.enforcerson);
  level.familychair show();
  var2 = getEnt("interrogation_hallway_clip", "targetname");
  var2 delete();
  level.interrogationdoor scripts\sp\door::door_close(level.player, 0.05, 0, 0);
  level.interrogationdoor.locked = 1;
  level.interrogationdoor scripts\engine\utility::delaythread(9, &scripts\sp\door::reset_door);
  level.player clearclienttriggeraudiozone(4.5);
  wait 3;
  var0 fadeovertime(3);
  var0.alpha = 0;

  while(nullweapon(level.player getcurrentweapon())) {
    waitframe();
  }

  level.player freezecontrols(0);
  level.player forceplaygestureviewmodel("vm_int_gesture_watch_look");
  interrogation_end(1);
}

function interrogation_end(var0) {
  if(scripts\engine\utility::flag("interrogation_failed")) {
    return;
  }

  if(!istrue(var0)) {
    var1 = getEnt("interrogation_room_containment", "targetname");
    var2 = cos(20);

    for(;;) {
      if(distance2d(level.player.origin, level.price.origin) < 135 && scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.price getEye(), var2) || distance2d(level.player.origin, level.price.origin) < 95) {
        break;
      }

      waitframe();
    }
  }

  thread interrogation_room_vo_pause_monitor();
  level notify("demeanor_monitor_end");
  level.player scripts\engine\sp\utility::set_player_demeanor("safe");
  thread final_walk_scene(var0);
  level waittill("car_unlock");
  GscBinSkip1(0x45, 0, scripts\engine\utility::spawn_script_origin(level.policecar gettagorigin("tag_seat_enter_2"), level.policecar gettagangles("tag_seat_enter_2")));
}

function interrogation_outro_blackoverlay_delay(var0) {
  wait 0.4;
  var0.alpha = 0;
}

function interrogation_outro_dialogue(var0) {}

function interrogation_welcome_note() {
  wait 11;
  var0 = scripts\sp\hud_util::createfontstring("default", 1.25);
  var0.alpha = 0;
  var0.alignx = "center";
  var0.aligny = "middle";
  var0.horzalign = "center";
  var0.vertalign = "middle";
  var0.x = -80;
  var0.y = 100;
  var1 = 1;
  var2 = 0.25;
  var0 settext(&"STPETERSBURG/YOURE_WELCOME_NOTE");
  var0 fadeovertime(var1);
  var0.alpha = 1;
  wait 7;
  var0 fadeovertime(var2);
  var0.alpha = 0;
}

function interrogation_outro_camera() {
  level.player enableinvulnerability();
  level.player playerdisabletriggers();
  level.player cleardamageindicators();
  level.player freezecontrols(1);
  level.player hidelegsandshadow();
  level.player scripts\common\utility::allow_cinematic_motion(0, "outro");
  setomnvar("ui_hide_hud", 1);
  scripts\engine\utility::flag_set("lighting_interrogation_outro_cinematic");
  interrogation_rig_enable("interrogation_outro", undefined, 0.1, undefined, 0);
  var0 = scripts\engine\sp\utility::array_spawn_targetname("outro_police", 1);

  foreach(var2 in var0) {
    var2.animname = "outro_police_" + var3 + 1;
    var2.ignoreall = 1;
  }

  thread interrogation_welcome_note();
  var4 = getEntArray("outro_gas_barrel", "targetname");
  scripts\engine\utility::array_call(var4, &show);
  name_hide_array([level.enforcer, level.enforcerwife, level.enforcerson]);
  scripts\engine\utility::flag_set("flag_bink_active");
  level.interrogationdoor scripts\engine\sp\utility::anim_stopanimScripted();
  var5 = [level.enforcerwife, level.enforcerson, level.interrogationdoor, level.player.rig];
  var5 = scripts\engine\utility::array_combine(var5, var0);

  if(!scripts\engine\utility::flag("enforcer_dead")) {
    var5 = scripts\engine\utility::array_add(var5, level.enforcer);
  }

  thread interrogation_outro_dof(var4);
  thread interrogation_cine_skip(var5, "interrogation_outro", 0);
  level.enforceranimnode notify("single anim", "end");
  level.enforceranimnode thread scripts\common\anim::anim_single(var5, "interrogation_outro");
  var6 = getanimlength(level.player.rig scripts\engine\utility::getanim("interrogation_outro"));
  wait var6;
  scripts\sp\utility::userskip_stop();

  foreach(var8 in var5) {
    level.enforceranimnode thread scripts\common\anim::anim_last_frame_solo(var8, "interrogation_outro");
  }

  level.player showlegsandshadow();
  level.player freezecontrols(0);
  level.player playerenabletriggers();
  level.player disableinvulnerability();
  level.player scripts\common\utility::allow_cinematic_motion(0, "outro");
  setomnvar("ui_hide_hud", 0);
}

function interrogation_outro_dof(var0) {
  var1 = getEntArray("outro_gas_barrel", "targetname");
  var2 = undefined;

  foreach(var4 in var1) {
    if(var4.model == "ee_sign_note") {
      var2 = var4;
      break;
    }
  }

  level thread scripts\engine\sp\utility::dof_enable(2, 40);
  wait 1.5;
  level.enforcer thread scripts\engine\sp\utility::dof_enable_autofocus(1.5, 3, undefined, undefined, "tag_eye", undefined, 1);
  wait 5;
  var2 thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 2, undefined, undefined, "tag_origin");
  wait 11.5;
  thread scripts\engine\sp\utility::dof_disable();
}

function show_animname() {
  self endon("death");

  for(;;) {
    waitframe();
  }
}

function final_walk_scene(var0) {
  var1 = getEnt("interrogation_nikolai_clip", "targetname");

  if(isDefined(var1)) {
    var1 delete();
  }

  var2 = [level.price, level.nikolai, level.nikolaivan, level.policecar];
  var3 = scripts\engine\utility::ter_op(istrue(var0), "decline_exit", "walk_to_car");

  if(var3 == "decline_exit") {
    level.outeranimnode thread scripts\common\anim::anim_single_solo(level.interrogationdoor, var3);
  }

  level.priceanimnode notify("stop_loop");
  level.outeranimnode notify("stop_loop");
  level.outeranimnode scripts\common\anim::anim_single(var2, var3);
  level.outeranimnode thread scripts\common\anim::anim_loop_solo(level.nikolai, "car_idle", "car_loop_stop");
  level.outeranimnode thread scripts\common\anim::anim_loop_solo(level.price, "car_idle");
}

function player_car_enter(var0) {
  level.player setstance("stand");
  level.player lerpfovscalefactor(0, 1);

  if(isDefined(level.revolver) && level.player hasweapon(level.revolver)) {
    level.player takeweapon(level.revolver);
  }

  setsaveddvar("MLMROTLMO", 175);
  var1 = scripts\engine\utility::ter_op(var0 == "left", "car_interact_left", "car_interact_right");
  interrogation_rig_enable(var1, "viewhands_hero_kyle_urban", 0.35, level.outeranimnode);
  level.policecar setanimrestart(level.policecar scripts\engine\utility::getanim(var1));
  wait 0.05;
  level.outeranimnode scripts\common\anim::anim_single_solo(level.player.rig, var1);
}

function interrogation_room_vo_pause_monitor() {
  level endon("interrogation_end");
  var0 = getEnt("interrogation_room_containment", "targetname");
  var1 = getEnt("interrogation_warehouse_containment", "targetname");
  var2 = 0;
  var3 = 0;

  for(;;) {
    if(!level.player istouching(var1)) {
      if(!var3) {
        scripts\engine\utility::flag_set("pause_price_vo");
        scripts\engine\utility::flag_set("pause_nikolai_vo");
        var3 = 1;
        blendshape_disable(level.nikolai);
        blendshape_enable(level.enforcer);
      }
    } else if(var3) {
      scripts\engine\utility::flag_clear("pause_price_vo");
      scripts\engine\utility::flag_clear("pause_nikolai_vo");
      var3 = 0;
      blendshape_enable(level.nikolai);
      blendshape_disable(level.enforcer);
    }

    if(!level.player istouching(var0)) {
      if(!var2) {
        scripts\engine\utility::flag_set("pause_butcher_vo");
        scripts\engine\utility::flag_set("pause_family_vo");
        level.enforcerwife stoploopsound();
        var2 = 1;
      }
    } else if(var2) {
      scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_family_idle_loop(1);
      scripts\engine\utility::flag_clear("pause_butcher_vo");
      scripts\engine\utility::flag_clear("pause_family_vo");
      var2 = 0;
    }

    wait 0.5;
  }
}

function dialogue_cooldown_timer() {
  level endon("missionfailed");

  for(;;) {
    foreach(var2, var1 in level.dialoguecooldowns) {
      if(var1[1] != 0) {
        level.dialoguecooldowns[var2][1] -= 1;
      }
    }

    wait 1;
  }
}

function play_dialogue(var0, var1) {
  level.alivestates = get_actor_alive_states();

  if(!is_dialogue_on_cooldown(var0)) {
    GscBinSkip1(0x74, var1);
  }

  return false;
}

function is_dialogue_on_cooldown(var0) {
  return level.dialoguecooldowns[var0][1] != 0;
}

function set_dialogue_on_cooldown(var0, var1) {
  var2 = scripts\engine\utility::ter_op(isDefined(var1), var1, level.dialoguecooldowns[var0][0]);
  level.dialoguecooldowns[var0][1] = var2;
}

function player_give_gunless_loadout() {
  level.player scripts\engine\sp\utility::takeallweaponsexcludemelee();
  level.player giveweapon("iw8_gunless_ik");
  level.player switchtoweapon("iw8_gunless_ik");
}

function player_interrogation_speed_setup() {
  level.player scripts\sp\player::player_movement_state("creep");
  setsaveddvar("MNPNORMOMP", 0.65);
  scripts\engine\sp\utility::player_speed_set(75, 0.5);
}

function player_post_escort_setup() {
  level.player scripts\common\utility::allow_mantle(0);
  player_interrogation_speed_setup();
}

function player_aim_target() {
  var0 = 0;
  var1 = 1;
  var2 = 2;
  level.mindistancesq = squared(50);
  level.maxdistancesq = squared(215);
  level.oneoverfactor = 1 / (log(level.maxdistancesq) - log(level.mindistancesq));
  level.currentplayertarget = 0;

  for(;;) {
    var3 = quick_maffs();
    var4 = var3[3];

    if(isDefined(var3[3]) && var4.size > 0) {
      var5 = var4[0]["position"];
      var6 = var4[0]["normal"];
      var7 = var4[0]["entity"];

      if(isalive(var7) && isDefined(var7.name)) {
        switch (var7.name) {
          case "The Butcher":
            if(var3[0][var0] < -0.065) {
              level.currentplayertarget = 2;
            } else if(var3[0][var0] > 0.065) {
              level.currentplayertarget = 3;
            } else {
              level.currentplayertarget = 1;
            }

            break;
          case "Captain Price":
            level.currentplayertarget = 6;
            break;
          case "Nikolai":
            level.currentplayertarget = 7;
            break;
          case "Yegor":
            level.currentplayertarget = 8;
            break;
          case "Ousa":
            if(var3[1][var0] < -0.065) {
              level.currentplayertarget = 10;
            } else if(var3[1][var0] > 0.065) {
              level.currentplayertarget = 11;
            } else {
              level.currentplayertarget = 9;
            }

            break;
          case "Amon":
            if(var3[2][var0] < -0.065) {
              level.currentplayertarget = 13;
            } else if(var3[2][var0] > 0.065) {
              level.currentplayertarget = 14;
            } else {
              level.currentplayertarget = 12;
            }

            break;
        }
      }
    } else if(!scripts\engine\utility::flag("son_dead") && !scripts\engine\utility::flag("wife_dead") && var3[1][var1] >= var3[1][var2]) {
      if(var3[1][var0] < 0) {
        level.currentplayertarget = 15;
      } else {
        level.currentplayertarget = 16;
      }
    } else if(!scripts\engine\utility::flag("son_dead") && !scripts\engine\utility::flag("wife_dead") && var3[2][var1] >= var3[2][var2]) {
      if(var3[2][var0] < 0) {
        level.currentplayertarget = 15;
      } else {
        level.currentplayertarget = 16;
      }
    } else if(!scripts\engine\utility::flag("enforcer_dead") && var3[0][var1] >= var3[0][var2]) {
      if(var3[0][var0] < 0) {
        level.currentplayertarget = 4;
      } else {
        level.currentplayertarget = 5;
      }
    } else {
      level.currentplayertarget = 0;
    }

    waitframe();
  }
}

function quick_maffs() {
  var0 = [];
  var1 = level.player getEye();
  var2 = anglesToForward(level.player getplayerangles());
  var3 = var1 + var2 * 2048;
  var4 = scripts\engine\trace::create_contents(1);
  var5 = physics_raycast(var1, var3, var4, level.player, 1, "physicsquery_closest");
  var0 = fov_calculation(level.enforcer, var1, var2);
  var0 = fov_calculation(level.enforcerwife, var1, var2);
  var0 = fov_calculation(level.enforcerson, var1, var2);
  var0 = var5;
  return var0;
}

function fov_calculation(var0, var1, var2, var3, var4, var5) {
  if(!isalive(var0)) {
    return [0, 0, 0];
  }

  var6 = [];
  var7 = var0 getorigin() + (0, 0, 25);
  var8 = vectorNormalize(var7 - var1);
  var9 = vectordot(var2, var8);
  var10 = anglestoup(level.player getplayerangles());
  var11 = vectorcross(var2, var8);
  var12 = vectordot(var11, var10);
  var13 = clamp(distancesquared(var1, var7), level.mindistancesq, level.maxdistancesq);
  var14 = (log(var13) - log(level.mindistancesq)) * level.oneoverfactor;
  var15 = 0.73 + var14 * 0.254;
  return [var12, var9, var15];
}

function interrogation_rig_enable(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var3 = scripts\engine\utility::ter_op(isDefined(var3), var3, level.yegoranimnode);
  var2 = scripts\engine\utility::ter_op(isDefined(var2), var2, 0.25);
  var4 = scripts\engine\utility::ter_op(isDefined(var4), var4, 0);
  var5 = scripts\engine\utility::ter_op(isDefined(var5), var5, 0);
  var6 = scripts\engine\utility::ter_op(isDefined(var6), var6, 0);
  var7 = scripts\engine\utility::ter_op(isDefined(var7), var7, 0);
  var8 = scripts\engine\utility::ter_op(isDefined(var8), var8, 0);

  if(!var4) {
    level.player disableweapons();
  }

  var3 thread scripts\common\anim::anim_first_frame_solo(level.player.rig, var0);
  level.player hidelegsandshadow();
  level.player setstance("stand");
  level.player allowcrouch(0);
  level.player allowprone(0);
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  level.player playerlinktoblend(level.player.rig, "tag_player", var2, var2 * 0.25, var2 * 0.25);
  wait var2;
  level.player playerlinktodelta(level.player.rig, "tag_player", 1, var5, var6, var7, var8, 1);

  if(isDefined(var1)) {
    level.player.rig setModel(var1);
    level.player.rig show();
    level.player.rig castshadows();
    return;
  }

  level.player.rig hide();
}

function interrogation_rig_disable(var0, var1, var2) {
  var1 = scripts\engine\utility::ter_op(isDefined(var1), var1, 0.25);

  if(var1 != -1) {
    var3 = getanimlength(level.player.rig scripts\engine\utility::getanim(var0));
    var4 = level scripts\engine\utility::waittill_notify_or_timeout_return("userskipped", var3 - var1);
    level.player freezecontrols(1);
    waitframe();
    level.player playerlinktodelta(level.player.rig, "tag_player", 0, 0, 0, 0, 0, 1);
    level.player playerlinktoblend(level.player.rig, "tag_player", var1);

    if(var4 == "userskipped") {
      level.player.rig waittillmatch("single anim", "end");
    } else {
      wait var1 + 0.1;
    }
  }

  level.player.rig hide();
  level.player.rig dontcastshadows();
  level.player showlegsandshadow();
  level.player unlink();

  if(!istrue(var2)) {
    level.player allowcrouch(1);
    level.player allowprone(1);
  }

  level.player enableweapons();
  level.player freezecontrols(0);
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

function interrogation_rig_disable_instant() {
  interrogation_rig_disable(undefined, -1);
}

function damage_monitor() {
  GscBinSkip4(0x6e, level.enforcer, "enforcer_dead");
}

function target_damage_listener(var0) {
  level endon(var0);

  for(;;) {
    self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10);
    damage_handler(self, var2, var5, var8, var10);
  }
}

function damage_handler(var0, var1, var2, var3, var4) {
  var5 = ["j_helmet", "j_head", "j_neck", "j_spine4", "j_spinelower", "j_spineupper", "j_mainroot"];
  var6 = ["j_helmet", "j_head"];
  var7 = ["j_shoulder", "j_elbow", "j_wrist"];
  var8 = ["j_hip", "j_knee", "j_ankle", "j_ball"];
  var9 = ["react_son_melee", "react_wife_melee"];

  if(isPlayer(var1)) {
    turn_off_headtracking();
    level.actioncount++;

    if(var2 == "MOD_PISTOL_BULLET" || var2 == "MOD_RIFLE_BULLET") {
      var10 = clamp(var0.health - 2, 2, 8);
      var0.health = int(var10);

      if(isDefined(var3) && scripts\engine\utility::array_contains(var5, var3) || var0.health <= 2) {
        var11 = scripts\engine\utility::array_contains(var6, var3);
        thread target_death_wrapper(var0, var11);
        return;
      }

      if(scripts\engine\utility::is_equal(var0, level.enforcer)) {
        play_dialogue("enforcer_shot", &scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_enforcer_shot);
      } else if(!scripts\engine\utility::flag("wife_dead") && !scripts\engine\utility::flag("son_dead")) {
        thread target_death_wrapper(var0, 0);
      }

      var12 = getsubstr(var3, 0, var3.size - 3);

      if(issubstr(var3, "_le")) {
        if(scripts\engine\utility::array_contains(var7, var12)) {
          thread enforcer_play_additive_anim("shot_arm_left");
        } else if(scripts\engine\utility::array_contains(var8, var12)) {
          thread enforcer_play_additive_anim("shot_leg_left");
        }
      } else if(issubstr(var3, "_ri")) {
        if(scripts\engine\utility::array_contains(var7, var12)) {
          thread enforcer_play_additive_anim("shot_arm_right");
        } else if(scripts\engine\utility::array_contains(var8, var12)) {
          thread enforcer_play_additive_anim("shot_leg_right");
        }
      }

      if(!scripts\engine\utility::flag("intel_revealed")) {
        scripts\engine\utility::flag_set("interrogation_failed");
        scripts\sp\player_death::set_custom_death_quote(91);
        thread scripts\sp\utility::missionfailedwrapper();
        return;
      }

      return;
    }

    if(var3 == "MOD_MELEE" || var3 == "MOD_CRUSH") {
      if(scripts\engine\utility::is_equal(var1, level.enforcer)) {
        if(var3 != "MOD_CRUSH") {
          return;
        }

        scripts\engine\utility::delaythread(1, &play_dialogue, "enforcer_melee", &scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_enforcer_melee);
        thread target_play_anim(level.enforcerson, "react_enforcer_melee", 0, 1);
      } else {
        play_dialogue("family_melee", &scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_family_melee);
        thread target_play_anim(level.enforcer, var10[randomint(var10.size)], 0, 1);
        target_play_anim(var1, "interrogate_melee", 0, 1);
        scripts\engine\utility::flag_set("interrogation_failed");
        scripts\sp\player_death::set_custom_death_quote(91);
        thread scripts\sp\utility::missionfailedwrapper();
      }

      var10 = clamp(var1.health - 2, 2, 8);
      var1.health = int(var10);

      if(var1.health <= 2) {
        var11 = scripts\engine\utility::array_contains(var7, var4);
        thread target_death_wrapper(var1, var11, 1);
        return;
      }

      return;
    }

    if(isDefined(var6)) {
      var6 = getweaponbasename(var6);
      iprintlnbold("Weapon: " + var6 + ", Type: " + var4 + ", Part: " + var5);
      return;
    }

    iprintlnbold("Tried to handle invalid damage for: " + var2.name);
    return;
  }
}

function enforcer_play_additive_anim(var0) {
  var1 = level.enforcer scripts\engine\utility::getanim(var0);
  var2 = getanimlength(var1);
  level.enforcer setanimrestart(var1, 1, 0.1);
  level.enforcer scripts\engine\utility::delaycall(var2, &clearanim, var1, 0.25);
}

function nearby_shot_monitor() {
  level.familyflinchanims = ["whizby_1", "whizby_2", "whizby_4", "whizby_3"];

  for(;;) {
    var0 = level.enforcer.health;
    var1 = level.enforcerwife.health;
    var2 = level.enforcerson.health;
    level.player waittill("weapon_fired");
    level.actioncount++;
    thread weapon_fire_vo_cooldown();
    wait 0.1;
    var3 = is_enforcer_target() && level.enforcer.health < var0;

    if(!scripts\engine\utility::flag("enforcer_dead") && !var3 && is_enforcer_threatened()) {
      var4 = "whizby_flinch_" + randomintrange(1, 3);
      enforcer_play_additive_anim(var4);
    }

    var5 = 1;
    var6 = 1;

    if(!scripts\engine\utility::flag("wife_dead")) {
      var5 = is_relative_target() && level.enforcerwife.health < var1;
    }

    if(!scripts\engine\utility::flag("son_dead")) {
      var6 = is_relative_target() && level.enforcerson.health < var2;
    }

    if(!var5 && !var6) {
      if(temp_is_performance_active()) {
        thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_family_scream();
        continue;
      }

      if(!scripts\engine\utility::flag("family_spooked")) {
        scripts\engine\utility::flag_set("family_spooked");
        thread target_play_anim(level.enforcerson, "whizby_single", 0, 1);
        continue;
      }

      level.enforcerwife stoploopsound();
      var7 = getanimlength(level.enforcerson scripts\engine\utility::getanim(level.familyflinchanims[0]));
      thread target_play_anim(level.enforcerson, level.familyflinchanims[0], 0, 1);
      level scripts\engine\utility::thread_on_notify("pause_family_vo", &scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_family_idle_loop, undefined, undefined, undefined, level.player, "weapon_fired");
      level.familyflinchanims = scripts\sp\maps\stpetersburg\stpetersburg_utility::array_rotate(level.familyflinchanims);
    }
  }
}

function weapon_fire_vo_cooldown() {
  level notify("weapon_fire_vo_cooldown");
  level endon("weapon_fire_vo_cooldown");
  var0 = 7;
  scripts\engine\utility::flag_set("pause_butcher_vo");
  scripts\engine\utility::flag_set("pause_family_vo");
  wait var0;
  var1 = getEnt("interrogation_room_containment", "targetname");

  if(level.player istouching(var1)) {
    scripts\engine\utility::flag_clear("pause_butcher_vo");
    scripts\engine\utility::flag_clear("pause_family_vo");
    return;
  }
}

function enforcer_ads_anims() {
  level endon("missionfailed");
  level.enforcer endon("death");
  var0 = [1, 2, 3];
  var1 = "idle";
  var2 = 0;
  var3 = 0;
  var4 = 7;
  var5 = getEnt("interrogation_room_containment", "targetname");
  var6 = 0;
  var7 = 2.5;
  scripts\engine\utility::flag_wait("revolver_picked_up");
  level waittill("enable_ads_reactions_enforcer");

  for(;;) {
    waitframe();

    if(scripts\engine\utility::array_contains(var0, level.currentplayertarget) && !temp_is_performance_active()) {
      level.actioncount++;
      var8 = anglesToForward(level.player.angles);
      var9 = anglesToForward(level.enforcer.angles);
      var10 = vectordot(var8, var9);

      if(!scripts\engine\utility::flag("defeated_state_active")) {
        play_dialogue("enforcer_ads", &scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_enforcer_ads);
      }

      if(scripts\engine\utility::flag("defeated_state_active")) {
        if(level.player istouching(var5) && !scripts\engine\utility::flag("enforcer_dead")) {
          play_dialogue("enforcer_defeated", &scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_enforcer_defeated);
          break;
        }
      } else if(!var2 && !scripts\engine\utility::flag("intel_revealed")) {
        if(!var6) {
          thread scripts\sp\maps\stpetersburg\stpetersburg_vo::mus_kyle_pointgun();
          thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_enforcer_ads_family_reaction();
          var6 = 1;
        }

        switch (level.currentplayertarget) {
          case 2:
            var11 = scripts\engine\utility::ter_op(var10 <= 0, "ads_left", "ads_right");

            if(var1 != var11) {
              var2 = 1;
              var12 = var11 + "_in";
              target_play_anim(level.enforcer, var12);

              if(target_play_anim(level.enforcer, var11, 1)) {
                var1 = var11;
              }
            }

            break;
          case 3:
            var11 = scripts\engine\utility::ter_op(var10 <= 0, "ads_right", "ads_left");

            if(var1 != var11) {
              var2 = 1;
              var12 = var11 + "_in";
              target_play_anim(level.enforcer, var12);

              if(target_play_anim(level.enforcer, var11, 1)) {
                var1 = var11;
              }
            }

            break;
          case 1:
            if(var1 != "ads_center") {
              var2 = 1;
              var11 = "ads_center";
              var12 = var11 + "_in";
              target_play_anim(level.enforcer, var12);

              if(target_play_anim(level.enforcer, var11, 1)) {
                var1 = "ads_center";
              }
            }

            break;
        }
      }
    } else if(var1 != "idle" && level.enforcer.health > 1 && !temp_is_performance_active()) {
      var13 = var1 + "_out";
      wait var7;

      if(!scripts\engine\utility::array_contains(var0, level.currentplayertarget) && !temp_is_performance_active()) {
        if(target_play_anim(level.enforcer, var13, 0, 1)) {
          var1 = "idle";
        }
      }

      var2 = 0;
      var3++;
    }

    if(var1 != "idle" && level.enforcer.currentanimpriority != level.animpriority["ads"] && level.enforcer.currentanimpriority != level.animpriority["react_ads"]) {
      var2 = 0;
      var1 = "idle";
    }
  }
}

function relative_ads_anims() {
  level endon("missionfailed");
  var0 = [9, 12, 10, 13, 11, 14];
  var1 = "idle";
  var2 = "aim";
  var3 = 0;
  var4 = level.animpriority["react_ads"];
  var5 = 0;
  var6 = 0;
  var7 = 2;
  level waittill("enable_ads_reactions_family");

  for(;;) {
    waitframe();

    if(scripts\engine\utility::flag("wife_dead") && scripts\engine\utility::flag("son_dead")) {
      break;
    }

    if(scripts\engine\utility::flag("final_phase")) {
      break;
    }

    if(scripts\engine\utility::array_contains(var0, level.currentplayertarget) && !temp_is_performance_active()) {
      level.actioncount++;
      level notify("family_ads_reaction_active");
      var8 = anglesToForward(level.player.angles);
      var9 = anglesToForward(level.enforcerson.angles);
      var10 = vectordot(var8, var9);
      var11 = scripts\engine\utility::ter_op(level.player scripts\engine\sp\utility::isads(), "ads", "aim");

      if(var11 != var2) {
        var2 = var11;
        var3 = 0;
      }

      if(!var5) {
        var5 = 1;
        thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_family_aim();
        thread scripts\sp\maps\stpetersburg\stpetersburg_vo::mus_kyle_pointgun();
        scripts\engine\utility::flag_set("family_spooked");
        scripts\engine\utility::delaythread(1.75, &target_play_anim, level.enforcerson, "whizby_single", 0, 1);
      } else if(var11 == "ads") {
        level notify("revolver_phase_family_ads");

        if(!var6) {
          thread scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_family_ads();
          var6 = 1;
        }
      }

      if(!var3) {
        turn_off_headtracking();
        var3 = 1;

        switch (level.currentplayertarget) {
          case 13:
          case 10:
          case 9:
            var12 = scripts\engine\utility::ter_op(level.player scripts\engine\sp\utility::isads(), "react_ads_wife", "react_aim_wife");

            if(var1 != var12) {
              target_play_anim(level.enforcer, var12, 1);
              var1 = var12;
            }

            break;
          case 14:
          case 12:
          case 11:
            var12 = scripts\engine\utility::ter_op(level.player scripts\engine\sp\utility::isads(), "react_ads_wife", "react_ads_son");

            if(var1 != var12) {
              target_play_anim(level.enforcer, var12, 1);
              var1 = var12;
            }

            break;
        }
      }

      continue;
    }

    if(var1 != "idle" && !scripts\engine\utility::flag("wife_dead") && !scripts\engine\utility::flag("son_dead") && !temp_is_performance_active()) {
      var13 = var1 + "_out";
      wait var7;

      if(!scripts\engine\utility::flag("enforcer_dead") && level.enforcer.currentanimpriority <= var4) {
        if(!scripts\engine\utility::array_contains(var0, level.currentplayertarget) && !temp_is_performance_active()) {
          target_restore_idle_anim(level.enforcer);
        }
      }

      if(level.currentrelativeanimpriority == 0) {
        var1 = "idle";
      }

      var3 = 0;
    }
  }

  scripts\engine\utility::flag_wait("defeated_state_active");

  for(;;) {
    waitframe();

    if(scripts\engine\utility::array_contains(var0, level.currentplayertarget) && !temp_is_performance_active()) {
      level notify("defeated_state_family_ads");
      wait 0.5;
    }
  }
}

function price_ads_anims() {
  level endon("missionfailed");
  level endon("intel_revealed");
  level endon("interrogation_failed");
  scripts\engine\utility::flag_wait("revolver_picked_up");
  var0 = scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_price_ads();

  while(var0.size > 0) {
    if(!temp_is_performance_active() && level.player scripts\engine\sp\utility::isads() && level.currentplayertarget == 6 && !scripts\engine\utility::flag("final_phase")) {
      level.actioncount++;
      level notify("price_ads_reaction");
      wait 0.5;
      thread scripts\sp\maps\stpetersburg\stpetersburg_utility::add_dialogue_line_price(var0[0][0], var0[0][1]);
      var0 = scripts\engine\utility::array_remove_index(var0, 0);
      level.priceanimnode scripts\common\anim::anim_single_solo(level.price, "ads_price");

      if(!scripts\engine\utility::flag("dry_fire_react") || !temp_is_performance_active() && !scripts\engine\utility::flag("final_phase")) {
        level.priceanimnode notify("stop_loop");
        level.priceanimnode thread scripts\common\anim::anim_loop_solo(level.price, "idle_loop");
      }
    }

    waitframe();
  }
}

function target_play_anim(var0, var1, var2, var3, var4) {
  if(!isalive(var0)) {
    return 0;
  }

  var5 = scripts\engine\utility::ter_op(scripts\engine\utility::is_equal(var0, level.enforcer), level.enforcer.currentanimpriority, level.currentrelativeanimpriority);
  var6 = get_interrogate_anim_priority(var1);

  if(istrue(var4) || var6 >= var5 && !scripts\engine\utility::is_equal(var1, level.previousanim[var0.name])) {
    level.previousanim[var0.name] = var1;

    if(scripts\engine\utility::is_equal(var0, level.enforcer) && !scripts\engine\utility::flag("enforcer_dead")) {
      level.enforcer.currentanimpriority = var6;

      if(istrue(var2)) {
        level.enforceranimnode notify("stop_loop");
        level.enforceranimnode notify("enforcer_chair_loop_end");
        level.enforcerchair scripts\engine\sp\utility::anim_stopanimScripted();
        level.enforceranimnode thread scripts\common\anim::anim_loop_solo(var0, var1);
        return 1;
      } else {
        level.enforceranimnode notify("stop_loop");
        level.enforceranimnode notify("enforcer_chair_loop_end");
        level.enforcerchair scripts\engine\sp\utility::anim_stopanimScripted();
        level.enforceranimnode notify("single anim", "end");
        level.enforceranimnode scripts\common\anim::anim_single_solo(var0, var1);

        if(istrue(var3) && level.enforcer.currentanimpriority <= var6) {
          return target_restore_idle_anim(var0);
        }
      }
    } else if(scripts\engine\utility::is_equal(var0, level.enforcerwife) || scripts\engine\utility::is_equal(var0, level.enforcerson)) {
      level.currentrelativeanimpriority = var6;
      level.wifeanimnode notify("stop_loop");
      level.sonanimnode notify("stop_loop");
      level.enforcerwife stoploopsound();

      if(istrue(var2)) {
        level.wifeanimnode thread scripts\common\anim::anim_loop_solo(level.enforcerwife, var1);
        level.sonanimnode thread scripts\common\anim::anim_loop_solo(level.enforcerson, var1);
        return 1;
      } else {
        level.wifeanimnode notify("single anim", "end");
        level.sonanimnode notify("single anim", "end");

        if(var1 == "whizby_1" || var1 == "whizby_2") {
          level.wifeanimnode thread scripts\common\anim::anim_single_solo(level.familychair, var1);
        }

        level.wifeanimnode thread scripts\common\anim::anim_single_solo(level.enforcerwife, var1);
        level.sonanimnode scripts\common\anim::anim_single_solo(level.enforcerson, var1);

        if(istrue(var3) && level.currentrelativeanimpriority <= var6) {
          return target_restore_idle_anim(var0);
        }
      }
    }
  }

  return 0;
}

function target_restore_idle_anim(var0) {
  if(scripts\engine\utility::flag("interrogation_end")) {
    return false;
  }

  if(scripts\engine\utility::is_equal(var0, level.enforcer) && !scripts\engine\utility::flag("enforcer_dead")) {
    level.enforceranimnode notify("stop_loop");
    level.enforceranimnode notify("single anim", "end");
    var1 = "idle_interrogate";

    if(scripts\engine\utility::flag("final_phase")) {
      var1 += "_high";
    } else if(scripts\engine\utility::flag("interrogation_escort_done")) {
      var1 += "_med";
    }

    if(scripts\engine\utility::flag("son_dead")) {
      var1 = "grieve_son_death";

      if(scripts\engine\utility::flag("wife_dead")) {
        var1 = "grieve_both_death";
      }

      level.enforcer.currentanimpriority = 25;
    } else if(scripts\engine\utility::flag("wife_dead")) {
      var1 = "grieve_wife_death";
      level.enforcer.currentanimpriority = 25;
    } else {
      level.enforcer.currentanimpriority = 0;
    }

    level.enforceranimnode thread scripts\common\anim::anim_loop_solo(var0, var1);
    level.previousanim[var0.name] = "idle_interrogate";
    return true;
  } else if(level.currentrelativeanimpriority < 99 && (scripts\engine\utility::is_equal(var1, level.enforcerwife) || scripts\engine\utility::is_equal(var1, level.enforcerson))) {
    level.wifeanimnode notify("stop_loop");
    level.sonanimnode notify("stop_loop");
    var1 = "idle_interrogate";

    if(scripts\engine\utility::flag("family_spooked")) {
      var1 += "_high";
    }

    level.currentrelativeanimpriority = 0;

    if(scripts\engine\utility::flag("family_spooked")) {
      level.wifeanimnode notify("family_chair_loop_end");
      level.wifeanimnode thread scripts\common\anim::anim_loop_solo(level.familychair, "chair_idle_high", "family_chair_loop_end");
    }

    scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_family_idle_loop();
    level.wifeanimnode thread scripts\common\anim::anim_loop_solo(level.enforcerwife, var1);
    level.sonanimnode thread scripts\common\anim::anim_loop_solo(level.enforcerson, var1);
    level.previousanim[var1.name] = "idle_interrogate";
    return true;
  }

  return false;
}

function target_death_wrapper(var0, var1, var2) {
  if(scripts\engine\utility::flag("interrogation_failed")) {
    return;
  }

  var3 = getdvarint("stp_family_deaths", 0);
  turn_off_headtracking();
  turn_off_headtracking_solo(level.price);

  if(!scripts\engine\utility::flag("intel_revealed") || var0 != level.enforcer) {
    scripts\engine\utility::flag_set("interrogation_failed");
  }

  if(var0 == level.enforcer) {
    scripts\engine\utility::flag_set("enforcer_dead");
    level.enforcer scripts\sp\maps\stpetersburg\stpetersburg_utility::dialogue_stop_and_clear_stack();
    scripts\engine\utility::flag_set("pause_family_vo");
    play_dialogue("enforcer_death", &scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_enforcer_death);

    if(!scripts\engine\utility::flag("wife_dead") && !scripts\engine\utility::flag("son_dead")) {}

    if(!istrue(var2)) {
      level.enforceranimnode notify("enforcer_chair_loop_end");
      level.enforceranimnode notify("single anim", "end");
      level.enforcerchair scripts\engine\sp\utility::anim_stopanimScripted();
      thread target_death_anim(level.enforceranimnode, level.enforcer);
    }

    turn_on_headtracking_solo(level.enforcerwife, level.player, "wife_dead");
  } else if(var0 == level.enforcerwife) {
    scripts\engine\utility::flag_set("wife_dead");
    level.enforcer scripts\sp\maps\stpetersburg\stpetersburg_utility::dialogue_stop_and_clear_stack();
    level.enforcerwife scripts\sp\maps\stpetersburg\stpetersburg_utility::dialogue_stop_and_clear_stack();
    level.enforcerson scripts\sp\maps\stpetersburg\stpetersburg_utility::dialogue_stop_and_clear_stack();
    waitframe();

    if(var3 < 2) {
      thread play_dialogue("wife_death", &scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_wife_death);
    }

    level.currentrelativeanimpriority = 99;
    thread son_react_death(level.enforcerwife, var1);
    thread enforcer_react_death(level.enforcerwife);
    thread target_death_anim(level.wifeanimnode, level.enforcerwife);
  } else if(var0 == level.enforcerson) {
    scripts\engine\utility::flag_set("son_dead");
    level.enforcer scripts\sp\maps\stpetersburg\stpetersburg_utility::dialogue_stop_and_clear_stack();
    level.enforcerwife scripts\sp\maps\stpetersburg\stpetersburg_utility::dialogue_stop_and_clear_stack();
    level.enforcerson scripts\sp\maps\stpetersburg\stpetersburg_utility::dialogue_stop_and_clear_stack();
    waitframe();

    if(var3 < 2) {
      thread play_dialogue("son_death", &scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_son_death);
    }

    level.currentrelativeanimpriority = 99;
    thread wife_react_death(level.enforcerson);
    thread enforcer_react_death(level.enforcerson);
    thread target_death_anim(level.sonanimnode, level.enforcerson);
  }

  if(var0 != level.enforcer || var0 == level.enforcer && !scripts\engine\utility::flag("intel_revealed")) {
    level.player freezecontrols(1);
    level.price scripts\sp\maps\stpetersburg\stpetersburg_utility::dialogue_stop_and_clear_stack();

    if(var0 != level.enforcer) {
      var3++;
      setDvar("stp_family_deaths", var3);

      if(var3 > 2) {
        var4 = [["What are you doin, are you fuckin' mad?!", "dx_vom_pri_interrogation_revolver_killfam_20"], ["What the fuck, Sergeant, you bloody mental?!", "dx_vom_pri_interrogation_revolver_killfam_30"]];
        var5 = scripts\engine\utility::random(var4);
        scripts\engine\utility::delaythread(0.5, &scripts\sp\maps\stpetersburg\stpetersburg_utility::add_dialogue_line_price, var5[0], var5[1]);
        scripts\sp\player_death::set_custom_death_quote(435);
        level.missionfailed = 1;
        scripts\engine\utility::flag_set("missionfailed");
        thread scripts\sp\player_death::set_death_hint();
        scripts\sp\hud_util::fade_out(0);
        setblur(5, 1);
        wait 2.5;
        changelevel("", 0, 2);
      }

      scripts\sp\player_death::set_custom_death_quote(434);
      scripts\sp\hud_util::fade_out(0);
    } else {
      scripts\engine\utility::delaythread(0.5, &scripts\sp\maps\stpetersburg\stpetersburg_utility::add_dialogue_line_price, "What the hell are you doing, Sergeant?! We needed that intel.", "dx_vom_pri_interrogation_revolver_killbutcher_10");
      level.price scripts\engine\utility::delaythread(2.25, &scripts\engine\sp\utility::anim_stopanimscripted);
      scripts\sp\player_death::set_custom_death_quote(91);
      wait 1;
    }

    thread scripts\sp\utility::missionfailedwrapper();
    return;
  }
}

function enforcer_react_death(var0) {
  if(!scripts\engine\utility::flag("enforcer_dead")) {
    if(scripts\engine\utility::is_equal(var0, level.enforcerwife) && !scripts\engine\utility::flag("son_dead")) {
      target_play_anim(level.enforcer, "react_death_wife", 0, 1);
      turn_on_headtracking_solo(level.enforcer, level.player, "enforcer_dead");
      return;
    }

    if(scripts\engine\utility::is_equal(var0, level.enforcerson) && !scripts\engine\utility::flag("wife_dead")) {
      target_play_anim(level.enforcer, "react_death_wife", 0, 1);
      turn_on_headtracking_solo(level.enforcer, level.player, "enforcer_dead");
      return;
    }

    target_play_anim(level.enforcer, "react_death_wife", 0, 1);
    thread play_dialogue("family_death", &scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_family_death);
    return;
  }
}

function wife_react_death(var0) {
  if(!scripts\engine\utility::flag("wife_dead")) {
    var1 = scripts\engine\utility::ter_op(scripts\engine\utility::is_equal(var0, level.enforcer), "enforcer", "son");
    var2 = "react_death_" + var1;
    var3 = "grieve_" + var1 + "_death";
    level.wifeanimnode scripts\common\anim::anim_single_solo(level.enforcerwife, var2);

    if(var1 == "enforcer" && scripts\engine\utility::flag("son_dead")) {
      return;
    }

    if(!scripts\engine\utility::flag("wife_dead")) {
      level.wifeanimnode notify("stop_loop");
      level.wifeanimnode thread scripts\common\anim::anim_loop_solo(level.enforcerwife, var3);
      return;
    }

    return;
  }
}

function son_react_death(var0, var1) {
  if(!scripts\engine\utility::flag("son_dead")) {
    var2 = scripts\engine\utility::ter_op(scripts\engine\utility::is_equal(var0, level.enforcer), "enforcer", "mother");
    var3 = "react_death_" + var2;

    if(istrue(var1)) {
      var3 += "_head";
    }

    var4 = "grieve_" + var2 + "_death";
    level.sonanimnode scripts\common\anim::anim_single_solo(level.enforcerson, var3);

    if(var2 == "enforcer" && scripts\engine\utility::flag("wife_dead")) {
      return;
    }

    if(!scripts\engine\utility::flag("son_dead")) {
      level.sonanimnode notify("stop_loop");
      level.sonanimnode thread scripts\common\anim::anim_loop_solo(level.enforcerson, var4);
    }

    return;
  }

  if(scripts\engine\utility::is_equal(var3, level.enforcerwife)) {
    level.sonanimnode notify("stop_loop");
    level.sonanimnode notify("single anim", "end");
    level.sonanimnode scripts\common\anim::anim_single_solo(level.enforcerson, "death_fall");
    level.sonanimnode thread scripts\common\anim::anim_last_frame_solo(level.enforcerson, "death_fall");
    return;
  }
}

function target_death_anim(var0, var1) {
  var1 = scripts\engine\utility::ter_op(isDefined(var1), var1, 0);

  if(istrue(var0.magic_bullet_shield)) {
    var0 scripts\common\ai::stop_magic_bullet_shield();
  }

  if(scripts\engine\utility::is_equal(var0, level.enforcer)) {
    level.enforcer.currentanimpriority = level.animpriority["death"];
  } else {
    level.currentrelativeanimpriority = level.animpriority["death"];
  }

  var0.skipdeathanim = 1;
  var0.diequietly = 1;
  self notify("stop_loop");
  var2 = scripts\engine\utility::ter_op(var1, "death_head", "death");

  if(scripts\engine\utility::is_equal(var0, level.enforcerwife)) {
    thread scripts\common\anim::anim_single_solo(level.familychair, var2 + "_wife");
  } else if(scripts\engine\utility::is_equal(var0, level.enforcerson)) {
    thread scripts\common\anim::anim_single_solo(level.familychair, var2 + "_son");
  }

  scripts\common\anim::anim_single_solo(var0, var2);

  if(scripts\engine\utility::is_equal(var0, level.enforcer)) {
    var2 += "_idle";
    var0 scripts\engine\sp\utility::name_hide();
    thread scripts\common\anim::anim_loop_solo(var0, var2);
    return;
  }
}

function idle_monitor() {
  level endon("missionfailed");
  var0 = 0;
  var1 = 0;
  var2 = 0;
  var3 = 0;
  var4 = 0;
  scripts\engine\utility::flag_wait("revolver_picked_up");

  while(!scripts\engine\utility::flag("final_phase")) {
    wait 1;
    var5 = 1;

    foreach(var7 in level.revolvervodone) {
      var5 = var5 && var7;
    }

    if(var5) {
      scripts\engine\utility::flag_clear("pause_inactive_vo");

      if(!var4) {
        play_dialogue("inactive", &scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_dry_fire_nags);
      }

      break;
    }

    if(level.actioncount <= 0) {
      var0 += 1;
      var1 += 1;
    } else {
      if(!var5) {
        scripts\engine\utility::flag_set("pause_inactive_vo");
      }

      level.actioncount = 0;
      var0 = 0;
      var1 = 0;
    }

    if(var4 && var1 > 8) {
      scripts\engine\utility::flag_clear("pause_inactive_vo");
    }

    if(var0 > 10 && !temp_is_performance_active() && !var3) {
      scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_ads_no_target();
      var0 = 0;
      var3 = 1;
    }

    if(var1 > 20 && !temp_is_performance_active() && !var4) {
      wait 5;
      play_dialogue("inactive", &scripts\sp\maps\stpetersburg\stpetersburg_vo::vo_interrogation_dry_fire_nags);
      var4 = 1;
    }
  }

  level waittill("start_hallway_idle_monitor");
  var0 = 0;

  while(!scripts\engine\utility::flag("interrogation_end")) {
    wait 1;

    if(level.actioncount <= 0) {
      var0 += 1;
    }

    if(var0 > 15) {
      level notify("price_hallway_nags_trigger");
      break;
    }
  }
}

function delete_on_level_notify(var0) {
  self endon("trigger");
  self endon("death");
  level waittill(var0);
  self delete();
}

function temp_performance_flag_set() {
  scripts\engine\utility::flag_set("scripted_performance");
}

function temp_performance_flag_clear() {
  scripts\engine\utility::flag_clear("scripted_performance");
}

function temp_is_performance_active() {
  return scripts\engine\utility::flag("scripted_performance");
}

function is_enforcer_target() {
  var0 = [1, 2, 3];
  return scripts\engine\utility::array_contains(var0, level.currentplayertarget);
}

function is_relative_target() {
  var0 = [9, 12, 10, 13, 11, 14];
  return scripts\engine\utility::array_contains(var0, level.currentplayertarget);
}

function is_enforcer_threatened() {
  var0 = [1, 2, 3, 4, 5, 16];
  return scripts\engine\utility::array_contains(var0, level.currentplayertarget);
}

function is_relative_threatened() {
  var0 = [9, 12, 10, 13, 11, 14, 15, 16];
  return scripts\engine\utility::array_contains(var0, level.currentplayertarget);
}

function get_interrogate_anim_priority(var0) {
  var1 = strtok(var0, "_");
  var2 = "";

  foreach(var4 in var1) {
    if(var5 == 0) {
      var2 = var4;
    } else {
      var2 = var2 + "_" + var4;
    }

    if(scripts\engine\utility::array_contains_key(level.animpriority, var2)) {
      return level.animpriority[var2];
    }
  }

  iprintlnbold("Nothing found for: " + var2);
  return -1;
}

function get_actor_alive_states() {
  var0 = !scripts\engine\utility::flag("enforcer_dead");
  var1 = !scripts\engine\utility::flag("wife_dead");
  var2 = !scripts\engine\utility::flag("son_dead");
  var3 = [var0, var1, var2];
  return var3;
}

function turn_on_headtracking(var0, var1) {}

function turn_off_headtracking() {
  if(isDefined(level.enforcer) && !scripts\engine\utility::flag("enforcer_dead")) {
    level.enforcer notify("headtracking_off");
    level.enforcer stoplookat();
  }

  if(isDefined(level.enforcerwife) && !scripts\engine\utility::flag("wife_dead")) {
    level.enforcerwife notify("headtracking_off");
    level.enforcerwife stoplookat();
  }

  if(isDefined(level.enforcerson) && !scripts\engine\utility::flag("son_dead")) {
    level.enforcerson notify("headtracking_off");
    level.enforcerson stoplookat();
    return;
  }
}

function turn_on_headtracking_solo(var0, var1, var2) {}

function look_at_ent_list(var0, var1, var2) {
  self notify("headtracking_off");
  self endon("headtracking_off");

  if(isDefined(var1)) {
    level endon(var1);
  }

  jumpiftrue(isDefined(var2)) LOC_00000024;
  var2 = 10;

  for(;;) {
    var3 = scripts\engine\utility::random(var0);
    scripts\common\utility::lookatentity(var3);
    wait randomfloatrange(var2 - 1, var2 + 1);
  }
}

function turn_off_headtracking_solo(var0) {
  if(isDefined(var0) && scripts\engine\utility::flag(var0)) {
    return;
  }

  self notify("headtracking_off");
  self stoplookat();
}

function blendshape_enable() {
  if(scripts\engine\utility::is_equal(self, level.enforcer) && scripts\engine\utility::flag("enforcer_dead")) {
    return;
  }

  var0 = blendshape_get_modelname(self);

  if(self.headmodel != var0) {
    self.og_headmodel = self.headmodel;
    self detach(self.headmodel);
    self.headmodel = var0;
    self attach(self.headmodel);
    return;
  }
}

function blendshape_get_modelname(var0) {
  switch (var0.name) {
    case "Captain Price":
      return "head_hero_price_blendshape";
    case "The Butcher":
      return "head_villain_enforcer_damage_blendshape";
    case "Nikolai":
      return "head_hero_nikolai_blendshape";
    case "Ousa":
      return "head_sc_f_mahdawi_blendshape";
    default:
      iprintlnbold("Something went wrong for: " + var0.name);
      break;
  }
}

function blendshape_disable() {
  if(!isDefined(self.og_headmodel)) {
    return;
  }

  self detach(self.headmodel);
  self.headmodel = self.og_headmodel;
  self attach(self.headmodel);
}

function name_hide_array(var0) {
  foreach(var2 in var0) {
    var2 scripts\engine\sp\utility::name_hide();
  }
}

function name_show_array(var0) {
  foreach(var2 in var0) {
    var2 scripts\engine\sp\utility::name_show();
  }
}

function should_skip_interrogation() {
  return scripts\common\utility::iswegameplatform();
}