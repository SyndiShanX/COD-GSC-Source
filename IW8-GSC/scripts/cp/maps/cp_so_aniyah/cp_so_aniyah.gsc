/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_so_aniyah\cp_so_aniyah.gsc
*********************************************************/

function main() {
  ref_11c1e();
  setdvarifuninitialized("scr_use_squads", 1);
  setdvarifuninitialized("scr_squad_max", 4);
  setdvarifuninitialized("scr_squad_leader_max", 2);
  setdvarifuninitialized("scr_ai_squad_move_type", "1");
  setdvarifuninitialized("scr_smoketest", "0");
  setdvarifuninitialized("scr_cp_so_solo_chopper", 0);
  setdvarifuninitialized("scr_cp_so_intel_collected", 0);
  setdvarifuninitialized("scr_cp_so_num_juggernauts", 0);
  scripts\cp\utility::coop_mode_enable();
  registerscriptedagents();
  scripts\engine\utility::flag_init("scriptables_ready");
  scripts\engine\utility::flag_init("all_players_connected");
  scripts\engine\utility::flag_init("enemies_spawning");
  scripts\engine\utility::flag_init("crate_spawns_past_a");
  scripts\engine\utility::flag_init("crate_spawns_past_b");
  scripts\cp\maps\cp_so_aniyah\cp_so_aniyah_precache::main();
  scripts\cp\maps\cp_so_aniyah\gen\cp_so_aniyah_art::main();
  scripts\cp\maps\cp_so_aniyah\cp_so_aniyah_fx::main();
  setDvar("NPONLLLSPL", 1.25);
  setDvar("PKKMTTRQO", 4);
  setDvar("NKLMONNPNN", 2048);
  setDvar("MROOOROPKL", 8);
  setDvar("LTQMSPKRKO", 8);

  if(level.createfx_enabled) {
    return;
  }

  scripts\cp\vehicle::init_vehicles();
  level thread scripts\cp\cp_objectives::objectives_init();
  level.ref_13bea = 0;
  level.c130airdrop_getvalidteaminlastplace = [];
  level.hostdamagefactorlow = 0;
  level.map_interaction_func = &scripts\cp\maps\cp_so_aniyah\cp_so_aniyah_interactions::register_interactions;
  level.custom_onspawnplayer_func = &onplayerspawned;
  level.custom_onplayerconnect_func = &onplayerconnect;
  level.weapon_rank_event_table = "scripts/cp/maps/cp_so_aniyah/cp_so_aniyah_weaponrank_event.csv";
  level.player_interaction_monitor = &scripts\cp\maps\cp_so_aniyah\cp_so_aniyah_interactions::level_specific_player_interaction_monitor;
  level.wait_for_interaction_func = &scripts\cp\maps\cp_so_aniyah\cp_so_aniyah_interactions::level_specific_wait_for_interaction_triggered;
  level.interaction_trigger_properties_func = &interaction_trigger_properties;
  level.strike_player_connect_black_screen_fn = &ref_1247b;
  level.mud_sfx = &mud_sfx;

  if(!scripts\engine\utility::flag_exist("introscreen_over")) {
    scripts\engine\utility::flag_init("introscreen_over");
  }

  if(!scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_init("strike_init_done");
  }

  scripts\engine\utility::flag_init("chopper_selection_timeout");
  scripts\engine\utility::flag_init("pilot_selected");
  thread wait_for_pre_game_period();
  thread wait_for_strike_init_complete();
  level thread scripts\cp\cp_movers::main();
  level thread scripts\cp\classes\cp_class_progression::class_progression_init();
  level thread scripts\cp\factions\faction_progression::faction_progression_init();
  level thread scripts\cp\cp_deployablebox::init();
  level.additional_laststand_weapon_exclusion = [];
  thread setup_map_specific_devgui();
  level.devgui_setup_func = &onplayerspawneddevguisetup;

  if(level.scripted_spawner_func.size < 1) {
    scripts\engine\utility::flag_set("strike_init_done");
  }

  if(!scripts\engine\utility::flag_exist("infil_complete")) {
    scripts\engine\utility::flag_init("infil_complete");
  }

  var0 = getDvar("cp_so_aniyah_start_obj", "");

  if(isDefined(var0) && var0 != "") {
    thread rundebugstartobjective(level);
  }

  level.eogscoreboard = ["currency", "kills", "headShots", "downs", "revives"];
  scripts\cp\cp_compass::setupminimap("compass_map_cp_so_aniyah");
  scripts\engine\utility::flag_set("infil_complete");
  thread playing_bomb_counter_beep();
}

function display_ai() {
  level endon("game_ended");
  var0 = (1, 1, 0);
  var1 = (0, 1, 0);
  var2 = (1, 0, 0);
  var3 = ["axis", "allies", "total"];

  for(;;) {
    var4 = 30;

    foreach(var6 in var3) {
      if(var6 == "total") {
        var7 = getaiarray().size;
      } else {
        var7 = getaiarray(var6).size;
      }

      if(var7 < 20) {
        var8 = var1;
      } else if(var7 < 30) {
        var8 = var0;
      } else {
        var8 = var2;
      }

      var4 += 15;
    }

    waitframe();
  }
}

function ref_11c1e() {
  var0 = getEntArray("minimap_corner", "targetname");
  GscBinSkip1(0x45, 0, (11264, -5120, 256));
}

function rundebugstartobjective(var0) {
  wait 2;
  scripts\engine\utility::flag_wait("infil_complete");
  scripts\engine\utility::flag_wait("objective_table_parsed");

  if(isDefined(level.objectivestabledata[var0])) {
    var1 = level.objectivestabledata[var0];

    if(isDefined(var1.ondebugstartfunc)) {
      [[var1.ondebugstartfunc]](var1);
    }

    thread scripts\cp\cp_objectives::run_objective(var1.objname, var1.questtype);
    return;
  }
}

function onplayerspawneddevguisetup(var0) {
  var1 = var0.name;
  var2 = undefined;

  foreach(var4 in level.players) {
    if(var4 == var0) {
      var2 = int(var5);
      break;
    }
  }

  if(isDefined(var2)) {
    thread setupdevguientries(var0, var0, var1);
    return;
  }
}

function setupdevguientries(var0, var1, var2) {}

function wait_for_pre_game_period() {
  if(!isDefined(level.agent_funcs)) {
    level.agent_funcs = [];
  }

  wait 0.2;
}

function wait_for_strike_init_complete() {
  level endon("game_ended");
  scripts\engine\utility::flag_init("personal_ent_zones_initialized");

  if(scripts\engine\utility::flag_exist("strike_init_done")) {
    scripts\engine\utility::flag_wait("strike_init_done");
    var0 = getDvar("scr_strike_name");
    var1 = undefined;

    switch (var0) {
      case "putnewstrikehere":
        break;
      default:
        break;
    }

    return;
  }
}

function registerscriptedagents() {
  scripts\mp\mp_agent::init_agent("mp/iw8_default_agent_definition.csv");
  scripts\mp\agents\soldier\soldier_agent::registerscriptedagent();
  scripts\mp\agents\juggernaut\juggernaut_agent::registerscriptedagent();
}

function onplayerconnect(var0) {}

function onplayerspawned() {
  scripts\cp\gametypes\cp_specops::givedefaultloadout();
  var0 = "iw8_ar_mike4";
  var1 = scripts\cp\cp_weapon::buildweapon_variant(var0, "none", "none", 5);
  self giveweapon(var1);
  self setweaponammoclip(var1, weaponclipsize(var1));
  self setweaponammostock(var1, weaponmaxammo(var1));
  self switchtoweapon(var1);
  var2 = "iw8_pi_mike1911";
  var3 = scripts\cp\cp_weapon::buildweapon_variant(var2, "none", "none", 1);
  self giveweapon(var3);
  self setweaponammoclip(var3, weaponclipsize(var3));
  self setweaponammostock(var3, weaponmaxammo(var3));
  thread scripts\cp\cp_powers::givepower("power_frag", "primary", undefined, undefined, undefined, undefined, 1, 4);
  thread scripts\cp\cp_powers::givepower("power_snapshotGrenade", "secondary", undefined, undefined, undefined, undefined, 1, 4);
  self.last_stand_pistol = scripts\cp\cp_weapon::buildweapon_variant("iw8_pi_mike1911", "none", "none", 1);
  self.weaponlist = self getweaponslistprimaries();
  thread scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(self.weaponlist[0], 1);

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[0])) {
    self.primaryweaponobj = self.weaponlist[0];
  }

  if(isDefined(self.weaponlist) && isDefined(self.weaponlist[1])) {
    self.secondaryweaponobj = self.weaponlist[1];
  }

  self setclientomnvar("ui_hide_minimap", 0);

  if(!scripts\engine\utility::flag("all_players_connected")) {
    self allowmovement(0);
  }

  level.hostdamagefactorlow++;

  if(!isDefined(level.givematchplacementchallenge) && !isDefined(level.give_weapon_alt_clip_ammo_hack) && (level.hostdamagefactorlow > 1 || getdvarint("scr_cp_so_solo_chopper", 0))) {
    ref_13522();
  }

  if(level.hostdamagefactorlow > 1) {
    level.ref_11b47 = 2;
  } else {
    level.ref_11b47 = 4;
  }

  level.ref_11b46 = 47 - level.ref_11b47 * 4 * level.hostdamagefactorlow;
  bomb_vest_controller_holder();

  if(scripts\engine\utility::flag("enemies_spawning")) {
    thread setup_bot_arena();
  }

  thread interruptbombplanting();
}

