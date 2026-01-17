/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_asylum.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\behavior_zombie_dog;
#using scripts\shared\ai\zombie;
#using scripts\shared\ai\zombie_death;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_audio_zhd;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_magicbox;
#using scripts\zm\_zm_net;
#using scripts\zm\_zm_perk_additionalprimaryweapon;
#using scripts\zm\_zm_perk_deadshot;
#using scripts\zm\_zm_perk_doubletap2;
#using scripts\zm\_zm_perk_juggernaut;
#using scripts\zm\_zm_perk_quick_revive;
#using scripts\zm\_zm_perk_random;
#using scripts\zm\_zm_perk_sleight_of_hand;
#using scripts\zm\_zm_perk_staminup;
#using scripts\zm\_zm_perk_widows_wine;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_power;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;
#using scripts\zm\_zm_powerup_weapon_minigun;
#using scripts\zm\_zm_radio;
#using scripts\zm\_zm_score;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_trap_electric;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_annihilator;
#using scripts\zm\_zm_weap_bouncingbetty;
#using scripts\zm\_zm_weap_bowie;
#using scripts\zm\_zm_weap_cymbal_monkey;
#using scripts\zm\_zm_weap_tesla;
#using scripts\zm\_zm_weapons;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\bgbs\_zm_bgb_anywhere_but_here;
#using scripts\zm\zm_asylum_achievements;
#using scripts\zm\zm_asylum_ffotd;
#using scripts\zm\zm_asylum_fx;
#using scripts\zm\zm_asylum_zombie;
#using scripts\zm\zm_zmhd_cleanup_mgr;
#namespace zm_asylum;

function autoexec function_d9af860b() {
  level.aat_in_use = 1;
  level.bgb_in_use = 1;
  level.zbarrier_override = &function_aeabaa98;
  level.zbarrier_override_tear_in = &function_ee422b5c;
}

function main() {
  zm_asylum_ffotd::main_start();
  setclearanceceiling(17);
  level.sndzhdaudio = 1;
  level.default_game_mode = "zclassic";
  level.default_start_location = "default";
  zm_asylum_fx::main();
  init_clientfields();
  visionset_mgr::register_info("visionset", "zm_showerhead", 21000, 100, 31, 1, &visionset_mgr::ramp_in_out_thread_per_player, 0);
  visionset_mgr::register_info("overlay", "zm_showerhead_postfx", 21000, 500, 32, 1);
  visionset_mgr::register_info("overlay", "zm_waterfall_postfx", 21000, 501, 32, 1);
  level._uses_sticky_grenades = 1;
  zm::init_fx();
  level._uses_retrievable_ballisitic_knives = 1;
  level.register_offhand_weapons_for_level_defaults_override = &offhand_weapon_overrride;
  level._zmbvoxlevelspecific = &init_level_specific_audio;
  level.customspawnlogic = &function_91b06047;
  level._round_start_func = &zm::round_start;
  level.givecustomcharacters = &givecustomcharacters;
  initcharacterstartindex();
  level._zombie_custom_add_weapons = &custom_add_weapons;
  level.customrandomweaponweights = &function_659c2324;
  level.var_12d3a848 = 0;
  level.customhudreveal = &customhudreveal;
  include_perks_in_random_rotation();
  level flag::init("intro_finished");
  load::main();
  level.default_laststandpistol = getweapon("pistol_m1911");
  level.default_solo_laststandpistol = getweapon("pistol_m1911_upgraded");
  level.laststandpistol = level.default_laststandpistol;
  level.start_weapon = level.default_laststandpistol;
  level thread zm::last_stand_pistol_rank_init();
  _zm_weap_cymbal_monkey::init();
  _zm_weap_tesla::init();
  level thread function_54bf648f();
  level.zone_manager_init_func = &asylum_zone_init;
  init_zones[0] = "west_downstairs_zone";
  init_zones[1] = "west2_downstairs_zone";
  level thread zm_zonemgr::manage_zones(init_zones);
  level.zombie_ai_limit = 24;
  level.burning_zombies = [];
  init_zombie_asylum();
  init_sounds();
  level thread setupmusic();
  level thread intro_screen();
  level thread chair_useage();
  level thread function_a67a7819();
  level flag::wait_till("start_zombie_round_logic");
  level thread function_bb75f24a();
  level thread master_electric_switch();
  function_a552cd4a();
  level.var_9aaae7ae = &function_869d6f66;
  level thread zm_perks::spare_change();
  zm_asylum_ffotd::main_end();
}

