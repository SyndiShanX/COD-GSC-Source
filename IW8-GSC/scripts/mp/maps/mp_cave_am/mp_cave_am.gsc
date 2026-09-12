/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_cave_am\mp_cave_am.gsc
*****************************************************/

function main() {
  scripts\mp\trials\mp_trl_cleararea::keypad_check_levelinput();
  level.music_style = "middle_east";
  scripts\mp\maps\mp_cave_am\mp_cave_am_precache::main();
  scripts\mp\maps\mp_cave_am\gen\mp_cave_am_art::main();
  scripts\mp\maps\mp_cave_am\mp_cave_am_fx::main();
  scripts\mp\maps\mp_cave_am\mp_cave_am_lighting::main();
  level.ref_13D50 = 1;
  scripts\mp\load::main();
  level thread scripts\engine\scriptable_door::system_init();
  var_0 = spawn("trigger_radius", (376, -1568, -112), 0, 128, 300);
  var_0.targetname = "OutOfBounds";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_cave_am", "codcaster_compass_map_mp_cave_am");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("sm_spotDistCull", 1500);
  setDvar("sm_sunDistantShadows", 0);
  setDvar("sm_sunSampleSizeNear", 0.3);
  setDvar("sm_sunCascadeSizeMultiplier1", 2);
  setDvar("sm_sunCascadeSizeMultiplier2", 1);
  setDvar("sm_sunPoissonFiltering", 0);
  setDvar("cg_defaultWindFrequencyScale", 2);
  setDvar("cg_defaultWindAmplitudeScale", 5);
  setDvar("r_tessellationFactor", 45);
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("r_sunIntensityHeatOverride", 0.01);
  setDvar("r_umbraMinObjectContribution", 8);
  setDvar("r_umbraAccurateOcclusionThreshold", 1024);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "desert";
  game["axis_outfit"] = "desert";
  thread scripts\mp\motiondetectors::init();
  thread managegate();
  thread destructibletrucksetup("destructibleTruck01", "destructibleTruck01_edges", "destructibleTruck01_edges_dst");
  thread destructibletrucksetup("destructibleTruck02", "destructibleTruck02_edges", "destructibleTruck02_edges_dst");
  thread matchfxexploder();
  thread ref_11F11();
  thread ref_12F8E();
  thread player_fired_gun_monitor();
}

function player_fired_gun_monitor() {
  var_0 = spawn("script_model", (1592, 561, 176));
  var_0 setModel("me_construction_plank_bridge_a_11");
  var_0.angles = (85.3, 326, -11);
  var_1 = spawn("script_model", (-1034, 844, 92));
  var_1 setModel("me_construction_plank_bridge_a_11");
  var_1.angles = (0, 275, -90);
  var_2 = spawn("script_model", (3715, 1658.5, 262));
  var_2 setModel("me_construction_plank_bridge_a_11");
  var_2.angles = (272, 145, -90);
  var_3 = spawn("script_model", (-1061, 917.5, 112));
  var_3 setModel("hardware_plywood_bare_01_24_dirty");
  var_3.angles = (270, 0, 0);
  var_4 = spawn("script_model", (842, 332, 60));
  var_4 setModel("me_construction_plank_bridge_a_11");
  var_4.angles = (270, 0, 0);
  var_5 = getEnt("tactical_cover_col", "targetname");
  var_6 = spawn("script_model", (1768, 2128, 80));
  var_6.angles = (0, 255, 0);
  var_6 clonebrushmodeltoscriptmodel(var_5);
}

function matchfxexploder() {
  level waittill("prematch_countdown");
  scripts\engine\utility::exploder(77);
}

#using_animtree("");

function managegate() {
  level waittill("infil_setup_complete");

  if(!scripts\mp\flags::gameflag("infil_will_run")) {
    return;
  }

  scripts\mp\flags::gameflagwait("infil_started");
  level.scr_animtree["gate_left"] = #animtree;
  level.scr_anim["gate_left"]["close"] = $mp_trainyard_gatel_close;
  level.scr_animname["gate_left"]["close"] = "mp_trainyard_gateL_close";
  level.scr_anim["gate_left"]["open"] = % mp_trainyard_gatel_open;
  level.scr_animname["gate_left"]["open"] = "mp_trainyard_gateL_open";
  level.scr_animtree["gate_right"] = #animtree;
  level.scr_anim["gate_right"]["close"] = % mp_trainyard_gater_close;
  level.scr_animname["gate_right"]["close"] = "mp_trainyard_gateR_close";
  level.scr_anim["gate_right"]["open"] = % mp_trainyard_gater_open;
  level.scr_animname["gate_right"]["open"] = "mp_trainyard_gateR_open";
  var_0 = getEnt("infil_door_left", "targetname");
  var_1 = getEnt("infil_door_right", "targetname");
  var_2 = getEnt("infil_door_chain", "targetname");
  var_0.animname = "gate_left";
  var_0 scripts\common\anim::setanimtree();
  var_1.animname = "gate_right";
  var_1 scripts\common\anim::setanimtree();
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "open");
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "open");
  var_2 hide();
  level waittill("prematch_countdown");
  var_0 thread scripts\common\anim::anim_single_solo(var_0, "close");
  var_1 thread scripts\common\anim::anim_single_solo(var_1, "close");
  GscBinSkip1(0x45, 0, "_left");
}

function destructibletrucksetup(var_0, var_1, var_2) {
  level endon("game_ended");
  wait 5;
  var_3 = getscriptablearray(var_0, "targetname");
  var_4 = getEnt(var_1, "targetname");
  var_5 = getEnt(var_2, "targetname");
  var_5 hide();

  if(isDefined(var_3) && isDefined(var_3[0])) {
    var_6 = var_3[0];
    var_7 = 1;

    while(var_7) {
      var_6 waittill("scriptableNotification", var_8, var_9);

      switch (var_8) {
        case "onfire":
        case "flareup":
        case "vehicle_death":
          var_7 = 0;
          var_5 show();
          var_4 hide();
          return;
        case "anim_explosion":
          var_7 = 0;
          var_5 show();
          var_4 hide();
          return;
      }
    }

    return;
  }
}

function ref_11F11() {
  level endon("game_ended");
  level waittill("used_nuke");
  var_0 = spawn("script_origin", (-106, 364, 216));
  var_0 makeusable();
  thread players_in_laststand();
}

function players_in_laststand() {
  self waittill("trigger", var_0);
  var_0 playerhide();
  var_0 vehiclepinonminimap(0);
  var_0 allowmovement(0);
  var_0 allowfire(0);
  var_0 disableoffhandprimaryweapons(0);
  var_0 disableoffhandsecondaryweapons(0);
  var_0 disableweapons(0);
  var_0 disableweaponswitch(0);
  var_0 setcamerathirdperson(1);
  var_0 allowcrouch(0);
  var_0 allowmelee(0);
  var_0 allowjump(0);
  var_0 allowprone(0);
  var_0 scripts\common\utility::allow_killstreaks(0);
  var_0 scripts\common\utility::allow_supers(0);
  var_0.ref_12E54 = 1;
  var_0 scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/SAFE");
}

function ref_12F8E() {
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn_secondary", (-548, 2268, 100), (0, 330, 0)));
}