function setup_map_specific_devgui() {}

function interaction_trigger_properties(var0, var1, var2) {
  switch (var1.script_noteworthy) {
    default:
      self.interaction_trigger setusefov(360);
      self.interaction_trigger sethintrequiresholding(0);

      if(isDefined(var1.useduration)) {
        self.interaction_trigger setuseholdduration(var1.useduration);
      }

      break;
  }
}

function ref_1247b(var0) {}

function ref_14379() {
  while(level.hostdamagefactorlow < getdvarint("NKSQNMMRRQ")) {
    waitframe();
  }
}

function playing_bomb_counter_beep() {
  level.ref_11b4d = 1;
  level.ref_11f7e = [];
  level.openangles = [];
  level.ref_13855 = [];
  createthreatbiasgroup("ground_troops");
  createthreatbiasgroup("roof_troops");
  createthreatbiasgroup("ground_players");
  createthreatbiasgroup("heli");
  setignoremegroup("heli", "ground_troops");
  setignoremegroup("ground_players", "roof_troops");
  scripts\engine\utility::flag_wait("objectives_registered");
  team_revive_kbm_override_callback();
  stream_time();
  thread bwasjuggernaut(7600, 0, "crate_spawns_past_a");
  thread stoppingpower_onweaponcreated();
  thread target_found_speed();
  teamcanrespawn();
  taketeamplunder();
  stoppingpower_clearhcrongameended();
  var0 = scripts\engine\utility::getStruct("truck_infil_end", "targetname");
  var1 = spawn("script_model", var0.origin);
  var1.angles = var0.angles;
  var1 setModel("veh8_mil_lnd_umike_infil");
  var2 = getEnt("player32x32x256", "targetname");
  var2.origin = (4249.97, 2341.5, 200);
  var2.angles = (0, 114, 0);
  scripts\cp\laser_traps\cp_laser_traps::ref_1437a();
  thread ref_13f26();
  scripts\engine\utility::flag_set("all_players_connected");
  supersupplydropbeginuse();
  thread supportbox_watch_flight();
  thread subway_fast_travel_teleport_data();
  thread ref_12758("dx_cps_kama_mobile_heist_nag_find_phones_20");

  foreach(var4 in level.players) {
    var4 allowmovement(1);
    var4 setthreatbiasgroup("ground_players");
  }

  scripts\cp\laser_traps\cp_laser_traps::ref_13067();
  var6 = scripts\engine\utility::getStruct("infil_start_area", "targetname");

  while(brevent1playerthink(var6.origin, 450) && !getdvarint("scr_cp_so_solo_chopper")) {
    wait 0.1;
  }

  foreach(var4 in level.players) {
    thread setup_bot_arena();
  }

  scripts\engine\utility::flag_set("enemies_spawning");
  thread setup_heli_starts();
  thread setup_enemytype_on_spawner();
  thread bot_add_landing_spot("intel_1_extra", undefined, undefined, undefined, 1);
  thread bot_add_landing_spot("intel_2_extra", "intel_2", 600, 1, 2);
  thread bot_add_landing_spot("intel_3_extra", "intel_3", 2000, 2, 4);
  level waittill("exfil_complete");
  level notify("end_of_mission");
  setomnvar("cp_objective_index", 0);
  level thread[[level.endgame]]("allies", level.end_game_string_index["win"]);
}

function ref_12758(var0) {
  if(!isDefined(level.ref_121a7)) {
    level.ref_121a7 = spawn("script_origin", (0, 0, 0));
  }

  level.ref_121a7 stopsounds();
  var1 = lookupsoundlength(var0) * 0.001;
  level.ref_121a7 playSound(var0);
  wait var1;
}

function ref_1244f(var0, var1) {
  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(level.givematchplacementchallenge.vo)) {
    level.givematchplacementchallenge.vo = spawn("script_origin", (0, 0, 0));
  }

  level.givematchplacementchallenge.vo stopsounds();
  var2 = lookupsoundlength(var0) * 0.001;

  if(var1) {
    level.givematchplacementchallenge.vo playsoundtoplayer(var0, level.givematchplacementchallenge);
  } else {
    level.givematchplacementchallenge.vo playSound(var0);
  }

  wait var2;
}

function ref_12450(var0) {
  ref_1244f(var0, 1);
}

function vip_onrespawn(var0) {
  if(isDefined(level.givematchplacementchallenge) && isDefined(level.choppergunners[0]) && isDefined(level.choppergunners[0])) {
    if(level.givematchplacementchallenge == var0) {
      return true;
    }

    if(scripts\engine\utility::is_equal(level.choppergunners[0], var0)) {
      return true;
    }

    if(scripts\engine\utility::is_equal(level.choppergunners[0].turret, var0)) {
      return true;
    }
  }

  return false;
}

function ref_123d5(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 0;
  }

  if(isDefined(level.givematchplacementchallenge) && !isDefined(level.givematchplacementchallenge.waittill_player_deposits)) {
    level.givematchplacementchallenge.waittill_player_deposits = 0;
  }

  if(vip_onrespawn(var0) && (scripts\engine\utility::time_has_passed(level.givematchplacementchallenge.waittill_player_deposits, 6) || var2)) {
    level.givematchplacementchallenge.waittill_player_deposits = gettime();
    ref_1244f(scripts\engine\utility::random(var1));
    return;
  }
}

function getdomplateradius() {
  self endon("death");
  self endon("crashing");
  var0 = ["dx_vom_apap_killstreak_chopper_reloading_10", "dx_vom_apap_killstreak_chopper_reloading_20"];
  level.givematchplacementchallenge.playapacheonly_dialogue = 0;
  level.givematchplacementchallenge.getggweapontablelootvariants = 0;

  for(;;) {
    level.givematchplacementchallenge waittill("shoot_missile");
    level.givematchplacementchallenge.playapacheonly_dialogue = 1;
    level.givematchplacementchallenge.getggweapontablelootvariants = 0;

    if(self.missilesleft == 0) {
      level.givematchplacementchallenge.waittill_player_deposits = gettime();
      level.givematchplacementchallenge.getggweapontablelootvariants = 1;
      ref_12450(scripts\engine\utility::random(var0));
      wait 3;
    }
  }
}

function getdropbagdelay() {
  self endon("death");
  self endon("crashing");
  var0 = ["dx_vom_apap_killstreak_chopper_combat_200", "dx_vom_apap_killstreak_chopper_combat_210", "dx_vom_apap_killstreak_chopper_combat_220", "dx_vom_apap_killstreak_chopper_combat_230"];

  for(;;) {
    self waittill("missiles_refilled");

    if(isDefined(level.givematchplacementchallenge) && !isDefined(level.givematchplacementchallenge.waittill_player_deposits)) {
      level.givematchplacementchallenge.waittill_player_deposits = 0;
    }

    if(scripts\engine\utility::time_has_passed(level.givematchplacementchallenge.waittill_player_deposits, 6) || istrue(level.givematchplacementchallenge.getggweapontablelootvariants)) {
      level.givematchplacementchallenge.waittill_player_deposits = gettime();
      ref_12450(scripts\engine\utility::random(var0));
      wait 18;
    }
  }
}

function ref_123f4() {
  if(!isDefined(level.givematchplacementchallenge.waittill_player_deposits)) {
    level.givematchplacementchallenge.waittill_player_deposits = 0;
  }

  if(scripts\engine\utility::time_has_passed(level.givematchplacementchallenge.waittill_player_deposits, 6)) {
    level.givematchplacementchallenge.waittill_player_deposits = gettime();

    if(give_super_ammo_after_loadout_given(self.origin)) {
      if(randomint(100) > 50) {
        ref_12450("dx_vom_apap_killstreak_chopper_combat_160");
        return;
      }

      ref_12450("dx_vom_apap_killstreak_chopper_combat_170");
      return;
    }

    if(level.choppergunners[0] scripts\engine\math::is_point_on_right(self.origin)) {
      ref_12450("dx_vom_apap_killstreak_chopper_combat_190");
      return;
    }

    ref_12450("dx_vom_apap_killstreak_chopper_combat_180");
    return;
  }
}

function team_revive_kbm_override_callback() {
  level.giveplayerpoints = ["dx_vom_apap_killstreak_chopper_combat_120", "dx_vom_apap_killstreak_chopper_combat_130", "dx_vom_apap_killstreak_chopper_combat_150", "dx_vom_apap_killstreak_chopper_combat_20", "dx_vom_apap_killstreak_chopper_combat_310", "dx_vom_apap_killstreak_chopper_combat_70", "dx_vom_apap_killstreak_chopper_combat_90", "dx_vom_apap_killstreak_chopper_reactions_10", "dx_vom_apap_killstreak_chopper_reactions_100", "dx_vom_apap_killstreak_chopper_reactions_20", "dx_vom_apap_killstreak_chopper_reactions_40"];
  level.givepointsandxp = ["dx_vom_apap_killstreak_chopper_reactions_50", "dx_vom_apap_killstreak_chopper_reactions_60"];
  level.givequest = ["dx_vom_apap_killstreak_chopper_reactions_110", "dx_vom_apap_killstreak_chopper_reactions_80"];
}

