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
  level.ref_13d50 = 1;
  scripts\mp\load::main();
  level thread scripts\engine\scriptable_door::system_init();
  var0 = spawn("trigger_radius", (376, -1568, -112), 0, 128, 300);
  var0.targetname = "OutOfBounds";
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_cave_am", "codcaster_compass_map_mp_cave_am");
  level.kill_border_triggers = getEntArray("kill_border_trigger", "targetname");
  setDvar("LKOLRONRNQ", 1500);
  setDvar("TMNTMTQRM", 0);
  setDvar("NPONLLLSPL", 0.3);
  setDvar("LSNRQTOKRR", 2);
  setDvar("NTLKNLNPLK", 1);
  setDvar("MTQRRSOMTT", 0);
  setDvar("MRNRKKOPLN", 2);
  setDvar("MQPQKNPQOK", 5);
  setDvar("NOSQLKNSQO", 45);
  setDvar("r_useCompressedSunShadow", 1);
  setDvar("NSSMQLPRNT", 0.01);
  setDvar("PKKMTTRQO", 8);
  setDvar("NKLMONNPNN", 1024);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "desert";
  game["axis_outfit"] = "desert";
  thread scripts\mp\motiondetectors::init();
  thread managegate();
  thread destructibletrucksetup("destructibleTruck01", "destructibleTruck01_edges", "destructibleTruck01_edges_dst");
  thread destructibletrucksetup("destructibleTruck02", "destructibleTruck02_edges", "destructibleTruck02_edges_dst");
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

function destructibletrucksetup(var0, var1, var2) {
  level endon("game_ended");
  wait 5;
  var3 = getscriptablearray(var0, "targetname");
  var4 = getEnt(var1, "targetname");
  var5 = getEnt(var2, "targetname");
  var5 hide();

  if(isDefined(var3) && isDefined(var3[0])) {
    var6 = var3[0];
    var7 = 1;

    while(var7) {
      var6 waittill("scriptableNotification", var8, var9);

      switch (var8) {
        case "onfire":
        case "flareup":
        case "vehicle_death":
          var7 = 0;
          var5 show();
          var4 hide();
          return;
        case "anim_explosion":
          var7 = 0;
          var5 show();
          var4 hide();
          return;
      }
    }

    return;
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