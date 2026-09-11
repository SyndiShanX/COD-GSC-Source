/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\lab\lab_util.gsc
***********************************************/

function setplayerviewmodel(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    level.player setviewmodel(var_0);
  }

  if(isDefined(var_1)) {}

  if(isDefined(var_2)) {
    level.player setshadowmodel(var_2);
    return;
  }
}

function rpg_on_rebels() {
  if(scripts\engine\utility::flag("hilltop_heli_dead")) {
    return;
  }

  level endon("hilltop_heli_dead");

  for(;;) {
    var_0 = [level.rebel_1, level.rebel_2, level.rebel_3, level.rebel_4, level.rebel_5];
    var_0 = scripts\engine\utility::array_removedead_or_dying(var_0);
    var_1 = [];

    foreach(var_3 in var_0) {
      if(has_backpack(var_3)) {
        var_1 = var_3;
      }
    }

    var_0 = scripts\engine\utility::array_remove_array(var_0, var_1);

    if(var_0.size > 0) {
      var_3 = get_closest_actor(var_0, level.player.origin, 0);

      if(isDefined(var_3) && !isarray(var_3)) {
        GscBinSkip4(0x6e, var_3, 1);
      }
    }

    wait 2;
  }
}

function has_backpack() {
  var_0 = ["body_sla_rebels_lmg_2_1", "body_sla_rebels_female_5_1"];

  if(scripts\engine\utility::array_contains(var_0, self.model)) {
    return true;
  }

  return false;
}

function rpg_on_back(var_0) {
  self endon("death");

  while(!scripts\engine\utility::flag("hilltop_heli_dead")) {
    wait 2;

    while(in_player_fov(level.cos60, self getEye(), level.heroes)) {
      waitframe();
    }

    var_1 = spawn("weapon_iw8_la_rpapa7_straight", self.origin);
    var_1 linkTo(self, "j_spineupper", (0, 6.6, 0), (17, 0, 0));
    var_1 itemweaponsetammo(1, 1);
    thread remove_rpg_on_back(var_1);

    if(!isDefined(var_0)) {
      return;
    }

    var_1 waittill("trigger", var_2, var_3);

    if(isDefined(var_3)) {
      var_3 unlink();
      var_3 physicslaunchserveritem(var_3.origin, (0, 0, 15));
    }

    wait 5;
  }
}

function remove_rpg_on_back(var_0) {
  self endon("death");
  scripts\engine\utility::flag_wait("hilltop_heli_dead");

  while(isDefined(var_0)) {
    if(!scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_0.origin, level.cos60)) {
      var_0 delete();
    }

    wait 1;
  }
}

function make_incendiary_shottie() {
  return scripts\sp\utility::make_weapon("iw8_sh_dpapa12_incendiary");
}

function make_bulletdrop_weapon() {
  return scripts\sp\utility::make_weapon("iw8_sn_hdromeo_ballistics_quickraise", ["vzscope_hdromeo_ballistics", "bipod_hdromeo_ballistics", "rec_hdromeo|1", "back_hdromeo|1", "front_hdromeo|1", "mag_hdromeo|1"]);
}

function using_bulletdrop_weapon() {
  return self getcurrentweapon().basename == "iw8_sn_hdromeo_ballistics_quickraise";
}

function check_dropped_weapon() {
  var_0 = self.weapon;
  self waittill("death");
  var_1 = createheadicon(var_0);
  var_2 = spawn("weapon_" + var_1, self.origin + (0, 0, 15), 0);
}

function wait_for_dropped_weapon_or_timeout() {
  level endon("abort_wait_for_dropped_weapon");
  level thread scripts\engine\sp\utility::notify_delay("abort_wait_for_dropped_weapon", 0.1);
  self waittill("weapon_dropped", var_0);
  return var_0;
}

function intro_movie() {
  setomnvar("ui_hide_hud", 1);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  setomnvar("ui_hide_weapon_info", 1);
  cinematicingame("sp_estate_cine_transition");
  level.player freezecontrols(1);
  waitframe();

  while(iscinematicplaying()) {
    wait 0.05;
  }

  level.player freezecontrols(0);
  level notify("intro_movie_finised");

  if(isDefined(level.binkstopper)) {
    level.binkstopper destroy();
  }

  setomnvar("ui_hide_hud", 0);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(1);
  setomnvar("ui_hide_weapon_info", 0);
}

function player_jugg_fight(var_0) {
  if(var_0) {
    level.player setthreatbiasgroup("player");
    setsaveddvar("MSOOMPMPQS", 1);
    setsaveddvar("OLMLOTTLRM", 1.8);
    level.friendlyfiredisabled = 1;
    return;
  }

  level.player setthreatbiasgroup("allies");
  setsaveddvar("MSOOMPMPQS", 0);
  setsaveddvar("OLMLOTTLRM", 1.4);
  level.friendlyfiredisabled = 0;
}

function temp_nags(var_0, var_1, var_2, var_3) {
  level endon(var_1);

  if(!isDefined(var_2)) {
    var_2 = "Rebel";
  }

  if(!scripts\engine\utility::flag_exist(var_1)) {
    scripts\engine\utility::flag_init(var_1);
  }

  if(!isarray(var_0)) {
    var_0 = var_0;
  }

  jumpiffalse(isDefined(var_3)) LOC_00000038;
  wait var_3;

  while(!scripts\engine\utility::flag(var_1)) {
    foreach(var_5 in var_0) {
      thread temp_dialog(var_2, "green", var_5);
      wait 16;
    }
  }
}

function node_anim_reach_idle(var_0, var_1) {
  var_0 scripts\sp\anim::anim_reach_solo(self, var_1);
  var_0 thread scripts\common\anim::anim_loop_solo(self, var_1);
  var_0.guys_in_place++;
}