function teamcanrespawn() {
  var0 = scripts\engine\utility::getStructArray("weapon_variant_spawn", "targetname");

  foreach(var2 in var0) {
    var3 = strtok(var2.weaponinfo, "|");
    var4 = var3[0];
    var5 = int(var3[1]);
    var6 = scripts\cp\cp_weapon::buildweapon_variant(var4, "none", "none", var5);
    var7 = spawn("weapon_" + createheadicon(var6), var2.origin, 17);
    var7.angles = var2.angles;
    var7 scripts\anim\shared::setscriptammo(var4, var2);
  }

  init_gas_trap_room("me_riverbed_rock_cluster_md_03", (9746.25, 541.635, 232.99), (359.463, 336.201, -6.52015));
  init_gas_trap_room("me_riverbed_rock_cluster_md_03", (9716, 500.707, 237.361), (0, 269.056, 0));
  init_gas_trap_room("me_riverbed_rock_cluster_md_03", (9721.62, 582.172, 232.99), (359.463, 291.201, -6.52017));
  init_gas_trap_room("me_riverbed_rock_cluster_md_03", (9671.29, 574.622, 237.349), (356.672, 224.06, -0.874738));
}

function init_gas_trap_room(var0, var1, var2) {
  var3 = spawn("script_model", var1);
  var3.angles = var2;
  var3 setModel(var0);
}

function init_loadout_selection_structs(var0, var1) {
  var2 = spawnStruct();
  var2.origin = var0;
  var2.angles = var1;
  return var2;
}

function taketeamplunder() {
  var0 = scripts\engine\utility::getStructArray("rpg_pickup", "targetname");

  if(!isDefined(var0) || var0.size == 0) {
    var0 = [];
    GscBinSkip0(0x2e, 0, init_loadout_selection_structs((3414.02, -206.307, 438.851), (0.937701, 163.49, -73.7181)));
  }

  var1 = "iw8_la_rpapa7";
  var2 = scripts\cp\cp_weapon::buildweapon(var1);

  foreach(var4 in var0) {
    var5 = spawn("weapon_" + createheadicon(var2), var4.origin, 17);
    var5.angles = var4.angles;
    var5 itemweaponsetammo(weaponclipsize(var5), weaponmaxammo(var5));
  }
}

function stoppingpower_onweaponcreated() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  level.bronattackerdamagenottracked = [];
  var0 = scripts\engine\utility::getStructArray("sb_ammo", "targetname");

  foreach(var2 in var0) {
    var3 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var2.origin, var2.angles);
    setheadiconsnaptoedges(var3.headiconid, 1000);
    level.bronattackerdamagenottracked[level.bronattackerdamagenottracked.size] = var3;
  }

  level.ref_13855[level.ref_13855.size] = broadcast_health((7915.56, 719.412, 309.503), (0, 35.2279, 0));
  scripts\engine\utility::flag_wait("crate_spawns_past_a");
  thread bwasjuggernaut(6400, 0, "crate_spawns_past_b");
  broadcast_health((6286.55, 98.5832, 304.667), (0, 50.2161, 0));
  broadcast_health((3952.29, 2727.76, 509.668), (0, 193.771, 0));
  scripts\engine\utility::flag_wait("crate_spawns_past_b");
  last_exfil_nag();
  broadcast_health((3286.01, -309.974, 637.655), (0, 6.95607, 0));
}

function last_exfil_nag() {
  foreach(var1 in level.ref_13855) {
    var1 delete();
  }
}

function broadcast_health(var0, var1) {
  var2 = scripts\cp\laser_traps\cp_laser_traps::brplayerhudoutlineforteammatesupdate(var0, var1);
  setheadiconsnaptoedges(var2.headiconid, 1000);
  level.bronattackerdamagenottracked[level.bronattackerdamagenottracked.size] = var2;
  return var2;
}

function supportbox_watch_flight() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  level.weapon_xp_iw8_pi_decho = [];
  var0 = scripts\engine\utility::getStructArray("sb_lethal", "targetname");

  foreach(var2 in var0) {
    var3 = scripts\engine\utility::getclosest(var2.origin, scripts\engine\utility::array_combine(level.ref_11f7e, [scripts\engine\utility::getStruct("exfil", "targetname")]));

    if(level.ref_11f7e["intel_1"] == var3 || level.ref_11f7e["intel_2"] == var3) {
      var4 = scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback(var2.origin, var2.angles);
    } else {
      var4 = scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled(var2.origin, var2.angles);
    }

    setheadiconsnaptoedges(var4.headiconid, 1000);
    level.weapon_xp_iw8_pi_decho[level.weapon_xp_iw8_pi_decho.size] = var4;
  }

  level.ref_13855[level.ref_13855.size] = weapon_xp_iw8_pi_golf21(&scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback, (9603.81, 604.333, 276.825), (0, 324.1, 0));
  level.ref_13855[level.ref_13855.size] = weapon_xp_iw8_pi_golf21(&scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled, (9585.84, 617.592, 277.95), (0, 331.922, 0));
  weapon_xp_iw8_pi_golf21(&scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled, (7705.28, 1012.39, 306.169), (0, 212.005, 0));
  scripts\engine\utility::flag_wait("crate_spawns_past_a");
  weapon_xp_iw8_pi_golf21(&scripts\cp\laser_traps\cp_laser_traps::focus_fire_outline_enabled, (6189.07, 249.703, 300.327), (0, 225.653, 0));
  weapon_xp_iw8_pi_golf21(&scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback, (4105.12, 2344.8, 516.591), (0, 169.026, 0));
  scripts\engine\utility::flag_wait("crate_spawns_past_b");
  weapon_xp_iw8_pi_golf21(&scripts\cp\laser_traps\cp_laser_traps::playerplunderlosedepositcallback, (3479.5, 125.858, 440.031), (0, 194.667, 0));
}

function weapon_xp_iw8_pi_golf21(var0, var1, var2) {
  var3 = [[var0]](var1, var2);
  setheadiconsnaptoedges(var3.headiconid, 1000);
  level.weapon_xp_iw8_pi_decho[level.weapon_xp_iw8_pi_decho.size] = var3;
  return var3;
}

function target_found_speed() {
  scripts\engine\utility::flag_wait("scriptables_ready");
  level.ref_13a14 = [];
  var0 = scripts\engine\utility::getStructArray("sb_tactical", "targetname");

  foreach(var2 in var0) {
    var3 = scripts\cp\laser_traps\cp_laser_traps::ref_13433(var2.origin, var2.angles);
    setheadiconsnaptoedges(var3.headiconid, 1000);
    level.ref_13a14[level.ref_13a14.size] = var3;
  }

  level.ref_13855[level.ref_13855.size] = ref_13a15(&scripts\cp\laser_traps\cp_laser_traps::player_limitedammo, (9642.09, 572.949, 276.446), (0, 317.414, 0));
  level.ref_13855[level.ref_13855.size] = ref_13a15(&scripts\cp\laser_traps\cp_laser_traps::ref_13433, (9625.2, 589.434, 277.056), (0, 322.444, 0));
  ref_13a15(&scripts\cp\laser_traps\cp_laser_traps::player_limitedammo, (7851.16, 700.082, 311.378), (0, 22.4981, 0));
  scripts\engine\utility::flag_wait("crate_spawns_past_a");
  ref_13a15(&scripts\cp\laser_traps\cp_laser_traps::player_limitedammo, (6113.88, 301.455, 297.712), (0, 101.655, 0));
  ref_13a15(&scripts\cp\laser_traps\cp_laser_traps::player_limitedammo, (3917.02, 2626.14, 366.841), (0, 301.772, 0));
  ref_13a15(&scripts\cp\laser_traps\cp_laser_traps::player_limitedammo, (3529.03, -202.147, 440.773), (0, 31.7719, 0));
}

function ref_13a15(var0, var1, var2) {
  var3 = [[var0]](var1, var2);
  setheadiconsnaptoedges(var3.headiconid, 1000);
  level.ref_13a14[level.ref_13a14.size] = var3;
  return var3;
}

function stream_time() {
  for(var0 = 1; var0 < 4; var0++) {
    var1 = scripts\engine\utility::getStruct("carepackage_intel_" + var0, "targetname");
    var2 = scripts\cp\laser_traps\cp_laser_traps::get_enter_leave_station_time(var1.origin, var1.angles);
    var3 = scripts\cp\laser_traps\cp_laser_traps::get_ending_struct(var2);
    var4 = scripts\cp\laser_traps\cp_laser_traps::get_emp_effect_duration(var2);

    switch (var0) {
      case 1:
        thread scripts\cp\laser_traps\cp_laser_traps::get_end_ang(var2, var3, var4, "sentry", &ref_124a2);
        break;
      case 2:
        thread scripts\cp\laser_traps\cp_laser_traps::get_end_ang(var2, var3, var4, "cluster_strike", &ref_124a3);
        break;
      case 3:
        thread scripts\cp\laser_traps\cp_laser_traps::get_end_ang(var2, var3, var4, "juggernaut", &ref_124a4);
        break;
      default:
        break;
    }

    setheadiconsnaptoedges(var2.headicon, 1000);
  }
}

