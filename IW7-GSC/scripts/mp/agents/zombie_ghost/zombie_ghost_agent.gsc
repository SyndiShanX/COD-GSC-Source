/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3961.gsc
************************/

registerscriptedagent() {
  level.zombie_ghost_hide_nodes = scripts\engine\utility::getstructarray("zombie_ghost_hide_node", "script_noteworthy");
  level.zombie_ghost_hover_nodes = scripts\engine\utility::getstructarray("zombie_ghost_hover_node", "targetname");
  scripts\aitypes\bt_util::init();
  lib_03B4::func_DEE8();
  lib_0F46::func_2371();
  func_AEB0();
  thread func_FAB0();
}

func_FAB0() {
  level endon("game_ended");
  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["zombie_ghost"]["setup_func"] = ::setupagent;
  level.agent_definition["zombie_ghost"]["setup_model_func"] = ::func_FACE;
  level.agent_funcs["zombie_ghost"]["on_killed"] = ::func_C535;
  level.agent_funcs["zombie_ghost"]["on_damaged"] = ::func_C536;
}

setupagent() {
  self.class = undefined;
  self.movespeedscaler = undefined;
  self.avoidkillstreakonspawntimer = undefined;
  self.guid = undefined;
  self.name = undefined;
  self.saved_actionslotdata = undefined;
  self.perks = undefined;
  self.weaponlist = undefined;
  self.objectivescaler = undefined;
  self.sessionteam = undefined;
  self.sessionstate = undefined;
  self.disabledweapon = undefined;
  self.disabledweaponswitch = undefined;
  self.disabledoffhandweapons = undefined;
  self.disabledusability = 1;
  self.nocorpse = undefined;
  self.ignoreme = 0;
  self.precacheleaderboards = 0;
  self.ten_percent_of_max_health = undefined;
  self.command_given = undefined;
  self.current_icon = undefined;
  self.do_immediate_ragdoll = undefined;
  self.can_be_killed = 0;
  self.attack_spot = undefined;
  self.entered_playspace = 0;
  self.marked_for_death = undefined;
  self.trap_killed_by = undefined;
  self.hastraversed = 0;
  self.aistate = "idle";
  self.synctransients = "walk";
  self.sharpturnnotifydist = 100;
  self.fgetarg = 15;
  self.height = 40;
  self.var_252B = 26 + self.fgetarg;
  self.var_B640 = "normal";
  self.var_B641 = 50;
  self.var_2539 = 54;
  self.var_253A = -64;
  self.var_4D45 = 2250000;
  self.precacheminimapicon = 1;
  self.guid = self getentitynumber();
  self.moveratescale = 1;
  self.var_C081 = 1;
  self.traverseratescale = 1;
  self.generalspeedratescale = 1;
  self.var_2AB2 = 0;
  self.var_2AB8 = 1;
  self.timelineevents = 0;
  self.var_2F = 1;
  self.var_B5F9 = 40;
  self.var_B62E = 60;
  self.meleeradiusbasesq = squared(self.var_B62E);
  self.defaultgoalradius = self.fgetarg + 1;
  self.meleedot = 0.5;
  self.dismember_crawl = 0;
  self.died_poorly = 0;
  self.isfrozen = undefined;
  self.flung = undefined;
  self.dismember_crawl = 0;
  self.var_B0FC = 1;
  self.full_gib = 0;
  self.var_C1F7 = 0;
  scripts\mp\agents\zombie\zombie_util::func_F794(self.var_B62E);
  self setsolid(0);
  thread func_899C();
}

func_899C() {
  self endon("death");
  level waittill("game_ended");
  self clearpath();
  foreach(var_04, var_01 in self.var_164D) {
    var_02 = var_01.var_4BC0;
    var_03 = level.asm[var_04].states[var_02];
    scripts\asm\asm::func_2388(var_04, var_02, var_03, var_03.var_116FB);
    scripts\asm\asm::func_238A(var_04, "idle", 0.2, undefined, undefined, undefined);
  }
}

