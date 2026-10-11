/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_badad75eef11559.gsc
************************************************/

#using script_16ea1b94f0f381b3;
#using script_185660037b9236c1;
#using script_220d0eb95a8fab7d;
#using script_249b0a9054ceb230;
#using script_2d05e472a90adb1d;
#using script_2f11ea014b8bb8eb;
#using script_36fcbbe3d561c895;
#using script_41387eecc35b88bf;
#using script_42982ffd0134f28e;
#using script_485622d93fa7e4cf;
#using script_4e6e58ab5d96c2b0;
#using script_4ef01fe6151dde4d;
#using script_4fa7e9e11630166c;
#using script_4fdefae8b7bcdf73;
#using script_5080d40cd904ba73;
#using script_55221d469e7b320e;
#using script_60dd6e3992c1f29;
#using script_638d701d263ee1ed;
#using script_64351208cb856df9;
#using script_686729055b66c6e4;
#using script_6f65366f542f6627;
#using script_7534b1d3ac3ea47a;
#using script_7956d56c4922bd1;
#using script_79deab1955343d5d;
#using script_7cfaa6fd841fb4dd;
#using script_7d3e27aa82b5d70b;
#using script_7edf952f8921aa6b;
#using script_9880b9dc28bc25e;
#using scripts\asm\shared\mp\utility;
#using scripts\common\callbacks;
#using scripts\common\hud_util;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\vehicle_code;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\content_manager;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\loot_crystal;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\tripwire;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_airdrop;
#using scripts\cp_mp\vehicles\vehicle_damage;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\cp_mp\zombie_perks;
#using scripts\engine\scriptable_ascender;
#using scripts\engine\throttle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\ai_sentry_turret;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\ob;
#using scripts\mp\music_and_dialog;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\outofbounds;
#using scripts\mp\utility\player;
#namespace namespace_89d580f5dfa3808f;