function ref_124a2(var0, var1, var2) {
  thread ref_12758("dx_mpa_rutl_sentry_gun_achieve");
}

function ref_124a3(var0, var1, var2) {
  thread ref_12758("dx_mpa_rutl_cluster_strike_achieve");
}

function ref_124a4(var0, var1, var2) {
  thread ref_12758("dx_mpa_rutl_juggernaut_achieve");
}

function ref_13522() {
  var0 = scripts\engine\utility::getStruct("carepackage_apache", "targetname");
  level.give_weapon_alt_clip_ammo_hack = scripts\cp\laser_traps\cp_laser_traps::get_enter_leave_station_time(var0.origin, var0.angles);
  var1 = scripts\cp\laser_traps\cp_laser_traps::get_ending_struct(level.give_weapon_alt_clip_ammo_hack);
  var2 = scripts\cp\laser_traps\cp_laser_traps::get_emp_effect_duration(level.give_weapon_alt_clip_ammo_hack);
  thread giveachievementpilotkill(level.give_weapon_alt_clip_ammo_hack, var1, var2);
}

function giveachievementpilotkill(var0, var1, var2, var3) {
  var0 endon("pilot_selected");
  var4 = createnavobstaclebybounds(var0.origin, (30, 10, 64), var0.angles);
  var5 = var0 scripts\cp\utility::killstreak_createobjective("icon_minimap_carepackage", "allies", 1, 1, 0);
  var6 = deleteheadicon(var0);
  setheadiconfriendlyimage(var6, "hud_icon_killstreak_apache");
  addclienttoheadiconmask(var6, -7);
  setheadiconmaxdistance(var6, 0);
  setheadiconsnaptoedges(var6, 1000);
  setheadiconowner(var6, undefined);
  setheadiconzoffset(var6, 1);
  hideheadiconfromplayersinmask(var6);
  var0.headicon = var6;
  var0 setCursorHint("HINT_NOICON");
  var0 sethintdisplayrange(256);
  var0 setuserange(100);
  var0 setusefov(180);
  var0 sethintdisplayfov(180);
  var0 setuseholdduration("duration_short");
  var0 setusepriority(0);
  var0 sethintonobstruction("show");
  var0 sethinttag("tag_use");
  var0 makeusable();
  var0 setHintString(&"CP_SO_ANIYAH/APACHE_INTERACT");
  var0.hostage_room_enemy_watcher = undefined;
  thread give_xp_to_all_players_hack(var0, var2, var1, var5, var4);

  for(;;) {
    var0 waittill("trigger", var7);

    if(!isPlayer(var7) || istrue(var7 scripts\cp\cp_outofbounds::isoob())) {
      continue;
    }

    thread ref_1428e(var7);
  }
}

function give_xp_to_all_players_hack(var0, var1, var2, var3, var4) {
  var0 waittill("pilot_selected");
  setomnvarforallclients("ui_vote_type", 0);
  var0 makeunusable();
  var0 notsolid();
  setheadiconimage(var0.headicon);
  var0.headicon = undefined;
  var1 delete();
  var2 setscriptablepartstate("anims", "capture", 0);
  var2 setscriptablepartstate("capture", "start", 0);
  objective_state(var3, "done");
  scripts\cp\utility::nonobjective_returnobjectiveid(var3);
  wait 2;
  var0 setCanDamage(0);
  var0 setnonstick(1);
  destroynavobstacle(var4);
  var2 delete();
  var0 delete();
}

function ref_1428e(var0) {
  var0 endon("pilot_selected");
  self endon("last_stand");
  self setclientomnvar("ui_vote_type", 1);
  thread waittill_juggs_alive(var0);
  self waittill("luinotifyserver", var1);

  if(var1 == "apache_yes") {
    thread ref_124a0(self);
    var0 notify("pilot_selected");
    return;
  }
}

function waittill_juggs_alive(var0) {
  var0 endon("pilot_selected");
  self waittill("last_stand");
  self setclientomnvar("ui_vote_type", 0);
}

function ref_124a0(var0) {
  level endon("game_ended");
  var0 endon("disconnect");
  wait 0.1;

  while(!var0 isonground() || var0 isonladder() || var0 isjumping()) {
    waitframe();
  }

  if(istrue(var0 scripts\cp\cp_outofbounds::isoob())) {
    var1 = 0;

    for(;;) {
      wait 0.05;

      if(!istrue(var0 scripts\cp\cp_outofbounds::isoob())) {
        var1++;
      } else {
        var1 = 0;
      }

      if(var1 >= 20) {
        break;
      }
    }
  }

  level.givematchplacementchallenge = var0;
  var0.stopcirclesatgameend = 1;
  thread setup_crates_to_mark();
  var0 playerhide();
  var0 vehiclepinonminimap(1);
  var0 allowmovement(0);
  var2 = scripts\engine\utility::array_remove(level.players, var0);
  level.givematchplacementchallenge.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", var0, var2, var0, 1, 1);

  foreach(var4 in var2) {
    var4.headicon = deleteheadicon(var4);
    setheadiconenemyimage(var4.headicon, "hud_icon_head_equipment_friendly");
    addclienttoheadiconmask(var4.headicon, 0);
    setheadiconzoffset(var4.headicon, 1);
    setheadiconsnaptoedges(var4.headicon, 31999);
    setheadiconmaxdistance(var4.headicon, 31999);
    setheadicondrawthroughgeo(var4.headicon, 1);
    setheadiconowner(var4.headicon, "allies");

    foreach(var6 in var2) {
      addteamtoheadiconmask(var4.headicon, var6);
    }

    setheadiconteam(var4.headicon);
  }

  var9 = 0;

  for(;;) {
    switch (var9) {
      case 0:
        scripts\engine\utility::delaythread(4, &ref_12758, "dx_mpa_rutl_chopper_gunner_friendly_use");
        break;
      case 1:
        scripts\engine\utility::delaythread(4, &ref_12758, "dx_vom_apap_killstreak_chopper_combat_60");
        break;
      case 2:
        scripts\engine\utility::delaythread(4, &ref_12758, "dx_vom_apap_killstreak_chopper_intro_110");
        var9 = -1;
        break;
      default:
        break;
    }

    var9++;
    var0 scripts\cp_mp\killstreaks\chopper_gunner::tryusechoppergunner();
    level.givematchplacementchallenge.chopper = level.choppergunners[0];
    level.givematchplacementchallenge.chopper.owner = var0;
    level.givematchplacementchallenge.chopper.occupants = [var0];
    level.givematchplacementchallenge.attractor = missile_createattractorent(level.givematchplacementchallenge.chopper, 1000, 7000);
    level.givematchplacementchallenge.chopper setthreatbiasgroup("heli");
    thread getdomplateradius();
    thread getdropbagdelay();
    var0 notify("end_custom_firendly_dmg_func");
    var0 setthreatbiasgroup("heli");
    level.givematchplacementchallenge.chopper waittill("death");
    var0 thread scripts\cp\utility::freezecontrolswrapper(1);
    var0 playerhide();
    var0 vehiclepinonminimap(1);
    var0 setclientomnvar("ui_hide_hud", 1);
    wait 2.25;
    var10 = 10;
    thread black_screen(var0, var10);
    thread givequestrewards(var0);
    wait 7.5;
    var0 thread scripts\cp\utility::freezecontrolswrapper(0);
    var0 scripts\engine\utility::delaycall(2.5, &setclientomnvar, "ui_hide_hud", 0);
  }
}

function interruptbombplanting() {
  self endon("death_or_disconnect");
  self endon("end_custom_firendly_dmg_func");
  self.players_monitor = 0;

  while(isDefined(self)) {
    self waittill("damage", var0, var1);

    if(isDefined(level.givematchplacementchallenge) && isDefined(level.choppergunners) && isDefined(level.choppergunners[0]) && isDefined(level.choppergunners[0].turret)) {
      if(!isDefined(self) || !isDefined(var1)) {
        return;
      }

      if(level.givematchplacementchallenge == var1 || scripts\engine\utility::is_equal(level.choppergunners[0], var1) || scripts\engine\utility::is_equal(level.choppergunners[0].turret, var1)) {
        level childthread scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "check_fire_ally");
        level childthread scripts\cp\cp_player_battlechatter::trysaylocalsound(level.givematchplacementchallenge, "check_fire_ally");
        waitframe();
        GscBinSkip4(0x35, level.givematchplacementchallenge);
      }
    }

    waitframe();
  }
}

function smokeglvfx(var0) {
  if(istrue(self.inlaststand) && !istrue(self.players_monitor)) {
    self.players_monitor = 1;
    childthread scripts\cp\cp_hud_message::tutorialprint(&"CP_SO_ANIYAH/APACHE_DOWNED", 5);
    var0 childthread scripts\cp\cp_hud_message::tutorialprint(&"CP_SO_ANIYAH/APACHE_FRIENDLY_FIRE", 5);
    wait 20;
    self.players_monitor = 0;
    return;
  }
}

function givequestrewards(var0) {
  for(var1 = int(var0); var1 > -1; var1--) {
    self setclientomnvar("ui_match_start_countdown", var1);
    wait 1;
  }
}

function give_super_ammo_after_loadout_given(var0) {
  if(isDefined(level.givematchplacementchallenge)) {
    return scripts\engine\utility::within_fov(level.givematchplacementchallenge getEye(), level.givematchplacementchallenge getplayerangles(), var0, 0.8);
  }

  return 0;
}