func_FACE(param_00) {
  var_01 = get_ghost_info();
  self.color = var_01.color;
  if(isDefined(level.fbd) && isDefined(level.fbd.fightstarted) && level.fbd.fightstarted) {
    self setModel("dlc4_boss_soul");
    return;
  }

  self setModel(level.zombie_ghost_model);
}

get_ghost_info() {
  var_00 = spawnStruct();
  switch (level.zombie_ghost_model) {
    case "zombie_ghost_cube_red":
    case "zombie_ghost_red":
      var_00.color = "red";
      break;

    case "zombie_ghost_cube_green":
    case "zombie_ghost_green":
      var_00.color = "green";
      break;

    case "zombie_ghost_cube_yellow":
    case "zombie_ghost_yellow":
      var_00.color = "yellow";
      break;

    case "zombie_ghost_cube_blue":
    case "zombie_ghost_blue":
      var_00.color = "blue";
      break;

    case "zombie_ghost_bomb_red":
      var_00.color = "red_bomb";
      break;

    case "zombie_ghost_bomb_green":
      var_00.color = "green_bomb";
      break;

    case "zombie_ghost_bomb_yellow":
      var_00.color = "yellow_bomb";
      break;

    case "zombie_ghost_bomb_blue":
      var_00.color = "blue_bomb";
      break;

    case "zombie_ghost_cube_white":
      var_00.color = "white";
      break;
  }

  return var_00;
}

func_50EF() {
  self endon("death");
  wait(0.5);
  if(scripts\engine\utility::istrue(self.head_is_exploding)) {
    return;
  }

  if(isDefined(level.var_C01F)) {}
}

func_AEB0() {
  level._effect["ghost_explosion_death_green"] = loadfx("vfx\iw7\core\zombie\vfx_zmb_ghost_imp.vfx");
}

func_C536(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = gettime();
  if(isplayer(param_01)) {
    if(isDefined(param_05) && param_05 == "iw7_entangler_zm") {
      if(!isDefined(self.var_65FC)) {
        func_D974(param_01, self);
      } else if(param_01 == self.var_65FC) {
        func_D974(param_01, self);
      } else if(!isDefined(level.fbd) || !isDefined(level.fbd.fightstarted) || !level.fbd.fightstarted) {
        _meth_8263(param_01, var_0C);
      }
    } else if(!isDefined(level.fbd) || !isDefined(level.fbd.fightstarted) || !level.fbd.fightstarted) {
      param_01 iprintlnbold("This weapon is not effective againt the ghost");
    }
  }

  if(isDefined(param_02)) {
    self.health = self.health + param_02;
  }
}

_meth_8263(param_00, param_01) {
  if(!isDefined(param_00.var_D8A1) || param_01 - param_00.var_D8A1 / 1000 > 3) {
    if(isDefined(level.grab_same_ghost_string)) {
      param_00 iprintlnbold(level.grab_same_ghost_string);
    } else {
      param_00 iprintlnbold(&"CP_ZMB_GHOST_TRACK_SAME_GHOST");
    }

    param_00.var_D8A1 = param_01;
  }
}

func_D974(param_00, param_01) {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::update_entangler_progress(param_00, param_01);
  param_01 thread func_158F(param_01);
  param_01 thread func_65FD(param_00, param_01);
}

func_158F(param_00) {
  param_00 endon("death");
  param_00 notify("activate_being_tracked_scriptable");
  param_00 endon("activate_being_tracked_scriptable");
  param_00 setscriptablepartstate("being_tracked", "on");
  wait(0.2);
  param_00 setscriptablepartstate("being_tracked", "off");
}

func_65FD(param_00, param_01) {
  param_01 endon("death");
  param_01 notify("entangled_by_player_monitor");
  param_01 endon("entangled_by_player_monitor");
  param_01.var_65FC = param_00;
  scripts\engine\utility::waitframe();
  param_01.var_65FC = undefined;
}

func_C535(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  func_108D0(self.var_1657, param_03, param_04);
  scripts\mp\mp_agent::default_on_killed(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08);
  if(isDefined(level.ghost_killed_update_func)) {
    [[level.ghost_killed_update_func]](param_01, param_04);
  }
}

func_108D0(param_00, param_01, param_02) {}