function anim_single_and_idle(var_0, var_1, var_2) {
  var_0 scripts\common\anim::anim_single_solo(self, var_1);
  var_0 thread scripts\common\anim::anim_loop_solo(self, var_2);
  var_0.guys_in_place++;
}

function anim_reach_arrive_idle(var_0, var_1, var_2) {
  var_0 scripts\sp\anim::anim_reach_solo(self, var_1);
  var_0 scripts\common\anim::anim_single_solo(self, var_1);
  var_0 thread scripts\common\anim::anim_loop([self, self.animatedmask], var_2);
  var_0.guys_in_place++;
}

function color_node_arrive(var_0) {
  self endon("death");
  self waittill("goal");

  if(isDefined(var_0.script_gesture)) {
    scripts\engine\utility::delaythread(0.7, &scripts\engine\sp\utility::gesture_simple, var_0.script_gesture);
  }

  if(isDefined(var_0.script_flag)) {
    scripts\engine\utility::flag_set(var_0.script_flag);
  }

  if(isDefined(var_0.script_sound)) {
    thread scripts\engine\sp\utility::smart_dialogue(var_0.script_sound);
    return;
  }
}

function teleport_when_safe(var_0, var_1) {
  while(isalive(var_0) && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, var_1.origin, cos(50))) {
    wait 0.15;
  }

  if(!isalive(var_0)) {
    return false;
  }

  var_0 forceteleport(var_1.origin, var_1.angles);
  return true;
}

function player_gas_mask(var_0, var_1) {
  level endon("switch_to_kyle");

  if(var_0) {
    level.player allowsprint(0);
    visor_anim(var_1, "ges_visor_down");
    level.player allowsprint(1);
    GscBinSkip4(0x6e, level.player);
  }

  visor_anim(var_1, "ges_visor_up", "old");
  wait 0.25;

  if(isDefined(level.gas_mask_overlay)) {
    level.gas_mask_overlay destroy();
    return;
  }
}

function visor_anim(var_0, var_1, var_2) {
  var_3 = 0.001;

  if(!isDefined(var_0)) {
    var_3 = 0.12;
  } else {
    visor_overlay(1, var_3, 10, 45);
    return;
  }

  if(scripts\engine\utility::is_equal(var_2, "old")) {
    level.player thread scripts\engine\sp\utility::player_gesture_force(var_1);
    wait 0.5;
    visor_overlay(0, var_3, 3.9, 30);
    return;
  }

  scripts\engine\utility::delaythread(2.5, &visor_overlay, 1, var_3, 10, 45);
  var_4 = mask_init();
  var_5 = var_4 scripts\engine\utility::getanim("player_mask_on");
  level.player thread scripts\engine\sp\utility::player_gesture_force("lab_vm_gasmask_ges");
  var_4 thread scripts\common\anim::anim_single_solo(var_4, "player_mask_on");
  wait 0.4;
  var_4 dontinterpolate();
  var_4 linktoplayerview(level.player, "j_wrist_le", (0, 0, 0), (0, 0, 0), 1, "view_jostle");
  scripts\engine\utility::flag_wait("player_mask_on");
  var_4 delete();
}

function visor_overlay(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.gas_mask_overlay)) {
    level.gas_mask_overlay = scripts\sp\hud_util::create_client_overlay("gasmask_overlay_delta2", 0);
    level.gas_mask_overlay.sort = -1;
    level.gas_mask_overlay.lowresbackground = 1;
  }

  level.gas_mask_overlay fadeovertime(var_1);
  level.gas_mask_overlay.alpha = var_0;
  level.player setdepthoffield(1, 200, 5000, 10000, 10, 0);
  level.player setviewmodeldepthoffield(4, 45, 6);
}

function mask_init() {
  scripts\engine\utility::flag_init("player_mask_on");
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("prop_child_hadir_gas_mask");
  var_0 scripts\engine\sp\utility::assign_animtree("player_mask");
  var_0 notsolid();
  var_0 scripts\common\anim::anim_first_frame_solo(var_0, "player_mask_on");
  return var_0;
}

function mask_death_function() {
  level endon("mission_fail");
  level endon("friendlyfire_mission_fail");
  scripts\engine\utility::waittill_any("death", "mission_fail", "friendlyfire_mission_fail");
  remove_mask_overlay();
}

function mask_fail_function() {
  level.player endon("death");
  level scripts\engine\utility::waittill_any("mission_fail", "friendlyfire_mission_fail");
  remove_mask_overlay();
}

function remove_mask_overlay() {
  if(isDefined(level.gas_mask_overlay)) {
    level.gas_mask_overlay fadeovertime(2);
    level.gas_mask_overlay.alpha = 0;
    wait 2;
    level.gas_mask_overlay destroy();
    return;
  }
}

function build_rebel_mask_lookup() {
  GscBinSkip1(0x45, "body_sla_rebels_female_1_1", "hat_sla_rebels_female_gasmask_1_1");
}

function ai_gas_mask(var_0) {
  var_1 = build_rebel_mask_lookup();

  if(self.team == "axis") {
    return;
  }

  if(var_0) {
    if(scripts\engine\utility::is_equal(self, level.farah)) {
      self.hatmodel = "hat_hero_farah_sas_gasmask";
    } else {
      if(isDefined(self.hatmodel)) {
        self detach(self.hatmodel);
        self.hatmodel = undefined;
      }

      self.hatmodel = var_1[self.model];
    }

    if(!isDefined(self.hatmodel)) {
      self.hatmodel = "hat_gasmask";
    }

    gasmask_on_belt("TAG_STOWED_BACK2", 0);
    self attach(self.hatmodel);
    return;
  }

  self detach(self.hatmodel);
  self.hatmodel = undefined;
}