function supersupplydropbeginuse() {
  level.train_elements_disable = getdvarint("scr_cp_so_intel_collected", 0);

  for(var0 = 1; var0 < 4; var0++) {
    var1 = scripts\engine\utility::getStruct("intel_" + var0, "targetname");
    var2 = scripts\cp\laser_traps\cp_laser_traps::trial_active_fob(var1.origin, var1.angles, &trial_end_time);
    level.ref_11f7e["intel_" + var0] = var2;

    switch (var0) {
      case 1:
        var2.helis_assault3_hangar = 1;
        var2.icon = "icon_waypoint_dom_a";
        break;
      case 2:
        var2.helis_assault3_hangar = 2;
        var2.icon = "icon_waypoint_dom_b";
        break;
      case 3:
        var2.helis_assault3_hangar = 4;
        var2.icon = "icon_waypoint_dom_c";
        break;
    }

    var2.ref_11f64 = scripts\cp\cp_objectives::requestworldid("intel_" + var0, 10);
    objective_setdescription(var2.ref_11f64, &"CP_SO_ANIYAH/OBJ_GATHER_INTEL");
    objective_setlabel(var2.ref_11f64, &"CP_SO_ANIYAH/INTEL");
    objective_setplayintro(var2.ref_11f64, 1);
    objective_setplayoutro(var2.ref_11f64, 0);
    objective_position(var2.ref_11f64, var1.origin + (0, 0, 15));
    objective_icon(var2.ref_11f64, var2.icon);
    objective_state(var2.ref_11f64, "current");
  }

  setomnvar("cp_objective_index", 1);
  setomnvar("cp_objective_sub_1_index", 2);
}

function trial_end_time(var0, var1) {
  var2 = 0;
  level.player playlocalsound("cp_intel_pickup");

  if(level.train_elements_disable == 0) {
    var2 = 1;
    thread ref_12758("dx_cps_kama_safehouse_intel_gathered_10");
  }

  level.ref_11f7e = scripts\engine\utility::array_remove(level.ref_11f7e, var1);
  level.train_elements_disable |= var1.helis_assault3_hangar;
  level notify("intel_collected");
  level.ref_11b4d = 2;
  objective_state(var1.ref_11f64, "done");
  thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_SO_ANIYAH/INTEL_GATHERED", "allies", 8);

  if(!var2) {
    if(level.train_elements_disable == 7) {
      thread ref_12758("dx_mpa_rutl_exfillosing_start_losingteam");
      return;
    }

    thread ref_12758("dx_cps_kama_safehouse_intel_gathered_20");
    return;
  }
}

function ref_11a9a(var0) {
  if(!isDefined(self.origin)) {
    return;
  }

  var1 = spawn("script_model", self.origin);
  var1 endon("death");
  var1.isusable = 1;
  var1 setCursorHint("hint_button");
  var1 sethintdisplayfov(360);
  var1 setusefov(135);
  var1 sethintdisplayrange(500);
  var1 setuserange(80);
  var1 sethintonobstruction("show");
  var1 setuseholdduration("duration_none");
  var1 sethintlockplayermovement(1);
  var1 makeusable();
  var1 setHintString(var0);
  var1.userate = 1;
  var1.laststandfinisherdone = 4;
  var1.curprogress = 0;
  var1.usetime = 5;
  var1.inuse = 0;
  var1.playerusing = undefined;

  for(;;) {
    var1 waittill("trigger", var2);
    var1 delete();
    break;
  }
}

function subway_fast_travel_teleport_data() {
  scripts\engine\utility::flag_init("exfil_signalled");

  while(level.train_elements_disable < 7) {
    level waittill("intel_collected");
  }

  var0 = scripts\engine\utility::getStruct("exfil", "targetname");
  level.ref_11f7e["exfil"] = var0;
  var0.ref_11f64 = scripts\cp\cp_objectives::requestworldid("exfil", 10);
  objective_setdescription(var0.ref_11f64, &"CP_SO_ANIYAH/REACH_SIGNAL_EXFIL");
  objective_setlabel(var0.ref_11f64, &"CP_SO_ANIYAH/OBJ_EXFIL");
  objective_setplayintro(var0.ref_11f64, 1);
  objective_setplayoutro(var0.ref_11f64, 0);
  objective_position(var0.ref_11f64, var0.origin + (0, 0, 15));
  objective_icon(var0.ref_11f64, "icon_waypoint_vehicle_little_bird");
  objective_state(var0.ref_11f64, "current");
  setomnvar("cp_objective_sub_1_index", 5);
  ref_11a9a(var0, &"CP_SO_ANIYAH/SIGNAL_HELO");
  scripts\engine\utility::flag_set("exfil_signalled");
  thread scripts\cp\cp_hud_message::teamhudtutorialmessage(&"CP_SO_ANIYAH/HOLD_LZ_LONG", "allies", 8);
  thread ref_12758("dx_cps_kama_bank_hvt_down_10");
  objective_setdescription(var0.ref_11f64, &"CP_SO_ANIYAH/HOLD_LZ_LONG");
  objective_setlabel(var0.ref_11f64, &"CP_SO_ANIYAH/HOLD_LZ");
  setomnvar("cp_objective_sub_1_index", 6);
  var1 = scripts\engine\utility::getStruct("exfil_signal", "targetname");
  magicgrenademanual("deploy_airdrop_mp", var1.origin, (0, 0, 0), 0.01);
  wait 10;
  var2 = scripts\common\utility::getvehiclespawner("exfil_heli", "targetname");

  foreach(var4 in scripts\engine\utility::getStructArray(var2.target, "targetname")) {
    var4 scripts\cp\laser_traps\cp_laser_traps::add_spawn_function(&ref_11a8f);

    if(isDefined(var4.speed)) {
      for(var5 = var4; isDefined(var5.target); var5 = scripts\engine\utility::getStruct(var5.target, "targetname")) {
        if(isDefined(var5.speed)) {
          var5.speed /= 2;
          continue;
        }

        var5.speed = 15;
      }
    }
  }

  var7 = var2 scripts\common\vehicle::spawn_vehicle_and_gopath();
  var7 vehicleshowonminimap(1);
  var7 aiupdatecoverexposetype(1);
  var7 scripts\common\vehicle::godon();
  var7 waittill("reached_dynamic_path_end");
  var7 setvehgoalpos(var7.origin + (0, 0, 30), 1);
  var7 sethoverparams(5);
  thread ref_142dd();
  objective_setdescription(var0.ref_11f64, &"CP_SO_ANIYAH/REACH_EXFIL");
  objective_setlabel(var0.ref_11f64, &"CP_SO_ANIYAH/OBJ_EXFIL");
  createnavobstaclebyent(var7);
  wait 3;

  while(!brevent1playerthink(var7.origin, 150)) {
    waitframe();
  }

  level notify("exfil_complete");
  wait 1.5;
  thread ref_12758("dx_mpa_rutl_gamestate_win");
}

function ref_11a8f() {
  self.ignoreme = 1;
  self setCanDamage(0);
  self setCanRadiusDamage(0);

  for(;;) {
    self.health = 10000;
    self waittill("damage");
  }
}

function ref_142dd() {
  level endon("exfil_complete");
  var0 = 1;

  for(;;) {
    if(var0) {
      ref_12758("dx_mpa_rutl_exfilwinning_arrive_winningteam");
    } else {
      ref_12758("dx_mpa_rutl_exfillosing_arrive_losingteam");
    }

    var0 = !var0;
    wait 10;
  }
}

function bomb_vest_controller_holder() {
  level.select_equipment_spawners = scripts\engine\math::remap(level.hostdamagefactorlow, 1, 4, 600, 800);
  level.select_hostage_room_one_spawners = scripts\engine\math::remap(level.hostdamagefactorlow, 1, 4, 1000, 1200);
  level.select_chopper_boss_target_player = scripts\engine\math::remap(level.hostdamagefactorlow, 1, 4, 1500, 1700);
  level.select_cliff_one_spawners = scripts\engine\math::remap(level.hostdamagefactorlow, 1, 4, 2000, 2200);
}

function bomb_vest_detonator_control_think(var0) {
  wait 0.1;
  self setthreatbiasgroup("ground_troops");

  switch (self.agent_type) {
    case "actor_enemy_cp_alq_desert_shotgun":
      self.goalradius = level.select_equipment_spawners;
      break;
    case "actor_enemy_cp_alq_desert_smg":
      self.goalradius = level.select_hostage_room_one_spawners;
      break;
    case "actor_enemy_cp_alq_desert_ar":
      self.goalradius = level.select_chopper_boss_target_player;
      break;
    default:
      self.goalradius = level.select_cliff_one_spawners;
      break;
  }

  if(!getdvarint("scr_cp_so_solo_chopper", 0) && scripts\engine\utility::is_equal(level.givematchplacementchallenge, var0)) {
    var1 = scripts\engine\utility::random(scripts\engine\utility::array_remove(level.players, var0));
  } else {
    var1 = var1;
  }

  self setgoalentity(var1, 1);
  thread blueprintextract_cleanupwhennoavailablelocales();
  self waittill("death", var2);
  thread ref_123d5(var2, scripts\engine\utility::array_combine(level.giveplayerpoints, level.givepointsandxp));
  var1 notify("enemy_died");
}