function init_clientfields() {
  clientfield::register("world", "asylum_trap_fx_north", 21000, 1, "int");
  clientfield::register("world", "asylum_trap_fx_south", 21000, 1, "int");
  clientfield::register("world", "asylum_generator_state", 21000, 1, "int");
  clientfield::register("clientuimodel", "player_lives", 21000, 2, "int");
}

function customhudreveal() {
  self endon("disconnect");
  self endon("death");
  level flag::wait_till("intro_finished");
  self zm::showhudandplaypromo();
}

function function_869d6f66() {
  if(!isDefined(self zm_bgb_anywhere_but_here::function_728dfe3())) {
    return false;
  }
  return true;
}

function init_sounds() {
  zm_utility::add_sound("break_stone", "break_stone");
  zm_utility::add_sound("zmb_couch_slam", "couch_slam");
  zm_utility::add_sound("door_slide_open", "door_slide_open");
  zm_utility::add_sound("zmb_heavy_door_open", "zmb_heavy_door_open");
  level thread custom_add_vox();
}

function setupmusic() {
  zm_audio::musicstate_create("round_start", 3, "round_start_asylum_1");
  zm_audio::musicstate_create("round_start_short", 3, "round_start_asylum_1");
  zm_audio::musicstate_create("round_start_first", 3, "round_start_asylum_1");
  zm_audio::musicstate_create("round_end", 3, "round_end_asylum_1");
  zm_audio::musicstate_create("lullaby_for_a_dead_man", 4, "lullaby_for_a_dead_man");
  zm_audio::musicstate_create("game_over", 5, "game_over_zhd_asylum");
  zm_audio::musicstate_create("none", 4, "none");
  zm_audio::musicstate_create("sam", 4, "sam");
}

function initcharacterstartindex() {
  level.characterstartindex = randomint(4);
}

function selectcharacterindextouse() {
  if(level.characterstartindex >= 4) {
    level.characterstartindex = 0;
  }
  self.characterindex = level.characterstartindex;
  level.characterstartindex++;
  return self.characterindex;
}

function givecustomcharacters() {
  if(isDefined(level.hotjoin_player_setup) && [[level.hotjoin_player_setup]]("c_zom_farmgirl_viewhands")) {
    return;
  }
  self detachall();
  if(!isDefined(self.characterindex)) {
    self.characterindex = assign_lowest_unused_character_index();
  }
  self.favorite_wall_weapons_list = [];
  self.talks_in_danger = 0;
  if(getdvarstring("") != "") {
    self.characterindex = getdvarint("");
  }
  self setcharacterbodytype(self.characterindex);
  self setcharacterbodystyle(0);
  self setcharacterhelmetstyle(0);
  switch (self.characterindex) {
    case 0: {
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("frag_grenade");
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("bouncingbetty");
      break;
    }
    case 1: {
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("870mcs");
      break;
    }
    case 2: {
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("hk416");
      break;
    }
    case 3: {
      self.talks_in_danger = 1;
      level.rich_sq_player = self;
      level.sndradioa = self;
      self.favorite_wall_weapons_list[self.favorite_wall_weapons_list.size] = getweapon("pistol_standard");
      break;
    }
  }
  level.vox zm_audio::zmbvoxinitspeaker("player", "vox_plr_", self);
  self setmovespeedscale(1);
  self setsprintduration(4);
  self setsprintcooldown(0);
}

function assign_lowest_unused_character_index() {
  charindexarray = [];
  charindexarray[0] = 0;
  charindexarray[1] = 1;
  charindexarray[2] = 2;
  charindexarray[3] = 3;
  if(level.players.size == 1) {
    charindexarray = array::randomize(charindexarray);
    return charindexarray[0];
  }
  foreach(player in level.players) {
    if(isDefined(player.characterindex)) {
      arrayremovevalue(charindexarray, player.characterindex, 0);
    }
  }
  if(charindexarray.size > 0) {
    return charindexarray[0];
  }
  return 0;
}

function offhand_weapon_overrride() {
  zm_utility::register_lethal_grenade_for_level("frag_grenade");
  level.zombie_lethal_grenade_player_init = getweapon("frag_grenade");
  zm_utility::register_tactical_grenade_for_level("cymbal_monkey");
  zm_utility::register_tactical_grenade_for_level("cymbal_monkey_upgraded");
  zm_utility::register_melee_weapon_for_level(level.weaponbasemelee.name);
  level.zombie_melee_weapon_player_init = level.weaponbasemelee;
  level.zombie_equipment_player_init = undefined;
}