function function_429e921f8ad411ff() {
  if(flag("jup_quest_init")) {
    return;
  }

  mapname = getmapname();

  if(is_equal(mapname, "mp_jup_resort_gw")) {
    level thread scripts\mp\music_and_dialog::disablemusic();
    scripts\cp_mp\vehicles\vehicle::vehicle_forceinit("veh_jup_ob_tank_escort");
    setDvar(@ "hash_6beec004cdf37c0", 187);
    namespace_134d54e39331ee45::function_af4cc6b8e4e57940();
    flag_set("jup_quest_init");
    callback::add("player_spawned", &on_player_spawned);
    scripts\cp_mp\tripwire::init();
    level.tripwireweaponname = "jup_frag_grenade_ob";
    [[level.var_f1bff73a86c35c52]]();
    level.var_cced1297c1210e46 = throttle_initialize("explosive_barrel", 1, default_to(level.framedurationseconds, 0.1));
    scripts\engine\scriptable_ascender::function_547c48dc070b2109(&function_8751cff989bde6a0);
    level._effect["lightning_strike_origin_weak"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_escort_act_2_neutralizer_electricity_attack_thin");
    level._effect["lightning_strike_weak"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_escort_act_2_neutralizer_attack_bolt_thin");
    level._effect["lightning_strike_origin"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_escort_act_2_neutralizer_electricity_attack");
    level._effect["lightning_strike"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_escort_act_2_neutralizer_attack_bolt");
    level._effect["lightning_strike_origin_loop"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_escort_act_2_neutralizer_electricity_attack_loop");
    level._effect["lightning_strike_impact"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_escort_act_2_neutralizer_electricity_impact");
    level._effect["neutralizer_explosion"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_escort_act_2_neutralizer_electricity_explo");
    level._effect["lightning_strike_origin"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_escort_act_2_neutralizer_electricity_attack");
    function_b0154b5bd3ac71d5();
    namespace_8ef157d888576350::function_610dfcbf191b189b();

    if(!getdvarint(@ "hash_6b556410d8d6245e", 0)) {
      setDvar(@ "hash_f1d095735ac37f33", 0);
      setDvar(@ "hash_f1f518497502aea8", 1);
      setDvar(@ "hash_37edd5a66bd29f3d", 2);
      setDvar(@ "hash_2fe0283b419ff08a", 1);
      setDvar(@ "hash_464559793bf93309", 0);
      level.var_a9e2544b9283299b = 1;
      level thread quest_start();
    }

    return;
  }

  if(getdvarint(@ "hash_8ac9461d39008a26", 0)) {
    level thread function_2e0dc001c9a5c661();
  }

  callback::add("exfil_to_s0_act2", &function_2a6c134406898721);
}

function on_player_spawned(params) {
  level flag_set("player_ready");

  if(getdvarint(@ "hash_5afec64dac12fb31", 0)) {
    wait 15;
    function_36451a8bfae75b4b();
  }
}

function quest_start() {
  level waittill("player_ready");
  namespace_22b8ba12655bf3f2::function_d589c49c4b9b50a0(&scripts\mp\gametypes\ob::function_91d032246bb24684);
  level thread intro_music();
  level thread map_transition();
}

function function_b267d2bd2147013() {
  level flag_wait("exfil_to_s0_act_2");
  level flag_set("powerup_disable_nuke");
}

function intro_music() {
  flag_wait("quest_infil_active");
  flags::gameflagwait("prematch_done");
  wait 1;
  setmusicstate("mx_jup_ob_q_infil");
}

function function_81e85bcedda2052() {
  level.var_df433561007fc313 = spawnStruct();
  level.var_df433561007fc313.act_name = "s0_act2";
  level.var_df433561007fc313.var_d5b8ef36ed91386a = 0;
  level.var_df433561007fc313.var_87da3b5200f9f001 = 0;
  level.var_df433561007fc313.var_718d9cc814712443 = 0;
  level.var_df433561007fc313.n_specials = 0;
  level.var_df433561007fc313.n_armored = 0;
  level.var_df433561007fc313.n_mercs = 0;
  level.var_df433561007fc313.n_zombies = 0;
  level.var_df433561007fc313.n_defend = 0;
  level.var_df433561007fc313.n_players = 0;
  level.var_df433561007fc313.n_heavy = 0;
  level.var_df433561007fc313.n_shield = 0;
  level.var_df433561007fc313.n_captain = 0;
  level.var_df433561007fc313.n_rusher = 0;
  level.var_df433561007fc313.difficulty = "difficulty_normal";
  level.var_df433561007fc313 thread setup_barrels();
  level.var_df433561007fc313 thread setup_ammo();
  level.var_df433561007fc313 thread setup_mines();
  level.var_df433561007fc313 thread function_ca13228a501ce246();
  level.var_df433561007fc313 thread function_7c5122b771e3b136();
  level.var_df433561007fc313 thread function_9cf8db85d41361b9();
  level.var_df433561007fc313 function_8e97ef62875df62();
  level.var_df433561007fc313 function_8cfae918b996bdd();
  level.var_df433561007fc313 thread oob_triggers();
  level thread namespace_134d54e39331ee45::function_7a5ab9d5c8dbfe6a();
  level.var_df433561007fc313 thread function_20936bc2cdd94c37();
  level.var_df433561007fc313 thread function_20936cc2cdd94e6a();
  level.var_df433561007fc313 thread function_20936dc2cdd9509d();
  level.var_df433561007fc313 thread function_209366c2cdd94138();
  level.var_df433561007fc313 escort_init();
  level.var_df433561007fc313 thread function_6bb7f830e7bd0851();
  level.var_df433561007fc313 thread squad_death_watcher();
  level function_24f7bf25b01b1d1f();
}

function function_8e97ef62875df62() {
  self.var_cd927c3a6d220500 = ["jup_ob_enemy_basic_grunt_long", "jup_ob_enemy_basic_grunt_short", "jup_ob_enemy_basic_soldier_short", "jup_ob_enemy_basic_soldier_long"];
  self.var_bf4b0f953edcff84 = ["jup_ob_enemy_specialist_heavytactician", "jup_ob_enemy_basic_soldier_long", "jup_ob_enemy_basic_soldier_short", "jup_ob_enemy_basic_specialforce_long"];
  self.var_5f9a84079974ac46 = [];
  self.var_5f9a84079974ac46["sniper"] = "jup_ob_enemy_specialist_sniper";
}

function function_8cfae918b996bdd() {
  self.var_2afbe67f5431e683 = [];
  var_6005bdbd0f0bf49b = spawnStruct();
  var_6005bdbd0f0bf49b.subclass = "zombie_base";
  var_6005bdbd0f0bf49b.chance = 100;
  var_6005bdbd0f0bf49b.max_active = 1000;
  var_999ee79b7b959d5c = spawnStruct();
  var_999ee79b7b959d5c.subclass = "zombie_base_armored_heavy";
  var_999ee79b7b959d5c.chance = 40;
  var_999ee79b7b959d5c.max_active = 8;
  var_7cfd7ef1c45f43e4 = spawnStruct();
  var_7cfd7ef1c45f43e4.subclass = "zombie_hellhound";
  var_7cfd7ef1c45f43e4.chance = 30;
  var_7cfd7ef1c45f43e4.max_active = 4;
  var_cb8500fece5d36f = spawnStruct();
  var_cb8500fece5d36f.subclass = "zombie_mangler";
  var_cb8500fece5d36f.chance = 15;
  var_cb8500fece5d36f.max_active = 1;
  var_d831ba4ba9425466 = spawnStruct();
  var_d831ba4ba9425466.subclass = "zombie_disciple";
  var_d831ba4ba9425466.chance = 15;
  var_d831ba4ba9425466.max_active = 1;
  var_bde179c449fa91f6 = spawnStruct();
  var_bde179c449fa91f6.subclass = "zombie_abom_mega_hvt";
  var_bde179c449fa91f6.chance = 0;
  var_bde179c449fa91f6.max_active = 1;
  self.var_2afbe67f5431e683["base_zombie"] = var_6005bdbd0f0bf49b;
  self.var_2afbe67f5431e683["armored_zombie"] = var_999ee79b7b959d5c;
  self.var_2afbe67f5431e683["hellhound"] = var_7cfd7ef1c45f43e4;
  self.var_2afbe67f5431e683["mangler"] = var_cb8500fece5d36f;
  self.var_2afbe67f5431e683["disciple"] = var_d831ba4ba9425466;
  self.var_2afbe67f5431e683["abomination"] = var_bde179c449fa91f6;
}

function function_20936bc2cdd94c37() {
  level endon("game_ended");
  self.samsites = [];
  var_888edc824a65c0e4 = getStructArray("samsite_spawn", "targetname");

  foreach(samsite_spawn in var_888edc824a65c0e4) {
    samsite = namespace_c5d39841678f2fb1::spawn_samsite(samsite_spawn);
    thread function_d19da8a793b7ed6(samsite);
    thread function_19c133a652a8cc3d(samsite);
    self.samsites = array_add(self.samsites, samsite);
  }
}

function function_20936cc2cdd94e6a() {
  level endon("game_ended");
}

function function_20936dc2cdd9509d() {
  level endon("game_ended");
  self.escort_path_events = getStructArray("escort_path_events", "target");
}

function function_209366c2cdd94138() {
  level endon("game_ended");
}

function function_970f611dc2e032db(var_3d5033905ec1ebff) {
  foreach(event in self.escort_path_events) {
    if(is_equal(var_3d5033905ec1ebff, event.targetname)) {
      return event;
    }
  }

  return undefined;
}

function function_a9241d4812148865(s_event) {
  if(!isDefined(s_event)) {
    return;
  }

  if(!isDefined(s_event.script_noteworthy)) {
    return;
  }

  switch (s_event.script_noteworthy) {
    case #"hash_ffc06812dd13691d":
      a_spawner_structs = getStructArray(s_event.targetname, "target");
      thread spawn_zombie_group(a_spawner_structs, s_event, 1, 0.2, self.vh_escort);
      thread namespace_64135de19550f047::ob_airstrike(s_event.origin, "multi_airstrike", 2, 0, s_event.angles[1]);
      break;
  }
}

function function_6bb7f830e7bd0851() {
  level endon("game_ended");
  level flag_set("powerup_disable_nuke");
  var_2185d088534858ce = getdvarint(@ "hash_64e503da6384ad7b", 0);

  switch (var_2185d088534858ce) {
    case 2:
      level.var_df433561007fc313 function_eb7e2348a1f2409f();
      level.var_df433561007fc313 function_eb7e2248a1f23e6c();
      level.var_df433561007fc313 function_eb7e2148a1f23c39();
      return;
    case 3:
      level.var_df433561007fc313 function_eb7e2248a1f23e6c();
      level.var_df433561007fc313 function_eb7e2148a1f23c39();
      return;
    case 4:
      level.var_df433561007fc313 function_eb7e2148a1f23c39();
      return;
    case 5:
      wait 4;
      level.var_df433561007fc313 thread quest_complete();
      return;
    case 6:
      level.var_df433561007fc313 function_eb7e2148a1f23c39();
      return;
    default:
      break;
  }

  level.var_df433561007fc313 function_eb7e2448a1f242d2();
  level.var_df433561007fc313 function_eb7e2348a1f2409f();
  level.var_df433561007fc313 function_eb7e2248a1f23e6c();
  level.var_df433561007fc313 function_eb7e2148a1f23c39();
}

function function_eb7e2448a1f242d2() {
  level endon("game_ended");
  self.var_358ab8df65cbb5b4 = 0;
  self.var_118630ce901b2217 = 2;
  self.act_step = 1;
  thread function_fdbef9ca19c6fb7a();

  if(!getdvarint(@ "hash_70249f5c9fc86370", 0)) {
    self waittill("infil_done");
  }

  flag_set("infil_done");
  function_c6352d8194937a50();
  flag_wait("infil_chopper_destroyed");
  thread function_db518d8f0ec31ae0();
  thread scripts\cp_mp\overlord::playconversation("quest_s0_a2t6_samsite_start", level.players, 4, 1);
  level waittill("story_quest_complete_step_1");

  if(isalive(level.players[0])) {
    level.players[0] callback::callback("destroyed_sam_shepherd");
  }
}

function function_eb7e2348a1f2409f() {
  level endon("game_ended");
  setmusicstate("mx_jup_ob_q_tension");
  self.act_step = 2;
  setup_drop_zone();
  thread function_d15b54af563202f();
  thread function_17373c6ea57393fd();
  level waittill("story_quest_complete_step_2");

  if(isalive(level.players[0])) {
    level.players[0] callback::callback("secured_airdrop_shepherd");
  }
}

function function_eb7e2248a1f23e6c() {
  level endon("game_ended");
  self.act_step = 3;

  if(is_equal(getdvarint(@ "hash_64e503da6384ad7b"), 3)) {
    self.vh_escort = spawn_escort_vehicle(self);
    function_da11a8810b7c3bc8();
    function_97e82918ce08c384();
    wait 15;
  }

  thread escort_begin();
  thread function_7124f960c512f09a("activate");
  level waittill("story_quest_complete_step_3");

  if(isalive(level.players[0])) {
    level.players[0] callback::callback("escorted_vehicle_shepherd");
  }
}

function function_eb7e2148a1f23c39() {
  level endon("game_ended");
  self.act_step = 4;

  if(is_equal(getdvarint(@ "hash_64e503da6384ad7b"), 4) || is_equal(getdvarint(@ "hash_64e503da6384ad7b"), 6)) {
    var_1d9efeb8c1d779bf = getStruct("final_destination", "script_noteworthy");
    self.vh_escort = spawn_escort_vehicle(self, var_1d9efeb8c1d779bf);
    function_2674a21020618651(0);
    function_da11a8810b7c3bc8();
    wait 15;
    self.vh_escort escort_setup(self);
    function_97e82918ce08c384();
    self.vh_escort notify("reached_end_node");
  }

  self.vh_escort.generateslots = 1;
  self.vh_escort function_a52670a99736f59d();

  if(isDefined(self.vh_escort.navobstacleid)) {
    destroynavobstacle(self.vh_escort.navobstacleid);
    self.vh_escort.navobstacleid = undefined;
  }

  self.vh_escort.navobstacleid = createnavobstaclebyent(self.vh_escort);

  if(is_equal(getdvarint(@ "hash_64e503da6384ad7b"), 6)) {
    thread function_2e69383c6abc963b("abomination_encounter_location");
  }

  thread function_459b11a053734e1();
  thread defend_begin();
  level waittill("story_quest_complete_step_4");

  if(isalive(level.players[0])) {
    level.players[0] callback::callback("defended_escort_shepherd");
  }
}

function function_db518d8f0ec31ae0(var_50e779230014a475) {
  scripts\mp\gametypes\br_gametype_dmz::showdmzsplash("quest_s0_act2_start", level.players);

  foreach(samsite in self.samsites) {
    samsite thread namespace_c5d39841678f2fb1::function_f72a6146b33f7d1("jup_ui_map_icon_generic_marker", self);
  }

  namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT2_DESTROY_SAMSITES", level.players);

  foreach(player in level.players) {
    player setclientomnvar("ui_br_objective_param", 0);
  }
}

function function_d15b54af563202f(var_50e779230014a475) {
  var_50e779230014a475 = default_to(var_50e779230014a475, "");

  switch (var_50e779230014a475) {
    case #"hash_e9d9fcb8daba8602":
      namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT2_SECURE_AIRDROP_CLEAR", level.players);
      break;
    default:
      namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT2_SECURE_AIRDROP", level.players);
      break;
  }
}

function function_7124f960c512f09a(var_50e779230014a475) {
  var_50e779230014a475 = default_to(var_50e779230014a475, "");

  switch (var_50e779230014a475) {
    case #"hash_b389e7ddef378fd0":
      namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT2_ESCORT_ACTIVATE", level.players);
      break;
    case #"hash_e9d9fcb8daba8602":
      namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT2_ESCORT_COMPLETE_CLEAR", level.players);

      if(isDefined(self.vh_escort)) {
        function_32df7454369064fb(self.vh_escort.health, self.vh_escort.var_c552b5bccbe7cb58);
      }

      break;
    default:
      namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT2_ESCORT", level.players);

      if(isDefined(self.vh_escort)) {
        function_32df7454369064fb(self.vh_escort.health, self.vh_escort.var_c552b5bccbe7cb58);
      }

      break;
  }
}

function function_459b11a053734e1(var_50e779230014a475) {
  var_50e779230014a475 = default_to(var_50e779230014a475, "");

  switch (var_50e779230014a475) {
    case #"hash_c6514c88e37149bf":
      namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT2_DEFEND_START", level.players);

      if(isDefined(self.vh_escort)) {
        function_32df7454369064fb(self.vh_escort.health, self.vh_escort.var_c552b5bccbe7cb58);
      }

      break;
    case #"hash_2b03afb9f1da2591":
      namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT2_DEFEND_DETONATE", level.players);

      if(isDefined(self.vh_escort)) {
        function_32df7454369064fb(self.vh_escort.health, self.vh_escort.var_c552b5bccbe7cb58);
      }

      break;
    default:
      namespace_262d6474998a2356::function_641bc1548cff8210("QUEST_0_ACT2_DEFEND", level.players);

      if(isDefined(self.vh_escort)) {
        function_32df7454369064fb(self.vh_escort.health, self.vh_escort.var_c552b5bccbe7cb58);
      }

      break;
  }
}

function function_fdbef9ca19c6fb7a() {
  self.var_5aea8a52620494e9 = getStruct("fortified_building_entrance", "targetname");
  self.var_ab1459cb9bbc5539 = getStruct("fortified_building_atrium", "targetname");
  self.var_d2e6cd0ac5baeb45 = getStruct("fortified_building_roof", "targetname");
  self.var_5aea8a52620494e9.var_df433561007fc313 = self;
  self.var_ab1459cb9bbc5539.var_df433561007fc313 = self;
  self.var_d2e6cd0ac5baeb45.var_df433561007fc313 = self;
  self.var_5aea8a52620494e9 thread function_186d567068121c23();
  self.var_ab1459cb9bbc5539 thread function_c41fab32a7097793();
  thread function_34c6dea0b5aadb9e(self.var_ab1459cb9bbc5539);
}

function function_186d567068121c23() {
  self.var_df433561007fc313 thread function_d1ce7548ed380171(self);
}

function function_c41fab32a7097793() {
  self.var_df433561007fc313 thread function_d1ce7548ed380171(self);
}

function function_7c5b27a81030641f() {
  self.var_df433561007fc313 function_d1ce7548ed380171(self);
  trigger_volumes = getnoentvolumearray("roof_noent_trigger", "targetname");

  foreach(trigger_volume in trigger_volumes) {
    self.var_df433561007fc313 thread function_d34b0d81252aad22(trigger_volume);
  }
}

function function_d34b0d81252aad22(trigger_volume) {
  self endon("quest_s0_act2_ended");
  self endon("player_entered_roof");
  level endon("story_quest_complete_step_1");
  reinforcements_spawned = 0;

  while(true) {
    trigger_volume waittill("trigger", ent);
    is_vehicle = ent scripts\common\vehicle::isvehicle();

    if(!isPlayer(ent) && !is_vehicle) {
      continue;
    }

    a_players = [];

    if(is_vehicle) {
      if(isarray(ent.occupants)) {
        foreach(occupant in ent.occupants) {
          if(isPlayer(occupant)) {
            a_players = array_add(a_players, occupant);
          }
        }
      }
    }

    if(isPlayer(ent)) {
      if(!istrue(self.var_8dd943c14cdc87b3) && isarray(self.var_d2e6cd0ac5baeb45.a_mercs)) {
        foreach(merc in self.var_d2e6cd0ac5baeb45.a_mercs) {
          merc val::set("roof_mercs", "ignoreall", 0);
        }

        self.var_8dd943c14cdc87b3 = 1;
      }

      a_players = array_add(a_players, ent);
      level.var_df433561007fc313 thread function_235944ad0915efdb(ent, 1, 1);
    }

    if(a_players.size > 0 && !reinforcements_spawned) {
      var_2b4364d8d93a45b9 = getStructArray("samsite_location_merc_chopper", "targetname");
      thread function_804aa1cbd49ba400(var_2b4364d8d93a45b9);
      reinforcements_spawned = 1;
    }

    wait 0.1;
  }
}

function function_34c6dea0b5aadb9e(var_d1b16c8e8b471b9e) {
  self endon("quest_s0_act2_ended");
  approach_radius = 2750;

  while(true) {
    wait 1;
    players = scripts\mp\utility\player::getplayersinradius(var_d1b16c8e8b471b9e.origin, approach_radius);

    if(players.size > 0) {
      thread scripts\cp_mp\overlord::playevent("quest_s0_a2t6_fortified_building_approach", level.players);
      self.var_d2e6cd0ac5baeb45 thread function_7c5b27a81030641f();
      thread function_49b9346c557df701();
      return;
    }
  }
}

function setup_sentry(spawn_struct, location_struct) {
  self endon("quest_s0_act2_ended");
  self.var_70507c40273c3d2c = scripts\engine\throttle::throttle_initialize("sentry_health_bar_update", 2);

  if(!isDefined(level.sentrysettings["ai_sentry_turret"])) {
    scripts\mp\ai_sentry_turret::init();
  }

  sentry = namespace_64135de19550f047::function_586d4d82f07e0d09(spawn_struct);
  self.var_f32357b4f622db32 = default_to(self.var_f32357b4f622db32, []);
  self.var_f32357b4f622db32 = array_add(self.var_f32357b4f622db32, sentry);
}

function function_19c133a652a8cc3d(samsite) {
  self endon("quest_s0_act2_ended");
  samsite waittill("samsite_bomb_detonated");
  thread function_47c574f1b82564e1();
}

function function_d19da8a793b7ed6(samsite) {
  self endon("quest_s0_act2_ended");
  samsite waittill("samsite_bomb_planted");
  thread function_d63316812c3bc04b(self.var_d2e6cd0ac5baeb45);
}

function function_47c574f1b82564e1() {
  self.var_358ab8df65cbb5b4++;

  foreach(player in level.players) {
    player setclientomnvar("ui_br_objective_param", self.var_358ab8df65cbb5b4);
  }

  if(self.var_358ab8df65cbb5b4 >= self.var_118630ce901b2217) {
    scripts\cp_mp\overlord::playconversation("quest_s0_a2t6_samsite_destroyed", level.players, 5, 1);
    thread function_9aa696b9bad4fdc9();
    level notify("story_quest_complete_step_1");
  }
}

function function_49b9346c557df701() {
  if(isarray(self.var_79c8996a40bba4ae)) {
    foreach(sam_marker in self.var_79c8996a40bba4ae) {
      function_a28e8535e00d34f3(sam_marker);
      function_17db39bd195cc5b1(sam_marker);
    }
  }

  self.var_942160dfc85d052 = [];
  var_9c870dc9569e2805 = getStructArray("ascender_marker", "targetname");

  foreach(var_1f5b07c79d3bed3a in var_9c870dc9569e2805) {
    var_be93d3e51d75015 = objidpoolmanager::requestobjectiveid(0);
    waitframe();
    objidpoolmanager::objective_set_play_intro(var_be93d3e51d75015, 1);
    objidpoolmanager::objective_set_play_outro(var_be93d3e51d75015, 0);
    objidpoolmanager::objective_add_objective(var_be93d3e51d75015, "current");
    objidpoolmanager::update_objective_position(var_be93d3e51d75015, var_1f5b07c79d3bed3a.origin + (0, 0, 64));
    objidpoolmanager::update_objective_icon(var_be93d3e51d75015, "jup_ui_map_icon_generic_marker");
    objidpoolmanager::objective_playermask_showtoall(var_be93d3e51d75015);
    objidpoolmanager::update_objective_setbackground(var_be93d3e51d75015, 1);
    self.var_942160dfc85d052 = array_add(self.var_942160dfc85d052, var_be93d3e51d75015);
  }
}

function setup_drop_zone() {
  airdrop_struct = getStruct("quest_escort_start_struct", "targetname");
  wait 5.5;
  function_be15cfdf04549227(airdrop_struct.origin + (0, 0, 2500));
  thread scripts\cp_mp\overlord::playconversation("quest_s0_a2t6_airdrop_flare", level.players, 1.5, 1);
  self.var_f4aca19752f2420e = spawnscriptable("ob_quest_act2_airdrop_location", airdrop_struct.origin, airdrop_struct.angles);
  self.var_f4aca19752f2420e setscriptablepartstate("smoke", "smoking");
  function_bbe1277f672a7aff();
  s_location = getStruct("airdrop_location", "targetname");
  var_36bfaa6d1617a83b = getStructArray("ai_goal", "targetname");
  var_f83db8d7f8c4654c = [];

  foreach(s_goal in var_36bfaa6d1617a83b) {
    if(is_equal(s_goal.target, s_location.targetname)) {
      var_f83db8d7f8c4654c = array_add(var_f83db8d7f8c4654c, s_goal);
    }
  }

  var_2b4364d8d93a45b9 = getStructArray("airdrop_location_merc_chopper", "targetname");
  thread function_804aa1cbd49ba400(var_2b4364d8d93a45b9);
  thread function_d1ce7548ed380171(s_location, var_f83db8d7f8c4654c);
  thread function_1b4d007c48f6440d(s_location, var_f83db8d7f8c4654c, 1);
}

function function_be15cfdf04549227(spawn_origin) {
  flare = spawn("script_model", spawn_origin);
  start_pos = flare.origin;
  flare.angles = vectortoangles((0, 0, 1));
  flare setModel("equip_flare_br");
  flare setscriptablepartstate("launch", "start", 0);
  travelpart = "start_" + "revive";
  flare setscriptablepartstate("travel", travelpart, 0);
  flare thread _utilflare_lerpflare();
}

function _utilflare_lerpflare() {
  self endon("death");
  level endon("game_ended");
  movetime = 1;
  self moveTo(self.origin + (0, 0, 250), movetime);
  wait movetime;
  _utilflare_flareexplode();
}

function _utilflare_flareexplode() {
  self setscriptablepartstate("travel", "off", 0);
  fxstate = "start_" + "revive";
  self setscriptablepartstate("explode", fxstate, 0);
  thread function_e193d48772619047();
}

function function_e193d48772619047() {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("phosphorus", "start", 0);
  wait 0.3;
  self setscriptablepartstate("phosphorus_loop", "start", 0);
  wait 25;
  self setscriptablepartstate("phosphorus", "end", 0);
  wait 0.3;
  self setscriptablepartstate("phosphorus_loop", "off", 0);
  wait 5;
  self delete();
}

function function_bbe1277f672a7aff() {
  self.var_355ab3e4e47094d5 = objidpoolmanager::requestobjectiveid(0);
  var_63f6cfa75b069ffb = getStruct("airdrop_location", "targetname");
  waitframe();
  objidpoolmanager::objective_set_play_intro(self.var_355ab3e4e47094d5, 1);
  objidpoolmanager::objective_set_play_outro(self.var_355ab3e4e47094d5, 0);
  objidpoolmanager::objective_add_objective(self.var_355ab3e4e47094d5, "current");
  objidpoolmanager::update_objective_position(self.var_355ab3e4e47094d5, var_63f6cfa75b069ffb.origin);
  objidpoolmanager::update_objective_icon(self.var_355ab3e4e47094d5, "jup_ui_map_icon_generic_marker");
  objidpoolmanager::objective_playermask_showtoall(self.var_355ab3e4e47094d5);
  objidpoolmanager::update_objective_setbackground(self.var_355ab3e4e47094d5, 1);
}

function function_1a3d5a6bc4965338() {
  scripts\mp\objidpoolmanager::returnobjectiveid(self.var_355ab3e4e47094d5);
}

function function_17373c6ea57393fd() {
  wait 25;
  self.var_f4aca19752f2420e setscriptablepartstate("smoke", "dissipate");
  self.vh_escort = spawn_escort_vehicle(self);
  self.vh_escort setCanDamage(0);
  wait 5;
  self.var_f4aca19752f2420e freescriptable();
  self.var_f4aca19752f2420e notify("death");
  thread function_d62e17e7af01d68b();
}

function function_d62e17e7af01d68b() {
  self endon("quest_s0_act2_ended");
  thread function_d15b54af563202f("clear");
  start_time = gettime();

  while(true) {
    a_ai = getaiarrayinradius(self.vh_escort.origin, 2250);

    if(a_ai.size < 6 || gettime() - start_time > 120000) {
      function_1a3d5a6bc4965338();
      function_97e82918ce08c384();
      level notify("story_quest_complete_step_2");
      thread scripts\cp_mp\overlord::playconversation("quest_s0_a2t6_activate_vehicle", level.players, 0, 1);
      return;
    }

    wait 3;
  }
}

function escort_begin() {
  self endon("quest_s0_act2_ended");
  self.ambushradius = self.var_d46c4a839418dd7d.ambushradius;
  self.floodradius = self.var_d46c4a839418dd7d.floodradius;
  self.escorticon = self.var_d46c4a839418dd7d.escorticon;
  function_2674a21020618651();
  self.vh_escort.e_start waittill("escort_started");
  veh_dist = distance(self.vh_escort.origin, self.vh_escort.spawndata.origin);

  if(veh_dist > 2.5) {
    self.vh_escort vehicle_teleport(self.vh_escort.spawndata.origin, self.vh_escort.spawndata.angles);
    wait 0.1;
  }

  setmusicstate("mx_jup_ob_q2_escort");
  function_84610473025b148();
  thread function_7124f960c512f09a("escort");
  self.vh_escort.markerattach unlink();
  self.vh_escort.markerattach linkTo(self.vh_escort, "tag_attach_rocket", (0, 0, 65), (0, 0, 0));
  self.vh_escort.e_start delete();
  wait_time = function_c619613f382927df("dx_ob_oesc_esca_acve_escbootup") + 1;
  self.vh_escort.vo_ent playsoundonmovingent("dx_ob_oesc_esca_acve_escbootup");
  self.vh_escort setscriptablepartstate("engine", "start");
  self.vh_escort setscriptablepartstate("panel", "activate");
  wait wait_time;
  self.vh_escort setscriptablepartstate("beacon_light", "active");
  self.vh_escort setscriptablepartstate("headlight_left", "active");
  self.vh_escort setscriptablepartstate("headlight_right", "active");
  self.vh_escort setscriptablepartstate("side_lights", "on");
  function_da11a8810b7c3bc8();
}

function spawn_escort_vehicle(quest_info, var_1d9efeb8c1d779bf) {
  wait 1;
  spawndata = spawnStruct();
  spawn_struct = getStruct("quest_escort_start_struct", "targetname");
  spawn_origin = (0, 0, 0);
  spawn_angles = (0, 0, 0);

  if(is_equal(self.movement_type, "spline")) {
    spawn_angles = self.nd_spline_start.angles;
    spawn_origin = self.nd_spline_start.origin;
  } else {
    spawn_angles = spawn_struct.angles;
    spawn_origin = spawn_struct.origin;
  }

  if(isDefined(var_1d9efeb8c1d779bf)) {
    spawn_origin = var_1d9efeb8c1d779bf.origin;
  }

  spawndata.angles = spawn_angles;
  spawndata.team = level.players[0].team;
  spawndata.initai = 0;
  spawndata.origin = spawn_origin;
  spawndata.nohitmarkers = 1;
  spawndata.preventrespawn = 1;
  spawndata.str_payload = "neutralizer";
  spawndata.quest_instance = self;
  println("<dev string:x1c>" + spawndata.origin + "<dev string:x3d>" + spawndata.angles);
  vh_escort = scripts\cp_mp\vehicles\vehicle_airdrop::vehicle_airdrop("veh_jup_ob_tank_escort", spawndata);
  vh_escort.spawndata = spawndata;
  vh_escort.script_noteworthy = self.script_noteworthy;
  vh_escort vehphys_parkingbrake(1);
  vh_escort vehicleshowonminimap(0);
  vh_escort vehicleunpingable(1);
  vh_escort.var_df433561007fc313 = quest_info;
  vh_escort function_6faa66a04c0dda2d(quest_info);
  self notify("vehicle_spawned");
  quest_info thread function_894089537e64ba63(vh_escort);
  return vh_escort;
}

function function_894089537e64ba63(vh_escort) {
  vh_escort waittill("freefall");
  wait 0.75;
  vh_escort vehicle_teleport(vh_escort.spawndata.origin, vh_escort.spawndata.angles);
  thread scripts\cp_mp\overlord::playevent("quest_s0_a2t6_secure_vehicle_soap", level.players);
}

function escort_init() {
  self.var_1be7d142b0b72909 = getStruct("quest_s0_act2_escort", "targetname");
  self.script_noteworthy = self.var_1be7d142b0b72909.script_noteworthy;
  self.nd_spline_start = function_a833053c48e37c08();
  self.movement_type = "p2p";
  self.p2p_start = getStruct("quest_escort_p2p_start", "targetname");

  if(isDefined(self.nd_spline_start) && !istrue(getdvarint(@ "hash_b41b7481ff7c12f", 0))) {
    self.movement_type = "spline";
  } else {
    self.movement_type = "p2p";
    self.p2p_start = getStruct("quest_escort_p2p_start", "targetname");
  }

  self.routedifficulty = "difficulty_normal";
  [self.interact_struct] = getStructArray("escort_vehicle_spawn", "targetname");
  self.rocketlaunched = 0;
  self.waskilled = 0;
  self.var_d46c4a839418dd7d = spawnStruct();
  self.var_d46c4a839418dd7d.ambushradius = 0;
  self.var_d46c4a839418dd7d.floodradius = 0;
  self.var_d46c4a839418dd7d.escorticon = "hud_icon_jup_ob_obj_escort_vehicle";
  self.var_d46c4a839418dd7d.escorthealth = 3500;
  self.var_d46c4a839418dd7d.var_de0c6b19da7810df = 6;
  self.var_d46c4a839418dd7d.speedincrease = 0;
  self.var_d46c4a839418dd7d.escortaccel = 5;
  self.var_d46c4a839418dd7d.escortdecel = 3;
  self.var_d46c4a839418dd7d.escortproximity = 500;
  self.var_d46c4a839418dd7d.var_31c07988f05debcf = 2500;
}

function function_a833053c48e37c08() {
  self endon("quest_s0_act2_ended");
  s_startnode = getvehiclenode("quest_escort_spline_start", "targetname");
  return s_startnode;
}

function function_2674a21020618651(attach_spline) {
  if(!isDefined(attach_spline)) {
    attach_spline = 1;
  }

  self endon("quest_s0_act2_ended");
  self.vh_escort vehicle_turnengineoff();
  self.vh_escort setCanDamage(0);
  self.vh_escort.vo_ent = spawn("script_model", self.vh_escort.origin);
  self.vh_escort.vo_ent linkTo(self.vh_escort, "tag_origin", (0, 0, 78), (0, 0, 0));

  if(!is_equal(getdvarint(@ "hash_64e503da6384ad7b"), 4) && !is_equal(getdvarint(@ "hash_64e503da6384ad7b"), 6)) {
    self.vh_escort.e_start = scripts\cp_mp\interaction::register_interact(self.vh_escort.origin, 48, &escort_interact, &"JUP_OB_OBJECTIVES/QUEST_0_ACT2_ESCORT_START_INTERACT");
    self.vh_escort setscriptablepartstate("panel", "open");
    self.vh_escort.e_start linkTo(self.vh_escort, "tag_control_panel_door_lower_animate", (0, -7.5, 0), (0, 90, 0));

    if(is_equal(self.movement_type, "spline")) {
      self.vh_escort.nd_start = getvehiclenode("quest_escort_spline_start", "targetname");
    }
  }

  wait 1;

  if(istrue(getdvarint(@ "hash_21824b71fa4a97bd", 0))) {
    contentsoverride = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 0, 1);
    a_results = scripts\engine\trace::ray_trace(self.vh_escort.origin + (0, 0, 100), self.vh_escort.spawndata.origin - (0, 0, 100), self.vh_escort, contentsoverride);
    ground_pos = a_results["position"];
    pos_diff = distancesquared(self.vh_escort.origin, ground_pos);
    logprint("Act 2 Quest Escort: Escort Vehicle Desired Spawn Origin: " + self.vh_escort.spawndata.origin);
    logprint("Act 2 Quest Escort: Escort Vehicle Current Origin: " + self.vh_escort.origin);
    logprint("Act 2 Quest Escort: Escort Vehicle Ground Raycast: " + ground_pos);
    logprint("Act 2 Quest Escort: Escort Vehicle Ground Origin Difference Squared: " + pos_diff);

    if(self.vh_escort.origin[2] < self.vh_escort.spawndata.origin[2]) {
      self.vh_escort vehicle_teleport(self.vh_escort.spawndata.origin, self.vh_escort.spawndata.angles);
    }
  }

  if(is_equal(self.movement_type, "spline") && istrue(attach_spline)) {
    self.vh_escort scripts\common\vehicle::attach_vehicle(self.vh_escort.nd_start);
  }
}

function function_da11a8810b7c3bc8() {
  self endon("quest_s0_act2_ended");
  self.vh_escort.var_aa4804cc1bc59e93 = 1;
  self.vh_escort.var_1cb92917037d8996 = 0;
  self.vh_escort.var_5cd270934176a923 = 0;
  self.vh_escort escort_setup(self);

  if(is_equal(self.movement_type, "p2p")) {
    self.vh_escort thread function_df4c9a21b5873371();
  } else if(isDefined(self.vh_escort.nd_start)) {
    self.vh_escort thread scripts\common\vehicle::vehicle_paths(self.vh_escort.nd_start);
    scripts\common\vehicle_paths::gopath(self.vh_escort);
    thread function_bb0d7d2ab7bb1c6b();
  }

  self.vh_escort thread escort_think(self);
  self.vh_escort thread function_9c9e518280bea222(self);
  self.vh_escort thread function_1db9d507d5dd43da();
  thread function_8543cb813eebd318();
  thread function_a46548c342e333f7();
}

function function_6faa66a04c0dda2d(activity_instance) {
  self.team = level.players[0].team;
  self.health = activity_instance.var_d46c4a839418dd7d.escorthealth * 2;
  self.basespeed = activity_instance.var_d46c4a839418dd7d.var_de0c6b19da7810df;
  self.speedincrease = activity_instance.var_d46c4a839418dd7d.speedincrease;
  self.accel = activity_instance.var_d46c4a839418dd7d.escortaccel;
  self.decel = activity_instance.var_d46c4a839418dd7d.escortdecel;
  self.proximity = activity_instance.var_d46c4a839418dd7d.escortproximity;
  self.attractradi = activity_instance.var_d46c4a839418dd7d.var_31c07988f05debcf;
  self.var_c70842e4e81f2852 = 1;

  if(getDvar(@ "hash_a3cd7baf4609ce24", "-1") != "-1") {
    self.health = getdvarint(@ "hash_a3cd7baf4609ce24");
  }

  if(getDvar(@ "hash_1138e73c40e1324a", "-1") != "-1") {
    self.basespeed = getdvarfloat(@ "hash_1138e73c40e1324a");
  }

  self.var_c552b5bccbe7cb58 = self.health;
}

function escort_setup(activity_instance) {
  self setCanDamage(1);
  self vehphys_parkingbrake(0);
  self.attractor = add_attractor(self, 1, self.attractradi, 1, undefined, &function_1282eec91da30219);
}

function escort_think(activity_instance) {
  self endon("death");
  self endon("reached_end_node");
  n_proximity = squared(self.proximity);
  self.generateslots = 0;

  while(true) {
    self.b_proximity = 0;
    self.n_players = 0;
    a_players = level.players;

    foreach(player in a_players) {
      if(isDefined(player) && isDefined(self) && distancesquared(self.origin, player.origin) <= n_proximity) {
        self.b_proximity = 1;
        self.n_players++;
      }
    }

    n_players = self.n_players - 1;
    n_players = clamp(n_players, 0, 3);
    var_578e9d1584d07d25 = n_players * self.speedincrease + 1;
    self.n_speed = self.basespeed * var_578e9d1584d07d25;
    self.n_speed = clamp(self.n_speed, 1, 12);
    wait 0.5;

    if(!istrue(self.b_proximity) || istrue(self.final_stop)) {
      if(is_equal(self.spawndata.quest_instance.movement_type, "p2p")) {
        self function_a7fac0397762d7a6("p2p", "manualSpeed", mph_to_ips(0));
        self function_a7fac0397762d7a6("p2p", "resume", 0);
        self function_a7fac0397762d7a6("p2p", "pause", 1);
      } else {
        self vehicle_setspeed(0, self.accel, self.decel);
      }

      if(!istrue(self.b_proximity) && !istrue(self.final_stop)) {
        self setscriptablepartstate("chassis", "alert");
        self setscriptablepartstate("beacon_light", "alert");
        self setscriptablepartstate("headlight_left", "alert");
        self setscriptablepartstate("headlight_right", "alert");
        self notify("no_escorts");
      }
    } else {
      if(is_equal(self.spawndata.quest_instance.movement_type, "p2p")) {
        self function_a7fac0397762d7a6("p2p", "manualSpeed", mph_to_ips(self.n_speed));
        self function_a7fac0397762d7a6("p2p", "pause", 0);
        self function_a7fac0397762d7a6("p2p", "resume", 1);
      } else {
        self vehicle_setspeed(self.n_speed, self.accel, self.decel);
      }

      self setscriptablepartstate("beacon_light", "active");
      self setscriptablepartstate("headlight_left", "active");
      self setscriptablepartstate("headlight_right", "active");
    }

    vehspeed = self vehicle_getspeed();

    if(vehspeed <= 0.5) {
      function_a52670a99736f59d();
      continue;
    }

    function_6e427a8504ec078c();
  }
}

function private function_1db9d507d5dd43da() {
  self endon("death");
  turret_types = ["sentry_turret", "remote_turret"];
  self vehphys_enablecollisioncallback(1);

  while(true) {
    self waittill("collision", body0, body1, flag0, flag1, position, normal, normalspeed, ent, partenum);

    if(isDefined(ent.turrettype) && array_contains(turret_types, ent.turrettype)) {
      ent notify("kill_turret", 1);
    }
  }
}

function function_a52670a99736f59d() {
  self endon("death");

  if(!istrue(self.generateslots)) {
    return;
  }

  var_c38db2e51d5f66a2 = anglesToForward(self.angles);
  var_e560aa662258c25d = anglestoright(self.angles);
  var_40fc788beae80d60 = [];
  s_attackpt = function_fc784a7d07e0449a(36, -98, var_c38db2e51d5f66a2, var_e560aa662258c25d);
  var_40fc788beae80d60 = function_6d6af8144a5131f1(var_40fc788beae80d60, s_attackpt);
  s_attackpt = function_fc784a7d07e0449a(36, 98, var_c38db2e51d5f66a2, var_e560aa662258c25d);
  var_40fc788beae80d60 = function_6d6af8144a5131f1(var_40fc788beae80d60, s_attackpt);
  s_attackpt = function_fc784a7d07e0449a(-24, -98, var_c38db2e51d5f66a2, var_e560aa662258c25d);
  var_40fc788beae80d60 = function_6d6af8144a5131f1(var_40fc788beae80d60, s_attackpt);
  s_attackpt = function_fc784a7d07e0449a(-24, 98, var_c38db2e51d5f66a2, var_e560aa662258c25d);
  var_40fc788beae80d60 = function_6d6af8144a5131f1(var_40fc788beae80d60, s_attackpt);
  s_attackpt = function_fc784a7d07e0449a(-72, -98, var_c38db2e51d5f66a2, var_e560aa662258c25d);
  var_40fc788beae80d60 = function_6d6af8144a5131f1(var_40fc788beae80d60, s_attackpt);
  s_attackpt = function_fc784a7d07e0449a(-72, 98, var_c38db2e51d5f66a2, var_e560aa662258c25d);
  var_40fc788beae80d60 = function_6d6af8144a5131f1(var_40fc788beae80d60, s_attackpt);

  if(getdvarint(@ "hash_3f737f506519563d", 0)) {
    foreach(attackpt in var_40fc788beae80d60) {
      line(attackpt.origin, attackpt.origin + (0, 0, 1024), (1, 0, 0), 1, 0, 600);
    }
  }

  function_357609ca7ca5486e(self.attractor, var_40fc788beae80d60);
  self.generateslots = 0;
}

function function_6e427a8504ec078c() {
  self endon("death");

  if(self.generateslots == 1) {
    return;
  }

  a_empty = [];
  function_357609ca7ca5486e(self.attractor, a_empty);
  self.generateslots = 1;
}

function function_fc784a7d07e0449a(xoffset, yoffset, anglesforward, anglesright) {
  var_1e0625e95bbc715c = spawnStruct();
  var_1e0625e95bbc715c.origin = self.origin + anglesforward * xoffset + anglesright * yoffset;
  return var_1e0625e95bbc715c;
}

function private function_84610473025b148() {
  foreach(player in level.players) {
    player setclientomnvar("ui_br_objective_progress_bar", 100);
    player setclientomnvar("ui_br_objective_progress_bar_threshold", 20);
    player setclientomnvar("ui_br_objective_param", 100);
  }
}

function function_8543cb813eebd318() {
  self endon("quest_s0_act2_ended");
  self.vh_escort endon("death");
  n_start_health = self.vh_escort.health;
  var_d3f9d2fc8ac619b1 = 0;
  var_a905d9404522f094 = 0;
  var_239302032f4239a9 = 0;
  var_1570787437209b1a = 0;

  while(true) {
    self.vh_escort waittill("damage", idamage, eattacker, vdir, vpoint, smeansofdeath, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid);

    if(isDefined(eattacker) && isPlayer(eattacker) && isDefined(idamage)) {
      self.vh_escort.health += idamage;
      continue;
    }

    iprintlnbold(self.vh_escort.health);

    if(idamage > self.vh_escort.health && isDefined(self.vh_escort.attractor)) {
      a_empty = [];
      function_357609ca7ca5486e(self.vh_escort.attractor, a_empty);
      remove_attractor(self.vh_escort.attractor);
    }

    function_32df7454369064fb(self.vh_escort.health, n_start_health);

    if(self.vh_escort.health <= 0) {
      a_empty = [];
      function_357609ca7ca5486e(self.vh_escort.attractor, a_empty);
      remove_attractor(self.vh_escort.attractor);
      self.vh_escort scripts\cp_mp\vehicles\vehicle_damage::function_d0df49de517ded03();
      self.vh_escort scripts\cp_mp\vehicles\vehicle::vehicle_explode();
      break;
    }

    if(isDefined(vpoint)) {
      playsoundatpos(vpoint, "evt_ob_obj_acv_damage");
    }

    if(!var_a905d9404522f094 && self.vh_escort.health <= n_start_health * 0.759) {
      var_a905d9404522f094 = 1;
      self.vh_escort.vo_ent playsoundonmovingent("dx_ob_oesc_esca_acve_escacvhealth75");
    }

    if(!var_239302032f4239a9 && self.vh_escort.health <= n_start_health * 0.509) {
      var_239302032f4239a9 = 1;
      thread scripts\cp_mp\overlord::playevent("quest_s0_a2t6_escort_health_50", level.players);
      continue;
    }

    if(!var_1570787437209b1a && self.vh_escort.health <= n_start_health * 0.159) {
      var_1570787437209b1a = 1;
      thread scripts\cp_mp\overlord::playevent("quest_s0_a2t6_escort_health_15", level.players);
    }
  }
}

function function_a46548c342e333f7() {
  self endon("quest_s0_act2_ended");
  self endon("device_detonated");
  self.vh_escort waittill("death");
  thread scripts\cp_mp\overlord::playconversation("quest_s0_a2t6_escort_death", level.players, 0, 1);
  self.waskilled = 1;
  thread function_cb078cbf493f2b94();

  if(isDefined(self.vh_escort.payload)) {
    self.payload = self.vh_escort.payload;
    self.vh_escort.payload delete();
  }

  if(isDefined(self.var_82b17a28607ecace)) {
    self.var_82b17a28607ecace freescriptable();
    self.var_82b17a28607ecace notify("death");
  }

  if(isDefined(self.var_b0d934858b1288b6)) {
    self.var_b0d934858b1288b6 freescriptable();
    self.var_b0d934858b1288b6 notify("death");
  }

  if(isDefined(self.vh_escort.markerattach)) {
    self.vh_escort.markerattach delete();
  }

  wait 9;
  namespace_134d54e39331ee45::function_3b564213c8be506d();
}

function private function_cb078cbf493f2b94() {
  if(isDefined(self.vh_escort)) {
    if(isDefined(self.vh_escort.e_start)) {
      self.vh_escort.e_start delete();
    }

    if(isDefined(self.vh_escort.vo_ent)) {
      self.vh_escort.vo_ent delete();
    }

    if(isDefined(self.vh_escort.attractor)) {
      remove_attractor(self.vh_escort.attractor);
    }
  }
}

function private function_32df7454369064fb(currentvalue, totalvalue) {
  percentagecomplete = currentvalue / totalvalue * 100;
  n_percent = clamp(percentagecomplete, 0, 100);
  n_percent = int(n_percent);
  function_cd08026f9908f3d6(n_percent);
}

function function_cd08026f9908f3d6(n_percent) {
  foreach(player in level.players) {
    player setclientomnvar("ui_br_objective_progress_bar", n_percent);
    player setclientomnvar("ui_br_objective_param", n_percent);
  }
}

function private function_c619613f382927df(str_alias) {
  var_c5fd8d562611e0e4 = lookupsoundlength(str_alias);
  var_c5fd8d562611e0e4 = float(var_c5fd8d562611e0e4);
  var_c5fd8d562611e0e4 /= 1000;
  return var_c5fd8d562611e0e4;
}

function function_1282eec91da30219(attractor, zombie) {
  if(istrue(zombie.var_ed256e1ab4ed752)) {
    return 1;
  }

  if(isDefined(zombie.var_941802a0997e0c42) || istrue(zombie.var_d243a619c1894518)) {
    return 0;
  }

  if(isDefined(level.players)) {
    player = getclosest(zombie.origin, level.players, 3500);

    if(isDefined(player) && distance2dsquared(zombie.origin, player.origin) < distance2dsquared(zombie.origin, attractor.source.origin)) {
      return 0;
    }
  }

  if(isalive(zombie) && isDefined(attractor)) {
    return 1;
  }
}

function function_33a37dad0f5c6416(abom) {
  abom endon("death");
  self.vh_escort endon("death");
  abom.var_ac634d34ba9d701f = 0;

  while(true) {
    if(!isDefined(self.vh_escort)) {
      return;
    }

    if(isPlayer(abom.enemy)) {
      dist = distance2dsquared(abom.enemy.origin, self.vh_escort.origin);

      if(dist > 3062500) {
        abom.var_ed256e1ab4ed752 = 1;
        abom.var_ac634d34ba9d701f = gettime();
      } else if(dist < 3062500 && gettime() - abom.var_ac634d34ba9d701f > 6000) {
        abom.var_ed256e1ab4ed752 = 0;
      }
    }

    wait 0.25;
  }
}

function escort_interact(player) {
  if(!isPlayer(player)) {
    return;
  }

  if(istrue(player.inlaststand) || !isalive(player)) {
    return;
  }

  if(player isreloading() || player isgestureplaying()) {
    return;
  }

  player thread function_86953a5b59ac4e80(self);
}

function function_86953a5b59ac4e80(interact) {
  self setstance("stand");
  self freezecontrols(1);
  time = self getgestureanimlength("jup_ges_button_press_01");
  self forceplaygestureviewmodel("jup_ges_button_press_01");
  vehicle = interact getlinkedparent();
  wait time * 0.275;

  if(istrue(self.inlaststand) || !isalive(self)) {
    self freezecontrols(0);
    return;
  }

  vehicle setscriptablepartstate("screen", "on");
  vehicle setscriptablepartstate("button", "pressed");
  wait time * 0.25;
  self freezecontrols(0);
  interact notify("escort_started");
}

function function_df4c9a21b5873371() {
  self endon("death");
  s_goal = getStruct("quest_escort_p2p_start", "targetname");
  self addcomponent("p2p");
  self function_a7fac0397762d7a6("p2p", "manualSpeed", mph_to_ips(s_goal.script_speed));
  self function_a7fac0397762d7a6("p2p", "brakeAtGoal", 0);
  self function_a7fac0397762d7a6("p2p", "goalPoint", s_goal.origin);

  while(true) {
    if(isDefined(self.var_94d203388c9f2657)) {
      s_goal = self.var_94d203388c9f2657;
      self.var_94d203388c9f2657 = undefined;
    }

    if(isDefined(s_goal.target)) {
      s_goal = getStruct(s_goal.target, "targetname");
      self.var_b6e5d0ffc0c902d = s_goal;
      self function_a7fac0397762d7a6("p2p", "manualSpeed", mph_to_ips(s_goal.script_speed));
      self function_a7fac0397762d7a6("p2p", "brakeAtGoal", 0);
    }

    self function_a7fac0397762d7a6("p2p", "goalPoint", s_goal.origin);
    thread function_df5c996333f30a6b();
    self waittill("near_goal");

    if(!isDefined(s_goal.target) || is_equal(s_goal.script_noteworthy, "final_destination")) {
      self notify("reached_end_node");
      self.final_stop = 1;
      self function_a7fac0397762d7a6("p2p", "brakeAtGoal", 1);
      level notify("story_quest_complete_step_3");
      break;
    }

    if(is_equal(s_goal.script_noteworthy, "ambush_encounter_location")) {
      thread function_f1ad2aee4e5a3b2f(20);
      self.var_df433561007fc313 thread function_2e69383c6abc963b(s_goal.script_noteworthy);
      continue;
    }

    if(is_equal(s_goal.script_noteworthy, "merc_camp_encounter_location")) {
      self.var_df433561007fc313 thread function_e2c32c2fc7cbaa46(s_goal.script_noteworthy, 1);
      continue;
    }

    if(is_equal(s_goal.script_noteworthy, "zombified_camp_encounter_location")) {
      self.var_df433561007fc313 thread function_e2c32c2fc7cbaa46(s_goal.script_noteworthy);
      self.var_df433561007fc313 thread function_2e69383c6abc963b(s_goal.script_noteworthy);
      continue;
    }

    if(is_equal(s_goal.script_noteworthy, "abomination_encounter_location")) {
      self.var_df433561007fc313 thread function_2e69383c6abc963b(s_goal.script_noteworthy);
      continue;
    }

    if(isDefined(s_goal.script_noteworthy)) {
      s_event = self.var_df433561007fc313 function_970f611dc2e032db(s_goal.script_noteworthy);

      if(isDefined(s_event)) {
        self.var_df433561007fc313 thread function_a9241d4812148865(s_event);
      }

      self.var_df433561007fc313 thread function_fca9f3b49a578a92(s_goal.script_noteworthy);
    }
  }
}

function function_f1ad2aee4e5a3b2f(n_delay) {
  if(!isDefined(n_delay)) {
    n_delay = 0;
  }

  wait n_delay;
  thread scripts\cp_mp\overlord::playconversation("quest_s0_a2t6_mid_escort", level.players, 0, 1);
}

function function_df5c996333f30a6b() {
  self endon("near_goal");
  start_time = gettime();
  starting_origin = self.origin;

  while(true) {
    if(istrue(self.final_stop)) {
      return;
    }

    if(isDefined(self.var_b6e5d0ffc0c902d) && istrue(self.b_proximity)) {
      elapsed_time = gettime() - start_time;

      if(elapsed_time > 5000) {
        dist = distance2d(starting_origin, self.origin);

        if(dist < 10) {
          self.var_94d203388c9f2657 = self.var_b6e5d0ffc0c902d;
          self notify("near_goal");
        }
      }
    } else {
      start_time = gettime();
      starting_origin = self.origin;
    }

    wait 1;
  }
}

function function_bb0d7d2ab7bb1c6b() {
  self endon("quest_s0_act2_complete");
  self endon("quest_s0_act2_end");
  self.vh_escort endon("death");
  thread ambush_watcher();
  thread function_245c0fb75415e353();
  thread function_559b54ebd2c6d3f3();
  thread function_247102c154ae35dd();
  thread function_373589e7b9dfead7();
  thread function_a9425bec08296e0d("zombie_spawn_group_1");
  thread function_a9425bec08296e0d("zombie_spawn_group_2");
  thread function_a9425bec08296e0d("zombie_spawn_group_3");
  thread function_a9425bec08296e0d("zombie_spawn_group_4");
  thread function_764e9f6e76e35aab();
}

function ambush_watcher() {
  self endon("quest_s0_act2_complete");
  self endon("quest_s0_act2_end");
  self.vh_escort endon("death");
  self.vh_escort waittill("ambush_encounter_location");
  thread function_f1ad2aee4e5a3b2f(20);
  thread function_2e69383c6abc963b("ambush_encounter_location");
}

function function_245c0fb75415e353() {
  self endon("quest_s0_act2_complete");
  self endon("quest_s0_act2_end");
  self.vh_escort endon("death");
  self.vh_escort waittill("merc_camp_encounter_location");
  thread function_e2c32c2fc7cbaa46("merc_camp_encounter_location", 1);
}

function function_559b54ebd2c6d3f3() {
  self endon("quest_s0_act2_complete");
  self endon("quest_s0_act2_end");
  self.vh_escort endon("death");
  self.vh_escort waittill("zombified_camp_encounter_location");
  thread function_e2c32c2fc7cbaa46("zombified_camp_encounter_location");
  thread function_2e69383c6abc963b("zombified_camp_encounter_location");
}

function function_247102c154ae35dd() {
  self endon("quest_s0_act2_complete");
  self endon("quest_s0_act2_end");
  self.vh_escort endon("death");
  self.vh_escort waittill("abomination_encounter_location");
  thread function_2e69383c6abc963b("abomination_encounter_location");
}

function function_373589e7b9dfead7() {
  if(!isarray(self.escort_path_events)) {
    return;
  }

  foreach(s_event in self.escort_path_events) {
    thread event_watcher(s_event.targetname);
  }
}

function event_watcher(var_3d5033905ec1ebff) {
  self endon("quest_s0_act2_complete");
  self endon("quest_s0_act2_end");
  self.vh_escort endon("death");
  self.vh_escort waittill(var_3d5033905ec1ebff);
  s_event = function_970f611dc2e032db(var_3d5033905ec1ebff);

  if(isDefined(s_event)) {
    thread function_a9241d4812148865(s_event);
  }

  thread function_fca9f3b49a578a92(var_3d5033905ec1ebff);
}

function function_a9425bec08296e0d(group_name) {
  self endon("quest_s0_act2_complete");
  self endon("quest_s0_act2_end");
  self.vh_escort endon("death");
  self.vh_escort waittill(group_name);
  thread function_fca9f3b49a578a92(group_name);
}

function function_764e9f6e76e35aab() {
  self endon("quest_s0_act2_complete");
  self endon("quest_s0_act2_end");
  self.vh_escort endon("death");
  self.vh_escort waittill("final_destination");
  self.vh_escort notify("reached_end_node");
  self.vh_escort.final_stop = 1;
  level notify("story_quest_complete_step_3");
}

function function_97e82918ce08c384() {
  self endon("quest_s0_act2_complete");
  self endon("quest_s0_act2_end");
  waitframe();
  self.vh_escort.markerattach = spawn("script_model", self.vh_escort.origin);
  self.vh_escort.markerattach.team = "neutral";
  self.vh_escort.markerattach linkTo(self.vh_escort, "tag_control_panel_door_lower_animate", (0, -7.5, 0), (0, 90, 0));
  self.var_d524faad28ac9c20 = scripts\mp\objidpoolmanager::requestobjectiveid(0);
  scripts\mp\objidpoolmanager::objective_add_objective(self.var_d524faad28ac9c20, "active");
  var_154a0c69b64b56f6 = self.vh_escort.origin;
  self.nd_spline_start = function_a833053c48e37c08();

  if(isDefined(self.nd_spline_start)) {
    var_154a0c69b64b56f6 = self.nd_spline_start.origin;
  } else if(isDefined(self.p2p_start)) {
    var_154a0c69b64b56f6 = self.p2p_start.origin;
  }

  scripts\mp\objidpoolmanager::objective_set_play_intro(self.var_d524faad28ac9c20, 0);
  scripts\mp\objidpoolmanager::objective_set_play_outro(self.var_d524faad28ac9c20, 0);
  scripts\mp\objidpoolmanager::objective_add_objective(self.var_d524faad28ac9c20, "current");
  scripts\mp\objidpoolmanager::update_objective_icon(self.var_d524faad28ac9c20, "jup_ui_map_icon_generic_marker");
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.var_d524faad28ac9c20);
  scripts\mp\objidpoolmanager::update_objective_position(self.var_d524faad28ac9c20, var_154a0c69b64b56f6 + (0, 0, 24));
  scripts\mp\objidpoolmanager::update_objective_onentity(self.var_d524faad28ac9c20, self.vh_escort.markerattach);
  scripts\mp\objidpoolmanager::update_objective_setbackground(self.var_d524faad28ac9c20, 1);
  objective_settint(self.var_d524faad28ac9c20, 195, 239, 158);
}

function function_2e69383c6abc963b(location_noteworthy) {
  s_location = getStruct(location_noteworthy, "targetname");

  if(isDefined(s_location)) {
    function_1b4d007c48f6440d(s_location, undefined, 1, 0.1);
  }
}

function function_e2c32c2fc7cbaa46(location_noteworthy, var_a44c9d2580138d8d) {
  if(!isDefined(var_a44c9d2580138d8d)) {
    var_a44c9d2580138d8d = 0;
  }

  s_location = getStruct(location_noteworthy, "targetname");
  var_36bfaa6d1617a83b = getStructArray("ai_goal", "targetname");
  var_f83db8d7f8c4654c = [];

  foreach(s_goal in var_36bfaa6d1617a83b) {
    if(is_equal(s_goal.target, s_location.targetname)) {
      var_f83db8d7f8c4654c = array_add(var_f83db8d7f8c4654c, s_goal);
    }
  }

  if(istrue(var_a44c9d2580138d8d)) {
    var_2b4364d8d93a45b9 = getStructArray("merc_camp_encounter_location_merc_chopper", "targetname");
    thread function_804aa1cbd49ba400(var_2b4364d8d93a45b9);
  }

  thread function_d1ce7548ed380171(s_location);
  self.var_865c65851de2f738 = getStructArray("sentry_spawn", "targetname");

  foreach(sentry_struct in self.var_865c65851de2f738) {
    if(is_equal(sentry_struct.target, s_location.targetname)) {}
  }
}

function function_fca9f3b49a578a92(location_noteworthy) {
  var_19f37b5b125ffe11 = getStruct("escort_path_spawning", "targetname");
  a_spawner_structs = getStructArray(location_noteworthy, "targetname");

  if(a_spawner_structs.size > 0 && isDefined(var_19f37b5b125ffe11)) {
    thread spawn_zombie_group(a_spawner_structs, var_19f37b5b125ffe11, 1, 0.2);
  }
}

function private function_9c9e518280bea222(activity_instance) {
  self endon("death");
  self endon("reached_end_node");

  while(true) {
    wait 30;
    self waittill("no_escorts");

    if(isDefined(self.vo_ent)) {
      self.vo_ent playsoundonmovingent("dx_ob_oesc_esca_acve_escnoescortsinrange");
    }
  }
}

function function_2e0dc001c9a5c661() {
  var_d08f3ac86be7ae9e = getStructArray("map_transition_to_act2", "targetname");
  self.var_a5016e4b6acfea47 = [];
  level waittill("prematch_done");
  thread function_a49ca0a80cb63664();

  foreach(s_exfil in var_d08f3ac86be7ae9e) {
    s_exfil.var_d182b8d3f3aaa93b = scripts\cp_mp\content_manager::spawn_script_model(s_exfil, "ob_quest_exfil_site_xmodel", 1, 1);
    s_exfil.var_d182b8d3f3aaa93b setscriptablepartstate("ob_quest_exfil_site", "standby");
    s_exfil.var_d182b8d3f3aaa93b setscriptablepartstate("ob_quest_exfil_icon", "default_icon");
    s_exfil.var_d182b8d3f3aaa93b setscriptablepartstate("ob_quest_exfil_smoke", "smoking");
    self.var_a5016e4b6acfea47[self.var_a5016e4b6acfea47.size] = s_exfil.var_d182b8d3f3aaa93b;
    s_exfil.var_d182b8d3f3aaa93b.interact = scripts\cp_mp\interaction::register_interact(s_exfil.var_d182b8d3f3aaa93b, 120, &function_a1778cdfcc8373ae, &"JUP_OB_OBJECTIVES/QUEST_0_ACT2_EXFIL_INTERACT");
    s_exfil.var_d182b8d3f3aaa93b.interact sethintonobstruction("show");
    s_exfil thread function_e3ba83b1bb428b8e();
  }

  level flag_wait("exfil_to_s0_act_2");

  foreach(s_exfil in var_d08f3ac86be7ae9e) {
    if(isDefined(s_exfil.n_obj_id)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(s_exfil.n_obj_id);
      s_exfil.n_obj_id = undefined;
    }
  }
}

function function_a49ca0a80cb63664() {
  level flag_wait("exfil_to_s0_act_2");
  wait 1;

  foreach(var_d182b8d3f3aaa93b in self.var_a5016e4b6acfea47) {
    if(isDefined(var_d182b8d3f3aaa93b) && isDefined(var_d182b8d3f3aaa93b.interact)) {
      var_d182b8d3f3aaa93b.interact delete();
    }

    if(isDefined(var_d182b8d3f3aaa93b)) {
      var_d182b8d3f3aaa93b delete();
    }
  }
}

function function_e3ba83b1bb428b8e() {
  self.n_obj_id = scripts\mp\objidpoolmanager::requestobjectiveid(1);
  scripts\mp\objidpoolmanager::objective_add_objective(self.n_obj_id, "invisible", self.var_d182b8d3f3aaa93b.origin, "ui_map_icon_ob_quest_exfil", "icon_small");
  scripts\mp\objidpoolmanager::update_objective_onentity(self.n_obj_id, self.var_d182b8d3f3aaa93b);
  scripts\mp\objidpoolmanager::function_c3c6bff089dfdd34(self.n_obj_id, "icon_regular");
  objective_setlabel(self.n_obj_id, &"SHARED_HINTSTRINGS/EXFIL");
  objective_setplayintro(self.n_obj_id, 0);
}

function function_a1778cdfcc8373ae(player) {
  self function_dfb78b3e724ad620(0);

  if(isDefined(level.var_d8b6115a502e7e76)) {
    if(!self[[level.var_d8b6115a502e7e76]](player)) {
      self playsoundtoplayer("ui_zm_core_door_purchase_deny", player);
      return;
    }
  }

  level flag_set("exfil_nuclear");
  level thread map_transition();
  level flag_set("exfil_to_s0_act_2");
  self delete();
}

function defend_begin() {
  function_459b11a053734e1("start");
  setmusicstate("");
  thread scripts\cp_mp\overlord::playconversation("quest_s0_a2t6_defend_arrival", level.players, 0, 1);
  self.vh_escort setscriptablepartstate("beacon_light", "off");
  self.vh_escort setscriptablepartstate("headlight_left", "off");
  self.vh_escort setscriptablepartstate("headlight_right", "off");
  function_6ec87531a2f50abb();
}

function function_6ec87531a2f50abb() {
  if(isDefined(self.var_b0d934858b1288b6)) {
    return;
  }

  objective_setlabel(self.var_d524faad28ac9c20, &"JUP_OB_OBJECTIVES/QUEST_0_ACT2_DEFEND_ACTIVATE_MARKER_LABEL");
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.var_d524faad28ac9c20, 1);
  scripts\mp\objidpoolmanager::objective_set_pulsate(self.var_d524faad28ac9c20, 1);
  scripts\mp\objidpoolmanager::update_objective_state(self.var_d524faad28ac9c20, "invisible");
  waitframe();
  scripts\mp\objidpoolmanager::update_objective_state(self.var_d524faad28ac9c20, "current");
  interact_origin = self.vh_escort gettagorigin("tag_attach_rocket");
  self.var_b0d934858b1288b6 = spawnscriptable("ob_hacking_device_s0_act2_defend", interact_origin);
  self.var_b0d934858b1288b6.var_df433561007fc313 = self;
  namespace_29b5250e9959ea::function_3cec1b2981075936("jup_hacking_device_ob", self.var_b0d934858b1288b6, &function_c5a6850e8e01e061);
  self.vh_escort.markerattach unlink();
  self.vh_escort.markerattach linkTo(self.vh_escort, "tag_attach_rocket", (-40, 0, 48), (0, 0, 0));
  thread function_f5c999e269f92619("defend_start");
}

function function_c5a6850e8e01e061(player) {
  if(!isPlayer(player)) {
    return;
  }

  if(istrue(player.inlaststand) || !isalive(player)) {
    return;
  }

  if(player isreloading() || player isgestureplaying()) {
    return;
  }

  self.var_df433561007fc313 thread defend_start();
  self freescriptable();
  self notify("death");
}

function defend_start() {
  self endon("quest_s0_act2_ended");
  level endon("game_ended");

  if(istrue(self.defend_active)) {
    return;
  }

  self.defend_active = 1;
  setmusicstate("mx_jup_ob_worldboss_2");
  self notify("defend_start");
  earthquake(0.175, 0.4, self.vh_escort.origin, 1000);
  playrumbleonposition("grenade_rumble", self.vh_escort.origin);

  if(isDefined(self.vh_escort)) {
    self.vh_escort setscriptablepartstate("rear_light", "off");
  }

  thread scripts\cp_mp\overlord::playconversation("quest_s0_a2t6_defend_start", level.players, 0, 1);
  thread function_7e2f20c8a0e38e9c();
  thread defend_watcher();
}

function defend_watcher() {
  self endon("quest_s0_act2_ended");
  self.vh_escort endon("death");
  level endon("game_ended");
  self.var_e504d983a6aa7dc2 = gettime();
  thread function_3af116a208317db7();
  thread function_dcda77c686a22dbc();
  thread function_6d38ce46ef394070();
  scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.var_d524faad28ac9c20);
  function_459b11a053734e1("defend");
  thread function_b255f185e2c06ed4();
  defend_time = default_to(getdvarint(@ "hash_f156147cb46669c3", 60), 60);
  wait defend_time;
  objective_setlabel(self.var_d524faad28ac9c20, &"JUP_OB_OBJECTIVES/QUEST_0_ACT2_DEFEND_DETONATE_MARKER_LABEL");
  scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.var_d524faad28ac9c20);
  scripts\mp\objidpoolmanager::objective_set_play_intro(self.var_d524faad28ac9c20, 1);
  scripts\mp\objidpoolmanager::objective_set_pulsate(self.var_d524faad28ac9c20, 1);
  scripts\mp\objidpoolmanager::update_objective_state(self.var_d524faad28ac9c20, "invisible");
  waitframe();
  scripts\mp\objidpoolmanager::update_objective_state(self.var_d524faad28ac9c20, "current");
  self.var_f1271465f4a6a4f9 = gettime();
  function_459b11a053734e1("detonate");
  self.var_8bfc6c5f7610e1ec = gettime();
  thread scripts\cp_mp\overlord::playevent("quest_s0_a2t6_complete", level.players);
  self.var_722b949c50154560 = 1;
  function_f3261744da978d4f();
  thread function_a871bbfb76af397d();
}

function function_6d38ce46ef394070() {
  self endon("quest_s0_act2_ended");
  level endon("story_quest_complete_step_4");

  while(true) {
    if(!isDefined(self.vh_escort)) {
      return;
    }

    elapsed_time = (gettime() - self.var_e504d983a6aa7dc2) / 1000;
    var_d8ef071103d43ca7 = elapsed_time / 60 * 100;
    var_b1ddab7718607d5 = 0.07;

    if(var_d8ef071103d43ca7 > 33 && var_d8ef071103d43ca7 < 66) {
      var_b1ddab7718607d5 = 0.0875;
    } else if(var_d8ef071103d43ca7 > 66) {
      var_b1ddab7718607d5 = 0.12;
    }

    earthquake(var_b1ddab7718607d5, 0.1, self.vh_escort.origin, 750);
    wait 0.1;
  }
}

function function_f3261744da978d4f() {
  interact_origin = self.vh_escort gettagorigin("tag_attach_rocket");
  self.var_82b17a28607ecace = spawnscriptable("ob_hacking_device_s0_act2_detonate", interact_origin);
  self.var_82b17a28607ecace.var_df433561007fc313 = self;
  namespace_29b5250e9959ea::function_3cec1b2981075936("jup_hacking_device_ob", self.var_82b17a28607ecace, &function_25b874eb128890a1);
  self.var_785101daa1fc6003 = gettime();
  self.vh_escort.markerattach unlink();
  self.vh_escort.markerattach linkTo(self.vh_escort, "tag_attach_rocket", (-40, 0, 48), (0, 0, 0));
  thread function_f5c999e269f92619("device_detonated");
}

function function_25b874eb128890a1(player) {
  if(!isPlayer(player)) {
    return;
  }

  if(istrue(player.inlaststand) || !isalive(player)) {
    return;
  }

  if(player isreloading() || player isgestureplaying()) {
    return;
  }

  self.var_df433561007fc313 notify("device_detonated");

  if(isDefined(self.var_df433561007fc313.vh_escort)) {
    self.var_df433561007fc313.vh_escort setscriptablepartstate("rear_light", "launch");
  }

  self.var_df433561007fc313 thread function_169f90fd59c5fe78();
  self freescriptable();
  self notify("death");
}

function function_a871bbfb76af397d() {
  self endon("device_detonated");
  self.vh_escort endon("death");

  while(true) {
    if(isDefined(self.var_785101daa1fc6003)) {
      elapsed_time = (gettime() - self.var_785101daa1fc6003) / 1000;

      if(elapsed_time > 180) {
        thread function_169f90fd59c5fe78();
        self.var_82b17a28607ecace freescriptable();
        self.var_82b17a28607ecace notify("death");
        return;
      }
    }

    if(isDefined(self.var_8bfc6c5f7610e1ec)) {
      elapsed_time = (gettime() - self.var_8bfc6c5f7610e1ec) / 1000;

      if(elapsed_time > 30) {
        self.var_8bfc6c5f7610e1ec = gettime();
        thread scripts\cp_mp\overlord::playevent("quest_s0_a2t6_complete", level.players);
      }
    }

    if(isDefined(self.var_f1271465f4a6a4f9)) {
      elapsed_time = (gettime() - self.var_f1271465f4a6a4f9) / 1000;

      if(elapsed_time > 30) {
        self.var_f1271465f4a6a4f9 = gettime();
        scripts\mp\objidpoolmanager::objective_playermask_hidefromall(self.var_d524faad28ac9c20);
        waitframe();
        scripts\mp\objidpoolmanager::objective_playermask_showtoall(self.var_d524faad28ac9c20);
        scripts\mp\objidpoolmanager::objective_set_play_intro(self.var_d524faad28ac9c20, 1);
        scripts\mp\objidpoolmanager::objective_set_pulsate(self.var_d524faad28ac9c20, 1);
      }
    }

    wait 1;
  }
}

function function_b255f185e2c06ed4() {
  self.var_5a7e0e43ccdc431f = getStruct("defend_location", "targetname");
  self.var_5a7e0e43ccdc431f.var_216bc1fde948c1a3 = getStruct("defend_zombie_wave", "targetname");
  var_67fc9f2155bccd5e = getStructArray("zombie_wave_spawn", "targetname");
  var_d98d45929ffbb835 = [];

  foreach(s_zombie_spawn in var_67fc9f2155bccd5e) {
    if(is_equal(s_zombie_spawn.target, self.var_5a7e0e43ccdc431f.var_216bc1fde948c1a3.targetname)) {
      var_d98d45929ffbb835 = array_add(var_d98d45929ffbb835, s_zombie_spawn);
    }
  }

  self.var_5a7e0e43ccdc431f.var_216bc1fde948c1a3.max_active = 8;
  self.var_5a7e0e43ccdc431f.var_216bc1fde948c1a3.time_between_spawns = 0.2;
  self.var_5a7e0e43ccdc431f.var_216bc1fde948c1a3.a_spawn_structs = var_d98d45929ffbb835;
  thread function_c4ca28aac25522a2(self.var_5a7e0e43ccdc431f.var_216bc1fde948c1a3);
}

function function_3af116a208317db7() {
  self endon("quest_s0_act2_ended");

  if(!isDefined(self.vh_escort)) {
    return;
  }

  self.vh_escort endon("death");

  if(!isDefined(self.vh_escort.payload)) {
    return;
  }

  self.vh_escort.payload.charge_state = 0;
  self.vh_escort.payload setscriptablepartstate("body", "initiate");
  wait 1.5;

  while(true) {
    if(!isDefined(self.var_e504d983a6aa7dc2)) {
      continue;
    }

    elapsed_time = (gettime() - self.var_e504d983a6aa7dc2) / 1000;
    completion_percent = elapsed_time / 60 * 100;

    if(is_equal(self.vh_escort.payload.charge_state, 0)) {
      self.vh_escort.payload.charge_state = 1;
      self.vh_escort.payload setscriptablepartstate("charge", "charge_state_1");
    } else if(completion_percent > 33 && completion_percent < 66 && is_equal(self.vh_escort.payload.charge_state, 1)) {
      self.vh_escort.payload.charge_state = 2;
      self.vh_escort.payload setscriptablepartstate("charge", "charge_state_2");
    } else if(completion_percent > 66 && completion_percent < 99 && is_equal(self.vh_escort.payload.charge_state, 2)) {
      self.vh_escort.payload.charge_state = 3;
      self.vh_escort.payload setscriptablepartstate("charge", "charge_state_3");
    } else if(completion_percent > 99 && is_equal(self.vh_escort.payload.charge_state, 3)) {
      self.vh_escort.payload.charge_state = 4;
      self.vh_escort.payload setscriptablepartstate("charge", "charge_state_4");
      return;
    }

    wait 1;
  }
}

function function_7e2f20c8a0e38e9c() {
  self endon("quest_s0_act2_ended");
  level endon("story_quest_complete_step_4");
  self.vh_escort endon("death");
  self.vh_escort.nearby_players = [];

  while(true) {
    self.vh_escort.nearby_players = scripts\mp\utility\player::getplayersinradius(self.vh_escort.origin, 450);

    foreach(player in self.vh_escort.nearby_players) {
      if(!istrue(self.var_e6fec6c76ff0c39f)) {
        player thread function_6b84ce5557affd27(self);
      }
    }

    wait 0.5;
  }
}

function function_6b84ce5557affd27(var_54492f7bf0674200) {
  self endon("death");
  self endon("disconnect");
  self playrumblelooponentity("damage_light");

  while(true) {
    if(isarray(var_54492f7bf0674200.vh_escort.nearby_players) && array_contains(var_54492f7bf0674200.vh_escort.nearby_players, self) && !istrue(var_54492f7bf0674200.var_99626a64c1275340)) {
      self.var_e6fec6c76ff0c39f = 1;
      wait 0.1;
      continue;
    }

    self stoprumble("damage_light");
    self.var_e6fec6c76ff0c39f = undefined;
    return;
  }
}

function function_169f90fd59c5fe78() {
  thread function_3ec05a7bf5c377ef();
  scripts\mp\objidpoolmanager::returnobjectiveid(self.var_d524faad28ac9c20);
  var_3bd6f565bc3ff6f7 = self.vh_escort gettagorigin("tag_attach_rocket");
  var_903f82ea21cc311f = var_3bd6f565bc3ff6f7 + (0, 0, 128);
  playFXOnTag(level._effect["lightning_strike_origin_loop"], self.vh_escort.payload, "tag_origin");
  self.vh_escort.payload playsoundevent("sndevent_act2_transition_to_igc");
  thread function_a0f338ea39fbf73a(var_903f82ea21cc311f, 400, 1);
  thread device_explosion();
  earthquake(0.275, 0.5, self.vh_escort.origin, 1750);
  playrumbleonposition("grenade_rumble", self.vh_escort.origin);
  wait 1.5;
  thread function_a0f338ea39fbf73a(var_903f82ea21cc311f, 300, 1);
  earthquake(0.275, 0.5, self.vh_escort.origin, 1750);
  playrumbleonposition("grenade_rumble", self.vh_escort.origin);
  wait 1.35;
  playFXOnTag(level._effect["neutralizer_explosion"], self.vh_escort.payload, "tag_origin");
  earthquake(0.275, 0.5, self.vh_escort.origin, 1750);
  playrumbleonposition("grenade_rumble", self.vh_escort.origin);
  wait 0.15;
  thread quest_complete();
  thread function_a0f338ea39fbf73a(var_903f82ea21cc311f, 150, 1);
  thread function_1de7b72c15891a94();
  wait 0.5;
}

function function_dcda77c686a22dbc() {
  self endon("quest_s0_act2_ended");
  self endon("device_detonated");
  self.vh_escort endon("death");
  var_3bd6f565bc3ff6f7 = self.vh_escort gettagorigin("tag_attach_rocket");
  up_angles = vectorNormalize(anglestoup(self.vh_escort gettagangles("tag_attach_rocket")));
  var_903f82ea21cc311f = var_3bd6f565bc3ff6f7 + up_angles * 152;
  self.var_a65ff8abf8d244a2 = spawn_model("tag_origin", var_903f82ea21cc311f);
  self.var_a65ff8abf8d244a2 forcenetfieldhighlod_sharedfunc(1);
  self.var_2c323a01b507a66b = spawn_model("tag_origin", var_903f82ea21cc311f);
  self.var_2c323a01b507a66b forcenetfieldhighlod_sharedfunc(1);
  waitframe();
  search_radius = 1000;
  wait 3;
  wait_time = 5;
  full_strike = 0;
  target_zombies = 0;
  var_42a8f237c5ff3bda = [];
  zombie_target = undefined;

  while(true) {
    elapsed_time = (gettime() - self.var_e504d983a6aa7dc2) / 1000;
    var_d8ef071103d43ca7 = elapsed_time / 60 * 100;

    if(var_d8ef071103d43ca7 > 0 && var_d8ef071103d43ca7 < 20) {
      wait_time = 5;
    } else if(var_d8ef071103d43ca7 >= 20 && var_d8ef071103d43ca7 < 40) {
      wait_time = 2.5;
    } else if(var_d8ef071103d43ca7 >= 40 && var_d8ef071103d43ca7 < 60) {
      wait_time = 1.5;
    } else if(var_d8ef071103d43ca7 >= 60 && var_d8ef071103d43ca7 < 90) {
      wait_time = 1;
    } else if(var_d8ef071103d43ca7 > 95) {
      wait_time = 0.375;
      target_zombies = percent_chance(45);
    }

    if(var_d8ef071103d43ca7 >= 75) {
      full_strike = 1;
    }

    if(istrue(target_zombies)) {
      var_42a8f237c5ff3bda = getaiarrayinradius(self.vh_escort.origin, search_radius, "team_two_hundred");

      if(var_42a8f237c5ff3bda.size > 0) {
        zombie_target = array_random(var_42a8f237c5ff3bda);

        if(istrue(zombie_target.var_20bed26d985c0b63)) {
          zombie_target = undefined;
        }
      }
    }

    thread lightning_strike(var_903f82ea21cc311f, search_radius, full_strike, zombie_target);
    wait wait_time;
  }
}

function function_a0f338ea39fbf73a(var_903f82ea21cc311f, search_radius, full_strike) {
  if(!isDefined(full_strike)) {
    full_strike = 0;
  }

  a_structs = function_9c6ba52445fdb1c(var_903f82ea21cc311f, search_radius, 1);

  foreach(strike_struct in a_structs) {
    thread lightning_strike(strike_struct.origin, search_radius, full_strike);
    wait 0.05;
  }
}

function lightning_strike(var_903f82ea21cc311f, search_radius, full_strike, zombie_target) {
  if(!isDefined(full_strike)) {
    full_strike = 0;
  }

  self endon("quest_s0_act2_ended");

  if(!isDefined(var_903f82ea21cc311f) || !isalive(self.vh_escort) || !isDefined(self.vh_escort.payload)) {
    return;
  }

  if(istrue(full_strike)) {
    var_5f46f69e474af537 = level._effect["lightning_strike_origin"];
    var_da2c1bb46bac2a2f = level._effect["lightning_strike"];
  } else {
    var_5f46f69e474af537 = level._effect["lightning_strike_origin_weak"];
    var_da2c1bb46bac2a2f = level._effect["lightning_strike_weak"];
  }

  radius_origin = getgroundposition(var_903f82ea21cc311f, 1);
  var_7ac7072a56b6862a = getrandomnavpoint(radius_origin, search_radius);

  if(isalive(zombie_target) && isDefined(zombie_target.model) && hastag(zombie_target.model, "j_spinelower")) {
    var_7ac7072a56b6862a = zombie_target gettagorigin("j_spinelower");
  }

  if(!isDefined(var_7ac7072a56b6862a)) {
    return;
  }

  self.var_a65ff8abf8d244a2.origin = var_7ac7072a56b6862a;
  waitframe();
  self.vh_escort.payload setscriptablepartstate("audio_impact", "impact_hit");
  playFXOnTag(var_5f46f69e474af537, self.vh_escort.payload, "tag_origin");
  waitframe();
  self.var_220c88e614c503dd = playfxontagsbetweenclients(var_da2c1bb46bac2a2f, self.var_2c323a01b507a66b, "tag_origin", self.var_a65ff8abf8d244a2, "tag_origin");
  self.var_220c88e614c503dd forcenetfieldhighlod_sharedfunc(1);
  self.var_220c88e614c503dd thread function_c6f6d1db0ba45c61();
  impact_angle = vectortoangles(var_7ac7072a56b6862a - var_903f82ea21cc311f);
  playFX(level._effect["lightning_strike_impact"], var_7ac7072a56b6862a, impact_angle);

  if(isalive(zombie_target)) {
    zombie_target.forceannihilate = 1;
    zombie_target kill();
  }

  a_ai_zombies = getaiarrayinradius(var_7ac7072a56b6862a, 32, "team_two_hundred");

  foreach(zombie in a_ai_zombies) {
    if(isalive(zombie)) {
      thread function_e199f62146443082(zombie);
    }
  }

  var_c41ff3df2633113b = getaiarrayinradius(var_7ac7072a56b6862a, 32, "team_hundred_ninety");

  foreach(soldier in var_c41ff3df2633113b) {
    thread function_31f4489d7f9865e2(soldier);
  }
}

function function_c6f6d1db0ba45c61() {
  wait 0.25;
  self delete();
}

function function_3ec05a7bf5c377ef() {
  var_c020246f882e51c0 = getentitylessscriptablearray("mp_jup_st_a_ob_quest_set_dressing", "targetname", self.vh_escort.origin, 2500);
  self.var_fb417bc0dea611fe = [];
  self.var_e11397c8e293578 = [];
  var_ebaf39cc98e192f0 = [];
  var_e7b3921421aa9e7d = 5;

  foreach(crystal in var_c020246f882e51c0) {
    var_3164ab88b1205ec7 = spawn_model("tag_origin", crystal.origin + (0, 0, 48));
    var_ebaf39cc98e192f0 = array_add(var_ebaf39cc98e192f0, var_3164ab88b1205ec7);
    crystal.var_3164ab88b1205ec7 = var_3164ab88b1205ec7;
    self.var_fb417bc0dea611fe = array_add(self.var_fb417bc0dea611fe, crystal);

    if(var_ebaf39cc98e192f0.size >= var_e7b3921421aa9e7d) {
      break;
    }
  }

  foreach(var_3164ab88b1205ec7 in var_ebaf39cc98e192f0) {
    lightning_ent = playfxontagsbetweenclients(level._effect["lightning_strike"], self.var_2c323a01b507a66b, "tag_origin", var_3164ab88b1205ec7, "tag_origin");
    lightning_ent forcenetfieldhighlod_sharedfunc(1);
    var_3164ab88b1205ec7.lightning_ent = lightning_ent;
    impact_angle = vectortoangles(var_3164ab88b1205ec7.origin - self.var_2c323a01b507a66b.origin);
    normalized_dir = vectorNormalize(var_3164ab88b1205ec7.origin - self.var_2c323a01b507a66b.origin);
    lightning_ent thread function_dd594ef572ab279(var_3164ab88b1205ec7.origin - 38 * normalized_dir, impact_angle);
    self.var_e11397c8e293578 = array_add(self.var_e11397c8e293578, lightning_ent);
  }
}

function function_dd594ef572ab279(impact_location, impact_angles) {
  self endon("death");

  while(true) {
    playFX(level._effect["lightning_strike_impact"], impact_location, impact_angles);
    wait 0.5;
  }
}

function function_1de7b72c15891a94() {
  foreach(crystal in self.var_fb417bc0dea611fe) {
    if(crystal getscriptableparthasstate("body", "jup_zm_phase_crystal_floor_destroy")) {
      crystal setscriptablepartstate("body", "jup_zm_phase_crystal_floor_destroy");
    }

    if(isDefined(crystal.var_3164ab88b1205ec7) && isDefined(crystal.var_3164ab88b1205ec7.lightning_ent)) {
      crystal.var_3164ab88b1205ec7.lightning_ent delete();
      crystal.var_3164ab88b1205ec7 delete();
    }

    wait 0.1;
  }
}

function function_9c6ba52445fdb1c(center_origin, n_radius, var_cd00b21daa6ae0b4) {
  a_s_spawnpts = [];
  valid_points = [];
  var_5ac1024b00cecc71 = (0, 0, 48);
  i = 0;

  while(i < 360) {
    x1 = n_radius * cos(i * 57.2958);
    y1 = n_radius * sin(i * 57.2958);
    check_pt = center_origin + (x1, y1, 0);
    pos_on_navmesh = getclosestpointonnavmesh(check_pt);

    if(isDefined(pos_on_navmesh)) {
      bsight = scripts\engine\trace::ray_trace_passed(center_origin + var_5ac1024b00cecc71, pos_on_navmesh + var_5ac1024b00cecc71, level.players);

      if(istrue(bsight)) {
        valid_points[valid_points.size] = pos_on_navmesh;
      }
    }

    i += 45;
  }

  if(is_equal(valid_points.size, 0)) {
    pos_on_navmesh = getclosestpointonnavmesh(center_origin);
    valid_points[valid_points.size] = pos_on_navmesh;
  }

  for(i = 0; i < valid_points.size; i++) {
    s_spot = spawnStruct();
    s_spot.origin = valid_points[i];
    s_spot.angles = (0, 0, 0);
    a_s_spawnpts[a_s_spawnpts.size] = s_spot;
  }

  if(istrue(var_cd00b21daa6ae0b4)) {
    return a_s_spawnpts;
  }

  rand_index = randomintrange(0, a_s_spawnpts.size);
  return a_s_spawnpts[rand_index];
}

function function_31f4489d7f9865e2(victim, inflictor) {
  firstshock = gettime() > victim._blackboard.var_dc51d4ea36da3ae1 + 1;
  victim._blackboard.var_dc51d4ea36da3ae1 = gettime();

  if(victim asmhaspainstate(victim.asmname) && firstshock) {
    victim asmevalpaintransition(victim.asmname);
  }

  victim setscriptablepartstate("shockStickVfx", "vfx_start", 0);
  victim dodamage(1, victim.origin, inflictor, inflictor);
  wait 1;

  if(isDefined(victim)) {
    victim setscriptablepartstate("shockStickVfx", "off", 0);
  }
}

function function_e199f62146443082(victim) {
  victim namespace_ed7c38f3847343dc::stun_ai(1);

  if(!victim getscriptablehaspart("shockStickVfx")) {
    return;
  }

  if(!victim getscriptableparthasstate("shockStickVfx", "vfx_start") || !victim getscriptableparthasstate("shockStickVfx", "off")) {
    return;
  }

  victim setscriptablepartstate("shockStickVfx", "vfx_start");
  wait 1;

  if(isalive(victim) && victim getscriptableparthasstate("shockStickVfx", "off")) {
    victim setscriptablepartstate("shockStickVfx", "off");
  }
}

function function_d1ce7548ed380171(s_location, goal) {
  var_73f5a8fe44a61415 = getStructArray("merc_spawn", "targetname");
  s_location.a_mercs = default_to(s_location.a_mercs, []);

  foreach(var_5883a55f39da8c48 in var_73f5a8fe44a61415) {
    if(isDefined(s_location) && !is_equal(var_5883a55f39da8c48.target, s_location.targetname)) {
      continue;
    }

    var_5502d8fb5a3b1365 = function_70a6287c1cf8575a(var_5883a55f39da8c48);

    if(isDefined(var_5502d8fb5a3b1365)) {
      merc_ai = var_5883a55f39da8c48 merc_spawn(var_5502d8fb5a3b1365);
      s_location.a_mercs = array_add(s_location.a_mercs, merc_ai);

      if(isDefined(s_location) && is_equal(s_location.targetname, "fortified_building_roof")) {
        merc_ai val::set("roof_mercs", "ignoreall", 1);
      }

      if(is_equal(var_5502d8fb5a3b1365, self.var_5f9a84079974ac46["sniper"])) {
        merc_ai thread behavior_guard(var_5883a55f39da8c48.origin);
      }
    }
  }

  var_2017958930cd9f59 = getStructArray("merc_spawn_group", "targetname");
  thread spawn_merc_group(var_2017958930cd9f59, s_location, 0, 0.2, goal);
  var_ec790ba1c195fbdd = getStructArray("specialist_merc_spawn_group", "targetname");
  thread spawn_merc_group(var_ec790ba1c195fbdd, s_location, 0, 0.2, goal);
}

function function_d63316812c3bc04b(s_location, goal) {
  var_2017958930cd9f59 = getStructArray("merc_reinforcement_group", "targetname");
  thread spawn_merc_group(var_2017958930cd9f59, s_location, 1, 1);
  var_ec790ba1c195fbdd = getStructArray("specialist_merc_reinforcement_group", "targetname");
  thread spawn_merc_group(var_ec790ba1c195fbdd, s_location, 1, 1, goal);
}

function spawn_merc_group(var_73f5a8fe44a61415, s_location, var_e71ddf3aa77ad97c, time_between_spawns, goal) {
  var_d0f63fb382aff7a6 = [];

  if(!isDefined(time_between_spawns)) {
    time_between_spawns = 0.2;
  }

  foreach(var_5883a55f39da8c48 in var_73f5a8fe44a61415) {
    if(isDefined(s_location) && !is_equal(var_5883a55f39da8c48.target, s_location.targetname)) {
      continue;
    }

    n_spawns = 2;
    var_9e3cc96b3a2c2e2c = 200;

    if(is_equal(var_5883a55f39da8c48.script_noteworthy, "medium_group")) {
      n_spawns = 3;
      var_9e3cc96b3a2c2e2c = 300;
    } else if(is_equal(var_5883a55f39da8c48.script_noteworthy, "large_group")) {
      n_spawns = 4;
      var_9e3cc96b3a2c2e2c = 400;
    }

    a_spawn_structs = function_b584f143ed0ec5d0(var_5883a55f39da8c48.origin, n_spawns, var_9e3cc96b3a2c2e2c);

    foreach(spawn_struct in a_spawn_structs) {
      var_5502d8fb5a3b1365 = function_70a6287c1cf8575a(var_5883a55f39da8c48);
      merc_ai = spawn_struct merc_spawn(var_5502d8fb5a3b1365);

      if(!isDefined(merc_ai)) {
        continue;
      }

      if(istrue(var_e71ddf3aa77ad97c)) {
        merc_ai thread ai_aware(4000);
      }

      s_goal = goal;

      if(isarray(goal)) {
        s_goal = array_random(goal);
      }

      if(isDefined(s_goal)) {
        navmesh_pos = getclosestpointonnavmesh(s_goal.origin);
        merc_ai setgoalpos(navmesh_pos, 64);
      }

      var_d0f63fb382aff7a6 = array_add(var_d0f63fb382aff7a6, merc_ai);

      if(isDefined(s_location) && is_equal(s_location.targetname, "fortified_building_roof")) {
        merc_ai val::set("roof_mercs", "ignoreall", 1);
      }

      wait time_between_spawns;
    }
  }

  if(isDefined(s_location)) {
    s_location.a_mercs = default_to(s_location.a_mercs, []);
    s_location.a_mercs = array_combine(s_location.a_mercs, var_d0f63fb382aff7a6);
  }
}

function function_70a6287c1cf8575a(var_5883a55f39da8c48) {
  if(isDefined(var_5883a55f39da8c48.script_noteworthy) && isDefined(self.var_5f9a84079974ac46[var_5883a55f39da8c48.script_noteworthy])) {
    return self.var_5f9a84079974ac46[var_5883a55f39da8c48.script_noteworthy];
  }

  if(is_equal(var_5883a55f39da8c48.targetname, "merc_spawn_group") || is_equal(var_5883a55f39da8c48.targetname, "merc_reinforcement_group")) {
    return array_random(self.var_cd927c3a6d220500);
  }

  if(is_equal(var_5883a55f39da8c48.targetname, "specialist_merc_spawn_group") || is_equal(var_5883a55f39da8c48.targetname, "specialist_merc_reinforcement_group")) {
    return array_random(self.var_bf4b0f953edcff84);
  }
}

function behavior_guard(origin, n_radius) {
  self endon("death");
  self endon("combat");

  if(!isDefined(origin)) {
    origin = self.origin;
  }

  if(isDefined(n_radius)) {
    n_goal_radius = n_radius;
  } else {
    n_goal_radius = 32;
  }

  while(true) {
    if(isDefined(origin) && distance2dsquared(origin, self.origin) > 4096) {
      scripts\mp\ai_behavior::function_304da84d9a815c01(origin, n_goal_radius, 1);
      self waittill("goal");
    }

    wait 2;
  }
}

function function_1b4d007c48f6440d(s_location, goal, var_e71ddf3aa77ad97c, time_between_spawns) {
  var_3f99910e8c5521f6 = getStructArray("zombie_spawn", "targetname");

  foreach(var_95e63e107775e24d in var_3f99910e8c5521f6) {
    if(isDefined(s_location) && !is_equal(var_95e63e107775e24d.target, s_location.targetname)) {
      continue;
    }

    zombie_subclass = function_ef4a8de5bdaaa4d9(var_95e63e107775e24d, s_location);

    if(isDefined(zombie_subclass)) {
      if(is_equal(zombie_subclass, self.var_2afbe67f5431e683["abomination"].subclass)) {
        continue;
      }

      zombie_ai = var_95e63e107775e24d zombie_spawn(zombie_subclass, self, 1, s_location, 1);
    }
  }

  var_540ec2131784d958 = getStructArray("zombie_spawn_group", "targetname");
  thread spawn_zombie_group(var_540ec2131784d958, s_location, var_e71ddf3aa77ad97c, time_between_spawns, goal);
}

function spawn_zombie_group(var_3f99910e8c5521f6, s_location, var_e71ddf3aa77ad97c, time_between_spawns, goal, group_size) {
  if(isDefined(s_location)) {
    s_location.active_info = [];
    s_location.active_info[self.var_2afbe67f5431e683["hellhound"].subclass] = 0;
    s_location.active_info[self.var_2afbe67f5431e683["armored_zombie"].subclass] = 0;
    s_location.active_info[self.var_2afbe67f5431e683["base_zombie"].subclass] = 0;
    s_location.active_info[self.var_2afbe67f5431e683["mangler"].subclass] = 0;
    s_location.active_info[self.var_2afbe67f5431e683["disciple"].subclass] = 0;
    s_location.active_info[self.var_2afbe67f5431e683["abomination"].subclass] = 0;
    s_location.active_info["n_active_zombies"] = 0;
  }

  foreach(var_95e63e107775e24d in var_3f99910e8c5521f6) {
    if(isDefined(s_location) && !is_equal(var_95e63e107775e24d.target, s_location.targetname)) {
      continue;
    }

    n_spawns = 8;
    var_9e3cc96b3a2c2e2c = 200;

    if(is_equal(var_95e63e107775e24d.script_noteworthy, "medium_group") || is_equal(group_size, "medium_group")) {
      n_spawns = 8;
      var_9e3cc96b3a2c2e2c = 200;
    } else if(is_equal(var_95e63e107775e24d.script_noteworthy, "large_group") || is_equal(group_size, "large_group")) {
      n_spawns = 16;
      var_9e3cc96b3a2c2e2c = 400;
    } else if(is_equal(var_95e63e107775e24d.script_noteworthy, "horde") || is_equal(group_size, "horde")) {
      n_spawns = 20;
      var_9e3cc96b3a2c2e2c = 700;
    }

    a_spawn_structs = function_b584f143ed0ec5d0(var_95e63e107775e24d.origin, n_spawns, var_9e3cc96b3a2c2e2c);

    foreach(spawn_struct in a_spawn_structs) {
      zombie_subclass = function_ef4a8de5bdaaa4d9(var_95e63e107775e24d, s_location);
      zombie_ai = spawn_struct zombie_spawn(zombie_subclass, self, 1, s_location);

      if(!isDefined(zombie_ai)) {
        continue;
      }

      if(istrue(var_e71ddf3aa77ad97c)) {
        zombie_ai thread ai_aware(4000);
      }

      s_goal = goal;

      if(isarray(goal)) {
        s_goal = array_random(goal);
      }

      if(isDefined(s_goal)) {
        navmesh_pos = getclosestpointonnavmesh(s_goal.origin);
        zombie_ai setgoalpos(navmesh_pos, 64);
      }

      time_between_spawns = default_to(time_between_spawns, 0.2);
      wait time_between_spawns;
    }
  }
}

function function_ef4a8de5bdaaa4d9(var_95e63e107775e24d, s_location) {
  if(isDefined(var_95e63e107775e24d.script_noteworthy) && isDefined(self.var_2afbe67f5431e683[var_95e63e107775e24d.script_noteworthy])) {
    return self.var_2afbe67f5431e683[var_95e63e107775e24d.script_noteworthy].subclass;
  } else {
    result = function_3cdcca49a665bda6(self.var_2afbe67f5431e683["armored_zombie"].subclass, self.var_2afbe67f5431e683["armored_zombie"].chance, self.var_2afbe67f5431e683["armored_zombie"].max_active, s_location);

    if(istrue(result)) {
      return self.var_2afbe67f5431e683["armored_zombie"].subclass;
    }

    result = function_3cdcca49a665bda6(self.var_2afbe67f5431e683["hellhound"].subclass, self.var_2afbe67f5431e683["hellhound"].chance, self.var_2afbe67f5431e683["hellhound"].max_active, s_location);

    if(istrue(result)) {
      return self.var_2afbe67f5431e683["hellhound"].subclass;
    }

    result = function_3cdcca49a665bda6(self.var_2afbe67f5431e683["mangler"].subclass, self.var_2afbe67f5431e683["mangler"].chance, self.var_2afbe67f5431e683["mangler"].max_active, s_location);

    if(istrue(result)) {
      return self.var_2afbe67f5431e683["mangler"].subclass;
    }

    result = function_3cdcca49a665bda6(self.var_2afbe67f5431e683["disciple"].subclass, self.var_2afbe67f5431e683["disciple"].chance, self.var_2afbe67f5431e683["disciple"].max_active, s_location);

    if(istrue(result)) {
      return self.var_2afbe67f5431e683["disciple"].subclass;
    }

    return self.var_2afbe67f5431e683["base_zombie"].subclass;
  }

  return self.var_2afbe67f5431e683["base_zombie"].subclass;
}

function function_3cdcca49a665bda6(subclass, chance, max_active, s_location) {
  aitype_chance = percent_chance(chance);

  if(istrue(aitype_chance)) {
    if(isDefined(s_location) && isDefined(subclass) && s_location.active_info[subclass] < max_active) {
      return true;
    } else if(!isDefined(s_location)) {
      return true;
    }
  }

  return false;
}

function merc_spawn(str_aitype) {
  ai_merc = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(str_aitype, self.origin, self.angles, "team_hundred_ninety");

  if(isDefined(ai_merc)) {
    return ai_merc;
  }
}

function zombie_spawn(var_d1e3b6ba5360f4e3, quest_info, b_anim, s_location, skip_tracking) {
  team = "team_two_hundred";
  aitypes = namespace_53fc9ddbb516e6e1::get_aitype_by_subclass_sharedfunc(var_d1e3b6ba5360f4e3);
  base_aitype = undefined;

  foreach(aitype in aitypes) {
    strlen = aitype.size;

    if(!isDefined(base_aitype) || base_aitype.size > strlen) {
      base_aitype = aitype;
    }
  }

  ai_zombie = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(base_aitype, self.origin, self.angles, "team_two_hundred", "difficulty_yellow");

  if(isDefined(ai_zombie) && ai_zombie function_8fa69650e33c84ef("spawn") && !isDefined(b_anim)) {
    ai_zombie thread animscriptedagent("spawn", "spawn_end", undefined, undefined, "spawn_animating");
  }

  waitframe();

  if(isalive(ai_zombie)) {
    ai_zombie namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_normal");

    if(is_equal(var_d1e3b6ba5360f4e3, "zombie_abom_mega_hvt")) {
      ai_zombie.var_20bed26d985c0b63 = 1;
    }

    ai_zombie.team = "team_two_hundred";
    str_speed = "sprint";
    ai_zombie namespace_dd16d65e824b8e9::function_f1e5805da192a1ef(str_speed, "default", 26);
    ai_zombie thread zombie_death_watcher(var_d1e3b6ba5360f4e3, s_location);
    ai_zombie.var_c23519e9c077ebc = 1;

    if(isDefined(s_location) && !istrue(skip_tracking)) {
      s_location.active_info[var_d1e3b6ba5360f4e3]++;
    }

    return ai_zombie;
  }
}

function function_9b03d4efc5c05c8e(var_b511c0101e1384b3) {
  [spawn_struct] = getStructArray("abom_wave_spawn", "script_noteworthy");
  abom_ai = spawn_struct zombie_spawn("zombie_abom_mega_hvt", self, 1, undefined, 1);
  abom_ai.var_d243a619c1894518 = 1;
  abom_ai._blackboard.var_1766d5cccf9b5670 = 0;
  abom_ai function_65cdab0fc78aba8f(self.vh_escort.origin, 3500);
}

function merc_attack() {
  self endon("death");
  self endon("clear_attack");
  self endon("goal");
  self.goalradius = randomintrange(800, 1500);

  while(true) {
    player = getclosest(self.origin, level.players);

    if(isalive(player)) {
      pos_on_navmesh = getclosestpointonnavmesh(player.origin);

      if(isDefined(pos_on_navmesh)) {
        self setgoalpos(pos_on_navmesh, 64);
        thread function_ea9c9fa94fbf39f1();
      }
    }

    wait 8;
  }
}

function function_c4ca28aac25522a2(wave_struct) {
  self endon("quest_s0_act2_ended");
  level endon("game_ended");
  thread zombie_wave(wave_struct);
}

function zombie_wave(wave_struct, max_active, time_between_spawns, a_spawn_structs) {
  self endon("quest_s0_act2_ended");
  self endon("device_detonated");
  level endon("game_ended");
  wave_struct.active_info = [];
  wave_struct.active_info[self.var_2afbe67f5431e683["hellhound"].subclass] = 0;
  wave_struct.active_info[self.var_2afbe67f5431e683["armored_zombie"].subclass] = 0;
  wave_struct.active_info[self.var_2afbe67f5431e683["base_zombie"].subclass] = 0;
  wave_struct.active_info[self.var_2afbe67f5431e683["mangler"].subclass] = 0;
  wave_struct.active_info[self.var_2afbe67f5431e683["disciple"].subclass] = 0;
  wave_struct.active_info[self.var_2afbe67f5431e683["abomination"].subclass] = 0;
  wave_struct.active_info["n_active_zombies"] = 0;
  max_active = wave_struct.max_active;
  time_between_spawns = wave_struct.time_between_spawns;
  a_spawn_structs = wave_struct.a_spawn_structs;
  wave_struct.var_634f3bec5d39faaf = 0;
  function_9b03d4efc5c05c8e(a_spawn_structs);
  self.var_2afbe67f5431e683["mangler"].max_active = 0;
  self.var_2afbe67f5431e683["disciple"].max_active = 0;
  self.var_2afbe67f5431e683["hellhound"].max_active = 1;

  while(true) {
    elapsed_time = (gettime() - self.var_e504d983a6aa7dc2) / 1000;
    max_active = 8;
    var_d8ef071103d43ca7 = elapsed_time / 60 * 100;

    if(var_d8ef071103d43ca7 > 33 && var_d8ef071103d43ca7 < 66) {
      max_active = 15;
    } else if(var_d8ef071103d43ca7 > 66 && var_d8ef071103d43ca7 < 95) {
      max_active = 20;
      self.var_2afbe67f5431e683["mangler"].max_active = 1;
    } else if(var_d8ef071103d43ca7 > 95) {
      self.var_2afbe67f5431e683["mangler"].max_active = 2;
      max_active = 25;
    }

    if(wave_struct.active_info["n_active_zombies"] < max_active) {
      zombie_subclass = function_ef4a8de5bdaaa4d9(self, wave_struct);
      spawn_struct = array_random(a_spawn_structs);
      spawn_origin = getclosestpointonnavmesh(spawn_struct.origin);
      spawn_struct.origin = spawn_origin;
      zombie_ai = spawn_struct zombie_spawn(zombie_subclass, self, 1, wave_struct);

      if(isDefined(zombie_ai)) {
        wave_struct.active_info["n_active_zombies"]++;
        zombie_ai thread ai_aware(4000);
      }
    }

    wait time_between_spawns;
  }
}

function zombie_death_watcher(var_d1e3b6ba5360f4e3, s_location) {
  self waittill("death");

  if(isDefined(s_location)) {
    if(s_location.active_info["n_active_zombies"] - 1 > 0) {
      s_location.active_info["n_active_zombies"]--;
    }

    if(s_location.active_info[var_d1e3b6ba5360f4e3] - 1 > 0) {
      s_location.active_info[var_d1e3b6ba5360f4e3]--;
    }
  }
}

function function_ea9c9fa94fbf39f1() {
  self notify("new_target");
  self endon("death");
  self endon("new_target");
  self waittill("goal");
  self notify("clear_attack");
}

function function_b584f143ed0ec5d0(origin, num_spots, n_radius) {
  a_s_spawnpts = [];

  if(!isDefined(n_radius)) {
    n_radius = 100;
  }

  for(i = 0; i < num_spots; i++) {
    var_2a74fdb9fac967ff = randomintrange(n_radius * -1, n_radius + 1);
    var_2a74fcb9fac965cc = randomintrange(n_radius * -1, n_radius + 1);
    pos = origin + (var_2a74fdb9fac967ff, var_2a74fcb9fac965cc, 0);
    pos_on_navmesh = getclosestpointonnavmesh(pos);
    s_spot = spawnStruct();

    if(isDefined(s_spot)) {
      s_spot.origin = pos_on_navmesh;
      s_spot.angles = (0, 0, 0);
    }

    if(isDefined(pos_on_navmesh)) {
      a_s_spawnpts[a_s_spawnpts.size] = s_spot;
    }
  }

  return a_s_spawnpts;
}

function ai_aware(n_radius) {
  self endon("death");

  while(true) {
    self function_65cdab0fc78aba8f(self.origin, n_radius);
    wait 3;
  }
}

function map_transition(var_684092929dab076f, var_576f57af0204c38c, str_mission) {
  if(getmapname() == "mp_jup_st_a" || getmapname() == "mp_jup_resort_gw") {
    foreach(player in level.players) {
      player clearsoundsubmix("jup_ob_exfil_success");
    }

    level function_81e85bcedda2052();
    level.var_df433561007fc313 thread function_2b5a99c0dc3aaed8();
    function_55c4fd7594396e83(2);

    if(getdvarint(@ "hash_70249f5c9fc86370", 0)) {
      level.var_df433561007fc313 notify("infil_done");
      level.var_df433561007fc313 flag_set("infil_done");
      level.var_df433561007fc313 flag_set("infil_chopper_destroyed");
      level.var_df433561007fc313 thread function_e22ffb38d3d9e977();
      return;
    }

    level.var_df433561007fc313 thread namespace_134d54e39331ee45::function_74139ae6c2c53345();
    return;
  }

  level thread namespace_bbc151ced3ff8d46::map_transition(var_684092929dab076f, var_576f57af0204c38c, str_mission);
}

function function_e22ffb38d3d9e977() {
  self.a_s_player_spawns = getStructArray("quest_act2_player_spawn", "targetname");

  for(i = 0; i < level.players.size; i++) {
    thread player_teleport(level.players[i], self.a_s_player_spawns[i]);
  }
}

function player_teleport(player, teleport_struct) {
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 1);
  player.ignoreme = 1;
  player freezecontrols(1);
  wait 1;
  player setOrigin(teleport_struct.origin);
  player setplayerangles(teleport_struct.angles);
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 1);
  player.ignoreme = 0;
  player freezecontrols(0);
}

function function_c6352d8194937a50() {
  target_location = (0, 0, 0);

  if(isDefined(self.var_3a7e8de43eccff16) && gettime() - self.var_3a7e8de43eccff16 < 3900) {
    wait 1.8;
  } else {
    wait 0.75;
  }

  level flag_clear("quest_infil_active");
  thread scripts\cp_mp\overlord::playconversation("quest_s0_a2t6_infil_heli_takedown", level.players, 0.5, 1);

  if(isDefined(self.infil_chopper)) {
    target_struct = getStruct("kill_infil_chopper", "script_noteworthy");
    target_location = target_struct.origin;
    thread function_275c0bbd4aaf5929();

    foreach(samsite in self.samsites) {
      samsite thread namespace_c5d39841678f2fb1::function_44e4433ebac52609(target_location, self.infil_chopper);
    }

    return;
  }

  self.a_s_player_spawns = getStructArray("quest_act2_player_spawn", "targetname");
  target_location = self.a_s_player_spawns[0].origin + (0, 0, 1000);
  flag_set("infil_chopper_destroyed");
}

function function_275c0bbd4aaf5929() {
  self.infil_chopper endon("death");
  self.infil_chopper waittill("sam_missile_explode");
  flag_set("infil_chopper_destroyed");

  if(isarray(self.infil_chopper.pilots)) {
    foreach(pilot in self.infil_chopper.pilots) {
      pilot delete();
    }
  }

  foreach(player in level.players) {
    player stopsoundchannel("voice_radio_2d");
  }

  self.infil_chopper scripts\cp_mp\vehicles\vehicle_damage::vehicle_damage_setCanDamage(1);
  self.infil_chopper scripts\cp_mp\vehicles\vehicle_damage::function_d0df49de517ded03();
  self.infil_chopper scripts\cp_mp\vehicles\vehicle::vehicle_explode();
}

function quest_complete() {
  level notify("story_quest_complete_step_4");
  self.var_99626a64c1275340 = 1;
  namespace_262d6474998a2356::function_b8b15f7f0820954e(level.players);
  setmusicstate("");
  level.battlechatterdisabled = 1;

  if(!getdvarint(@ "hash_bc6484f2fc437a2d", 0)) {
    foreach(player in level.players) {
      if(isalive(player)) {
        thread function_e46fdb5c5c2231c7(player);
        player thread scripts\common\hud_util::fade_out(1, "white");
      }
    }

    earthquake(0.25, 3, self.vh_escort.origin, 1750);
    playrumbleonposition("grenade_rumble", self.vh_escort.origin);
    wait 6.5;

    if(isDefined(self.vh_escort.payload)) {
      self.vh_escort.payload setscriptablepartstate("charge", "idle");
    }

    wait 0.3;

    foreach(player in level.players) {
      if(namespace_b3fcba693d3adc37::function_f3645fa4bfb45a97(player)) {
        player notify("last_stand_revived");
      }

      player setsoundsubmix("jup_ob_endgame");
      player setclientdvar(@ "hash_cbb22e2fb1a57873", 1);
    }

    play_movie("jup_ob_act2_cine_outro");
    level.battlechatterdisabled = 0;
    level thread function_bf01aba31e9023d1(1);
  }
}

function function_e46fdb5c5c2231c7(player) {
  player setscriptablepartstate("ob_quest_s0_act2_escort_neutralizer_fx", "neutralizer_explosion");
  wait 2;
  player freezecontrols(1);
  player.ignoreme = 1;
  player thread hidehudenable();
}

function play_movie(str_movie) {
  var_7848ff3f98ef4a73 = 0;
  var_8c6c2faac72ea626 = 10;
  videoname = str_movie;
  videoduration = 144.5;
  var_1bab87417f147c8f = 0;

  foreach(player in level.players) {
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 0.5);
    player.var_59e5ea44ba5aff1 = 1;
    player val::set("mission_cinematic", "ignoreme", 1);
    player val::set("mission_cinematic", "freezecontrols", 1);
    player val::set("mission_cinematic", "damage", 0);
    player val::set("mission_cinematic", "weapon", 0);
    player val::set("mission_cinematic", "breath_system", 0);
    player val::set("mission_cinematic", "cg_drawcrosshair", 0);
    player val::set("mission_cinematic", "show_weapon_hud", 0);
  }

  wait 0.75;

  foreach(player in level.players) {
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 0, 0);
    player thread scripts\common\hud_util::fade_in(0, "white");
    player setclientomnvar("ui_br_bink_overlay_state", var_8c6c2faac72ea626);
    player utility::hidehudenable();
    player scripts\common\utility::letterbox_enable(1, videoduration);
  }

  playcinematicforall(videoname, 1, var_1bab87417f147c8f);
  wait videoduration;

  foreach(player in level.players) {
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(player, 1, 1);
  }

  wait 1;
  stopcinematicforall();

  foreach(player in level.players) {
    player setclientomnvar("ui_br_bink_overlay_state", var_7848ff3f98ef4a73);
  }

  wait 3;
}

