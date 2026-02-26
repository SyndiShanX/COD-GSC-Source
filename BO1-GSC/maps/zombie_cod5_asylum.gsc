/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\zombie_cod5_asylum.gsc
***************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_zombiemode_utility;
#include maps\_zombiemode_zone_manager;
#include maps\_music;
#using_animtree("generic_human");

main() {
  maps\zombie_cod5_asylum_fx::main();
  PreCacheModel("viewmodel_usa_pow_arms");
  PreCacheModel("viewmodel_rus_prisoner_arms");
  PreCacheModel("viewmodel_vtn_nva_standard_arms");
  PreCacheModel("viewmodel_usa_hazmat_arms");
  PreCacheModel("zombie_asylum_chair_nogore");
  PreCacheModel("zombie_power_lever_handle");
  level thread maps\_callbacksetup::SetupCallbacks();
  level.dogs_enabled = false;
  level.zones = [];
  precacheshellshock("electrocution");
  level.door_dialog_function = maps\_zombiemode::play_door_dialog;
  level.custom_zombie_vox = ::setup_custom_vox;
  precachemodel("tag_origin");
  precachemodel("zombie_zapper_power_box");
  precachemodel("zombie_zapper_power_box_on");
  precachemodel("zombie_zapper_cagelight_red");
  precachemodel("zombie_zapper_cagelight_green");
  precachemodel("lights_tinhatlamp_off");
  precachemodel("lights_tinhatlamp_on");
  precachemodel("lights_indlight_on");
  precachemodel("lights_indlight");
  level.valve_hint_north = (&"WAW_ZOMBIE_BUTTON_NORTH_FLAMES");
  level.valve_hint_south = (&"WAW_ZOMBIE_BUTTON_NORTH_FLAMES");
  precachestring(level.valve_hint_north);
  precachestring(level.valve_hint_south);
  precachestring(&"WAW_ZOMBIE_BETTY_ALREADY_PURCHASED");
  precachestring(&"WAW_ZOMBIE_BETTY_HOWTO");
  precachestring(&"WAW_ZOMBIE_FLAMES_UNAVAILABLE");
  precachestring(&"WAW_ZOMBIE_USE_AUTO_TURRET");
  precachestring(&"WAW_ZOMBIE_ELECTRIC_SWITCH");
  precachestring(&"WAW_ZOMBIE_INTRO_ASYLUM_LEVEL_BERLIN");
  precachestring(&"WAW_ZOMBIE_INTRO_ASYLUM_LEVEL_HIMMLER");
  precachestring(&"WAW_ZOMBIE_INTRO_ASYLUM_LEVEL_SEPTEMBER");
  include_weapons();
  include_powerups();
  if(getDvar("light_mode") != "") {
    return;
  }
  level._effect["zombie_grain"] = LoadFx("misc/fx_zombie_grain_cloud");
  maps\_waw_zombiemode_radio::init();
  level.Player_Spawn_func = ::spawn_point_override;
  level.zombiemode_precache_player_model_override = ::precache_player_model_override;
  level.zombiemode_give_player_model_override = ::give_player_model_override;
  level.zombiemode_player_set_viewmodel_override = ::player_set_viewmodel_override;
  level.register_offhand_weapons_for_level_defaults_override = ::register_offhand_weapons_for_level_defaults_override;
  level.use_zombie_heroes = true;
  maps\_zombiemode::main();
  level.zone_manager_init_func = ::asylum_zone_init;
  init_zones[0] = "west_downstairs_zone";
  init_zones[1] = "west2_downstairs_zone";
  level thread maps\_zombiemode_zone_manager::manage_zones(init_zones);
  level.burning_zombies = [];
  level.electrocuted_zombies = [];
  init_sounds();
  level thread master_electric_switch();
  init_zombie_asylum();
  level thread intro_screen();
  level thread toilet_useage();
  level thread chair_useage();
  level thread magic_box_light();
  level thread mature_settings_changes();
  maps\_zombiemode_betty::init();
  level.zombie_visionset = "zombie_asylum";
  maps\createart\zombie_cod5_asylum_art::main();
  level.has_pack_a_punch = false;
}
asylum_zone_init() {
  flag_init("always_on");
  flag_set("always_on");
  add_adjacent_zone("west_downstairs_zone", "west2_downstairs_zone", "power_on");
  add_adjacent_zone("west2_downstairs_zone", "north_downstairs_zone", "north_door1");
  add_adjacent_zone("north_downstairs_zone", "north_upstairs_zone", "north_upstairs_blocker");
  add_adjacent_zone("north_upstairs_zone", "north2_upstairs_zone", "upstairs_north_door1");
  add_adjacent_zone("north2_upstairs_zone", "kitchen_upstairs_zone", "upstairs_north_door2");
  add_adjacent_zone("kitchen_upstairs_zone", "power_upstairs_zone", "magic_box_north");
  add_adjacent_zone("west_downstairs_zone", "south_upstairs_zone", "south_upstairs_blocker");
  add_adjacent_zone("south_upstairs_zone", "south2_upstairs_zone", "south_access_1");
  add_adjacent_zone("south2_upstairs_zone", "power_upstairs_zone", "magic_box_south");
}
precache_player_model_override() {
  mptype\player_t5_zm_theater::precache();
}
give_player_model_override(entity_num) {
  if(isDefined(self.zm_random_char)) {
    entity_num = self.zm_random_char;
  }
  switch (entity_num) {
    case 0:
      character\c_usa_dempsey_zt::main();
      break;
    case 1:
      character\c_rus_nikolai_zt::main();
      break;
    case 2:
      character\c_jap_takeo_zt::main();
      break;
    case 3:
      character\c_ger_richtofen_zt::main();
      break;
  }
}
player_set_viewmodel_override(entity_num) {
  switch (self.entity_num) {
    case 0:
      self SetViewModel("viewmodel_usa_pow_arms");
      break;
    case 1:
      self SetViewModel("viewmodel_rus_prisoner_arms");
      break;
    case 2:
      self SetViewModel("viewmodel_vtn_nva_standard_arms");
      break;
    case 3:
      self SetViewModel("viewmodel_usa_hazmat_arms");
      break;
  }
}
register_offhand_weapons_for_level_defaults_override() {
  register_lethal_grenade_for_level("stielhandgranate");
  level.zombie_lethal_grenade_player_init = "stielhandgranate";
  register_tactical_grenade_for_level("zombie_cymbal_monkey");
  level.zombie_tactical_grenade_player_init = undefined;
  register_placeable_mine_for_level("mine_bouncing_betty");
  level.zombie_placeable_mine_player_init = undefined;
  register_melee_weapon_for_level("knife_zm");
  level.zombie_melee_weapon_player_init = "knife_zm";
}
player_zombie_awareness() {
  self endon("disconnect");
  self endon("death");
  while(1) {
    wait(1);
    zombie = get_closest_ai(self.origin, "axis");
    if(!isDefined(zombie) || !isDefined(zombie.zombie_move_speed)) {
      continue;
    }
    dist = 200;
    switch (zombie.zombie_move_speed) {
      case "walk":
        dist = 200;
        break;
      case "run":
        dist = 250;
        break;
      case "sprint":
        dist = 275;
        break;
    }
    if(distance2d(zombie.origin, self.origin) < dist) {
      yaw = self animscripts\zombie_utility::GetYawToSpot(zombie.origin);
      if(yaw < -95 || yaw > 95) {
        zombie playSound("behind_vocals");
      }
    }
  }
}
intro_screen() {
  flag_wait("all_players_connected");
  wait(2);
  level.intro_hud = [];
  for(i = 0; i < 3; i++) {
    level.intro_hud[i] = newHudElem();
    level.intro_hud[i].x = 0;
    level.intro_hud[i].y = 0;
    level.intro_hud[i].alignX = "left";
    level.intro_hud[i].alignY = "bottom";
    level.intro_hud[i].horzAlign = "left";
    level.intro_hud[i].vertAlign = "bottom";
    level.intro_hud[i].foreground = true;
    if(level.splitscreen && !level.hidef) {
      level.intro_hud[i].fontScale = 2.75;
    } else {
      level.intro_hud[i].fontScale = 1.75;
    }
    level.intro_hud[i].alpha = 0.0;
    level.intro_hud[i].color = (1, 1, 1);
    level.intro_hud[i].inuse = false;
  }
  level.intro_hud[0].y = -110;
  level.intro_hud[1].y = -90;
  level.intro_hud[2].y = -70;
  level.intro_hud[0] settext(&"WAW_ZOMBIE_INTRO_ASYLUM_LEVEL_BERLIN");
  level.intro_hud[1] settext(&"WAW_ZOMBIE_INTRO_ASYLUM_LEVEL_HIMMLER");
  level.intro_hud[2] settext(&"WAW_ZOMBIE_INTRO_ASYLUM_LEVEL_SEPTEMBER");
  for(i = 0; i < 3; i++) {
    level.intro_hud[i] FadeOverTime(1.5);
    level.intro_hud[i].alpha = 1;
    wait(1.5);
  }
  wait(1.5);
  for(i = 0; i < 3; i++) {
    level.intro_hud[i] FadeOverTime(1.5);
    level.intro_hud[i].alpha = 0;
    wait(1.5);
  }
  for(i = 0; i < 3; i++) {
    level.intro_hud[i] destroy();
  }
  level thread magic_box_limit_location_init();
}
play_pa_system() {
  clientnotify("switch_flipped_generator");
  speakerA = getstruct("loudspeaker", "targetname");
  playsoundatposition("alarm", speakerA.origin);
  level thread play_comp_sounds();
  generator_arc = getent("generator_arc", "targetname");
  generator_arc playLoopSound("gen_arc_loop");
  wait(4.0);
  generator = getent("generator_origin", "targetname");
  generator playLoopSound("generator_loop");
  wait(8.0);
  playsoundatposition("amb_pa_system", speakerA.origin);
}
play_comp_sounds() {
  computer = getent("comp", "targetname");
  computer playSound("comp_start");
  wait(6);
  computer playLoopSound("comp_loop");
}
init_zombie_asylum() {
  level.magic_box_uses = 1;
  flag_init("both_doors_opened");
  flag_init("electric_switch_used");
  flag_set("spawn_point_override");
  level thread init_elec_trap_trigs();
  level thread init_lights();
  water_trigs = getEntArray("waterfall", "targetname");
  array_thread(water_trigs, ::watersheet_on_trigger);
}
init_lights() {
  tinhats = [];
  arms = [];
  ents = getEntArray("elect_light_model", "targetname");
  for(i = 0; i < ents.size; i++) {
    if(issubstr(ents[i].model, "tinhat")) {
      tinhats[tinhats.size] = ents[i];
    }
    if(issubstr(ents[i].model, "indlight")) {
      arms[arms.size] = ents[i];
    }
  }
  for(i = 0; i < tinhats.size; i++) {
    wait_network_frame();
    tinhats[i] setModel("lights_tinhatlamp_off");
  }
  for(i = 0; i < arms.size; i++) {
    wait_network_frame();
    arms[i] setModel("lights_indlight");
  }
  flag_wait("electric_switch_used");
  for(i = 0; i < tinhats.size; i++) {
    wait_network_frame();
    tinhats[i] setModel("lights_tinhatlamp_on");
  }
  for(i = 0; i < arms.size; i++) {
    wait_network_frame();
    arms[i] setModel("lights_indlight_on");
  }
}
init_sounds() {
  maps\_zombiemode_utility::add_sound("break_stone", "break_stone");
  maps\_zombiemode_utility::add_sound("zmb_couch_slam", "couch_slam");
  maps\_zombiemode_utility::add_sound("door_slide_open", "door_slide_open");
}
include_weapons() {
  include_weapon("python_zm");
  include_weapon("cz75_zm");
  include_weapon("g11_lps_zm");
  include_weapon("famas_zm");
  include_weapon("spectre_zm");
  include_weapon("cz75dw_zm");
  include_weapon("spas_zm");
  include_weapon("hs10_zm");
  include_weapon("aug_acog_zm");
  include_weapon("galil_zm");
  include_weapon("commando_zm");
  include_weapon("fnfal_zm");
  include_weapon("dragunov_zm");
  include_weapon("l96a1_zm");
  include_weapon("rpk_zm");
  include_weapon("hk21_zm");
  include_weapon("m72_law_zm");
  include_weapon("china_lake_zm");
  include_weapon("zombie_cymbal_monkey");
  include_weapon("ray_gun_zm");
  include_weapon("crossbow_explosive_zm");
  include_weapon("knife_ballistic_zm");
  include_weapon("zombie_kar98k", false, true);
  include_weapon("stielhandgranate", false, true);
  include_weapon("zombie_gewehr43", false, true);
  include_weapon("zombie_m1garand", false, true);
  include_weapon("zombie_thompson", false, true);
  include_weapon("zombie_shotgun", false, true);
  include_weapon("mp40_zm", false, true);
  include_weapon("zombie_bar_bipod", false, true);
  include_weapon("zombie_stg44", false, true);
  include_weapon("zombie_doublebarrel", false, true);
  include_weapon("zombie_doublebarrel_sawed", false, true);
  include_weapon("zombie_cymbal_monkey");
  include_weapon("freezegun_zm");
  include_weapon("m1911_upgraded_zm", false);
  include_weapon("mine_bouncing_betty", false, true);
  maps\_zombiemode_weapons::add_limited_weapon("m1911_zm", 0);
  maps\_zombiemode_weapons::add_limited_weapon("freezegun_zm", 1);
  maps\_zombiemode_weapons::add_limited_weapon("crossbow_explosive_zm", 1);
  maps\_zombiemode_weapons::add_limited_weapon("knife_ballistic_zm", 1);
  level._uses_retrievable_ballisitic_knives = true;
  precacheItem("explosive_bolt_zm");
  precacheItem("explosive_bolt_upgraded_zm");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_kar98k", "zombie_kar98k_upgraded", &"WAW_ZOMBIE_WEAPON_KAR98K_200", 200, "rifle");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_type99_rifle", "", &"WAW_ZOMBIE_WEAPON_TYPE99_200", 200, "rifle");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_gewehr43", "zombie_gewehr43_upgraded", &"WAW_ZOMBIE_WEAPON_GEWEHR43_600", 600, "rifle");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_m1carbine", "zombie_m1carbine_upgraded", &"WAW_ZOMBIE_WEAPON_M1CARBINE_600", 600, "rifle");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_m1garand", "zombie_m1garand_upgraded", &"WAW_ZOMBIE_WEAPON_M1GARAND_600", 600, "rifle");
  maps\_zombiemode_weapons::add_zombie_weapon("stielhandgranate", "", &"WAW_ZOMBIE_WEAPON_STIELHANDGRANATE_250", 250, "grenade", "", 250);
  maps\_zombiemode_weapons::add_zombie_weapon("mine_bouncing_betty", "", &"WAW_ZOMBIE_WEAPON_SATCHEL_2000", 2000);
  maps\_zombiemode_weapons::add_zombie_weapon("kar98k_scoped_zombie", "", &"WAW_ZOMBIE_WEAPON_KAR98K_S_750", 750, "sniper");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_stg44", "zombie_stg44_upgraded", &"WAW_ZOMBIE_WEAPON_STG44_1200", 1200, "mg");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_thompson", "zombie_thompson_upgraded", &"WAW_ZOMBIE_WEAPON_THOMPSON_1200", 1200, "mg");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_type100_smg", "zombie_type100_smg_upgraded", &"WAW_ZOMBIE_WEAPON_TYPE100_1000", 1000, "mg");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_fg42", "zombie_fg42_upgraded", &"WAW_ZOMBIE_WEAPON_FG42_1500", 1500, "mg");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_doublebarrel", "zombie_doublebarrel_upgraded", &"WAW_ZOMBIE_WEAPON_DOUBLEBARREL_1200", 1200, "shotgun");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_doublebarrel_sawed", "", &"WAW_ZOMBIE_WEAPON_DOUBLEBARREL_SAWED_1200", 1200, "shotgun");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_shotgun", "zombie_shotgun_upgraded", &"WAW_ZOMBIE_WEAPON_SHOTGUN_1500", 1500, "shotgun");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_bar", "zombie_bar_upgraded", &"WAW_ZOMBIE_WEAPON_BAR_1800", 1800, "mg");
  maps\_zombiemode_weapons::add_zombie_weapon("zombie_bar_bipod", "", &"WAW_ZOMBIE_WEAPON_BAR_BIPOD_2500", 2500, "mg");
}
include_powerups() {
  include_powerup("nuke");
  include_powerup("insta_kill");
  include_powerup("double_points");
  include_powerup("full_ammo");
  include_powerup("carpenter");
}
init_elec_trap_trigs() {
  trap_trigs = getEntArray("gas_access", "targetname");
  array_thread(trap_trigs, ::electric_trap_think);
  array_thread(trap_trigs, ::electric_trap_dialog);
}
toilet_useage() {
  toilet_counter = 0;
  toilet_trig = getent("toilet", "targetname");
  toilet_trig SetCursorHint("HINT_NOICON");
  toilet_trig UseTriggerRequireLookAt();
  players = getplayers();
  if(!isDefined(level.music_override)) {
    level.music_override = false;
  }
  while(1) {
    wait(0.5);
    toilet_trig waittill("trigger");
    toilet_trig playSound("toilet_flush", "sound_done");
    toilet_trig waittill("sound_done");
    toilet_counter++;
    if(toilet_counter == 3) {
      playsoundatposition("zmb_cha_ching", toilet_trig.origin);
      level thread play_music_easter_egg();
    }
  }
}
play_music_easter_egg(player) {
  level.music_override = true;
  level thread maps\_zombiemode_audio::change_zombie_music("egg");
  wait(245);
  level.music_override = false;
  level thread maps\_zombiemode_audio::change_zombie_music("wave_loop");
}
chair_useage() {
  wait(2);
  chair_counter = 0;
  chair_trig = getent("dentist_chair", "targetname");
  chair_trig SetCursorHint("HINT_NOICON");
  chair_trig UseTriggerRequireLookAt();
  players = getplayers();
  while(1) {
    wait(0.05);
    for(i = 0; i < players.size; i++) {
      chair_trig waittill("trigger", players);
      chair_counter++;
      if(chair_counter == 3) {
        playsoundatposition("chair", chair_trig.origin);
        chair_counter = 0;
      }
    }
  }
}
electric_trap_dialog() {
  self endon("warning_dialog");
  level endon("switch_flipped");
  timer = 0;
  while(1) {
    wait(0.5);
    players = get_players();
    for(i = 0; i < players.size; i++) {
      dist = distancesquared(players[i].origin, self.origin);
      if(dist > 70 * 70) {
        timer = 0;
        continue;
      }
      if(dist < 70 * 70 && timer < 3) {
        wait(0.5);
        timer++;
      }
      if(dist < 70 * 70 && timer == 3) {
        wait(3);
        self notify("warning_dialog");
      }
    }
  }
}
hint_string(string) {
  self SetHintString(string);
  self SetCursorHint("HINT_NOICON");
}
electric_trap_think() {
  self.is_available = undefined;
  self.zombie_cost = 1000;
  self.in_use = 0;
  self sethintstring(&"ZOMBIE_NEED_POWER");
  self SetCursorHint("HINT_NOICON");
  flag_wait("power_on");
  while(1) {
    self sethintstring(&"ZOMBIE_BUTTON_BUY_TRAP", self.zombie_cost);
    self waittill("trigger", who);
    if(who in_revive_trigger()) {
      continue;
    }
    if(!isDefined(self.is_available)) {
      continue;
    }
    if(is_player_valid(who)) {
      if(who.score >= self.zombie_cost) {
        if(!self.in_use) {
          self.in_use = 1;
          play_sound_at_pos("purchase", who.origin);
          self thread electric_trap_move_switch(self);
          self waittill("switch_activated");
          who maps\_zombiemode_score::minus_to_player_score(self.zombie_cost);
          self sethintstring(&"ZOMBIE_TRAP_ACTIVE");
          self.zombie_dmg_trig = getent(self.target, "targetname");
          self.zombie_dmg_trig trigger_on();
          self thread activate_electric_trap();
          self waittill("elec_done");
          clientnotify(self.script_string + "off");
          if(isDefined(self.fx_org)) {
            self.fx_org delete();
          }
          if(isDefined(self.zapper_fx_org)) {
            self.zapper_fx_org delete();
          }
          if(isDefined(self.zapper_fx_switch_org)) {
            self.zapper_fx_switch_org delete();
          }
          self.zombie_dmg_trig trigger_off();
          self sethintstring(&"ZOMBIE_TRAP_COOLDOWN");
          wait(25);
          speakerA = getstruct("loudspeaker", "targetname");
          playsoundatposition("warning", speakera.origin);
          self notify("available");
          self.in_use = 0;
        }
      }
    }
  }
}
electric_trap_move_switch(parent) {
  tswitch = getent(parent.script_linkto, "script_linkname");
  if(tswitch.script_linkname == "4") {
    north_zapper_light_red();
    tswitch rotatepitch(-180, .5);
    tswitch playSound("amb_sparks_l_b");
    tswitch waittill("rotatedone");
    self notify("switch_activated");
    self waittill("available");
    tswitch rotatepitch(180, .5);
    north_zapper_light_green();
  } else {
    south_zapper_light_red();
    tswitch rotatepitch(180, .5);
    tswitch playSound("amb_sparks_l_b");
    tswitch waittill("rotatedone");
    self notify("switch_activated");
    self waittill("available");
    tswitch rotatepitch(-180, .5);
    south_zapper_light_green();
  }
}
activate_electric_trap() {
  if(isDefined(self.script_string) && self.script_string == "north") {
    machine = getent("zap_machine_north", "targetname");
    machine setModel("zombie_zapper_power_box_on");
    clientnotify("north");
  } else {
    machine = getent("zap_machine_south", "targetname");
    machine setModel("zombie_zapper_power_box_on");
    clientnotify("south");
  }
  clientnotify(self.target);
  fire_points = getStructArray(self.target, "targetname");
  for(i = 0; i < fire_points.size; i++) {
    wait_network_frame();
    fire_points[i] thread electric_trap_fx(self);
  }
  self.zombie_dmg_trig thread elec_barrier_damage();
  level waittill("arc_done");
  machine setModel("zombie_zapper_power_box");
}
electric_trap_fx(notify_ent) {
  self.tag_origin = spawn("script_model", self.origin);
  if(isDefined(self.script_sound)) {
    self.tag_origin playSound("zmb_elec_start");
    self.tag_origin playLoopSound("zmb_elec_loop");
    self thread play_electrical_sound();
  }
  wait(25);
  if(isDefined(self.script_sound)) {
    self.tag_origin stoploopsound();
  }
  self.tag_origin delete();
  notify_ent notify("elec_done");
  level notify("arc_done");
}
play_electrical_sound() {
  level endon("arc_done");
  while(1) {
    wait(randomfloatrange(0.1, 0.5));
    playsoundatposition("zmb_elec_arc", self.origin);
  }
}
elec_barrier_damage() {
  while(1) {
    self waittill("trigger", ent);
    if(isPlayer(ent)) {
      ent thread player_elec_damage();
    } else {
      if(!isDefined(ent.marked_for_death)) {
        ent.marked_for_death = true;
        ent thread zombie_elec_death(randomint(100));
      }
    }
  }
}
play_elec_vocals() {
  if(isDefined(self)) {
    org = self.origin;
    wait(0.15);
    playsoundatposition("zmb_elec_vocals", org);
    playsoundatposition("zmb_zombie_arc", org);
    playsoundatposition("zmb_exp_jib_zombie", org);
  }
}
player_elec_damage() {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(level.elec_loop)) {
    level.elec_loop = 0;
  }
  if(!isDefined(self.is_burning) && !self maps\_laststand::player_is_in_laststand()) {
    self.is_burning = 1;
    self setelectrified(1.25);
    shocktime = 2.5;
    self shellshock("electrocution", shocktime);
    if(level.elec_loop == 0) {
      elec_loop = 1;
      self playSound("zmb_zombie_arc");
    }
    if(!self hasperk("specialty_armorvest") || self.health - 100 < 1) {
      radiusdamage(self.origin, 10, self.health + 100, self.health + 100);
      self.is_burning = undefined;
    } else {
      self dodamage(50, self.origin);
      wait(.1);
      self.is_burning = undefined;
    }
  }
}
zombie_elec_death(flame_chance) {
  self endon("death");
  if(flame_chance > 90 && level.burning_zombies.size < 6) {
    level.burning_zombies[level.burning_zombies.size] = self;
    self thread zombie_flame_watch();
    self playSound("zmb_ignite");
    self thread animscripts\zombie_death::flame_death_fx();
    wait(randomfloat(1.25));
  } else {
    refs[0] = "guts";
    refs[1] = "right_arm";
    refs[2] = "left_arm";
    refs[3] = "right_leg";
    refs[4] = "left_leg";
    refs[5] = "no_legs";
    refs[6] = "head";
    self.a.gib_ref = refs[randomint(refs.size)];
    playsoundatposition("zmb_zombie_arc", self.origin);
    if(randomint(100) > 40) {
      self thread electroctute_death_fx();
      self thread play_elec_vocals();
    }
    wait(randomfloat(1.25));
    self playSound("zmb_zombie_arc");
  }
  self dodamage(self.health + 666, self.origin);
}
zombie_flame_watch() {
  self waittill("death");
  self stoploopsound();
  level.burning_zombies = array_remove_nokeys(level.burning_zombies, self);
}
spawn_point_override() {
  flag_wait("all_players_connected");
  players = get_players();
  north_structs = getStructArray("north_spawn", "script_noteworthy");
  south_structs = getStructArray("south_spawn", "script_noteworthy");
  side1 = north_structs;
  side2 = south_structs;
  if(randomint(100) > 50) {
    side1 = south_structs;
    side2 = north_structs;
  }
  for(i = 0; i < players.size; i++) {
    if(i < 2) {
      players[i] setorigin(side1[i].origin);
      players[i] setplayerangles(side1[i].angles);
      players[i].respawn_point = side1[i];
      players[i].spawn_side = side1[i].script_noteworthy;
      players[i].spectator_respawn = side1[i];
    } else {
      players[i] setorigin(side2[i].origin);
      players[i] setplayerangles(side2[i].angles);
      players[i].respawn_point = side2[i];
      players[i].spawn_side = side2[i].script_noteworthy;
      players[i].spectator_respawn = side2[i];
    }
  }
}
disable_bump_trigger(triggername) {
  triggers = getEntArray("audio_bump_trigger", "targetname");
  if(isDefined(triggers)) {
    for(i = 0; i < triggers.size; i++) {
      if(isDefined(triggers[i].script_label) && triggers[i].script_label == triggername) {
        triggers[i].script_activated = 0;
      }
    }
  }
}
master_electric_switch() {
  trig = getent("use_master_switch", "targetname");
  master_switch = getent("master_switch", "targetname");
  master_switch notsolid();
  trig sethintstring(&"WAW_ZOMBIE_ELECTRIC_SWITCH");
  trig SetCursorHint("HINT_NOICON");
  fx_org = spawn("script_model", (-674.922, -300.473, 284.125));
  fx_org setModel("tag_origin");
  fx_org.angles = (0, 90, 0);
  playFXOnTag(level._effect["electric_power_gen_idle"], fx_org, "tag_origin");
  cheat = false;
  if(cheat != true) {
    trig waittill("trigger", user);
  }
  master_switch rotateroll(-90, .3);
  master_switch playSound("zmb_switch_flip");
  flag_set("power_on");
  clientnotify("ZPO");
  level notify("switch_flipped");
  disable_bump_trigger("switch_door_trig");
  level thread play_the_numbers();
  left_org = getent("audio_swtch_left", "targetname");
  right_org = getent("audio_swtch_right", "targetname");
  left_org_b = getent("audio_swtch_b_left", "targetname");
  right_org_b = getent("audio_swtch_b_right", "targetname");
  if(isDefined(left_org)) {
    left_org playSound("amb_sparks_l");
  }
  if(isDefined(left_org_b)) {
    left_org playSound("amb_sparks_l_b");
  }
  if(isDefined(right_org)) {
    right_org playSound("amb_sparks_r");
  }
  if(isDefined(right_org_b)) {
    right_org playSound("amb_sparks_r_b");
  }
  SetClientSysState("levelNotify", "start_lights");
  level thread play_pa_system();
  flag_set("electric_switch_used");
  trig delete();
  traps = getEntArray("gas_access", "targetname");
  for(i = 0; i < traps.size; i++) {
    traps[i] sethintstring(&"WAW_ZOMBIE_BUTTON_NORTH_FLAMES");
    traps[i] SetCursorHint("HINT_NOICON");
    traps[i].is_available = true;
  }
  master_switch waittill("rotatedone");
  playFX(level._effect["switch_sparks"], getstruct("switch_fx", "targetname").origin);
  level notify("master_switch_activated");
  fx_org delete();
  fx_org = spawn("script_model", (-675.021, -300.906, 283.724));
  fx_org setModel("tag_origin");
  fx_org.angles = (0, 90, 0);
  playFXOnTag(level._effect["electric_power_gen_on"], fx_org, "tag_origin");
  fx_org playLoopSound("zmb_elec_current_loop");
  level thread north_zapper_light_green();
  level thread south_zapper_light_green();
  wait(6);
  fx_org stoploopsound();
  level notify("sleight_on");
  level notify("revive_on");
  level notify("doubletap_on");
  level notify("juggernog_on");
  exploder(101);
  wait(8);
  playsoundatposition("amb_sparks_l_end", left_org.origin);
  playsoundatposition("amb_sparks_r_end", right_org.origin);
}
electric_trap_wire_sparks(side) {
  self endon("elec_done");
  while(1) {
    sparks = getstruct("trap_wire_sparks_" + side, "targetname");
    self.fx_org = spawn("script_model", sparks.origin);
    self.fx_org setModel("tag_origin");
    self.fx_org.angles = sparks.angles;
    playFXOnTag(level._effect["electric_current"], self.fx_org, "tag_origin");
    targ = getstruct(sparks.target, "targetname");
    while(isDefined(targ)) {
      self.fx_org moveto(targ.origin, .15);
      self.fx_org playLoopSound("zmb_elec_current_loop", .1);
      self.fx_org waittill("movedone");
      self.fx_org stoploopsound(.1);
      if(isDefined(targ.target)) {
        targ = getstruct(targ.target, "targetname");
      } else {
        targ = undefined;
      }
    }
    playFXOnTag(level._effect["electric_short_oneshot"], self.fx_org, "tag_origin");
    wait(randomintrange(3, 9));
    self.fx_org delete();
  }
}
electric_current_open_middle_door() {
  sparks = getstruct("electric_middle_door", "targetname");
  fx_org = spawn("script_model", sparks.origin);
  fx_org setModel("tag_origin");
  fx_org.angles = sparks.angles;
  playFXOnTag(level._effect["electric_current"], fx_org, "tag_origin");
  targ = getstruct(sparks.target, "targetname");
  while(isDefined(targ)) {
    fx_org moveto(targ.origin, .075);
    if(isDefined(targ.script_noteworthy) && (targ.script_noteworthy == "junction_boxs" || targ.script_noteworthy == "electric_end")) {
      playFXOnTag(level._effect["electric_short_oneshot"], fx_org, "tag_origin");
    }
    fx_org playLoopSound("zmb_elec_current_loop", .1);
    fx_org waittill("movedone");
    fx_org stoploopsound(.1);
    if(isDefined(targ.target)) {
      targ = getstruct(targ.target, "targetname");
    } else {
      targ = undefined;
    }
  }
  level notify("electric_on_middle_door");
  playFXOnTag(level._effect["electric_short_oneshot"], fx_org, "tag_origin");
  wait(randomintrange(3, 9));
  fx_org delete();
}
electric_current_revive_machine() {
  sparks = getstruct("revive_electric_wire", "targetname");
  fx_org = spawn("script_model", sparks.origin);
  fx_org setModel("tag_origin");
  fx_org.angles = sparks.angles;
  playFXOnTag(level._effect["electric_current"], fx_org, "tag_origin");
  targ = getstruct(sparks.target, "targetname");
  wait(0.2);
  while(isDefined(targ)) {
    fx_org moveto(targ.origin, .075);
    if(isDefined(targ.script_noteworthy) && targ.script_noteworthy == "junction_revive") {
      playFXOnTag(level._effect["electric_short_oneshot"], fx_org, "tag_origin");
    }
    fx_org playLoopSound("zmb_elec_current_loop", .1);
    fx_org waittill("movedone");
    fx_org stoploopsound(.1);
    if(isDefined(targ.target)) {
      targ = getstruct(targ.target, "targetname");
    } else {
      targ = undefined;
    }
  }
  level notify("revive_on");
  playFXOnTag(level._effect["electric_short_oneshot"], fx_org, "tag_origin");
  wait(randomintrange(3, 9));
  fx_org delete();
}
electric_current_reload_machine() {
  sparks = getstruct("electric_fast_reload", "targetname");
  fx_org = spawn("script_model", sparks.origin);
  fx_org setModel("tag_origin");
  fx_org.angles = sparks.angles;
  playFXOnTag(level._effect["electric_current"], fx_org, "tag_origin");
  targ = getstruct(sparks.target, "targetname");
  while(isDefined(targ)) {
    fx_org moveto(targ.origin, .075);
    if(isDefined(targ.script_noteworthy) && targ.script_noteworthy == "reload_junction") {
      playFXOnTag(level._effect["electric_short_oneshot"], fx_org, "tag_origin");
    }
    fx_org playLoopSound("zmb_elec_current_loop", .1);
    fx_org waittill("movedone");
    fx_org stoploopsound(.1);
    if(isDefined(targ.target)) {
      targ = getstruct(targ.target, "targetname");
    } else {
      targ = undefined;
    }
  }
  level notify("sleight_on");
  playFXOnTag(level._effect["electric_short_oneshot"], fx_org, "tag_origin");
  wait(randomintrange(3, 9));
  fx_org delete();
}
electric_current_doubletap_machine() {
  sparks = getstruct("electric_double_tap", "targetname");
  fx_org = spawn("script_model", sparks.origin);
  fx_org setModel("tag_origin");
  fx_org.angles = sparks.angles;
  playFXOnTag(level._effect["electric_current"], fx_org, "tag_origin");
  targ = getstruct(sparks.target, "targetname");
  while(isDefined(targ)) {
    fx_org moveto(targ.origin, .075);
    if(isDefined(targ.script_noteworthy) && targ.script_noteworthy == "double_tap_junction") {
      playFXOnTag(level._effect["electric_short_oneshot"], fx_org, "tag_origin");
    }
    fx_org playLoopSound("zmb_elec_current_loop", .1);
    fx_org waittill("movedone");
    fx_org stoploopsound(.1);
    if(isDefined(targ.target)) {
      targ = getstruct(targ.target, "targetname");
    } else {
      targ = undefined;
    }
  }
  level notify("doubletap_on");
  playFXOnTag(level._effect["electric_short_oneshot"], fx_org, "tag_origin");
  wait(randomintrange(3, 9));
  fx_org delete();
}
electric_current_juggernog_machine() {
  sparks = getstruct("electric_juggernog", "targetname");
  fx_org = spawn("script_model", sparks.origin);
  fx_org setModel("tag_origin");
  fx_org.angles = sparks.angles;
  playFXOnTag(level._effect["electric_current"], fx_org, "tag_origin");
  targ = getstruct(sparks.target, "targetname");
  while(isDefined(targ)) {
    fx_org moveto(targ.origin, .075);
    fx_org playLoopSound("zmb_elec_current_loop", .1);
    fx_org waittill("movedone");
    fx_org stoploopsound(.1);
    if(isDefined(targ.target)) {
      targ = getstruct(targ.target, "targetname");
    } else {
      targ = undefined;
    }
  }
  level notify("juggernog_on");
  playFXOnTag(level._effect["electric_short_oneshot"], fx_org, "tag_origin");
  wait(randomintrange(3, 9));
  fx_org delete();
}
north_zapper_light_red() {
  zapper_lights = getEntArray("zapper_light_north", "targetname");
  for(i = 0; i < zapper_lights.size; i++) {
    zapper_lights[i] setModel("zombie_zapper_cagelight_red");
  }
  if(isDefined(level.north_light)) {
    level.north_light delete();
  }
  level.north_light = spawn("script_model", (366, 476, 329));
  level.north_light setModel("tag_origin");
  level.north_light.angles = (0, 270, 0);
  playFXOnTag(level._effect["zapper_light_notready"], level.north_light, "tag_origin");
}
north_zapper_light_green() {
  zapper_lights = getEntArray("zapper_light_north", "targetname");
  for(i = 0; i < zapper_lights.size; i++) {
    zapper_lights[i] setModel("zombie_zapper_cagelight_green");
  }
  if(isDefined(level.north_light)) {
    level.north_light delete();
  }
  level.north_light = spawn("script_model", (366, 476, 329));
  level.north_light setModel("tag_origin");
  level.north_light.angles = (0, 270, 0);
  playFXOnTag(level._effect["zapper_light_ready"], level.north_light, "tag_origin");
}
south_zapper_light_red() {
  zapper_lights = getEntArray("zapper_light_south", "targetname");
  for(i = 0; i < zapper_lights.size; i++) {
    zapper_lights[i] setModel("zombie_zapper_cagelight_red");
  }
  if(isDefined(level.south_light)) {
    level.south_light delete();
  }
  level.south_light = spawn("script_model", (168, -404, 330));
  level.south_light setModel("tag_origin");
  level.south_light.angles = (0, 90, 0);
  playFXOnTag(level._effect["zapper_light_notready"], level.south_light, "tag_origin");
}
south_zapper_light_green() {
  zapper_lights = getEntArray("zapper_light_south", "targetname");
  for(i = 0; i < zapper_lights.size; i++) {
    zapper_lights[i] setModel("zombie_zapper_cagelight_green");
  }
  if(isDefined(level.south_light)) {
    level.south_light delete();
  }
  level.south_light = spawn("script_model", (168, -404, 330));
  level.south_light setModel("tag_origin");
  level.south_light.angles = (0, 270, 0);
  playFXOnTag(level._effect["zapper_light_ready"], level.south_light, "tag_origin");
}
electroctute_death_fx() {
  self endon("death");
  if(isDefined(self.is_electrocuted) && self.is_electrocuted) {
    return;
  }
  self.is_electrocuted = true;
  self thread electrocute_timeout();
  if(self.team == "axis") {
    level.bcOnFireTime = gettime();
    level.bcOnFireOrg = self.origin;
  }
  playFXOnTag(level._effect["elec_torso"], self, "J_SpineLower");
  self playSound("zmb_elec_jib_zombie");
  wait 1;
  tagArray = [];
  tagArray[0] = "J_Elbow_LE";
  tagArray[1] = "J_Elbow_RI";
  tagArray[2] = "J_Knee_RI";
  tagArray[3] = "J_Knee_LE";
  tagArray = array_randomize(tagArray);
  playFXOnTag(level._effect["elec_md"], self, tagArray[0]);
  self playSound("zmb_elec_jib_zombie");
  wait 1;
  self playSound("zmb_elec_jib_zombie");
  tagArray[0] = "J_Wrist_RI";
  tagArray[1] = "J_Wrist_LE";
  if(!isDefined(self.a.gib_ref) || self.a.gib_ref != "no_legs") {
    tagArray[2] = "J_Ankle_RI";
    tagArray[3] = "J_Ankle_LE";
  }
  tagArray = array_randomize(tagArray);
  playFXOnTag(level._effect["elec_sm"], self, tagArray[0]);
  playFXOnTag(level._effect["elec_sm"], self, tagArray[1]);
}
electrocute_timeout() {
  self endon("death");
  self playLoopSound("amb_fire_manager_0");
  wait 12;
  self stoploopsound();
  if(isDefined(self) && isalive(self)) {
    self.is_electrocuted = false;
    self notify("stop_flame_damage");
  }
}
play_the_numbers() {
  while(1) {
    wait(randomintrange(15, 20));
    playsoundatposition("the_numbers", (-608, -336, 304));
    wait(randomintrange(15, 20));
  }
}
magic_box_limit_location_init() {
  level.open_chest_location = [];
  level.open_chest_location[0] = undefined;
  level.open_chest_location[1] = undefined;
  level.open_chest_location[2] = undefined;
  level.open_chest_location[3] = "opened_chest";
  level.open_chest_location[4] = "start_chest";
  level thread waitfor_flag_open_chest_location("magic_box_south");
  level thread waitfor_flag_open_chest_location("south_access_1");
  level thread waitfor_flag_open_chest_location("north_door1");
  level thread waitfor_flag_open_chest_location("north_upstairs_blocker");
  level thread waitfor_flag_open_chest_location("south_upstairs_blocker");
}
waitfor_flag_open_chest_location(which) {
  wait(3);
  switch (which) {
    case "magic_box_south":
      flag_wait("magic_box_south");
      level.open_chest_location[0] = "magic_box_south";
      break;
    case "south_access_1":
      flag_wait("south_access_1");
      level.open_chest_location[0] = "magic_box_south";
      level.open_chest_location[1] = "magic_box_bathroom";
      break;
    case "north_door1":
      flag_wait("north_door1");
      level.open_chest_location[2] = "magic_box_hallway";
      break;
    case "north_upstairs_blocker":
      flag_wait("north_upstairs_blocker");
      level.open_chest_location[2] = "magic_box_hallway";
      break;
    case "south_upstairs_blocker":
      flag_wait("south_upstairs_blocker");
      level.open_chest_location[1] = "magic_box_bathroom";
      break;
    default:
      return;
  }
}
magic_box_light() {
  open_light = getent("opened_chest_light", "script_noteworthy");
  hallway_light = getent("magic_box_hallway_light", "script_noteworthy");
  open_light_model = getent("opened_chest_model", "script_noteworthy");
  hallway_light_model = getent("magic_box_hallway_model", "script_noteworthy");
  while(true) {
    level waittill("magic_box_light_switch");
    open_light setLightIntensity(0);
    hallway_light setLightIntensity(0);
    open_light_model setModel("lights_tinhatlamp_off");
    hallway_light_model setModel("lights_tinhatlamp_off");
    if(level.chests[level.chest_index].script_noteworthy == "opened_chest") {
      open_light setLightIntensity(1);
      open_light_model setModel("lights_tinhatlamp_on");
    } else if(level.chests[level.chest_index].script_noteworthy == "magic_box_hallway") {
      hallway_light setLightIntensity(1);
      hallway_light_model setModel("lights_tinhatlamp_on");
    }
  }
}
watersheet_on_trigger() {
  while(1) {
    self waittill("trigger", who);
    if(isDefined(who) && isPlayer(who) && isAlive(who) && who.sessionstate != "spectator") {
      if(!who maps\_laststand::player_is_in_laststand()) {
        who setwatersheeting(true, 3);
        wait(0.1);
      }
    }
  }
}
setup_custom_vox() {
  level.plr_vox["level"]["power"] = "power";
}
asylum_exit_level() {
  zombies = GetAiArray("axis");
  for(i = 0; i < zombies.size; i++) {
    zombies[i] thread asylum_find_exit_point();
  }
}
asylum_find_exit_point() {
  self endon("death");
  player = getplayers()[0];
  dist_zombie = 0;
  dist_player = 0;
  dest = 0;
  away = VectorNormalize(self.origin - player.origin);
  endPos = self.origin + vector_scale(away, 600);
  locs = array_randomize(level.enemy_dog_locations);
  for(i = 0; i < locs.size; i++) {
    dist_zombie = DistanceSquared(locs[i].origin, endPos);
    dist_player = DistanceSquared(locs[i].origin, player.origin);
    if(dist_zombie < dist_player) {
      dest = i;
      break;
    }
  }
  self notify("stop_find_flesh");
  self notify("zombie_acquire_enemy");
  self setgoalpos(locs[dest].origin);
  while(1) {
    if(!flag("wait_and_revive")) {
      break;
    }
    wait_network_frame();
  }
  self thread maps\_zombiemode_spawner::find_flesh();
}
mature_settings_changes() {
  if(!is_mature()) {
    master_switch = getent("master_switch", "targetname");
    if(isDefined(master_switch)) {
      master_switch setModel("zombie_power_lever_handle");
    }
    asylum_chair_mature = GetEnt("asylum_chair_mature", "targetname");
    if(isDefined(asylum_chair_mature)) {
      asylum_chair_mature setModel("zombie_asylum_chair_nogore");
    }
  }
}