function asylum_zone_init() {
  zm_zonemgr::add_adjacent_zone("west_downstairs_zone", "west2_downstairs_zone", "power_on");
  zm_zonemgr::add_adjacent_zone("west2_downstairs_zone", "north_downstairs_zone", "north_door1");
  zm_zonemgr::add_adjacent_zone("north_downstairs_zone", "north_upstairs_zone", "north_upstairs_blocker");
  zm_zonemgr::add_adjacent_zone("north_upstairs_zone", "north2_upstairs_zone", "upstairs_north_door1");
  zm_zonemgr::add_adjacent_zone("north2_upstairs_zone", "kitchen_upstairs_zone", "upstairs_north_door2");
  zm_zonemgr::add_adjacent_zone("kitchen_upstairs_zone", "power_upstairs_zone", "magic_box_north");
  zm_zonemgr::add_adjacent_zone("west_downstairs_zone", "south_upstairs_zone", "south_upstairs_blocker");
  zm_zonemgr::add_adjacent_zone("south_upstairs_zone", "south2_upstairs_zone", "south_access_1");
  zm_zonemgr::add_adjacent_zone("south2_upstairs_zone", "power_upstairs_zone", "magic_box_south");
}

function function_54bf648f() {
  level.use_multiple_spawns = 1;
  level.spawner_int = 1;
  level.fn_custom_zombie_spawner_selection = &function_54da140a;
}

function function_54da140a() {
  var_6af221a2 = [];
  a_s_spots = array::randomize(level.zm_loc_types["zombie_location"]);
  for(i = 0; i < a_s_spots.size; i++) {
    if(!isDefined(a_s_spots[i].script_int)) {
      var_343b1937 = 1;
    } else {
      var_343b1937 = a_s_spots[i].script_int;
    }
    var_c15b2128 = [];
    foreach(sp_zombie in level.zombie_spawners) {
      if(sp_zombie.script_int == var_343b1937) {
        if(!isDefined(var_c15b2128)) {
          var_c15b2128 = [];
        } else if(!isarray(var_c15b2128)) {
          var_c15b2128 = array(var_c15b2128);
        }
        var_c15b2128[var_c15b2128.size] = sp_zombie;
      }
    }
    if(var_c15b2128.size) {
      sp_zombie = array::random(var_c15b2128);
      return sp_zombie;
    }
  }
  assert(isDefined(sp_zombie), "" + var_343b1937);
}

function custom_add_weapons() {
  zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_asylum_weapons.csv", 1);
}

function custom_add_vox() {
  zm_audio::loadplayervoicecategories("gamedata/audio/zm/zm_theater_vox.csv");
}

function intro_screen() {
  level flag::wait_till("start_zombie_round_logic");
  wait(2);
  level.intro_hud = [];
  for(i = 0; i < 3; i++) {
    level.intro_hud[i] = newhudelem();
    level.intro_hud[i].x = 0;
    level.intro_hud[i].y = 0;
    level.intro_hud[i].alignx = "left";
    level.intro_hud[i].aligny = "bottom";
    level.intro_hud[i].horzalign = "left";
    level.intro_hud[i].vertalign = "bottom";
    level.intro_hud[i].foreground = 1;
    if(level.splitscreen && !level.hidef) {
      level.intro_hud[i].fontscale = 2.75;
    } else {
      level.intro_hud[i].fontscale = 1.75;
    }
    level.intro_hud[i].alpha = 0;
    level.intro_hud[i].color = (1, 1, 1);
    level.intro_hud[i].inuse = 0;
  }
  level.intro_hud[0].y = -110;
  level.intro_hud[1].y = -90;
  level.intro_hud[2].y = -70;
  level.intro_hud[0] settext(&"ZM_ASYLUM_INTRO_ASYLUM_LEVEL_BERLIN");
  level.intro_hud[1] settext(&"ZM_ASYLUM_INTRO_ASYLUM_LEVEL_HIMMLER");
  level.intro_hud[2] settext(&"ZM_ASYLUM_INTRO_ASYLUM_LEVEL_SEPTEMBER");
  for(i = 0; i < 3; i++) {
    level.intro_hud[i] fadeovertime(1.5);
    level.intro_hud[i].alpha = 1;
    wait(1.5);
  }
  wait(1.5);
  for(i = 0; i < 3; i++) {
    level.intro_hud[i] fadeovertime(1.5);
    level.intro_hud[i].alpha = 0;
    wait(1.5);
  }
  for(i = 0; i < 3; i++) {
    level.intro_hud[i] destroy();
  }
  level flag::set("intro_finished");
  level thread magic_box_limit_location_init();
}

