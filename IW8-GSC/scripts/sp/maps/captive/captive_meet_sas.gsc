/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\captive\captive_meet_sas.gsc
********************************************************/

function meet_sas_flags() {
  scripts\engine\utility::flag_init("in_warehouse");
  scripts\engine\utility::flag_init("reached_sniper_cover");
  scripts\engine\utility::flag_init("reached_explore_2");
  scripts\engine\utility::flag_init("all_women_inside");
  scripts\engine\utility::flag_init("meet_sas_ready");
  scripts\engine\utility::flag_init("at_secure_door_threshold");
  scripts\engine\utility::flag_init("start_meet_sas_scene");
}

function meet_sas_start() {
  scripts\engine\utility::flag_set("saved_azadeh");
  scripts\engine\sp\utility::set_start_location("player_spawn_meet_sas", [level.player]);
  scripts\sp\player\teenagefarah::teenage_farah_combat_setup();
  scripts\sp\maps\captive\captive_util::spawn_prisoners();
  scripts\engine\sp\utility::activate_trigger_with_targetname("warehouse_sniper_defend");
  scripts\engine\sp\utility::activate_trigger_with_targetname("nadia_guard_door_exterior");
}

function meet_sas_main() {
  level.player setsoundsubmix("sp_npc_steps_down", 3, 1);
  scripts\engine\utility::delaythread(0.1, &scripts\engine\sp\utility::transient_load, "captive_gas_tr");
  thread warehouse_enter_teleport();
  level.meetsasref = scripts\engine\utility::getStruct("ref_MEET_sas", "targetname");
  level.securedoor = scripts\sp\door::get_interactive_door("secure_door");
  thread check_entered_through_secure_door();
  level.securedoor.animname = "secure_door";
  level.securedoor scripts\common\anim::setanimtree();

  if(!scripts\engine\utility::flag("sniper_killed")) {
    thread sniper_in_warehouse();
    scripts\engine\utility::flag_wait("reached_sniper_cover");
    scripts\engine\sp\utility::activate_trigger_with_targetname("warehouse_sniper_defend");
    scripts\engine\sp\utility::activate_trigger_with_targetname("nadia_guard_door_exterior");
  }

  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("enter_secure_area_objective", "targetname").origin);
  scripts\engine\utility::delaythread(0.25, &scripts\sp\maps\captive\captive_util::default_prisoner_movement_speeds);
  thread women_move_through_warehouse();
  scripts\engine\utility::flag_wait("start_meet_sas_scene");
  level thread scripts\engine\sp\utility::battlechatter_off("allies");
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("find_hadir_objective_1", "targetname").origin);
  thread close_warehouse_door();
  level.player scripts\common\utility::allow_weapon(0, "player_rig");
  level.ayah stopsounds();
  level.ayah scripts\engine\sp\utility::teleport_ai(getnode("bunker_ayah_start", "targetname"));
  level.darine stopsounds();
  level.darine scripts\engine\sp\utility::teleport_ai(getnode("bunker_darine_start", "targetname"));

  if(isDefined(level.nadia) && isalive(level.nadia)) {
    level.nadia stopsounds();
    level.nadia scripts\engine\sp\utility::teleport_ai(getnode("bunker_nadia_start", "targetname"));
  }

  if(isDefined(level.ghalia) && isalive(level.ghalia)) {
    level.ghalia stopsounds();
    level.ghalia scripts\engine\sp\utility::teleport_ai(getnode("bunker_ghalia_start", "targetname"));
  }

  if(isDefined(level.azadeh) && isalive(level.azadeh)) {
    level.azadeh stopsounds();
    level.azadeh scripts\engine\sp\utility::teleport_ai(getnode("bunker_azadeh_start", "targetname"));
  }

  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    var_2 delete();
  }

  var_4 = scripts\engine\sp\utility::array_spawn_targetname("meet_sas_guards", 1);
  scripts\sp\maps\captive\captive_util::spawn_sas();
  var_5 = scripts\engine\sp\utility::spawn_anim_model("rope1");
  var_6 = scripts\engine\sp\utility::spawn_anim_model("rope2");
  var_7 = scripts\engine\sp\utility::spawn_anim_model("rope3");
  var_8 = getscriptablearray("destructible_skylight", "targetname")[0];
  thread wait_trigger_destructible_skylight(level);
  var_9 = [level.sas1, level.sas2, var_5, var_6, var_7];
  GscBinSkip0(0x2e, var_9.size, level.ayah, var_8, level, level, level, level.securedoor, level);
}