function device_explosion() {
  a_ai = getaiarrayinradius(self.vh_escort.origin, 3500);
  var_6bfbb345d937798e = [];

  foreach(player in level.players) {
    foreach(ai in a_ai) {
      if(ai.team == player.team || ai.team == "neutral" || array_contains(var_6bfbb345d937798e, ai)) {
        continue;
      }

      var_6bfbb345d937798e = array_add(var_6bfbb345d937798e, ai);
    }
  }

  function_5a2c160d3a406b94(self.vh_escort.origin, var_6bfbb345d937798e, 1);
}

function function_5a2c160d3a406b94(v_location, a_ais, var_8d1aa1efbf8b3c6e) {
  var_473ff5b31f1ed342 = array_removedead(a_ais);
  var_473ff5b31f1ed342 = get_array_of_closest(v_location, var_473ff5b31f1ed342);
  var_f00cdf3d3bfc5a54 = [];

  foreach(ai in var_473ff5b31f1ed342) {
    if(!isalive(ai)) {
      continue;
    }

    b_skip = 0;

    if(istrue(ai.magic_bullet_shield)) {
      b_skip = 1;
    }

    if(istrue(ai.marked_for_death)) {
      b_skip = 1;
    }

    ai.marked_for_death = 1;

    if(!istrue(ai.var_9eb8bf12bddbe7f6)) {
      ai.var_9eb8bf12bddbe7f6 = 1;
      ai.no_powerups = 1;
      ai.var_7e4b076a06c6df27 = 1;
      ai.full_gib = 1;
      ai.var_745cd904c1ec804c = 1;
      var_f00cdf3d3bfc5a54 = array_add(var_f00cdf3d3bfc5a54, ai);
    }
  }

  var_60d4e0f1aeb32f84 = undefined;

  foreach(ai_killed in var_f00cdf3d3bfc5a54) {
    wait randomfloatrange(0.05, 0.15);

    if(!isalive(ai_killed)) {
      continue;
    }

    if(istrue(ai_killed.magic_bullet_shield)) {
      continue;
    }

    var_bc8818c262ac2b04 = undefined;

    if(isDefined(ai_killed.aicategory) && !istrue(var_8d1aa1efbf8b3c6e)) {
      if(ai_killed.aicategory == "special") {
        var_bc8818c262ac2b04 = ai_killed.maxhealth * function_519d44e54a9b8ae5("nuke").var_74576b4dd247d7b1;
      } else if(ai_killed.aicategory == "elite" || ai_killed.aicategory == "boss") {
        var_bc8818c262ac2b04 = ai_killed.maxhealth * function_519d44e54a9b8ae5("nuke").var_e896465ad8ccd911;
      }
    }

    if(isDefined(var_bc8818c262ac2b04) && var_bc8818c262ac2b04 < ai_killed.health) {
      if(!isDefined(var_60d4e0f1aeb32f84)) {
        var_60d4e0f1aeb32f84 = spawn("script_model", v_location);
      }

      if(var_bc8818c262ac2b04 > 0) {
        ai_killed dodamage(int(var_bc8818c262ac2b04), ai_killed.origin, undefined, var_60d4e0f1aeb32f84, "MOD_UNKNOWN", "none", "none", undefined, 65536);
      }

      ai_killed.marked_for_death = 0;
      ai_killed.var_9eb8bf12bddbe7f6 = 0;
      ai_killed.var_745cd904c1ec804c = 0;
      ai_killed.no_powerups = 0;
      ai_killed.var_7e4b076a06c6df27 = 0;
      ai_killed.full_gib = 0;
      continue;
    }

    ai_killed kill();
  }

  if(isDefined(var_60d4e0f1aeb32f84)) {
    var_60d4e0f1aeb32f84 delete();
  }
}