function mask_in_hand() {
  self attach("hat_gasmask", "tag_accessory_right");
  self.mask = "hat_gasmask";
}

function delete_on_death_delayed(var_0) {
  var_0 endon("death");
  self waittill("death");
  var_0 scripts\engine\utility::delaycall(3, &delete);
}

function trigger_nearest_friendly_respawn_trigger() {
  var_0 = getEntArray("trigger_multiple_friendly_respawn", "classname");
  sortbydistance(var_0, level.player.origin)[0] notify("trigger", level.player);
}

function spawn_farah() {
  var_0 = getspawner("hero_farah", "targetname");
  var_0.count = 5;
  level.farah = scripts\engine\sp\utility::spawn_targetname("hero_farah", 1);
  level.farah.animname = "farah";
  level.heroes[level.heroes.size] = level.farah;
  gasmask_on_belt(level.farah, "TAG_STOWED_BACK2", 1);
  level.farah.goalradius = 64;
}

function allies_molotov_toggle(var_0) {
  if(scripts\engine\utility::is_equal(self, level.price) || scripts\engine\utility::is_equal(self, level.kyle)) {
    return;
  }

  if(var_0) {
    self.grenadeweapon = getcompleteweaponname("molotov");
  } else {
    scripts\engine\sp\utility::set_grenadeweapon("flash frag");
  }

  self.grenadeammo = 255;
  self.grenadesafedist = 400;
}

function axis_grenade_toggle(var_0) {
  if(var_0) {
    self.grenadeammo = 255;
    return;
  }

  self.grenadeammo = 0;
}

function gasmask_on_belt(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "TAG_STOWED_BACK2";
  }

  if(istrue(var_1)) {
    self attach("accessory_wm_gas_mask_stow", var_0);
    self.gas_mask = 1;
    return;
  }

  if(istrue(self.gas_mask)) {
    self detach("accessory_wm_gas_mask_stow", var_0);
    self.gas_mask = 0;
    return;
  }
}

function spawn_price(var_0) {
  var_1 = getspawner("hero_price", "targetname");
  var_1.count = 5;
  level.price = scripts\engine\sp\utility::spawn_targetname("hero_price", 1);
  level.price.colornode_func = &color_node_arrive;
  level.price attach("misc_wm_halligan_tool", "TAG_STOWED_BACK3");
  level.price.halligan = "misc_wm_halligan_tool";

  if(isDefined(var_0)) {
    ai_gas_mask(level.price, var_0);
  }

  gasmask_on_belt(level.price, "TAG_STOWED_BACK2", 1);
  level.heroes[level.heroes.size] = level.price;
}

function spawn_alex(var_0) {
  level.alex = scripts\engine\sp\utility::spawn_targetname("alex", 1);

  if(isDefined(var_0)) {
    ai_gas_mask(level.alex, var_0);
  }

  level.alex scripts\engine\sp\utility::set_force_color("p");
  level.heroes[level.heroes.size] = level.alex;
  level.alex thread scripts\anim\shared::forceuseweapon(make_bulletdrop_weapon(), "primary");
}

function spawn_kyle(var_0) {
  var_1 = getspawner("hero_kyle", "targetname");
  var_1.count = 5;
  level.kyle = scripts\engine\sp\utility::spawn_targetname("hero_kyle", 1);
  level.kyle.animname = "kyle";
  level.heroes[level.heroes.size] = level.kyle;
  level.kyle.colornode_func = &color_node_arrive;

  if(isDefined(var_0)) {
    ai_gas_mask(level.kyle, var_0);
    return;
  }
}

function spawn_hill_friendlies() {
  spawn_price();
  spawn_farah();
  spawn_kyle();
  level.rebel_1 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_1", 1);
  level.heroes[level.heroes.size] = level.rebel_1;
  thread rebel_flood_spawner(getspawner("redshirt_rebel_1", "targetname"));
  level.rebel_2 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_2", 1);
  level.heroes[level.heroes.size] = level.rebel_2;
  thread rebel_flood_spawner(getspawner("redshirt_rebel_2", "targetname"));
  level.rebel_3 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_3", 1);
  level.heroes[level.heroes.size] = level.rebel_3;
  thread rebel_flood_spawner(getspawner("redshirt_rebel_3", "targetname"));
  level.rebel_4 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_4", 1);
  level.heroes[level.heroes.size] = level.rebel_4;
  thread rebel_flood_spawner(getspawner("redshirt_rebel_4", "targetname"));
  level.rebel_5 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_5", 1);
  level.heroes[level.heroes.size] = level.rebel_5;
  thread rebel_flood_spawner(getspawner("redshirt_rebel_5", "targetname"));
  thread rpg_on_rebels();
}

function bridge_blocker_friendlies_spawn() {
  level.bridge_blocker_1 = scripts\engine\sp\utility::spawn_targetname("bridge_blocker_1", 1);
  level.bridge_blocker_2 = scripts\engine\sp\utility::spawn_targetname("bridge_blocker_2", 1);
  thread bridge_blockers_delete();
}

function bridge_blockers_delete() {
  scripts\engine\utility::flag_wait("green_beam_safe_zone");
  scripts\engine\utility::array_call(getEntArray("bridge_blockers", "script_noteworthy"), &delete);
}

function spawn_team_price() {
  spawn_price();
  spawn_kyle();
  level.rebel_1 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_1", 1);
  level.heroes[level.heroes.size] = level.rebel_1;
  thread rebel_flood_spawner(getspawner("redshirt_rebel_1", "targetname"));
  level.rebel_2 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_2", 1);
  level.heroes[level.heroes.size] = level.rebel_2;
  thread rebel_flood_spawner(getspawner("redshirt_rebel_2", "targetname"));
  level.rebel_3 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_3", 1);
  level.heroes[level.heroes.size] = level.rebel_3;
  thread rebel_flood_spawner(getspawner("redshirt_rebel_3", "targetname"));
}