function sniper_achievement_check() {
  if(level.dodgedbullet) {
    scripts\sp\utility::giveachievement_wrapper("dodgebullet");
    return;
  }
}

function warehouse_enter_teleport() {
  var_0 = (1811, -1021, 3);
  var_1 = (0, 195, 0);
  var_2 = scripts\engine\utility::array_removedead(level.allprisoners);
  var_3 = cos(70);

  foreach(var_5 in var_2) {
    if(should_teleport(var_5) && !scripts\engine\utility::within_fov(var_0, level.player.origin, level.player.angles, var_3)) {
      var_5 forceteleport(var_0, var_1, 10000);
      var_0 += anglestoright(var_1) * 60;
    }
  }
}

function should_teleport() {
  var_0 = (1811, -1021, 3);

  if(self.origin[0] > 1842 && distance2d(self.origin, var_0) > 100) {
    return true;
  }

  return false;
}

function meet_sas_catchup() {
  if(level.start_point == "bink_speech") {
    return;
  }

  thread close_warehouse_door();
  update_sas_names();
  scripts\engine\sp\objectives::objective_set_position("objective", scripts\engine\utility::getStruct("find_hadir_objective_1", "targetname").origin);
}

function sniper_in_warehouse() {
  if(isDefined(level.fakesniper)) {
    level.fakesniper notify("kill_sniper");
  }

  var_0 = scripts\engine\sp\utility::spawn_targetname("sniper_interior", 1);
  var_0.ignoreme = 1;
  var_0.ignoreall = 1;
  var_0.dropweapon = 0;
  var_0.sidearm = isundefinedweapon();
  var_1 = scripts\sp\utility::make_weapon("iw8_sn_delta", ["laser_captive"]);
  var_0 scripts\anim\shared::forceuseweapon(var_1, "primary");
  var_0 laserforceon();
  var_0 scripts\engine\utility::delaycall(7, &laserforceoff);
  thread goto_node_and_callout();
  var_0.ignoreall = 0;
  var_0.ignoreme = 0;
  var_2 = waittill_death_or_flag(var_0, "start_meet_sas_scene");

  if(!isDefined(var_2)) {
    if(isalive(var_0)) {
      var_0 kill();
    }
  } else {
    thread scripts\sp\maps\captive\captive_vo::vo_ex_killed_sniper(var_2);
  }

  level.dont_callout_sniper_kill = 1;
  scripts\sp\analytics::analytics_event_upload("Player RPGd Sniper", 0);
  scripts\engine\utility::flag_set("sniper_killed");
}

function goto_node_and_callout() {
  self endon("death");
  scripts\sp\spawner::go_to_node(getnode("sniper_on_catwalk", "targetname"));
  level scripts\sp\maps\captive\captive_vo::vo_ms_sniper_alive();
}

function waittill_death_or_flag(var_0) {
  if(scripts\engine\utility::flag(var_0)) {
    return;
  }

  level endon(var_0);
  self waittill("death", var_1);
  return var_1;
}

function women_move_through_warehouse() {
  level endon("start_meet_sas_scene");
  scripts\engine\utility::flag_wait("sniper_killed");
  scripts\engine\sp\utility::activate_trigger_with_targetname("explore_warehouse_1");
  scripts\engine\utility::flag_wait_or_timeout("reached_explore_2", 5);
  level thread scripts\sp\maps\captive\captive_vo::vo_ms_nag_sas_door();
  scripts\engine\sp\utility::activate_trigger_with_targetname("explore_warehouse_2");
}