function blueprintextract_cleanupwhennoavailablelocales(var0) {
  self endon("death");

  if(isDefined(var0)) {
    while(!(level.train_elements_disable &var0)) {
      level waittill("intel_collected");
    }
  }

  for(;;) {
    wait randomintrange(5, 16);

    if(!give_super_ammo_after_loadout_given(self.origin) && !c130_door_badplace_id(self.origin, 2500)) {
      self.nocorpse = 1;
      self kill();
    }
  }
}

function bonustimeapplied(var0) {
  self setthreatbiasgroup("roof_troops");
  thread bomb_case_detonator_wire_color_change_think();
  thread blueprintextract_cleanupwhennoavailablelocales();
  self waittill("death", var1);
  thread ref_123d5(var1, scripts\engine\utility::array_combine(level.giveplayerpoints, level.givepointsandxp));
  var0 notify("rpg_guy_died");
}

function bomb_case_detonator_wire_color_change_think() {
  self endon("death");
  self.favoriteenemy = level.choppergunners[0];
  self waittill("shooting");
  ref_123f4();
}

function gatherstadiumlocs(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  return level.openangles.size + var0 < level.ref_11b46;
}

function bot_add_landing_spot(var0, var1, var2, var3, var4) {
  var5 = undefined;

  if(isDefined(var1)) {
    var5 = scripts\engine\utility::getStruct(var1, "targetname");

    while(!(level.train_elements_disable &var3) && !c130_door_badplace_id(var5.origin, var2)) {
      scripts\engine\utility::waittill_notify_or_timeout("intel_collected", 1);
    }

    if(var1 == "intel_3") {
      wait 1;
    }
  }

  var6 = scripts\engine\utility::getStructArray(var0, "targetname");

  foreach(var8 in var6) {
    while(!gatherstadiumlocs()) {
      wait 0.1;
    }

    var9 = var8 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();

    if(isDefined(var9) && isalive(var9)) {
      thread bomb_case_detonator_control_think();
      thread blueprintextract_cleanupwhennoavailablelocales(var9);
    }

    wait 0.1;
  }

  if(var0 == "intel_3_extra") {
    var11 = [];
    GscBinSkip0(0x2e, 0, init_for_final_sequence((3104.26, 405.641, 418), (0, 270, 0)), var4, var9);
  }
}

function init_for_final_sequence(var0, var1) {
  var2 = spawnStruct();
  var2.origin = var0;
  var2.angles = var1;
  var2.count = 0;
  var2.model = "opforce_juggernaut";
  var2.script_count = 0;
  var2.script_demeanor = "default";
  var2.script_dist_only = 0;
  var2.script_dot = 0;
  var2.script_escalation_level = 0;
  var2.script_forcespawn = 0;
  var2.script_goalheight = 0;
  var2.script_noteworthy = "juggernaut";
  var2.script_origin_other = (0, 0, 0);
  var2.script_radius = 0;
  var2.script_reuse_max = 0;
  var2.script_speed = 0;
  var2.script_team = "axis";
  var2.script_timeout = 0;
  var2.script_type = "actor_enemy_cp_rus_juggernaut";
  return var2;
}

function bomber_death_watcher() {
  self endon("death");
  setmusicstate("cp_juggernaut_intro");
  GscBinSkip4(0x35);
}

function ref_1333a() {
  self.objindex = scripts\cp\cp_objectives::requestworldid("obj_" + self getentitynumber(), 5);
  objective_setplayintro(self.objindex, 0);
  objective_setplayoutro(self.objindex, 0);
  objective_setownerteam(self.objindex, "axis");
  objective_state(self.objindex, "active");
  objective_icon(self.objindex, "icon_minimap_juggernaut");
  objective_setlocation(self.objindex, 0, self);
  thread laser_sights(self.objindex, "obj_" + self getentitynumber());
}

function laser_sights(var0, var1) {
  self waittill("death");
  scripts\cp\cp_objectives::freeworldid(var1);
  objective_state(var0, "done");
}

function vehicle_mp_deletenextframelate() {
  for(;;) {
    var0 = scripts\engine\utility::ref_143ad("damage", "flashbang");

    if(var0 == "damage") {
      if(!self.stuncooldown && ref_1459d()) {
        self.stuncooldown = 1;
        GscBinSkip4(0x35);
      }

      if(!ref_11ca4()) {
        continue;
      }
    }

    self.allowpain = 1;
    wait 0.05;
    self.minpaindamage = 0;
    self dodamage(10, self.damagepoint, self.is_specops_gametype);
    self.minpaindamage = self.minpainvalue;
    wait 0.05;
    self.allowpain = 0;
  }
}

function ref_1459d() {
  if(!isDefined(self.damageweapon)) {
    return false;
  }

  var0 = scripts\cp\utility::getbaseweaponname(self.damageweapon);

  if(var0 == "iw8_sn_alpha50" || var0 == "iw8_sh_oscar12") {
    return true;
  }

  return false;
}

function ref_11ca4() {
  if(!isDefined(self.damagemod)) {
    return false;
  }

  if(self.damagemod == "MOD_EXPLOSIVE" || self.damagemod == "MOD_GRENADE" || self.damagemod == "MOD_GRENADE_SPLASH") {
    return true;
  }

  return false;
}

function juggernaut_pain_cooldown() {
  self notify("start_new_cooldown");
  self endon("start_new_cooldown");
  wait 7;
  self.stuncooldown = 0;
}

function bomb_case_detonator_control_think() {
  self setthreatbiasgroup("ground_troops");
  level.openangles[level.openangles.size] = self;
  self waittill("death", var0);
  thread ref_123d5(var0, scripts\engine\utility::array_combine(level.giveplayerpoints, level.givepointsandxp));
  level.openangles = scripts\engine\utility::array_remove(level.openangles, self);
}

function bot_can_switch_to_attacker() {
  thread bomb_case_detonator_control_think();
  self endon("death");
  self waittill("jumpedout");

  switch (self.agent_type) {
    case "actor_enemy_cp_alq_desert_shotgun":
      self.goalradius = level.select_equipment_spawners;
      break;
    case "actor_enemy_cp_alq_desert_smg":
      self.goalradius = level.select_hostage_room_one_spawners;
      break;
    case "actor_enemy_cp_alq_desert_ar":
      self.goalradius = level.select_chopper_boss_target_player;
      break;
    default:
      self.goalradius = level.select_cliff_one_spawners;
      break;
  }

  var0 = scripts\engine\utility::getclosest(self.origin, level.players);
  self setgoalentity(var0, 1);
  thread blueprintextract_cleanupwhennoavailablelocales();
}

function ref_13649() {
  if(!isDefined(self.waittill_interrogation_dialogue_or_timeout)) {
    return false;
  }

  return gettime() - self.waittill_interrogation_dialogue_or_timeout < 10000;
}

function stoppingpower_clearhcrongameended() {
  level.set_flag_via_event_structs = scripts\engine\utility::getStructArray("ground_exfil", "targetname");
  level.ref_12d8a = scripts\engine\utility::getStructArray("roof_exfil", "targetname");
  level.set_flag_via_event_structs = scripts\engine\utility::array_combine(level.set_flag_via_event_structs, scripts\engine\utility::getStructArray("ground_intel_1", "targetname"));
  level.set_flag_via_event_structs = scripts\engine\utility::array_combine(level.set_flag_via_event_structs, scripts\engine\utility::getStructArray("ground_intel_2", "targetname"));
  level.ref_12d8a = scripts\engine\utility::array_combine(level.ref_12d8a, scripts\engine\utility::getStructArray("roof_intel_2", "targetname"));
  level.set_flag_via_event_structs = scripts\engine\utility::array_combine(level.set_flag_via_event_structs, scripts\engine\utility::getStructArray("ground_intel_3", "targetname"));
  level.ref_12d8a = scripts\engine\utility::array_combine(level.ref_12d8a, scripts\engine\utility::getStructArray("roof_intel_3", "targetname"));
  var0 = scripts\engine\utility::getStruct("ground_intel_1_10", "target");
  var0.origin += (0, 0, 30);

  foreach(var2 in scripts\engine\utility::getStructArray("ground_intel_1_10", "targetname")) {
    var2.origin += (0, 0, 30);
  }

  var0 = scripts\engine\utility::getStruct("ground_intel_3_5", "target");
  var0.origin = (3792.98, -240.453, 421.175);
  var0.angles = (0, 151.019, 0);
  var4 = [(3758.22, -263.405, 421.175), (3748.75, -239.547, 421.175), (3776.37, -211.444, 421.175)];
  var5 = [(0, 106.019, 0), (0, 151.019, 0), (0, 196.019, 0)];

  foreach(var7, var2 in scripts\engine\utility::getStructArray("ground_intel_3_5", "targetname")) {
    var2.origin = var4[var7];
    var2.angles = var5[var7];
  }

  var0 = scripts\engine\utility::getStruct("ground_intel_3_4", "target");
  var0.origin = (3796.9, 148.39, 422.785);
  var0.angles = (0, 199.503, 0);
  var4 = [(3791.04, 107.149, 422.785), (3766.9, 115.867, 422.785), (3764.17, 155.183, 422.785)];
  var5 = [(0, 154.503, 0), (0, 199.503, 0), (0, 244.502, 0)];

  foreach(var7, var2 in scripts\engine\utility::getStructArray("ground_intel_3_4", "targetname")) {
    var2.origin = var4[var7];
    var2.angles = var5[var7];
  }
}