function spawn_team_farah(var_0) {
  if(!scripts\sp\starts::is_after_start("gas_chambers")) {
    spawn_farah();

    if(scripts\sp\starts::is_after_start("hill_top")) {
      level.farah scripts\engine\sp\utility::set_force_color("g");
    }
  }

  level.rebel_1 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_1", 1);
  level.heroes[level.heroes.size] = level.rebel_1;
  thread rebel_flood_spawner(getspawner("redshirt_rebel_1", "targetname"), level.rebel_1);
  level.rebel_2 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_2", 1);
  level.heroes[level.heroes.size] = level.rebel_2;
  thread rebel_flood_spawner(getspawner("redshirt_rebel_2", "targetname"), level.rebel_2);
  level.rebel_3 = scripts\engine\sp\utility::spawn_targetname("redshirt_rebel_3", 1);
  level.heroes[level.heroes.size] = level.rebel_3;
  thread rebel_flood_spawner(getspawner("redshirt_rebel_3", "targetname"), level.rebel_3);
  array_thread_safe(level.heroes, &scripts\engine\sp\utility::set_goal_radius, 32);

  if(isDefined(var_0)) {
    array_thread_safe(level.heroes, &ai_gas_mask, 1);
    return;
  }
}

function price_spawn_func() {
  thread scripts\engine\sp\utility::battlechatter_probability(0.2);
}

function rebel_flood_spawner(var_0, var_1) {
  self endon("death");
  self endon("stop_rebel_flood");

  for(;;) {
    var_0 endon("entitydeleted");
    var_0 scripts\engine\utility::delaythread(0.1, &assign_spawner, self);

    if(!scripts\engine\utility::flag("open_lab_door")) {
      gasmask_on_belt(var_0, "TAG_STOWED_BACK2", 1);
    }

    var_0.my_spawner = self;
    var_0 waittill("death");
    level.heroes = scripts\engine\utility::array_remove(level.heroes, var_0);
    scripts\engine\utility::flag_waitopen("pause_rebel_respawning");
    rebel_flood_spawn_wait();

    while(scripts\engine\utility::within_fov(level.player.origin, level.player.angles, level.respawn_spawner_org, level.cos60)) {
      wait 0.15;
    }

    self.origin = level.respawn_spawner_org;
    self.count = 10;
    var_0 = self stalingradspawn();

    switch (self.script_animname) {
      case "rebel_1":
        level.rebel_1 = var_0;
        break;
      case "rebel_2":
        level.rebel_2 = var_0;
        break;
      case "rebel_3":
        level.rebel_3 = var_0;
        break;
      case "rebel_4":
        level.rebel_4 = var_0;
        break;
      case "rebel_5":
        level.rebel_5 = var_0;
        break;
      default:
        break;
    }

    if(!isDefined(var_1) && scripts\engine\utility::flag("lab_door_opened")) {
      var_1 = 1;
    }

    if(isDefined(var_1)) {
      thread ai_gas_mask(var_0);
    }

    rebuild_heroes_array();
    level.heroes[level.heroes.size] = var_0;

    if(isDefined(level.follow_ent)) {
      var_0 scripts\engine\utility::delaythread(0.1, &ai_movement_control, level.follow_ent);
    }

    if(isDefined(var_0)) {}
  }
}

function rebel_flood_spawn_wait() {
  level endon("clear_flood_wait");
  self endon("clear_flood_wait");
  wait 10;
}

function ai_movement_control(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(self) || !isDefined(level.follow_ent) || !isai(self) || !isalive(self)) {
    return;
  }

  scripts\engine\utility::flag_wait("tank_1_last_stop");

  if(!isDefined(self) || !isai(self) || !isalive(self)) {
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = level.player;
  }

  if(!isDefined(var_1)) {
    var_1 = 500;
  }

  if(!isDefined(var_2)) {
    var_2 = 500;
  }

  self.og_goalheight = self.goalheight;
  self.og_goalradius = self.goalradius;

  if(scripts\engine\utility::is_equal(self.team, "allies")) {
    scripts\engine\sp\utility::disable_ai_color();
    self.goalheight = 100;
  }

  self.goalradius = var_1;
  self.follow_ent = var_0;
  self cleargoalvolume();

  if(istrue(self.fixednode)) {
    self.fixednode = 0;
  }

  self setgoalpos(self.origin);
  self setgoalentity(var_0, var_2);
}

function stop_ai_movement_control() {
  self setgoalpos(self.origin);

  if(isDefined(self.og_goalradius)) {
    self.goalradius = self.og_goalradius;
  }

  if(isDefined(self.og_goalheight)) {
    self.goalheight = self.og_goalheight;
    return;
  }
}

function assign_spawner(var_0) {
  self.spawner = var_0;
}

function remove_animated_door(var_0) {
  var_1 = getEntArray(var_0, "script_noteworthy");

  foreach(var_3 in var_1) {
    assign_door_ents(var_3);
    var_3.collision connectpaths();
    waitframe();
    var_3.collision delete();
    var_3 delete();
  }
}

function assign_door_ents(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    if(var_3.spawnflags & 1) {
      var_0.collision = var_3;
    }

    var_3 linkTo(var_0);
  }

  var_0.closed_pos = var_0.origin;
}

function ai_laser_always_on() {
  self endon("death");
  scripts\engine\utility::flag_wait("ambush1_start");
  wait 2 + randomint(1);
  thread laser_discipline();
}