function init_zombie_asylum() {
  level flag::init("electric_switch_used");
  level flag::set("spawn_point_override");
  level thread init_lights();
  water_trigs = getEntArray("waterfall", "targetname");
  array::thread_all(water_trigs, &watersheet_on_trigger);
}

function chair_useage() {
  wait(2);
  chair_trig = getent("dentist_chair", "targetname");
  if(isDefined(chair_trig)) {
    chair_trig setcursorhint("HINT_NOICON");
    chair_trig usetriggerrequirelookat();
    players = getplayers();
    while(true) {
      chair_trig waittill("trigger", players);
      playsoundatposition("evt_chair", chair_trig.origin);
      wait(3);
    }
  }
}

function function_a67a7819() {
  var_769dd606 = struct::get("snd_flusher", "targetname");
  if(!isDefined(var_769dd606)) {
    return;
  }
  var_769dd606 zm_unitrigger::create_unitrigger(undefined, undefined, &function_f8772aa4);
  var_7d2efc67 = 0;
  while(var_7d2efc67 < 3) {
    var_769dd606 waittill("trigger_activated");
    if(isDefined(level.musicsystem.currentplaytype) && level.musicsystem.currentplaytype >= 4 || (isDefined(level.musicsystemoverride) && level.musicsystemoverride)) {
      continue;
    } else {
      var_7d2efc67++;
      playsoundatposition("evt_toilet_flush", var_769dd606.origin);
      wait(3.8);
    }
  }
  zm_unitrigger::unregister_unitrigger(var_769dd606.s_unitrigger);
  playsoundatposition("zmb_cha_ching", var_769dd606.origin);
  level thread zm_audio::sndmusicsystem_playstate("lullaby_for_a_dead_man");
}

function function_f8772aa4(player) {
  if(!isDefined(level.var_a3dcfd4f)) {
    return true;
  }
  if(level.var_a3dcfd4f >= 2) {
    return false;
  }
  return true;
}

function init_lights() {
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
    util::wait_network_frame();
    tinhats[i] setModel("lights_tinhatlamp_off");
  }
  for(i = 0; i < arms.size; i++) {
    util::wait_network_frame();
    arms[i] setModel("lights_indlight");
  }
  level flag::wait_till("electric_switch_used");
  for(i = 0; i < tinhats.size; i++) {
    util::wait_network_frame();
    tinhats[i] setModel("lights_tinhatlamp_on");
  }
  for(i = 0; i < arms.size; i++) {
    util::wait_network_frame();
    arms[i] setModel("lights_indlight_on");
  }
}

function function_91b06047(predictedspawn) {
  if(!isDefined(level.var_df35cb81)) {
    level.var_df35cb81 = function_da4025bc();
  }
  assert(isDefined(level.var_df35cb81), "");
  spawnpoint = function_290134d5(level.var_df35cb81, self);
  self spawn(spawnpoint.origin, spawnpoint.angles, "zsurvival");
  return spawnpoint;
}

function function_290134d5(spawnpoints, player) {
  if(!isDefined(self.playernum)) {
    if(self.team == "allies") {
      self.playernum = zm_utility::get_game_var("_team1_num");
      zm_utility::set_game_var("_team1_num", self.playernum + 1);
    } else {
      self.playernum = zm_utility::get_game_var("_team2_num");
      zm_utility::set_game_var("_team2_num", self.playernum + 1);
    }
  }
  for(j = 0; j < spawnpoints.size; j++) {
    if(spawnpoints[j].en_num == self.playernum) {
      return spawnpoints[j];
    }
  }
  return spawnpoints[0];
}

