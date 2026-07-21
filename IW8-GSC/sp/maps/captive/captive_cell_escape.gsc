/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\captive\captive_cell_escape.gsc
***************************************************/

cell_escape_flags() {
  scripts\engine\utility::flag_init("did_failed_open_vent");
  scripts\engine\utility::flag_init("got_spoon");
  scripts\engine\utility::flag_init("left_cell");
  scripts\engine\utility::flag_init("reached_second_cell");
  scripts\engine\utility::flag_init("hit_celldoor_button");
  scripts\engine\utility::flag_init("threw_noisemaker");
  scripts\engine\utility::flag_init("aimed_noisemaker");
}

cell_escape_start() {
  scripts\sp\player\teenagefarah::teenage_farah_cell_setup();
  setomnvar("ui_hide_hud", 1);
  level.spoon = spawn("script_model", scripts\engine\utility::getStruct("spoon_spawn", "targetname").origin + (0, 0, 1));
  level.spoon.angles = scripts\engine\utility::getStruct("spoon_spawn", "targetname").angles;
  level.spoon setModel("weapon_vm_me_spoon");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("hadir_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("main_cell");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_on("break_final");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("waterboarding");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("post_explosion");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("fallen_grate");
  scripts\sp\maps\captive\captive_lighting.gsc::lights_off("upstairs");
  scripts\sp\maps\captive\captive_lighting.gsc::dof_off();
  scripts\sp\maps\captive\captive_util.gsc::disable_context_melee();
  thread scripts\sp\maps\captive\captive_vo.gsc::vo_walla_guards_alert();
}

cell_escape_main() {
  var_0 = getEnt("bed_collision", "targetname");
  var_0 delete();
  var_1 = getEnt("check_allow_mantle_hud", "targetname");
  var_1 thread scripts\sp\maps\captive\captive_util.gsc::check_allow_mantle_hud();
  scripts\engine\sp\objectives::objective_update("objective", "current", undefined, &"CAPTIVE/OBJ_ESCAPE_CELL_DESC", &"CAPTIVE/OBJ_ESCAPE_CELL");
  scripts\sp\maps\captive\captive_util.gsc::setup_noisemaker_pickups();
  scripts\sp\player\teenagefarah::set_to_combat_speed();
  level thread check_pickup_noisemaker();
  var_2 = ["dx_vom_far_cell_escape_spoon_60", "dx_vom_far_cell_escape_spoon_70", "dx_vom_far_cell_escape_spoon_80"];
  level.player thread scripts\sp\maps\captive\captive_util.gsc::nagtill_delayed(20, "left_cell", var_2, 20, 1.3, 50);
  level.spoon thread spoon_check();
  scripts\sp\maps\captive\captive_util.gsc::init_low_vent_covers();
  var_3 = scripts\engine\utility::getStruct("stone_respawner", "targetname");
  var_3 thread stone_respawner_check();
  var_4 = getEnt("cell_door_button", "targetname");
  var_4 setCanDamage(1);
  var_4.health = 1000000;
  var_4 thread scripts\sp\maps\captive\captive_util.gsc::cell_door_button_check();
  scripts\engine\utility::flag_wait("got_spoon");
  scripts\sp\player\teenagefarah::teenage_farah_stealth_setup();
  level.player.currentpronespeedscale = 0;

  if(level.player getstance() == "prone")
    level.player setmovespeedscale(level.player.currentpronespeedscale);

  level thread reset_prone_scale_post_first_raise();
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ce_made_shiv();
  thread scripts\sp\maps\captive\captive_vo.gsc::mus_far_open_vent();
  scripts\engine\utility::flag_wait("reached_second_cell");
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ce_enter_cell();
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ce_rock_hints();
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ce_button_hint();
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ce_check_rock_near_button();
  level.player waittill("noisemaker_pickedup");

  if(scripts\engine\sp\utility::in_realism_mode())
    setomnvar("ui_realism_hud", 0);

  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ce_pickedup_first_rock();
  scripts\sp\maps\captive\captive_lighting.gsc::button_dof(var_4);
  scripts\engine\utility::flag_wait("hit_celldoor_button");

  if(scripts\engine\sp\utility::in_realism_mode())
    setomnvar("ui_realism_hud", 1);

  scripts\engine\utility::flag_set("aimed_noisemaker");
  scripts\engine\utility::flag_set("threw_noisemaker");
  level notify("stop_stone_respawner");
  var_3 scripts\sp\player\cursor_hint::remove_cursor_hint();
  level.disablenoisemakers = 1;
  scripts\sp\equipment\noisemaker::noisemakersdisablecursors();
  scripts\sp\maps\captive\captive_lighting.gsc::dof_off();
  level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ce_hit_button();
  var_5 = level.player getcurrentoffhand("secondaryoffhand");
  level.player scripts\engine\sp\utility::take_offhand(var_5);
  thread scripts\sp\analytics::analytics_kleenex_update("Open 1st grate to hit button");
  thread scripts\engine\sp\utility::autosave_by_name("cellblock_escape");
}

cell_escape_catchup() {
  if(level.start_point == "bink_speech") {
    return;
  }
  var_0 = getEnt("bed_collision", "targetname");
  var_0 delete();
  scripts\engine\utility::flag_set("got_spoon");
  scripts\engine\utility::flag_set("hit_celldoor_button");
  scripts\engine\utility::flag_set("threw_noisemaker");
  scripts\engine\utility::flag_set("aimed_noisemaker");
  scripts\sp\maps\captive\captive_util.gsc::cell_open_doors(1);
  scripts\sp\maps\captive\captive_util.gsc::init_low_vent_covers();
  var_1 = getEntArray("first_low_vent", "script_noteworthy");

  foreach(var_3 in var_1)
  var_3 delete();

  var_5 = getEnt("cell_door_button", "targetname");
  var_5 setCanDamage(1);
  var_5.health = 1000000;
  var_5 thread scripts\sp\maps\captive\captive_util.gsc::cell_door_button_check();
  scripts\engine\sp\objectives::objective_update("objective", "current", undefined, &"CAPTIVE/OBJ_ESCAPE_CELL_DESC", &"CAPTIVE/OBJ_ESCAPE_CELL");
}

spoon_check() {
  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_PICKUP", 360, 128, 64, 1);
  self waittill("trigger");

  foreach(var_1 in level.lowventcovers)
  var_1.frontinteract notify("clear_interact");

  self delete();

  if(scripts\engine\utility::flag("did_failed_open_vent"))
    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ce_pickup_spoon();

  scripts\engine\utility::flag_set("got_spoon");
}

reset_prone_scale_post_first_raise() {
  wait 4;
  level.player.currentpronespeedscale = 1.25;

  if(level.player getstance() == "prone")
    level.player setmovespeedscale(level.player.currentpronespeedscale);
}

stone_respawner_check() {
  self endon("death");
  level endon("stop_stone_respawner");
  level.lastspawnednoisemaker = undefined;
  thread stone_respawner_cursor_check();
  thread stone_respawn_pool_check();

  for(;;) {
    self waittill("trigger");
    scripts\sp\equipment\noisemaker::noisemakersdisablecursors();
    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ce_dig_in_respawner();
    var_0 = scripts\engine\sp\utility::spawn_anim_model("rock", level.breakanimref.origin, level.breakanimref.angles);
    level.breakanimref scripts\sp\player_rig::link_player_to_rig("rock_pile_dig", "crouch", undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
    level.player_rig attach("weapon_wm_me_spoonshank", "tag_accessory_right");
    level.breakanimref scripts\common\anim::anim_single([level.player_rig, var_0], "rock_pile_dig");
    level.player_rig detach("weapon_wm_me_spoonshank", "tag_accessory_right");
    scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
    var_0 delete();
    var_1 = level.player getammocount("noisemaker");

    if(isDefined(level.spawnednoisemakerpickup))
      level.spawnednoisemakerpickup delete();

    level.currentthrowobject = "captive_thrown_rock";
    level.player scripts\engine\sp\utility::give_offhand("noisemaker");
    level.player notify("noisemaker_pickedup", self);
    wait 0.5;
  }
}

stone_respawner_cursor_check() {
  self endon("death");
  level endon("stop_stone_respawner");
  scripts\engine\utility::flag_wait("got_spoon");
  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_DIG", 360, 128);

  for(;;) {
    level.player waittill("noisemaker_pickedup");
    scripts\sp\player\cursor_hint::remove_cursor_hint();
    level.player waittill("noisemaker_settled");

    while(isDefined(level.lastspawnednoisemaker))
      wait 0.5;

    var_0 = level.player getammocount("noisemaker");

    if(var_0 == 0)
      scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_DIG", 360, 128);
  }
}

stone_respawn_pool_check() {
  self endon("death");
  level endon("stop_stone_respawner");

  for(;;) {
    level.player waittill("noisemaker_settled", var_0);

    if(var_0.model == "captive_thrown_rock")
      level.spawnednoisemakerpickup = var_0;
  }
}

has_aimed_noisemaker() {
  if(scripts\engine\utility::flag("aimed_noisemaker"))
    return 1;

  return 0;
}

has_thrown_noisemaker() {
  if(scripts\engine\utility::flag("threw_noisemaker")) {
    scripts\engine\utility::flag_clear("aimed_noisemaker");
    return 1;
  }

  return 0;
}

check_pickup_noisemaker() {
  level endon("hit_celldoor_button");

  for(;;) {
    level.player waittill("noisemaker_pickedup");
    level.player playSound("scn_captive_rock_pickup");
    scripts\engine\utility::flag_clear("aimed_noisemaker");
    scripts\engine\utility::flag_clear("threw_noisemaker");

    if(level.player getlocalplayerprofiledata("grenadeHold"))
      thread scripts\engine\sp\utility::display_hint_forced("aim_noisemaker");
    else
      thread scripts\engine\sp\utility::display_hint_forced("aim_noisemaker_toggle");

    childthread check_aiming_noisemaker();
    childthread check_threw_noisemaker();
    scripts\engine\utility::flag_wait("aimed_noisemaker");

    if(level.player getlocalplayerprofiledata("grenadeHold"))
      thread scripts\engine\sp\utility::display_hint("throw_noisemaker");
    else
      thread scripts\engine\sp\utility::display_hint("throw_noisemaker_toggle");

    scripts\engine\utility::flag_wait("threw_noisemaker");
  }
}

check_aiming_noisemaker() {
  level endon("hit_celldoor_button");
  level.player waittill("secondary_offhand_pressed");
  var_0 = level.player getcurrentoffhand("secondaryoffhand");
  scripts\engine\utility::flag_clear("threw_noisemaker");

  if(isDefined(var_0)) {
    if(var_0.basename == "noisemaker")
      scripts\engine\utility::flag_set("aimed_noisemaker");
  }
}

check_threw_noisemaker() {
  level endon("hit_celldoor_button");
  level.player waittill("noisemaker_thrown");
  scripts\engine\utility::flag_set("threw_noisemaker");
}