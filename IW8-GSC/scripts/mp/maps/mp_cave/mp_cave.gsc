/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_cave\mp_cave.gsc
***********************************************/

function main() {
  level.music_style = "middle_east";
  scripts\mp\maps\mp_cave\mp_cave_precache::main();
  scripts\mp\maps\mp_cave\gen\mp_cave_art::main();
  scripts\mp\maps\mp_cave\mp_cave_fx::main();
  scripts\cp_mp\utility\game_utility::registernightmap();
  scripts\mp\load::main();
  scripts\mp\utility\player::overridevisionsetnightforlevel("nvg_base_mp_cave");
  level thread scripts\engine\scriptable_door::system_init();
  var0 = spawn("trigger_radius", (376, -1568, -112), 0, 128, 300);
  var0.targetname = "OutOfBounds";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_cave", "codcaster_compass_map_mp_cave");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("LKOLRONRNQ", 500);
  setDvar("PKKMTTRQO", 8);
  setDvar("NKLMONNPNN", 1024);
  setDvar("NOSQLKNSQO", 45);
  setDvar("MRNRKKOPLN", 2);
  setDvar("MQPQKNPQOK", 5);
  setDvar("NQNQPRLRQM", 2);
  setDvar("NSSMQLPRNT", 0.01);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "desert";
  game["axis_outfit"] = "desert";
  thread scripts\mp\motiondetectors::init();
  thread managegate();
  thread destructibletrucksetup("destructibleTruck01", "truckHeadlights01", "destructibleTruck01_edges", "destructibleTruck01_edges_dst", 51);
  thread destructibletrucksetup("destructibleTruck02", "truckHeadlights02", "destructibleTruck02_edges", "destructibleTruck02_edges_dst", 52);
  thread matchfxexploder();
  thread ref_11f11();
  thread ref_12f8e();
  thread player_fired_gun_monitor();
}

function player_fired_gun_monitor() {
  var0 = spawn("script_model", (1592, 561, 176));
  var0 setModel("me_construction_plank_bridge_a_11");
  var0.angles = (85.3, 326, -11);
  var1 = spawn("script_model", (-1034, 844, 92));
  var1 setModel("me_construction_plank_bridge_a_11");
  var1.angles = (0, 275, -90);
  var2 = spawn("script_model", (3715, 1658.5, 262));
  var2 setModel("me_construction_plank_bridge_a_11");
  var2.angles = (272, 145, -90);
  var3 = spawn("script_model", (-1061, 917.5, 112));
  var3 setModel("hardware_plywood_bare_01_24_dirty");
  var3.angles = (270, 0, 0);
  var4 = spawn("script_model", (842, 332, 60));
  var4 setModel("me_construction_plank_bridge_a_11");
  var4.angles = (270, 0, 0);
  var5 = getEnt("tactical_cover_col", "targetname");
  var6 = spawn("script_model", (1768, 2128, 80));
  var6.angles = (0, 255, 0);
  var6 clonebrushmodeltoscriptmodel(var5);
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
  var0 = getEnt("infil_door_left", "targetname");
  var1 = getEnt("infil_door_right", "targetname");
  var2 = getEnt("infil_door_chain", "targetname");
  var0.animname = "gate_left";
  var0 scripts\common\anim::setanimtree();
  var1.animname = "gate_right";
  var1 scripts\common\anim::setanimtree();
  var0 thread scripts\common\anim::anim_single_solo(var0, "open");
  var1 thread scripts\common\anim::anim_single_solo(var1, "open");
  var2 hide();
  level waittill("prematch_countdown");
  var0 thread scripts\common\anim::anim_single_solo(var0, "close");
  var1 thread scripts\common\anim::anim_single_solo(var1, "close");
  GscBinSkip1(0x45, 0, "_left");
}

function destructibletrucksetup(var0, var1, var2, var3, var4) {
  level endon("game_ended");
  wait 5;
  var5 = getscriptablearray(var0, "targetname");
  var6 = getEnt(var2, "targetname");
  var7 = getEnt(var3, "targetname");
  var8 = getEntArray(var1, "targetname");
  var7 hide();
  scripts\engine\utility::exploder(var4);

  if(isDefined(var5) && isDefined(var5[0])) {
    var9 = var5[0];
    var10 = 1;

    while(var10) {
      var9 waittill("scriptableNotification", var11, var12);

      switch (var11) {
        case "vehicle_death":
        case "onfire":
        case "flareup":
          trucklightsoff(var8);
          var10 = 0;
          scripts\engine\utility::kill_exploder(var4);
          var7 show();
          var6 hide();
          return;
        case "anim_explosion":
          trucklightsoff(var8);
          var10 = 0;
          scripts\engine\utility::kill_exploder(var4);
          var7 show();
          var6 hide();
          return;
      }
    }

    return;
  }
}

function trucklightsoff(var0) {
  foreach(var2 in var0) {
    var2 setlightintensity(0);
  }
}

function ref_11f11() {
  level endon("game_ended");
  level waittill("used_nuke");
  var0 = spawn("script_origin", (-106, 364, 216));
  var0 makeusable();
  thread players_in_laststand();
}

function players_in_laststand() {
  self waittill("trigger", var0);
  var0 playerhide();
  var0 vehiclepinonminimap(0);
  var0 allowmovement(0);
  var0 allowfire(0);
  var0 disableoffhandprimaryweapons(0);
  var0 disableoffhandsecondaryweapons(0);
  var0 disableweapons(0);
  var0 disableweaponswitch(0);
  var0 setcamerathirdperson(1);
  var0 allowcrouch(0);
  var0 allowmelee(0);
  var0 allowjump(0);
  var0 allowprone(0);
  var0 scripts\common\utility::allow_killstreaks(0);
  var0 scripts\common\utility::allow_supers(0);
  var0.ref_12e54 = 1;
  var0 scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/SAFE");
}

function ref_12f8e() {
  var0 = [];
  GscBinSkip0(0x2e, var0.size, scripts\mp\spawnlogic::init_trap_room_doors("mp_tdm_spawn_secondary", (-548, 2268, 100), (0, 330, 0)));
}