function function_da4025bc() {
  var_7eacef00 = [];
  var_95bba386 = [];
  north_structs = struct::get_array("north_spawn", "script_noteworthy");
  south_structs = struct::get_array("south_spawn", "script_noteworthy");
  for(i = 0; i < 2; i++) {
    if(!isDefined(var_7eacef00)) {
      var_7eacef00 = [];
    } else if(!isarray(var_7eacef00)) {
      var_7eacef00 = array(var_7eacef00);
    }
    var_7eacef00[var_7eacef00.size] = north_structs[i];
  }
  for(j = 0; j < 2; j++) {
    if(!isDefined(var_95bba386)) {
      var_95bba386 = [];
    } else if(!isarray(var_95bba386)) {
      var_95bba386 = array(var_95bba386);
    }
    var_95bba386[var_95bba386.size] = south_structs[j];
  }
  side1 = var_7eacef00;
  side2 = var_95bba386;
  if(randomint(100) > 50) {
    side1 = var_95bba386;
    side2 = var_7eacef00;
  }
  spawnpoints = arraycombine(side1, side2, 0, 0);
  for(i = 0; i < spawnpoints.size; i++) {
    spawnpoints[i].en_num = i;
  }
  return spawnpoints;
}

function disable_bump_trigger(triggername) {
  triggers = getEntArray("audio_bump_trigger", "targetname");
  if(isDefined(triggers)) {
    for(i = 0; i < triggers.size; i++) {
      if(isDefined(triggers[i].script_label) && triggers[i].script_label == triggername) {
        triggers[i].script_activated = 0;
      }
    }
  }
}

function master_electric_switch() {
  trig = getent("use_master_switch", "targetname");
  var_cf413835 = struct::get("power_switch", "targetname");
  trig sethintstring(&"ZOMBIE_ELECTRIC_SWITCH");
  trig setcursorhint("HINT_NOICON");
  fx_org = spawn("script_model", (-674.922, -300.473, 284.125));
  fx_org setModel("tag_origin");
  fx_org.angles = vectorscale((0, 1, 0), 90);
  cheat = 0;
  if(getdvarint("") >= 3) {
    wait(5);
    cheat = 1;
  }
  level clientfield::set("asylum_generator_state", 1);
  if(cheat != 1) {
    trig waittill("trigger", user);
  }
  playsoundatposition("zmb_switch_flip", var_cf413835.origin);
  zm_power::turn_power_on_and_open_doors();
  level notify("switch_flipped");
  disable_bump_trigger("switch_door_trig");
  level thread function_463cb1c6();
  util::setclientsysstate("levelNotify", "start_lights");
  level flag::set("electric_switch_used");
  trig delete();
  traps = getEntArray("gas_access", "targetname");
  for(i = 0; i < traps.size; i++) {
    traps[i] sethintstring(&"ZOMBIE_ELECTRIC_SWITCH");
    traps[i] setcursorhint("HINT_NOICON");
    traps[i].is_available = 1;
  }
  var_cf413835 scene::play("p7_fxanim_zmhd_power_switch_bundle");
  playFX(level._effect["switch_sparks"], struct::get("switch_fx", "targetname").origin);
  level notify("master_switch_activated");
  fx_org delete();
  fx_org = spawn("script_model", (-675.021, -300.906, 283.724));
  fx_org setModel("tag_origin");
  fx_org.angles = vectorscale((0, 1, 0), 90);
  wait(6);
  fx_org stoploopsound();
  level notify("sleight_on");
  util::wait_network_frame();
  level notify("revive_on");
  util::wait_network_frame();
  level notify("doubletap_on");
  util::wait_network_frame();
  level notify("juggernog_on");
  exploder::exploder("lgt_exploder_power_on");
}

function function_463cb1c6() {
  power_on = getent("audio_swtch_left", "targetname");
  var_5c141942 = struct::get("evt_circuit_1", "targetname");
  var_36119ed9 = struct::get("evt_circuit_2", "targetname");
  var_100f2470 = struct::get("evt_circuit_3", "targetname");
  wait(0.75);
  if(isDefined(var_5c141942)) {
    playsoundatposition("evt_circuit_1", var_5c141942.origin);
  }
  wait(1.5);
  if(isDefined(var_36119ed9)) {
    playsoundatposition("evt_circuit_2", var_36119ed9.origin);
  }
  wait(1.5);
  if(isDefined(var_100f2470)) {
    playsoundatposition("evt_circuit_3", var_100f2470.origin);
  }
  wait(0.25);
  power_on playSound("evt_power_on");
  wait(5.5);
  power_on playLoopSound("evt_power_loop");
  level thread play_the_numbers();
  wait(1);
  level thread play_pa_system();
}