function function_2a6c134406898721(params) {
  if(!isDefined(params.player)) {
    return;
  }

  level.var_9ec4962076db301b["s0_act2"].var_576f57af0204c38c = params.exfil_chopper;
  level flag_set("exfil_to_s0_act_2");
  level thread function_700e95e77f71e457(params);
}

function function_700e95e77f71e457(params) {
  if(!isPlayer(params.player)) {
    return;
  }

  var_684092929dab076f = [params.player];
  var_576f57af0204c38c = level.var_9ec4962076db301b["s0_act2"].var_576f57af0204c38c;
  level thread namespace_bbc151ced3ff8d46::map_transition(var_684092929dab076f, var_576f57af0204c38c, "s0_act2");
}

function function_55c4fd7594396e83(difficulty_level) {
  setDvar(@ "hash_37edd5a66bd29f3d", difficulty_level);
  zombies = getaispeciesarray("all", "zombie");

  foreach(zombie in zombies) {
    new_difficulty = function_4d8bb2d866771a10(zombie.origin);
    zombie function_4a4fab5fd0b06d7b(new_difficulty);
  }

  if(isPlayer(level.player)) {
    new_region = get_region(level.player.origin);

    if(isDefined(new_region) && isDefined(difficulty_level)) {
      difficulty_list = get_difficulties();

      if(isDefined(difficulty_list)) {
        difficulty_ref = default_to(difficulty_list[difficulty_level], "difficulty_undefined");
        level.var_f756bf4293f67099[new_region] = difficulty_ref;
        params = spawnStruct();
        params.player = level.player;
        params.new_region = new_region;
        params.old_region = level.player.region;
        params.new_difficulty = difficulty_ref;
        params.old_difficulty = level.player.difficulty;
        level.player.region = new_region;
        level.player.difficulty = difficulty_ref;
        callback::callback("player_region_difficulty_change", params);
      }
    }
  }
}