function ref_134ed(var0, var1) {
  self.waittill_interrogation_dialogue_or_timeout = gettime();
  self.count = 1;
  self.script_moveoverride = 1;
  var2 = scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
  var2 thread[[var1]](var0);
  var3 = [var2];
  var2.script_noteworthy = "group_" + self.targetname + "_leader";
  wait 0.1;
  var4 = scripts\engine\utility::getStructArray(self.target, "targetname");

  foreach(var6 in var4) {
    var6.count = 1;
    var2 = var6 scripts\cp\laser_traps\cp_laser_traps::spawn_ai();
    var2 thread[[var1]](var0);
    var3 = var2;
    var2.script_noteworthy = "group_" + self.targetname + "_" + self.script_noteworthy;
    wait 0.1;
  }

  return var3;
}

function setup_bot_arena() {
  level endon("game_ended");
  self endon("disconnect");
  self.nexthealthtiercalledout = [];
  var0 = 5;
  self.track_get_reward_time_string = 1000;
  self.ref_1215a = 2000;
  self.hostage_carrier_oob = cos(90);

  for(;;) {
    while(level.ref_11f7e.size == 0) {
      wait 0.1;
    }

    var1 = self.origin;

    if(scripts\engine\utility::is_equal(level.givematchplacementchallenge, self)) {
      var2 = self getEye();
      var1 = (var2[0], var2[1], 0);
    }

    var3 = scripts\engine\utility::getclosest(var1, level.ref_11f7e);
    var4 = var3.origin - var1;
    var5 = [];
    var6 = [];

    foreach(var8 in level.set_flag_via_event_structs) {
      if(!ref_13649(var8)) {
        if(scripts\engine\utility::is_equal(var8.script_parameters, "inside") || !give_super_ammo_after_loadout_given(var8.origin)) {
          if(scripts\engine\math::within_fov_2d(var1, vectortoangles(var4), var8.origin, self.hostage_carrier_oob)) {
            var9 = distance2d(var1, var8.origin);

            if(!c130_door_badplace_id(var8.origin, self.track_get_reward_time_string)) {
              if(var9 < self.ref_1215a) {
                var6 = var8;
              } else {
                var5 = var8;
              }
            }
          }
        }
      }
    }

    if(var5.size > 0) {
      var5 = scripts\engine\utility::array_randomize(var5);
      self.nexthealthtiercalledout[self.nexthealthtiercalledout.size] = ref_134ed(var5[0], self, &bomb_vest_detonator_control_think);
    }

    if(var6.size > 0) {
      var6 = scripts\engine\utility::array_randomize(var6);
      self.nexthealthtiercalledout[self.nexthealthtiercalledout.size] = ref_134ed(var6[0], self, &bomb_vest_detonator_control_think);
    }

    if(self.nexthealthtiercalledout.size >= level.ref_11b47) {
      while(self.nexthealthtiercalledout.size > 0) {
        self waittill("enemy_died");
        var11 = [];

        foreach(var14, var13 in self.nexthealthtiercalledout) {
          self.nexthealthtiercalledout[var14] = scripts\engine\utility::array_removedead_or_dying(var13);

          if(self.nexthealthtiercalledout[var14].size != 0) {
            var11 = self.nexthealthtiercalledout[var14];
          }
        }

        self.nexthealthtiercalledout = var11;
      }

      wait var0;
    }

    wait 0.1;
  }
}

function setup_crates_to_mark() {
  level endon("game_ended");
  self endon("disconnect");
  var0 = 3;
  self.ref_12d85 = [];

  for(;;) {
    while(level.ref_11f7e.size == 0) {
      wait 0.1;
    }

    var1 = self getEye();
    var1 = (var1[0], var1[1], 0);
    var2 = [];

    foreach(var4 in level.ref_12d8a) {
      if(!ref_13649(var4) && !give_super_ammo_after_loadout_given(var4.origin)) {
        var5 = distance2d(var1, var4.origin);

        if(var5 > 2000) {
          var2 = var4;
        }
      }
    }

    if(var2.size >= level.ref_11b4d) {
      var2 = scripts\engine\utility::array_randomize(var2);

      for(var7 = 0; var7 < level.ref_11b4d; var7++) {
        self.ref_12d85[self.ref_12d85.size] = ref_134ed(var2[var7], self, &bonustimeapplied);
      }
    }

    if(self.ref_12d85.size >= level.ref_11b4d) {
      while(self.ref_12d85.size > 0) {
        self waittill("rpg_guy_died");
        var8 = [];

        foreach(var11, var10 in self.ref_12d85) {
          self.ref_12d85[var11] = scripts\engine\utility::array_removedead_or_dying(var10);

          if(self.ref_12d85[var11].size != 0) {
            var8 = self.ref_12d85[var11];
          }
        }

        self.ref_12d85 = var8;
      }

      if(var0 == 3 && level.train_elements_disable & 4) {
        var0 = 1.5;
      }

      wait var0;
    }

    wait 0.1;
  }
}

function setup_heli_starts() {
  while(!(level.train_elements_disable & 2)) {
    level waittill("intel_collected");
  }

  var0 = scripts\common\utility::getvehiclespawnerarray("truck_spawn", "targetname");
  var0 = scripts\engine\utility::array_randomize(var0);

  foreach(var2 in var0) {
    var3 = scripts\engine\utility::getStructArray(var2.target, "targetname");

    foreach(var5 in var3) {
      var5 scripts\cp\laser_traps\cp_laser_traps::add_spawn_function(&bot_can_switch_to_attacker);
    }

    while(!gatherstadiumlocs(4)) {
      wait 0.5;
    }

    var7 = var2 scripts\common\vehicle::spawn_vehicle_and_gopath();
    thread ref_13dea();
  }

  wait 6;

  if(randomint(100) > 50) {
    ref_12758("dx_cps_kama_callout_technicals_spawning_10");
  } else {
    ref_12758("dx_cps_kama_callout_technicals_spawning_20");
  }

  wait 1;

  if(isDefined(level.givematchplacementchallenge)) {
    level.givematchplacementchallenge.waittill_player_deposits = gettime();
    ref_12450("dx_vom_apap_killstreak_chopper_combat_270");
    return;
  }
}

function ref_13dea() {
  self.nodeath = 1;
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(self);
  var0 = loadfx("vfx/core/expl/large_vehicle_explosion.vfx");
  var1 = loadfx("vfx/iw8/veh/scriptables/shared/vfx_veh_fire_linger_sml.vfx");
  thread ref_13de8();
  self waittill("death", var2);

  if(self.model == "veh8_mil_lnd_pindia") {
    self setModel("veh8_mil_lnd_pindia_static_dst");
  } else {
    self setModel("veh8_mil_lnd_pindia_static_dst_red");
  }

  var3 = anglesToForward(self.angles);
  var4 = anglestoup(self.angles);
  playFX(var0, self.origin, var3, var4);
  thread ref_123d5(var2, scripts\engine\utility::array_combine(level.giveplayerpoints, level.givequest));
  wait 1;
  playFX(var1, self.origin + var3 * 20 + var4 * 10, var3, var4);
}

function ref_13de8() {
  self endon("death");
  self vehicleshowonminimap(1);
  self aiupdatecoverexposetype(1);
  wait 1;
  self setwaitspeed(0);
  self waittill("reached_wait_speed");
  wait 1;
  self vehicleshowonminimap(0);
}

function setup_enemytype_on_spawner() {
  scripts\engine\utility::flag_wait("exfil_signalled");
  var0 = getEntArray("tank_col", "targetname");
  var1 = scripts\common\utility::getvehiclespawnerarray("tank_spawn", "targetname");
  var1 = scripts\engine\utility::array_randomize(var1);

  foreach(var3 in var1) {
    var4 = var3 scripts\common\vehicle::spawn_vehicle_and_gopath();
    var5 = scripts\engine\utility::getclosest(var3.origin, var0);
    var4.helimakeexfilwait = var5;

    if(distance2d(var5.origin, (-336.514, 2708.69, 254)) < 200) {
      var5.angles += (0, -45, 0);
    }

    var5.origin = var4.origin + (0, 0, 60);
    var5 linkTo(var4);
    thread ref_13a4e();
  }

  wait 6;

  if(randomint(100) > 50) {
    ref_12758("dx_cps_kama_callout_tank_spawning_10");
  } else {
    ref_12758("dx_cps_kama_callout_tank_spawning_20");
  }

  wait 1;

  if(isDefined(level.givematchplacementchallenge)) {
    level.givematchplacementchallenge.waittill_player_deposits = gettime();
    var7 = randomint(100);

    if(level.givematchplacementchallenge.playapacheonly_dialogue && var7 > 66) {
      ref_12450("dx_vom_apap_killstreak_chopper_combat_280");
      return;
    }

    if(level.givematchplacementchallenge.playapacheonly_dialogue && var7 > 33) {
      ref_12450("dx_vom_apap_killstreak_chopper_combat_290");
      return;
    }

    ref_12450("dx_vom_apap_killstreak_chopper_combat_300");
    return;
  }
}