function electric_trap_wire_sparks(side) {
  self endon("elec_done");
  while(true) {
    sparks = struct::get("trap_wire_sparks_" + side, "targetname");
    self.fx_org = util::spawn_model("tag_origin", sparks.origin, sparks.angles);
    playFXOnTag(level._effect["electric_current"], self.fx_org, "tag_origin");
    targ = struct::get(sparks.target, "targetname");
    while(isDefined(targ)) {
      self.fx_org moveto(targ.origin, 0.15);
      self.fx_org playLoopSound("zmb_elec_current_loop", 0.1);
      self.fx_org waittill("movedone");
      self.fx_org stoploopsound(0.1);
      if(isDefined(targ.target)) {
        targ = struct::get(targ.target, "targetname");
      } else {
        targ = undefined;
      }
    }
    playFXOnTag(level._effect["electric_short_oneshot"], self.fx_org, "tag_origin");
    wait(randomintrange(3, 9));
    self.fx_org delete();
  }
}

function electric_current_open_middle_door() {
  sparks = struct::get("electric_middle_door", "targetname");
  fx_org = util::spawn_model("script_model", sparks.origin, sparks.angles);
  playFXOnTag(level._effect["electric_current"], fx_org, "tag_origin");
  targ = struct::get(sparks.target, "targetname");
  while(isDefined(targ)) {
    fx_org moveto(targ.origin, 0.075);
    if(isDefined(targ.script_noteworthy) && (targ.script_noteworthy == "junction_boxs" || targ.script_noteworthy == "electric_end")) {
      playFXOnTag(level._effect["electric_short_oneshot"], fx_org, "tag_origin");
    }
    fx_org playLoopSound("zmb_elec_current_loop", 0.1);
    fx_org waittill("movedone");
    fx_org stoploopsound(0.1);
    if(isDefined(targ.target)) {
      targ = struct::get(targ.target, "targetname");
    } else {
      targ = undefined;
    }
  }
  level notify("electric_on_middle_door");
  playFXOnTag(level._effect["electric_short_oneshot"], fx_org, "tag_origin");
  wait(randomintrange(3, 9));
  fx_org delete();
}

function play_the_numbers() {
  level thread function_9a0695b3();
  while(true) {
    wait(randomintrange(15, 20));
    playsoundatposition("evt_the_numbers", (-758, -310, 125));
    wait(randomintrange(15, 20));
  }
}

function function_9a0695b3() {
  while(true) {
    wait(randomintrange(3, 8));
    playsoundatposition("zmb_elec_room_sweets", (-758, -310, 125));
  }
}