function function_2b5a99c0dc3aaed8() {
  self.var_cd05af3824c52cde = getentitylessscriptablearray("mp_jup_st_a_ob_quest_set_dressing", "targetname");

  foreach(scriptable in self.var_cd05af3824c52cde) {
    if(isDefined(scriptable.script_noteworthy) && scriptable getscriptableparthasstate("body", scriptable.script_noteworthy)) {
      scriptable setscriptablepartstate("body", scriptable.script_noteworthy);
    }
  }

  var_b139ae25c4db8bbe = [];
  var_cfa15b0adac0f8bd = getStructArray("content_instance", "variantname");

  foreach(struct in var_cfa15b0adac0f8bd) {
    if(isDefined(struct.content_script_name) && struct.content_script_name == "loot_crystal") {
      if(isDefined(struct.contentgroups)) {
        spawn_points = struct.contentgroups["loot_crystal_spawn"];
      } else {
        spawn_points = getStructArray(struct.targetname, "target");
      }

      foreach(point in spawn_points) {
        point scripts\cp_mp\loot_crystal::function_e87afa054556fca(point);
      }
    }
  }
}

function setup_mines() {
  while(true) {
    var_da3a55eabb666c32 = getaiarray("team_hundred_ninety");

    if(isDefined(var_da3a55eabb666c32) && var_da3a55eabb666c32.size) {
      break;
    }

    wait 0.1;
  }

  self.a_mines = [];
  var_f75ab33b14599ef5 = getStructArray("sentry_mine", "targetname");

  foreach(s_mine in var_f75ab33b14599ef5) {
    wait randomfloat(1);
    mine = namespace_64135de19550f047::function_908ec13fb4d6cede(s_mine.origin, undefined, var_da3a55eabb666c32[0]);

    if(isDefined(mine)) {
      mine.allowfriendlyfire = 1;
      self.a_mines[self.a_mines.size] = mine;
    }
  }
}