function close_warehouse_door() {
  var_0 = scripts\sp\maps\captive\captive_util::setup_scripted_door("warehouse_main_door");
  var_1 = scripts\engine\utility::getStruct("warehouse_door_closed", "targetname");
  var_0.origin = var_1.origin;
  var_0.angles = var_1.angles;
  var_0.clip disconnectPaths();
  var_2 = getEnt("warehouse_main_door_bolt", "targetname");
  var_3 = scripts\engine\utility::getStruct("warehouse_main_door_bolt_closed", "targetname");
  var_2.origin = var_3.origin;
  var_2.angles = var_3.angles;
}

function check_entered_through_secure_door() {
  var_0 = 45;
  var_1 = angleclamp180(self.angles[1]);

  while(angleclamp180(self.angles[1] - var_1) < var_0) {
    waitframe();
  }

  scripts\engine\utility::flag_wait("at_secure_door_threshold");
  scripts\sp\door::remove_open_ability();
  thread door_hit_fx();
  thread scripts\sp\maps\captive\captive_vo::mus_meet_sas();
  var_2 = scripts\sp\player_rig::get_player_rig(1);
  level.player_rig.allows = ["offhand_weapons", "melee", "sprint", "jump", "mantle"];

  if(angleclamp180(self.angles[1] - var_1) < 100) {
    level.meetsasref thread scripts\sp\player_rig::link_player_to_rig("meet_sas", "stand", 1, 0.26, undefined, 0, 30, 30, 15, 1);
    level.meetsasref thread scripts\common\anim::anim_single_solo(self, "half_hit");
    wait 0.26;
    scripts\engine\utility::flag_set("start_meet_sas_scene");
  } else {
    level.meetsasref thread scripts\sp\player_rig::link_player_to_rig("meet_sas", "stand", 1, 0.26, undefined, 0, 30, 30, 15, 1);
    level.meetsasref thread scripts\common\anim::anim_single_solo(self, "full_hit");
    wait 0.26;
    scripts\engine\utility::flag_set("start_meet_sas_scene");
  }

  wait 7;
  level.player lerpviewangleclamp(3, 1, 1, 30, 30, 30, 15);
}

function door_hit_fx() {
  level waittill("door_hit_player");
  var_0 = 10;

  if(level.player.health <= 10) {
    var_0 = level.player.health - 1;
  }

  level.player playSound("scn_captive_sas_enter_gun_hit_plr");
  level.player shellshock("captive_hit_sas", 2);
  level.player scripts\sp\utility::do_damage(var_0, level.securedoor.origin, undefined, undefined, "MOD_MELEE");
  level.player playRumbleOnEntity("heavy_1s");
  wait 0.5;
  level.player playRumbleOnEntity("light_1s");
}

function price_meet_sas_scene() {
  scripts\sp\utility::nvidiaansel_scriptdisable(1);
  level.price detach("hat_hero_price_gasmask");
  var_0 = scripts\engine\sp\utility::spawn_anim_model("price_gasmask");
  level.meetsasref scripts\common\anim::anim_single([level.price, var_0], "meet_sas");
  level.price attach("hat_hero_price_gasmask");
  var_0 delete();
  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

function guards_killed_by_sas(var_0) {
  level.meetsasref scripts\common\anim::anim_single(var_0, "meet_sas");

  foreach(var_2 in var_0) {
    var_2.allowdeath = 1;
    var_2 scripts\engine\sp\utility::die();
  }
}

function wait_trigger_destructible_skylight(var_0) {
  level waittill("trigger_skylight");
  level.player playSound("scn_captive_sas_skylight_expl_lr");
  var_0 setscriptablepartstate("base", "break");
  level.player playRumbleOnEntity("heavy_1s");
}

function wait_assign_friendnames() {
  level waittill("assign_friendnames");
  update_sas_names();
}

function update_sas_names() {
  level.price.script_friendname = "Lt. Price";
  level.price.name = level.price.script_friendname;
  level.sas1.script_friendname = "S.A.S.";
  level.sas1.name = level.sas1.script_friendname;
  level.sas2.script_friendname = "S.A.S.";
  level.sas2.name = level.sas1.script_friendname;
}