function magic_box_limit_location_init() {
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

function waitfor_flag_open_chest_location(which) {
  wait(3);
  switch (which) {
    case "magic_box_south": {
      level flag::wait_till("magic_box_south");
      level.open_chest_location[0] = "magic_box_south";
      break;
    }
    case "south_access_1": {
      level flag::wait_till("south_access_1");
      level.open_chest_location[0] = "magic_box_south";
      level.open_chest_location[1] = "magic_box_bathroom";
      break;
    }
    case "north_door1": {
      level flag::wait_till("north_door1");
      level.open_chest_location[2] = "magic_box_hallway";
      break;
    }
    case "north_upstairs_blocker": {
      level flag::wait_till("north_upstairs_blocker");
      level.open_chest_location[2] = "magic_box_hallway";
      break;
    }
    case "south_upstairs_blocker": {
      level flag::wait_till("south_upstairs_blocker");
      level.open_chest_location[1] = "magic_box_bathroom";
      break;
    }
    default: {
      return;
    }
  }
}

function watersheet_on_trigger() {
  while(true) {
    self waittill("trigger", who);
    if(isDefined(who) && isplayer(who) && isalive(who) && who.sessionstate != "spectator") {
      if(!who laststand::player_is_in_laststand()) {
        if(isDefined(who.var_1e4200d5)) {
          if(!who.var_1e4200d5) {
            who thread function_4c24944a(self);
          }
        } else {
          who.var_1e4200d5 = 1;
          who thread function_4c24944a(self);
        }
      }
    }
    wait(1);
  }
}

function function_4c24944a(t_water) {
  self.var_1e4200d5 = 1;
  if(isDefined(t_water.script_int) && t_water.script_int) {
    visionset_mgr::activate("visionset", "zm_showerhead", self, 0.5, 2, 0.5);
    visionset_mgr::activate("overlay", "zm_showerhead_postfx", self, 0.5, 2, 0.5);
  } else {
    visionset_mgr::activate("overlay", "zm_waterfall_postfx", self, 0.5, 2, 0.5);
  }
  wait(1);
  if(self istouching(t_water)) {
    self thread function_4c24944a(t_water);
  } else {
    if(isDefined(t_water.script_int) && t_water.script_int) {
      visionset_mgr::deactivate("visionset", "zm_showerhead", self);
      visionset_mgr::deactivate("overlay", "zm_showerhead_postfx", self);
    } else {
      visionset_mgr::deactivate("overlay", "zm_waterfall_postfx", self);
    }
    self.var_1e4200d5 = 0;
  }
}

function setup_custom_vox() {
  level.plr_vox["level"]["power"] = "power";
}

function exit_level_func() {
  zombies = getaiarray();
  foreach(zombie in zombies) {
    if(isDefined(zombie.ignore_solo_last_stand) && zombie.ignore_solo_last_stand) {
      continue;
    }
    if(isDefined(zombie.find_exit_point)) {
      zombie thread[[zombie.find_exit_point]]();
      continue;
    }
    if(zombie.ignoreme) {
      zombie thread zm::default_delayed_exit();
      continue;
    }
    zombie thread zm::default_find_exit_point();
  }
}

function play_pa_system() {
  level clientfield::set("asylum_generator_state", 0);
  speakera = struct::get("loudspeaker", "targetname");
  playsoundatposition("amb_alarm", speakera.origin);
  level thread play_comp_sounds();
  wait(8);
  playsoundatposition("amb_pa_system", speakera.origin);
}

function play_comp_sounds() {
  computer = getent("comp", "targetname");
  computer playSound("amb_comp_start");
  wait(6);
  computer playLoopSound("amb_comp_loop");
}

function init_level_specific_audio() {
  level.vox zm_audio::zmbvoxadd("player", "general", "intro", "level_start", undefined);
  level.vox zm_audio::zmbvoxadd("player", "general", "door_deny", "nomoney", undefined);
  level.vox zm_audio::zmbvoxadd("player", "general", "perk_deny", "nomoney", undefined);
  level.vox zm_audio::zmbvoxadd("player", "general", "no_money_weapon", "nomoney", undefined);
}

function function_a552cd4a() {
  perk_machines = getEntArray("zombie_vending", "targetname");
  foreach(perk_machine in perk_machines) {
    if(isDefined(perk_machine.clip) && perk_machine.script_noteworthy == "specialty_additionalprimaryweapon") {
      perk_machine.clip delete();
    }
  }
}

function function_aeabaa98(zbarrier) {
  self.zbarrier = zbarrier;
  m_collision = (isDefined(self.zbarrier.script_string) ? self.zbarrier.script_string : "p6_anim_zm_barricade_board_collision");
  if(m_collision == "p6_anim_zm_barricade_board_collision") {
    self.zbarrier setzbarriercolmodel(m_collision);
  }
  self.zbarrier.chunk_health = [];
  for(i = 0; i < self.zbarrier getnumzbarrierpieces(); i++) {
    self.zbarrier.chunk_health[i] = 0;
  }
  if(isDefined(self.zbarrier.target)) {
    self.zbarrier.dynents = getEntArray(self.zbarrier.target, "targetname");
    for(i = 0; i < self.zbarrier.dynents.size; i++) {
      self.zbarrier hidezbarrierpiece(self.zbarrier.dynents[i].script_int);
      self.zbarrier.dynents[i] thread function_ee8a2035(self.zbarrier.dynents[i].script_int, self.zbarrier);
    }
  }
}

function function_ee8a2035(piece_index, zbarrier) {
  self endon("damage");
  var_31410ef7 = "closed";
  while(var_31410ef7 != "open" && var_31410ef7 != "opening") {
    wait(0.05);
    var_31410ef7 = zbarrier getzbarrierpiecestate(piece_index);
  }
  self notify("torn_down");
  e_piece = zbarrier.dynents[piece_index];
  if(isDefined(e_piece)) {
    self ghost();
    zm_utility::play_sound_at_pos("break_barrier_piece", self.origin);
    wait(randomfloatrange(0.3, 0.6));
    zm_utility::play_sound_at_pos("break_barrier_piece", self.origin);
  }
  self delete();
}

function function_ee422b5c(chunk) {
  if(isDefined(self.first_node.zbarrier.dynents) && isDefined(self.first_node.zbarrier.dynents[chunk])) {
    if(isDefined(self.first_node.zbarrier.dynents[chunk].script_noteworthy)) {
      animstatebase = self.first_node.zbarrier.dynents[chunk].script_noteworthy;
      self.first_node.zbarrier.var_48c7593a = 1;
    } else {
      assertmsg(("" + chunk) + "");
    }
  } else {
    animstatebase = self.first_node.zbarrier getzbarrierpieceanimstate(chunk);
  }
  return animstatebase;
}

function function_659c2324(a_keys) {
  if(a_keys[0] === level.weaponzmteslagun) {
    level.var_12d3a848 = 0;
    return a_keys;
  }
  n_chance = 0;
  if(zm_weapons::limited_weapon_below_quota(level.weaponzmteslagun)) {
    level.var_12d3a848++;
    if(level.var_12d3a848 <= 12) {
      n_chance = 5;
    } else {
      if(level.var_12d3a848 > 12 && level.var_12d3a848 <= 17) {
        n_chance = 8;
      } else if(level.var_12d3a848 > 17) {
        n_chance = 12;
      }
    }
  } else {
    level.var_12d3a848 = 0;
  }
  if(randomint(100) <= n_chance && zm_magicbox::treasure_chest_canplayerreceiveweapon(self, level.weaponzmteslagun) && !self hasweapon(level.weaponzmteslagunupgraded)) {
    arrayinsert(a_keys, level.weaponzmteslagun, 0);
    level.var_12d3a848 = 0;
  }
  return a_keys;
}

function function_bb75f24a() {
  level.var_a3dcfd4f = 0;
  var_f0a0f84f = struct::get_array("s_toilet_zhd", "targetname");
  array::thread_all(var_f0a0f84f, &function_db379af2);
  level thread function_fa408417();
  level waittill("hash_137fb152");
  level.var_a3dcfd4f = undefined;
  level flag::set("snd_zhdegg_activate");
  foreach(struct in var_f0a0f84f) {
    zm_unitrigger::unregister_unitrigger(struct.s_unitrigger);
  }
}

function function_db379af2() {
  level endon("hash_137fb152");
  self.var_46907f23 = 0;
  self.activated = 0;
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "toilet3") {
    self zm_unitrigger::create_unitrigger(undefined, undefined, &function_dffe609d);
  } else {
    self zm_unitrigger::create_unitrigger();
  }
  while(true) {
    self waittill("trigger_activated");
    self.var_46907f23++;
    if(self.var_46907f23 > 9) {
      playsoundatposition("zmb_zhd_toilet_flusheroo", self.origin);
      self.var_46907f23 = 0;
    } else {
      playsoundatposition("zmb_zhd_toilet_hit", self.origin);
    }
    if(self.var_46907f23 == self.script_int) {
      self.activated = 1;
      level.var_a3dcfd4f++;
      level notify("hash_b280e2e");
    } else if(isDefined(self.activated) && self.activated) {
      self.activated = 0;
      level.var_a3dcfd4f--;
      level notify("hash_b280e2e");
    }
    if(level.var_a3dcfd4f >= 3) {
      level notify("hash_137fb152");
    }
  }
}