function setup_barrels() {
  explosive_barrels = [];
  a_s_barrels = getStructArray("barrel_explosive", "targetname");

  foreach(s_barrel in a_s_barrels) {
    var_ca6d90a11ccbbf85 = spawnscriptable("barrel_toggleable_red", s_barrel.origin, s_barrel.angles);

    if(isDefined(var_ca6d90a11ccbbf85)) {
      if(isDefined(s_barrel.script_noteworthy)) {
        self.barrel_tunnel = var_ca6d90a11ccbbf85;
      }

      var_ca6d90a11ccbbf85 setscriptablepartstate("state", "healthy");

      if(isDefined(s_barrel.script_noteworthy) && s_barrel.script_noteworthy == "rooftop_barrel") {
        explosive_barrels[explosive_barrels.size] = var_ca6d90a11ccbbf85;
      }
    }
  }
}

function function_7c5122b771e3b136() {
  a_s_keys = getStructArray("turret_trap_key", "targetname");

  foreach(s_key in a_s_keys) {
    str_key_type = function_962b0a5c4028e615();
    item_intel = spawnnewitemfromscriptablesharedfunc(str_key_type, s_key.origin, (0, 0, 0), 0, 1, 1, 1);
  }
}

function function_962b0a5c4028e615() {
  var_bfb567bc6dd16556 = ["obloot_valuable_turret_trap_circuit", "obloot_valuable_turret_trap_circuit_brainrot", "obloot_valuable_turret_trap_circuit_cryofreeze", "obloot_valuable_turret_trap_circuit_deadwire", "obloot_valuable_turret_trap_circuit_napalmburst", "obloot_valuable_turret_trap_circuit_shatterblast"];
  return array_random(var_bfb567bc6dd16556);
}