function ref_13a4e() {
  self setModel("veh8_mil_lnd_vindia_a1_west");
  self.mainturret setModel("veh8_mil_lnd_vindia_a1_turret_west");
  self.mainturret makeunusable();
  self makeunusable();
  self.nodeath = 1;
  self vehicleshowonminimap(1);
  self aiupdatecoverexposetype(1);
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(self);
  scripts\common\vehicle::godoff();
  self.mgturret[0] setmode("manual");
  self.mgturret[0] makeunusable();
  self.mgturret[0] hide();
  var0 = loadfx("vfx/iw8_mp/killstreak/vfx_tank_death_exp.vfx");
  var1 = loadfx("vfx/iw8_cp/trials/cp_trials_tank_smoke.vfx");
  thread ref_13a3d();
  thread ref_13a43();
  thread ref_13a44();
  thread ref_13a3f();
  self waittill("death", var2);
  self setModel("veh8_mil_lnd_vindia_a1_west_dst");
  var3 = anglesToForward(self.angles);
  var4 = anglestoup(self.angles);
  playFX(var0, self.origin, var3, var4);

  if(!isDefined(level.ref_13a42)) {
    level.ref_13a42 = 0;
  }

  level.ref_13a42++;

  if(level.ref_13a42 < 4) {
    thread ref_123d5(var2, scripts\engine\utility::array_combine(level.giveplayerpoints, level.givequest));
  } else {
    var5 = ["dx_vom_apap_killstreak_chopper_armor_10", "dx_vom_apap_killstreak_chopper_armor_20", "dx_vom_apap_killstreak_chopper_armor_30"];
    thread ref_123d5(var2, var5, 1);
  }

  wait 4;
  playFX(var1, self.origin, var3, var4);
}

function ref_13a3d() {
  self endon("death");
  self setwaitspeed(0);
  scripts\engine\utility::ref_143a5("reached_wait_speed", "damage");
  self.mainturret.maxrange = 3000;
  self.mainturret turretfireenable();
  self.mainturret startfiring();
  var0 = cos(10);

  for(;;) {
    while(!ref_13e6f(var0)) {
      wait 0.1;
    }

    while(ref_13e6f(var0)) {
      for(var1 = 0; var1 < randomintrange(3, 5); var1++) {
        self.mainturret shootturret();
        wait randomfloatrange(0.3, 0.6);
      }

      wait randomintrange(3, 6);
    }
  }
}

function ref_13a3f() {
  self endon("death");

  for(;;) {
    self waittill("bulletwhizby", var0);

    if(scripts\engine\utility::array_contains(level.players, var0)) {
      var0 setclientomnvar("damage_feedback_icon", "hittankarmor");
      var0 setclientomnvar("damage_feedback_icon_notify", gettime());
      var0 setclientomnvar("damage_feedback", "hittankarmor");
      var0 setclientomnvar("damage_feedback_notify", gettime());
      var0 setclientomnvar("damage_feedback_nonplayer", 1);
    }
  }
}

function ref_13a40(var0, var1, var2) {
  var3 = undefined;

  if(cave_initial_enemy_goto_struct_on_spawn_and_wait_till_seen(var1)) {
    var3 = level.givematchplacementchallenge;
  } else if(scripts\engine\utility::array_contains(level.players, var1) && isDefined(var2) && (var2 == "MOD_EXPLOSIVE" || var2 == "MOD_GRENADE_SPLASH" || var2 == "MOD_PROJECTILE") || var2 == "MOD_PROJECTILE_SPLASH") {
    var3 = var1;
  }

  if(isDefined(var3) && isPlayer(var3)) {
    if(isDefined(var0)) {
      var3 setclientomnvar("damage_feedback_icon", "standard");
      var3 setclientomnvar("damage_feedback", "standard");
      var3 setclientomnvar("damage_feedback_icon_notify", gettime());
      var3 setclientomnvar("damage_feedback_notify", gettime());
      var3 setclientomnvar("ui_damage_amount", int(var0));

      if(var0 >= self.health - self.healthbuffer) {
        var3 setclientomnvar("damage_feedback_kill", 1);
        return;
      }

      var3 setclientomnvar("damage_feedback_kill", 0);
      return;
    }

    return;
  }
}

function ref_13a45(var0, var1, var2, var3, var4, var5, var6) {
  self endon("death");

  if(isDefined(var0)) {
    if(var0.basename == "iw8_la_rpapa7_mp") {
      self dodamage(var1, var3, var2, var4, var5, var0, var6);
      wait 0.1;
    }

    if(issubstr(var0.basename, "c4_") && isDefined(var5) && (var5 == "MOD_EXPLOSIVE" || var5 == "MOD_GRENADE_SPLASH" || var5 == "MOD_PROJECTILE_SPLASH")) {
      self dodamage(var1 * 3, var3, var2, var4, var5, var0, var6);
      wait 0.1;
      return;
    }

    return;
  }
}

function ref_13a43() {
  self endon("death");
  self waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
  GscBinSkip4(0x35, var0, var1, var4);
}

function ref_13a44() {
  self endon("death");
  self.mainturret waittill("damage", var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
  GscBinSkip4(0x35, var0, var1, var4);
}

function cave_initial_enemy_goto_struct_on_spawn_and_wait_till_seen(var0) {
  if(isDefined(level.givematchplacementchallenge) && isDefined(level.choppergunners) && isDefined(level.choppergunners[0]) && isDefined(level.choppergunners[0].turret)) {
    if(level.givematchplacementchallenge == var0) {
      return true;
    }

    if(scripts\engine\utility::is_equal(level.choppergunners[0], var0)) {
      return true;
    }

    if(scripts\engine\utility::is_equal(level.choppergunners[0].turret, var0)) {
      return true;
    }
  }

  return false;
}

function ref_13e6f(var0) {
  foreach(var2 in level.players) {
    if(!scripts\engine\utility::is_equal(var2, level.givematchplacementchallenge)) {
      if(scripts\engine\math::within_fov_2d(self.mainturret gettagorigin("tag_flash"), self.mainturret gettagangles("tag_flash"), var2.origin, var0)) {
        return true;
      }
    }
  }

  return false;
}

function ref_13f26() {
  level notify("stop_unrescuable_fail");
  level endon("stop_unrescuable_fail");
  var0 = 1;

  while(var0) {
    wait 0.2;

    if(isDefined(level.givematchplacementchallenge)) {
      var1 = scripts\engine\utility::array_remove(level.players, level.givematchplacementchallenge);
    } else {
      var1 = level.players;
    }

    var0 = 0;

    foreach(var3 in var1) {
      if(isDefined(var3) && !scripts\cp\cp_laststand::player_in_laststand(var3) && var3 scripts\cp_mp\utility\player_utility::_isalive()) {
        var0 = 1;
      }
    }
  }

  if(level.players.size == 1 && scripts\engine\utility::is_equal(level.players[0], level.givematchplacementchallenge)) {
    level thread[[level.endgame]]("axis", level.end_game_string_index["fail"]);
    return;
  }

  level thread[[level.endgame]]("axis", level.end_game_string_index["kia"]);
}

function c130_drop(var0, var1) {
  foreach(var3 in level.players) {
    if(isDefined(level.givematchplacementchallenge) && var3 == level.givematchplacementchallenge) {
      continue;
    }

    if(distancesquared(var3.origin, var0) <= var1 * var1) {
      return true;
    }
  }

  return false;
}

function c130_door_badplace_id(var0, var1) {
  foreach(var3 in level.players) {
    if(isDefined(level.givematchplacementchallenge) && var3 == level.givematchplacementchallenge) {
      continue;
    }

    if(distance2dsquared(var3.origin, var0) <= var1 * var1) {
      return true;
    }
  }

  return false;
}

function brevent1playerthink(var0, var1) {
  foreach(var3 in level.players) {
    if(isDefined(level.givematchplacementchallenge) && var3 == level.givematchplacementchallenge) {
      continue;
    }

    if(distance2dsquared(var3.origin, var0) > var1 * var1) {
      return false;
    }
  }

  return true;
}

function black_screen(var0, var1) {
  var2 = newclienthudelem(self);
  var2.x = 0;
  var2.y = 0;
  var2.alignx = "left";
  var2.aligny = "top";
  var2.sort = 20;
  var2.horzalign = "fullscreen";
  var2.vertalign = "fullscreen";
  var2.alpha = 1;
  var2.foreground = 1;
  var2 setshader("black", 640, 480);
  var2 endon("death");
  wait var0;
  var2 fadeovertime(var1);
  var2.alpha = 0;
  wait var1;
  var2 destroy();
}

function mud_sfx(var0) {
  if(var0 == "axis") {
    return 0;
  }

  var1 = 60000;

  if(level.time_survived < 3 * var1) {
    return 3;
  } else if(level.time_survived < 6 * var1) {
    return 2;
  }

  return 1;
}

function bwasjuggernaut(var0, var1, var2) {
  jumpiftrue(isDefined(var1)) LOC_0000000d;
  var1 = 0;

  for(;;) {
    foreach(var4 in level.players) {
      if(scripts\engine\utility::is_equal(level.givematchplacementchallenge, var4)) {
        continue;
      }

      if(var4.origin[var1] < var0) {
        scripts\engine\utility::flag_set(var2);
        return;
      }
    }

    wait 1;
  }
}