function laser_discipline() {
  self endon("death");
  var_0 = 0;
  self.a.laseron = 0;
  var_1 = 0.6;

  for(;;) {
    while(nullweapon(self.weapon)) {
      wait 0.25;
    }

    var_0 = is_aimed_at_enemy(level.cos10);

    if(var_0) {
      if(!self.a.laseron) {
        self.a.laseron = 1;
        self laserforceon();
        wait 0.5 + randomfloat(1);
        self.a.laseron = 0;
        self laserforceoff();
        wait 5 + randomfloat(2);
      }
    }

    wait var_1;
  }
}

function is_aimed_at_enemy(var_0) {
  if(isDefined(self) && isDefined(self.enemy) && isalive(self.enemy)) {
    var_1 = ["j_mainroot", "j_spine4", "tag_eye"];

    foreach(var_3 in var_1) {
      if(!isDefined(self gettagangles("tag_flash"))) {
        continue;
      }

      if(!nullweapon(self.weapon) && isalive(self.enemy) && scripts\engine\utility::within_fov(self.origin, self gettagangles("tag_flash"), self.enemy gettagorigin(var_3), var_0)) {
        return true;
      }
    }
  }

  return false;
}

function ai_display_dmg(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!isDefined(self.dmgarray)) {
    self.dmgarray = [];
    thread display_avg_dmg();
  }

  if(isDefined(var_0)) {
    var_10 = "DMG: " + var_0 + " HEALTH: " + self.health;
    self.dmgarray[self.dmgarray.size] = var_0;
    return;
  }
}

function display_avg_dmg() {
  self waittill("death");
  var_0 = self.dmgarray;
  var_1 = var_0.size;
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_2 += var_4;
  }

  iprintlnbold("Avg dmg per shot: " + var_2 / var_1);
  iprintlnbold("Times shot: " + var_1);
}

function display_enemy_lasknown_pos() {
  self endon("death");

  for(;;) {
    if(istrue(self._blackboard.shootparams_valid) && isDefined(self._blackboard.shootparams_pos)) {
      var_0 = self._blackboard.shootparams_pos;
    }

    waitframe();
  }
}

function rebuild_heroes_array() {
  level.heroes = scripts\engine\utility::array_removeundefined(level.heroes);
  return level.heroes;
}

function temp_dialog(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    wait var_3;
  }

  iprintlnbold(var_0 + ": " + var_2);
}

function get_closest_actor(var_0, var_1, var_2) {
  if(!isDefined(var_1)) {
    var_1 = level.player.origin;
  }

  var_3 = scripts\engine\utility::array_removeundefined(var_0);

  if(isDefined(var_2)) {
    return sortbydistance(var_3, var_1)[var_2];
  }

  return sortbydistance(var_3, var_1);
}

function in_player_fov(var_0, var_1, var_2) {
  var_3 = level.player getEye();
  var_4 = level.player getplayerangles();

  if(!isDefined(var_2)) {
    var_2 = scripts\engine\utility::array_removeundefined(level.heroes);
  }

  if(scripts\engine\utility::within_fov(var_3, var_4, var_1, var_0) && scripts\engine\trace::ray_trace_passed(var_3, var_1, var_2)) {
    return 1;
  }

  return 0;
}

function array_thread_safe(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_0 = scripts\engine\utility::array_removeundefined(var_0);

  if(isDefined(var_10)) {
    foreach(var_13, var_12 in var_0) {
      var_12 thread[[var_1]](var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    }

    return;
  }

  if(isDefined(var_12)) {
    foreach(var_15, var_12 in var_3) {
      var_12 thread[[var_4]](var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12);
    }

    return;
  }

  if(isDefined(var_14)) {
    foreach(var_17, var_12 in var_6) {
      var_12 thread[[var_7]](var_8, var_9, var_10, var_11, var_12, var_13, var_14);
    }

    return;
  }

  if(isDefined(var_15)) {
    foreach(var_19, var_12 in var_9) {
      var_12 thread[[var_10]](var_11, var_12, var_13, var_14, var_12, var_15);
    }

    return;
  }

  if(isDefined(var_12)) {
    foreach(var_12 in var_12) {
      var_12 thread[[var_13]](var_14, var_12, var_15, var_16, var_12);
    }

    return;
  }

  if(isDefined(var_18)) {
    foreach(var_12 in var_12) {
      var_12 thread[[var_15]](var_16, var_12, var_17, var_18);
    }

    return;
  }

  if(isDefined(var_19)) {
    foreach(var_12 in var_12) {
      var_12 thread[[var_17]](var_18, var_12, var_19);
    }

    return;
  }

  if(isDefined(var_12)) {
    foreach(var_12 in var_12) {
      var_12 thread[[var_19]](var_20, var_12);
    }

    return;
  }

  if(isDefined(var_22)) {
    foreach(var_12 in var_12) {
      var_12 thread[[var_21]](var_22);
    }

    return;
  }

  foreach(var_12 in var_12) {
    var_12 thread[[var_23]]();
  }
}

function disable_magic_bullet_delete() {
  stop_magic_bullet_safe();
  self delete();
}

function stop_magic_bullet_safe() {
  if(scripts\engine\utility::is_equal(self.magic_bullet_shield, 1)) {
    scripts\common\ai::stop_magic_bullet_shield();
    return;
  }
}

function magic_bullet_safe() {
  if(scripts\engine\utility::is_equal(self.magic_bullet_shield, 1)) {
    return;
  }

  scripts\common\ai::magic_bullet_shield();
}

function sun_flare_on() {
  while(!isDefined(level.sun_flare_pos)) {
    waitframe();
  }

  level.sun_flare_ent = spawn("script_model", level.sun_flare_pos);
  level.sun_flare_ent setModel("tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_lab_sunflare"), level.sun_flare_ent, "tag_origin");
}

