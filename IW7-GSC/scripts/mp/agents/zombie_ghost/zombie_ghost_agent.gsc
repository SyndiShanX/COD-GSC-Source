/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\agents\zombie_ghost\zombie_ghost_agent.gsc
*****************************************************************/

registerscriptedagent() {
  level.zombie_ghost_hide_nodes = scripts\engine\utility::getStructArray("zombie_ghost_hide_node", "script_noteworthy");
  level.zombie_ghost_hover_nodes = scripts\engine\utility::getStructArray("zombie_ghost_hover_node", "targetname");
  scripts\aitypes\bt_util::init();
  _id_03B4::_id_DEE8();
  _id_0F46::_id_2371();
  _id_AEB0();
  thread _id_FAB0();
}

_id_FAB0() {
  level endon("game_ended");

  if(!isDefined(level.agent_definition)) {
    level waittill("scripted_agents_initialized");
  }

  level.agent_definition["zombie_ghost"]["setup_func"] = ::setupagent;
  level.agent_definition["zombie_ghost"]["setup_model_func"] = ::_id_FACE;
  level.agent_funcs["zombie_ghost"]["on_killed"] = ::_id_C535;
  level.agent_funcs["zombie_ghost"]["on_damaged"] = ::_id_C536;
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
  self.ignoreall = 0;
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
  self.movemode = "walk";
  self.sharpturnnotifydist = 100;
  self.radius = 15;
  self.height = 40;
  self._id_252B = 26 + self.radius;
  self._id_B640 = "normal";
  self._id_B641 = 50;
  self._id_2539 = 54;
  self._id_253A = -64;
  self._id_4D45 = 2250000;
  self.ignoreclosefoliage = 1;
  self.guid = self getentitynumber();
  self.moveratescale = 1.0;
  self._id_C081 = 1.0;
  self.traverseratescale = 1.0;
  self.generalspeedratescale = 1.0;
  self._id_2AB2 = 0;
  self._id_2AB8 = 1;
  self.timelineevents = 0;
  self.allowcrouch = 1;
  self._id_B5F9 = 40;
  self._id_B62E = 60;
  self.meleeradiusbasesq = squared(self._id_B62E);
  self.defaultgoalradius = self.radius + 1;
  self.meleedot = 0.5;
  self.dismember_crawl = 0;
  self.died_poorly = 0;
  self.isfrozen = undefined;
  self.flung = undefined;
  self.dismember_crawl = 0;
  self._id_B0FC = 1;
  self.full_gib = 0;
  self._id_C1F7 = 0;
  scripts\mp\agents\zombie\zombie_util::_id_F794(self._id_B62E);
  self setsolid(0);
  thread _id_899C();
}

_id_899C() {
  self endon("death");
  level waittill("game_ended");
  self clearpath();

  foreach(var_4, var_1 in self._id_164D) {
    var_2 = var_1._id_4BC0;
    var_3 = anim.asm[var_4].states[var_2];
    scripts\asm\asm::_id_2388(var_4, var_2, var_3, var_3._id_116FB);
    scripts\asm\asm::_id_238A(var_4, "idle", 0.2, undefined, undefined, undefined);
  }
}

_id_FACE(var_0) {
  var_1 = get_ghost_info();
  self.color = var_1.color;

  if(isDefined(level.fbd) && isDefined(level.fbd.fightstarted) && level.fbd.fightstarted) {
    self setModel("dlc4_boss_soul");
    return;
  }

  self setModel(level.zombie_ghost_model);
}

get_ghost_info() {
  var_0 = spawnStruct();

  switch (level.zombie_ghost_model) {
    case "zombie_ghost_cube_red":
    case "zombie_ghost_red":
      var_0.color = "red";
      break;
    case "zombie_ghost_cube_green":
    case "zombie_ghost_green":
      var_0.color = "green";
      break;
    case "zombie_ghost_cube_yellow":
    case "zombie_ghost_yellow":
      var_0.color = "yellow";
      break;
    case "zombie_ghost_cube_blue":
    case "zombie_ghost_blue":
      var_0.color = "blue";
      break;
    case "zombie_ghost_bomb_red":
      var_0.color = "red_bomb";
      break;
    case "zombie_ghost_bomb_green":
      var_0.color = "green_bomb";
      break;
    case "zombie_ghost_bomb_yellow":
      var_0.color = "yellow_bomb";
      break;
    case "zombie_ghost_bomb_blue":
      var_0.color = "blue_bomb";
      break;
    case "zombie_ghost_cube_white":
      var_0.color = "white";
      break;
  }

  return var_0;
}

_id_50EF() {
  self endon("death");
  wait 0.5;

  if(scripts\engine\utility::is_true(self.head_is_exploding)) {
    return;
  }
  if(isDefined(level._id_C01F)) {
    return;
  }
}

_id_AEB0() {
  level._effect["ghost_explosion_death_green"] = loadfx("vfx/iw7/core/zombie/vfx_zmb_ghost_imp.vfx");
}

_id_C536(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = gettime();

  if(isPlayer(var_1)) {
    if(isDefined(var_5) && var_5 == "iw7_entangler_zm") {
      if(!isDefined(self._id_65FC)) {
        _id_D974(var_1, self);
      } else if(var_1 == self._id_65FC) {
        _id_D974(var_1, self);
      } else if(!isDefined(level.fbd) || !isDefined(level.fbd.fightstarted) || !level.fbd.fightstarted) {
        _id_8263(var_1, var_12);
      }
    } else if(!isDefined(level.fbd) || !isDefined(level.fbd.fightstarted) || !level.fbd.fightstarted)
      var_1 iprintlnbold("This weapon is not effective againt the ghost");
  }

  if(isDefined(var_2)) {
    self.health = self.health + var_2;
  }
}

_id_8263(var_0, var_1) {
  if(!isDefined(var_0._id_D8A1) || (var_1 - var_0._id_D8A1) / 1000 > 3) {
    if(isDefined(level.grab_same_ghost_string)) {
      var_0 iprintlnbold(level.grab_same_ghost_string);
    } else {
      var_0 iprintlnbold(&"CP_ZMB_GHOST_TRACK_SAME_GHOST");
    }

    var_0._id_D8A1 = var_1;
  }
}

_id_D974(var_0, var_1) {
  scripts\cp\maps\cp_zmb\cp_zmb_ghost_wave::update_entangler_progress(var_0, var_1);
  var_1 thread _id_158F(var_1);
  var_1 thread _id_65FD(var_0, var_1);
}

_id_158F(var_0) {
  var_0 endon("death");
  var_0 notify("activate_being_tracked_scriptable");
  var_0 endon("activate_being_tracked_scriptable");
  var_0 setscriptablepartstate("being_tracked", "on");
  wait 0.2;
  var_0 setscriptablepartstate("being_tracked", "off");
}

_id_65FD(var_0, var_1) {
  var_1 endon("death");
  var_1 notify("entangled_by_player_monitor");
  var_1 endon("entangled_by_player_monitor");
  var_1._id_65FC = var_0;
  scripts\engine\utility::waitframe();
  var_1._id_65FC = undefined;
}

_id_C535(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  _id_108D0(self._id_1657, var_3, var_4);
  scripts\mp\mp_agent::default_on_killed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8);

  if(isDefined(level.ghost_killed_update_func)) {
    [[level.ghost_killed_update_func]](var_1, var_4);
  }
}

_id_108D0(var_0, var_1, var_2) {}