function function_9cf8db85d41361b9() {
  var_3182fc198eec14cc = getStructArray("mimic_spawn_airdrop", "script_noteworthy");
  var_169015c2e960b106 = getStructArray("mimic_spawn_merc_camp", "script_noteworthy");
  var_6133cb764bf7c492 = getStructArray("mimic_spawn_zombified_camp", "script_noteworthy");
  var_b98c296dcdc1e367 = getStructArray("mimic_spawn_defend", "script_noteworthy");
  var_b3a793c70e4f3186 = array_combine(var_3182fc198eec14cc, var_169015c2e960b106, var_6133cb764bf7c492, var_b98c296dcdc1e367);

  foreach(spawn_pt in var_b3a793c70e4f3186) {
    var_9ea479f7a07714a9 = namespace_53fc9ddbb516e6e1::get_aitype_by_subclass_sharedfunc("zombie_mimic")[0];
    ai_mimic = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(var_9ea479f7a07714a9, spawn_pt.origin, spawn_pt.angles, "team_two_hundred");

    if(isDefined(ai_mimic)) {
      ai_mimic namespace_4df2ab39b0e96ec7::function_4a4fab5fd0b06d7b("difficulty_normal");
      namespace_6119efd5d1925c17::function_232cabbc43f9536(spawn_pt.origin, ai_mimic, spawn_pt, 0, 200, &function_e8ab086d51573a1d);
    }
  }
}