function sun_flare_off() {
  if(isDefined(level.sun_flare_ent)) {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_lab_sunflare"), level.sun_flare_ent, "tag_origin");
    return;
  }
}

function anim_single_and_loop(var_0, var_1, var_2, var_3) {
  scripts\common\anim::anim_single(var_0, var_1);
  thread scripts\common\anim::anim_loop(var_0, var_2, var_3);
}

function anim_single_and_loop_solo(var_0, var_1, var_2, var_3) {
  var_0 endon("stop_single_loop");
  scripts\common\anim::anim_single_solo(var_0, var_1);
  var_0 setgoalpos(var_0.origin);
  childthread scripts\common\anim::anim_loop_solo(var_0, var_2, var_3);
}

function anim_reach_and_loop_solo(var_0, var_1, var_2, var_3) {
  var_0 endon("stop_reach_loop");
  scripts\sp\anim::anim_reach_solo(var_0, var_1);
  scripts\common\anim::anim_single_solo(var_0, var_1);
  childthread scripts\common\anim::anim_loop_solo(var_0, var_2, var_3);
}

function toggle_ignore_all() {
  if(isDefined(self.ignoreall)) {
    self.ignoreall = !self.ignoreall;
    return;
  }
}

function move_lab_allies(var_0, var_1, var_2) {
  var_3 = getnodearray(var_0, "targetname");

  if(!isarray(var_1)) {
    var_1 = [var_1];
  }

  foreach(var_5 in var_1) {
    if(!isDefined(var_5)) {
      continue;
    }

    var_6 = get_my_node(var_5, var_3);

    if(isDefined(var_6)) {
      var_5 scripts\engine\sp\utility::disable_ai_color();
      thread move_to_lab_node(var_5);
      var_3 = scripts\engine\utility::array_remove(var_3, var_6);

      if(isDefined(var_2)) {
        wait var_2;
      }
    }
  }
}

function get_my_node(var_0) {
  foreach(var_2 in var_0) {
    if(scripts\engine\utility::is_equal(var_2.script_noteworthy, self.animname)) {
      return var_2;
    }
  }
}

function move_to_lab_node(var_0) {
  self endon("death");
  self endon("entitydeleted");
  self clearpath();
  scripts\engine\sp\utility::anim_stopanimScripted();
  self.og_goalradius = self.goalradius;
  scripts\sp\spawner::go_to_node(var_0);

  if(isDefined(self)) {
    self.goalradius = self.og_goalradius;
    return;
  }
}

function scripted_ai_rocket(var_0, var_1) {
  if(!scripts\engine\utility::flag_exist(var_1)) {
    scripts\engine\utility::flag_init(var_1);
  }

  scripts\engine\utility::flag_wait(var_1);
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = havemapentseffects("actor_enemy_spetsnaz_rpg", var_2.origin, var_2.angles, 1);

  if(!isDefined(var_3)) {
    return;
  }

  var_3 endon("death");
  var_3.ignoreall = 1;
  var_3.ignoreme = 1;
  var_3 scripts\engine\sp\utility::enable_dontevershoot();
  var_3 scripts\anim\shared::forceuseweapon("iw8_la_rpapa7_straight_ai", "primary");
  var_4 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  var_5 = spawn("script_origin", var_2.origin);
  wait 0.4;
  magicbullet("iw8_la_rpapa7_straight", var_3 gettagorigin("tag_flash"), var_4.origin, var_3);
  wait 0.4;
  var_3 allowedstances("prone");
  wait 1;
  var_3 delete();
}

function scripted_ai_rocket_player(var_0) {
  self endon("death");
  scripts\engine\sp\utility::enable_dontevershoot();
  scripts\anim\shared::forceuseweapon("iw8_la_rpapa7_straight_ai", "primary");
  var_1 = scripts\engine\utility::getStruct("targetname", "targetname");
  var_2 = spawn("script_origin", var_1.origin);

  for(;;) {
    waitframe();
    var_3 = level.player gettagorigin("j_head");
    var_4 = var_3 + anglesToForward(level.player.angles) * 40;

    if(!scripts\engine\trace::can_see_origin(var_4)) {
      continue;
    }

    wait 0.4;
    self shoot(1, var_2);
    break;
  }

  wait 3;
  scripts\engine\sp\utility::disable_dontevershoot();
}

function cine_letterboxing_up(var_0) {
  level.player scripts\sp\player::focusdisable();
  hidecinematicletterboxing(var_0, 0);
  setomnvar("ui_hide_hud", 1);
}

function cine_letterboxing_down(var_0) {
  level.player scripts\sp\player::focusenable();
  getrandomnodedestination(var_0, 0);
  setomnvar("ui_hide_hud", 0);
}

function hide_hill_weapons() {
  level endon("stop_weapon_hide_stript");
  var_0 = getEntArray("hill_weapons_lower", "targetname");
  var_1 = getEntArray("hill_weapons_upper", "targetname");
  var_2 = getEntArray("hilltop_placed_rpg", "targetname");
  var_1 = scripts\engine\utility::array_combine(var_2, var_1);
  var_3 = scripts\engine\utility::array_combine(var_0, var_1);
  hide_ent_array(var_3);
  scripts\engine\utility::flag_wait("hill_weapons_lower");
  GscBinSkip4(0x6e, var_0, "left_bunker_weapons_volume", "left_bunker_weapons");
}