function function_dffe609d(player) {
  if(!isDefined(level.var_a3dcfd4f)) {
    return true;
  }
  if(level.var_a3dcfd4f < 2) {
    return false;
  }
  return true;
}

function function_fa408417() {
  level endon("hash_137fb152");
  var_f0a0f84f = struct::get_array("s_toilet_zhd", "targetname");
  while(true) {
    level waittill("hash_b280e2e");
    foreach(struct in var_f0a0f84f) {
      if(isDefined(struct.script_noteworthy) && struct.script_noteworthy == "toilet3") {
        if(struct.var_46907f23 > 0 && level.var_a3dcfd4f <= 1) {
          struct.var_46907f23 = 0;
          playsoundatposition("zmb_zhd_toilet_flusheroo", struct.origin);
        }
        if(isDefined(struct.activated) && struct.activated && level.var_a3dcfd4f <= 2) {
          struct.activated = 0;
          level.var_a3dcfd4f--;
        }
      }
    }
  }
}

function include_perks_in_random_rotation() {
  zm_perk_random::include_perk_in_random_rotation("specialty_staminup");
  zm_perk_random::include_perk_in_random_rotation("specialty_deadshot");
  zm_perk_random::include_perk_in_random_rotation("specialty_widowswine");
  level.custom_random_perk_weights = &function_c027d01d;
}

function function_c027d01d() {
  temp_array = [];
  temp_array = array::randomize(temp_array);
  level._random_perk_machine_perk_list = array::randomize(level._random_perk_machine_perk_list);
  level._random_perk_machine_perk_list = arraycombine(level._random_perk_machine_perk_list, temp_array, 1, 0);
  keys = getarraykeys(level._random_perk_machine_perk_list);
  return keys;
}