function function_e8ab086d51573a1d() {
  prop_height = (0, 0, 64);
  players = player_utility::getplayersinradius(self.origin, 150);

  if(players.size) {
    foreach(player in players) {
      if(!isalive(player)) {
        continue;
      }

      if(istrue(player.ignoreme) || istrue(player.inlaststand)) {
        continue;
      }

      if(getdvarint(@ "hash_821690ed248715f7", 0)) {
        sphere(player.origin, 20, (0, 1, 0), 0, 1, 1);
      }

      if(isDefined(player.last_valid_position) && isDefined(self.navmesh_position)) {
        if(!trace::ray_trace_passed(player.last_valid_position, self.navmesh_position, [self], trace::create_default_contents(1))) {
          if(getdvarint(@ "hash_821690ed248715f7", 0)) {
            line(player.last_valid_position, self.navmesh_position, (0, 1, 1), 1, 0, 1);
            sphere(self.navmesh_position, 20, (1, 0, 0), 0, 1, 1);
          }

          continue;
        }
      } else {
        player_center = player gettagorigin("j_spine4");
        player_center = utility::default_to(player_center, player getcentroid());

        if(isDefined(player_center) && !sighttracepassed(self.origin + prop_height, player_center, 0, self)) {
          if(getdvarint(@ "hash_821690ed248715f7", 0)) {
            line(self.origin + prop_height, player gettagorigin("<dev string:x49>"), (1, 1, 0), 1, 0, 1);
          }

          continue;
        }
      }

      traceresult = playerphysicstrace(self.origin + (0, 0, 20), player.origin + (0, 0, 36), player, undefined, self, 1);

      if(traceresult["fraction"] >= 1) {
        self notify("stop_shake_tell");
        return player;
      }

      if(getdvarint(@ "hash_821690ed248715f7", 0)) {
        line(self.origin + (0, 0, 8), player.origin + (0, 0, 8), (1, 0, 0), 1, 0, 1);
        sphere(traceresult["<dev string:x55>"], 4, (1, 0, 0), 1, 0, 10, 1);
      }
    }
  }
}

function function_ca13228a501ce246() {
  var_90d87894eec8dade = getStructArray("quest_turret_trap_spawn", "targetname");

  foreach(s_turret_trap in var_90d87894eec8dade) {
    namespace_47d96238dd467828::function_936a5eebf22b23e1(s_turret_trap.script_noteworthy, s_turret_trap.origin, s_turret_trap.angles);
  }
}

function setup_ammo() {
  var_77ae610b84ee2e95 = getStructArray("ammo_restock", "targetname");

  foreach(s_ammo in var_77ae610b84ee2e95) {
    var_28b750103c3b51fb = spawnscriptable("military_ammo_restock_noent", s_ammo.origin, s_ammo.angles);
    var_28b750103c3b51fb setscriptablepartstate("military_ammo_restock", "useable_on");
  }
}

function function_804aa1cbd49ba400(a_s_pos, var_3db5d03d7aac2a57) {
  self.var_da3a55eabb666c32 = [];

  foreach(s_pos in a_s_pos) {
    s_pos.spawndata = spawnStruct();
    s_pos.spawndata.origin = s_pos.origin;
    s_pos.spawndata.angles = s_pos.angles;
    s_pos.spawndata.spawntype = "GAME_MODE";
    s_pos.spawndata.preventrespawn = 1;
    s_pos.v_chopper = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh_jup_blima_anim_infil", s_pos.spawndata);

    if(isDefined(s_pos.v_chopper)) {
      scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(s_pos.v_chopper);
      s_pos.v_chopper.callingteam = "team_hundred_ninety";
      s_pos.v_chopper.unload_land_offset = 255;
      s_pos.v_chopper.script_disconnectpaths = 1;
      s_pos.v_chopper.vehiclesetuprope = 1;
      s_pos.v_chopper.ignorelist = [s_pos.v_chopper];
      s_pos.v_chopper vehicle_setspeed(60, 10, 8);
      s_pos.v_chopper setvehgoalpos(s_pos.v_chopper.origin, 1);
      s_pos.v_chopper.s_quest = self;

      if(isDefined(var_3db5d03d7aac2a57)) {
        s_pos.v_chopper function_c776ee14bbf6320e(self, getStruct(s_pos.target, "targetname"));
        continue;
      }

      s_pos.v_chopper thread function_514f522c0fd10ad7(self, getStruct(s_pos.target, "targetname"));
    }
  }
}

function function_514f522c0fd10ad7(s_quest, s_goal) {
  self endon("death");
  self.a_ai_riders = [];
  n_special = 0;
  var_4661c9a486253047 = ["jup_ob_enemy_basic_soldier_long", "jup_ob_enemy_basic_soldier_short", "jup_ob_enemy_basic_specialforce_long"];
  n_riders = 6;

  for(i = 0; i < n_riders; i++) {
    str_aitype = array_random(var_4661c9a486253047);

    if(str_aitype == "jup_ob_enemy_basic_specialforce_long") {
      n_special++;

      if(n_special > 2) {
        str_aitype = "jup_ob_enemy_basic_soldier_long";
      }
    }

    ai_merc = namespace_53fc9ddbb516e6e1::spawnnewaitype_sharedfunc(str_aitype, self.origin, self.angles, "team_hundred_ninety");

    if(isDefined(ai_merc)) {
      ai_merc.ignore_nuke = 1;
      s_quest.var_da3a55eabb666c32[s_quest.var_da3a55eabb666c32.size] = ai_merc;
      self.a_ai_riders[i] = ai_merc;
    }

    waitframe();
  }

  namespace_5d57e6b81b105f5d::function_35c699c709e24b69(self.a_ai_riders);
  function_c776ee14bbf6320e(s_quest, s_goal);
}

function function_c776ee14bbf6320e(s_quest, s_goal) {
  self vehicle_setspeed(60, 10, 8);

  while(true) {
    if(isDefined(s_goal.script_noteworthy) && s_goal.script_noteworthy == "drop_off") {
      self setgoalyaw(flat_angle(s_goal.angles)[1]);
      self sethoverparams(0);
      heli_unload(s_quest, s_goal);
      self cleargoalyaw();
    } else {
      if(isDefined(s_goal.script_noteworthy)) {
        if(s_goal.script_noteworthy == "approach") {
          self setvehgoalpos(s_goal.origin, 1);
        }
      } else {
        self setvehgoalpos(s_goal.origin, 0);
      }

      self waittill("goal");
    }

    if(isDefined(s_goal.target)) {
      s_goal = getStruct(s_goal.target, "targetname");
      continue;
    }

    break;
  }

  a_ai_riders = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);

  foreach(ai_rider in a_ai_riders) {
    if(isalive(ai_rider)) {
      ai_rider kill();
    }
  }

  scripts\cp_mp\vehicles\vehicle_damage::function_d0df49de517ded03();
  scripts\cp_mp\vehicles\vehicle::vehicle_explode();
}

function smoke_screen(v_pos, wait_time) {
  if(!isDefined(wait_time)) {
    wait_time = 6.25;
  }

  wait wait_time;
  magicgrenademanual("smoke_grenade_mp", v_pos, (0, 0, -10), 0.5);
  thread play_sound_in_space("smoke_grenade_expl_trans", self.origin);
}

function heli_unload(s_quest, s_loc) {
  self setvehgoalpos(s_loc.origin, 1);
  self waittill("goal");
  thread smoke_screen(s_loc.origin - (0, 0, 165));

  if(isDefined(s_quest) && is_equal(s_quest.act_step, 2)) {
    thread scripts\cp_mp\overlord::playevent("quest_s0_a2t6_secure_vehicle_fletcher", level.players, 3.75);
  }

  var_b3941e6a151cf4d2 = scripts\common\vehicle_code::_vehicle_unload();
  self waittill("unloaded");

  foreach(guy in var_b3941e6a151cf4d2) {
    guy.var_f327ed481efe4857 = undefined;
    guy.ignore_nuke = 0;
  }

  return var_b3941e6a151cf4d2;
}

function oob_triggers() {
  flag_wait("infil_done");
  level.outofboundstriggers = getEntArray("OutOfBounds_ob_story", "targetname");

  if(is_equal(level.outofboundstriggers.size, 0)) {
    return;
  }

  level notify("switch_oob");
  waitframe();
  level thread scripts\mp\outofbounds::watchoobtriggers();
}

function squad_death_watcher() {
  level endon("game_ended");
  self endon("quest_s0_act2_ended");

  while(true) {
    players_alive = 0;

    foreach(player in level.players) {
      if(isalive(player)) {
        players_alive++;
      }
    }

    if(is_equal(players_alive, 0)) {
      thread scripts\cp_mp\overlord::playconversation("quest_s0_a2t6_squad_death", level.players, 0, 1);
      return;
    }

    wait 0.1;
  }
}

function function_8751cff989bde6a0(instance, player, edgeindex, isinverted, isvertical, ascendervec) {
  if(!isDefined(player)) {
    return;
  }

  if(isDefined(level.var_df433561007fc313)) {
    level.var_df433561007fc313 function_1fe2872f343ce025(player, 0);

    if(!istrue(level.var_df433561007fc313.var_d81c040f57ae057c)) {
      level.var_df433561007fc313.var_d81c040f57ae057c = 1;
      thread scripts\cp_mp\overlord::playconversation("quest_s0_a2t6_fortified_building_ascender", level.players, 0, 1);
    }
  }
}

function function_1fe2872f343ce025(player, b_show) {
  if(isPlayer(player) && !istrue(player.var_37d73912ee023d9b) && isarray(self.var_942160dfc85d052)) {
    foreach(var_be93d3e51d75015 in self.var_942160dfc85d052) {
      objective_removeclientfrommask(var_be93d3e51d75015, player);
      waitframe();
      player.var_37d73912ee023d9b = 1;

      foreach(player_check in level.players) {
        if(!is_equal(player, player_check) && !istrue(player_check.var_37d73912ee023d9b)) {
          objective_addclienttomask(var_be93d3e51d75015, player_check);
        }
      }

      objective_showtoplayersinmask(var_be93d3e51d75015);
    }
  }
}

function function_235944ad0915efdb(player, b_show, var_c2ad03705a55df) {
  if(!isDefined(var_c2ad03705a55df)) {
    var_c2ad03705a55df = 0;
  }

  if(istrue(player.var_8cb20a51c7ff105e)) {
    return;
  }

  player.var_8cb20a51c7ff105e = 1;

  if(isarray(self.var_79c8996a40bba4ae)) {
    foreach(var_1d396dde0a025645 in self.var_79c8996a40bba4ae) {
      objective_addclienttomask(var_1d396dde0a025645, player);
      objective_showtoplayersinmask(var_1d396dde0a025645);
    }
  }

  if(istrue(var_c2ad03705a55df) && !istrue(player.var_37d73912ee023d9b)) {
    wait 0.1;
    thread function_1fe2872f343ce025(player, 0);
  }
}

function function_9aa696b9bad4fdc9() {
  if(isarray(self.var_942160dfc85d052)) {
    foreach(var_be93d3e51d75015 in self.var_942160dfc85d052) {
      if(isDefined(var_be93d3e51d75015)) {
        objidpoolmanager::returnobjectiveid(var_be93d3e51d75015);
      }
    }
  }
}

function function_f5c999e269f92619(s_notify) {
  self.vh_escort endon("death");
  self endon(s_notify);

  while(true) {
    wait 1;

    if(isDefined(self.vh_escort)) {
      self.vh_escort setscriptablepartstate("rear_light", "countdown");
      self.vh_escort thread function_cd87cff6a50ddde(0.5);
    }
  }
}

function private function_cd87cff6a50ddde(n_delay) {
  self endon("death");

  if(isDefined(n_delay)) {
    wait n_delay;
  }

  if(isDefined(self)) {
    self setscriptablepartstate("rear_light", "off");
  }
}

function function_bf01aba31e9023d1(b_state) {
  if(!istrue(b_state)) {
    foreach(player in level.players) {
      player thread namespace_b3f32c8cb80b8124::function_5751d00ce46557da(0);
    }

    level thread scripts\mp\gamelogic::endgame("none", game["end_reason"]["objective_failed"]);
    return;
  }

  level notify("game_ended_story_mission");
  namespace_134d54e39331ee45::function_bf01aba31e9023d1(1);
}

function end_game() {
  wait 25;
  winning_team = "none";

  if(isDefined(level.players[0])) {
    winning_team = level.players[0].team;
  }

  thread scripts\mp\gamelogic::endgame(winning_team, game["end_reason"]["objective_completed"]);
}

function function_36451a8bfae75b4b() {
  params = [];
  params[0] = "<dev string:x61>";
  params[1] = "<dev string:x72>";
  params[2] = "<dev string:x80>";
  scripts\mp\gametypes\ob::function_ce34466b3cece887(params);
}

# /