function monitor_weapons(var_0, var_1) {
  if(isDefined(var_1)) {
    var_2 = sort_weapon_array(self, var_1);
  } else {
    var_2 = self;
  }

  if(var_2.size < 1) {
    return;
  }

  var_3 = getEnt(var_1, "targetname");
  var_4 = 0;
  var_5 = 0;

  while(!scripts\engine\utility::flag("hill_finished_trig")) {
    var_5 = level.player istouching(var_3);

    if(!var_4 && var_5) {
      show_ent_array(var_2);
    } else if(var_4 && !var_5) {
      hide_ent_array(var_2);
    }

    var_4 = var_5;
    wait 0.5;
  }
}

function sort_weapon_array(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_0) {
    if(scripts\engine\utility::is_equal(var_4.script_parameters, var_1)) {
      var_2 = var_4;
    }
  }

  return var_2;
}

function hide_ent_array(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 hide();
    }
  }
}

function show_ent_array(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2)) {
      var_2 show();
    }
  }
}

function notetrack_nag(var_0, var_1, var_2) {
  level endon(var_1);
  jumpiffalse(isDefined(var_2)) LOC_00000010;
  level endon(var_2);

  for(;;) {
    foreach(var_4 in var_0) {
      level waittill("nag");
      scripts\engine\sp\utility::smart_dialogue(var_4);
    }

    level.player thread scripts\sp\player::focus_display_hint(undefined, 6);
  }
}

function vehicle_spawncovernodes(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_4 *= -1;
  var_6 *= -1;
  var_9 = anglesToForward(var_1);
  var_10 = anglestoright(var_1);
  var_11 = (0, 0, 1);
  var_12 = vectortoangles(var_9);
  var_13 = vectortoangles(var_9 * -1);
  var_14 = vectortoangles(var_10);
  var_15 = vectortoangles(var_10 * -1);
  var_16 = [];
  vehicle_addcovernodetemplate(var_16, "Cover Left", var_2 - 16, var_6, var_14);
  vehicle_addcovernodetemplate(var_16, "Cover Right", var_2 + var_3, var_6 + 16, var_13);
  vehicle_addcovernodetemplate(var_16, "Cover Left", var_2 + var_3, var_7 - 16, var_13);
  vehicle_addcovernodetemplate(var_16, "Cover Right", var_2 - 16, var_7, var_15);
  vehicle_addcovernodetemplate(var_16, "Cover Left", var_4 + 16, var_7, var_15);
  vehicle_addcovernodetemplate(var_16, "Cover Right", var_4 - var_5, var_7 - 16, var_12);
  vehicle_addcovernodetemplate(var_16, "Cover Left", var_4 - var_5, var_6 + 16, var_12);
  vehicle_addcovernodetemplate(var_16, "Cover Right", var_4 + 16, var_6, var_14);
  var_17 = [];

  foreach(var_19 in var_16) {
    var_20 = var_0 + var_9 * var_19.forwarddistance + var_10 * var_19.rightdistance + var_11 * 32;
    var_20 += anglesToForward(var_19.angles) * 16 * -1;
    var_21 = spawncovernode(var_20, var_19.angles, var_19.type, 4, var_8);

    if(isDefined(var_21)) {
      var_17 = scripts\engine\utility::array_add(var_17, var_21);
    }
  }

  return var_17;
}

function vehicle_addcovernodetemplate(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5.type = var_1;
  var_5.forwarddistance = var_2;
  var_5.rightdistance = var_3;
  var_5.angles = var_4;
  return scripts\engine\utility::array_add(var_0, var_5);
}

function display_ai() {
  level endon("clear_parking_ai");

  if(scripts\sp\starts::is_after_start("pipes_outdoor")) {
    return;
  }

  var_0 = (1, 1, 0);
  var_1 = (0, 1, 0);
  var_2 = (1, 0, 0);
  var_3 = ["axis", "allies", "team3", "neutral", "total"];

  for(;;) {
    var_4 = 30;

    foreach(var_6 in var_3) {
      if(var_6 == "total") {
        var_7 = getaiarray().size;
      } else {
        var_7 = getaiarray(var_6).size;
      }

      if(var_7 < 9) {
        var_8 = var_1;
      } else if(var_7 < 25) {
        var_8 = var_0;
      } else {
        var_8 = var_2;
      }

      var_4 += 15;
    }

    waitframe();
  }
}

function wind_setdirection(var_0, var_1, var_2) {
  var_3 = (0, 0, 1);

  if(isDefined(level.ballistics.windobject)) {
    scripts\common\basic_wind::stop_wind(level.ballistics.windobject);
  }

  level.ballistics.windobject = scripts\common\basic_wind::init_wind(var_0, 2, 0);

  if(var_2) {
    var_4 = level.ballistics.wind;
    var_5 = 0;
    var_6 = gettime();
    var_7 = var_6 + var_2;
    var_8 = var_2 * 0.001 * 20;
    var_9 = 1 / var_8;

    while(gettime() < var_7) {
      var_10 = var_4;
      var_11 = vectorcross(var_10, var_3);
      var_12 = axistoangles(var_10, var_11, var_3);
      var_13 = var_1;
      var_14 = vectorcross(var_13, var_3);
      var_15 = axistoangles(var_13, var_14, var_3);
      var_16 = scripts\engine\math::fake_slerp(var_12, var_15, var_5);
      level.ballistics.wind = anglesToForward(var_16);
      var_5 += var_9;
      waitframe();
    }
  }

  level.ballistics.wind = var_1;
  setsaveddvar("MQPQKNPQOK", 2);
  setsaveddvar("MRNRKKOPLN", 2);
  setsaveddvar("NQTLPTNSSO", 3);
  setsaveddvar("OLSKLTPPMR", 0.7);
  setsaveddvar("LQLSPQOPKM", 50);
  setsaveddvar("NTMMTOLQMQ", level.ballistics.wind);
}

function unlink_player_from_rig_lab(var_0, var_1, var_2, var_3) {
  var_4 = level.player_rig;
  var_4 notify("unlink_player");

  if(!scripts\engine\utility::is_equal(level.player getlinkedparent(), var_4)) {
    return;
  }

  switch (var_4.stance) {
    case "stand":
      level.player scripts\common\utility::allow_crouch(1, "player_rig");
      level.player scripts\common\utility::allow_prone(1, "player_rig");
      break;
    case "crouch":
      level.player scripts\common\utility::allow_stand(1, "player_rig");
      level.player scripts\common\utility::allow_prone(1, "player_rig");
      break;
    case "prone":
      level.player scripts\common\utility::allow_stand(1, "player_rig");
      level.player scripts\common\utility::allow_crouch(1, "player_rig");
      break;
  }

  if(istrue(var_0)) {
    var_1 = var_4.ogstance;
  }

  if(isDefined(var_1)) {
    if(istrue(var_2)) {
      level.player setstance(var_1, 1, 1, 1);
      var_5 = scripts\engine\utility::drop_to_ground(level.player getEye(), 0, -60, (0, 0, 1));
      level.player setOrigin(var_5, 1);
    } else if(var_1 != var_4.stance) {
      level.player setstance(var_1);
    }
  }

  level.player unlink();

  if(!istrue(var_3)) {
    var_4 delete();
  }

  scripts\sp\utility::nvidiaansel_scriptdisable(0);
  level.player enablequickweaponswitch(0);
  level.player scripts\common\utility::allow_offhand_weapons(1, "player_rig");
  level.player scripts\common\utility::allow_sprint(1, "player_rig");
  level.player scripts\common\utility::allow_jump(1, "player_rig");
  level.player scripts\common\utility::allow_armor(1, "player_rig");
  level.player scripts\common\utility::allow_melee(1, "player_rig");
  level.player scripts\common\utility::allow_mantle(1, "player_rig");
}

function dragonsbreathpainfxhackspawnfunc() {
  while(!isDefined(level.spawn_funcs)) {
    wait 0.05;
  }

  scripts\engine\utility::array_thread(getaiarray(), &dragonsbreathpainfxhack);
  scripts\engine\sp\utility::add_global_spawn_function("allies", &dragonsbreathpainfxhack);
  scripts\engine\sp\utility::add_global_spawn_function("axis", &dragonsbreathpainfxhack);
  scripts\engine\sp\utility::add_global_spawn_function("neutral", &dragonsbreathpainfxhack);
  scripts\engine\sp\utility::add_global_spawn_function("team3", &dragonsbreathpainfxhack);
}

function dragonsbreathpainfxhack() {
  self endon("deathDelayed");
  thread notifydeathdelayed();

  for(;;) {
    self waittill("damage", var_0, var_0, var_0, var_1, var_0, var_0, var_0, var_0, var_0, var_2);

    if(!isDefined(var_2)) {
      continue;
    }

    if(isDefined(self.damagemod) && self.damagemod == "MOD_MELEE") {
      continue;
    }

    var_3 = getweaponammopoolname(var_2);

    if(var_3 == "incendiary") {
      dodragonsbreathpainfxhack(var_1);
    }
  }
}

function notifydeathdelayed() {
  self endon("entitydeleted");
  self waittill("death");
  wait 0.1;

  if(isDefined(self)) {
    self notify("deathDelayed");
    return;
  }
}

function dodragonsbreathpainfxhack(var_0) {
  wait 0.05;
  var_1 = getdragonsbreathvfxpackets();
  var_2 = [];
  var_3 = 20;

  foreach(var_5 in var_1) {
    var_6 = self gettagorigin(var_5.tag);

    if(distance(var_6, var_0) < var_3) {
      var_2 = scripts\engine\utility::array_add(var_2, var_5);
    }

    if(var_2.size > 3) {
      break;
    }
  }

  foreach(var_5 in var_2) {
    if(isDefined(self.basearchetype) && self.basearchetype == "juggernaut") {
      killfxontag(scripts\engine\utility::getfx("dragonsbreath_jugg_limb"), self, var_5.tag);
      killfxontag(scripts\engine\utility::getfx("dragonsbreath_jugg_chest"), self, var_5.tag);
      waitframe();

      if(var_5.tag == "j_spine4") {
        var_9 = scripts\engine\utility::getfx("dragonsbreath_jugg_chest");
        playFXOnTag(var_9, self, var_5.tag);
      } else {
        var_9 = scripts\engine\utility::getfx("dragonsbreath_jugg_limb");
        playFXOnTag(var_9, self, var_6.tag);
      }
    }

    if(fx_death_check(var_6)) {
      playFXOnTag(scripts\engine\utility::getfx(var_6.burnvfx + "_death"), self, var_6.tag);
      continue;
    }

    playFXOnTag(scripts\engine\utility::getfx(var_6.burnvfx), self, var_6.tag);
  }

  var_9 = undefined;
}

function fx_death_check(var_0) {
  if(var_0.tag == "j_head" || var_0.tag == "j_helmet") {
    return false;
  }

  if(istrue(self.bypassdbcheck)) {
    return true;
  }

  if(isalive(self)) {
    return false;
  }

  if(!isDefined(scripts\engine\utility::getfx(var_0.burnvfx + "_death"))) {
    return false;
  }

  return true;
}

function getdragonsbreathvfxpackets() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, createburnvfxpacket("j_knee_ri", "dragonsbreath_pain_limb"));
}

function createburnvfxpacket(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.tag = var_0;
  var_3.burnvfx = var_1;
  var_3.origin = self gettagorigin(var_0);
  return var_3;
}