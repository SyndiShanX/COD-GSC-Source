/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\captive\captive_util.gsc
***********************************************/

always_win_melee() {
  self.meleealwayswin = 1;
}

move_to_point_with_angles(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_4))
    wait(var_4);

  if(!isDefined(var_5))
    var_5 = 0;

  if(!isDefined(var_6))
    var_6 = 0;

  self moveTo(var_1, var_0, var_5, var_6);

  if(isDefined(var_2))
    self rotateTo(var_2, var_0, var_5, var_6);

  if(!isDefined(var_3))
    wait(var_0);
  else if(var_3)
    wait(var_0);
}

stub_move(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
  self linkTo(var_5);
  var_5 move_to_point_with_angles(var_0, var_1, var_2, var_3, var_4);
  self unlink();
  var_5 delete();
}

stub_path_array(var_0, var_1) {
  foreach(var_3 in var_0) {
    var_4 = scripts\engine\utility::getStruct(var_3[0], "targetname");
    var_5 = var_3[1];
    var_6 = var_3[2];
    var_7 = var_3[3];
    self moveTo(var_4.origin, var_5, var_6, var_7);
    self rotateTo(var_4.angles, var_5, var_6, var_7);
    wait(var_5);
  }

  if(isDefined(var_1))
    level notify(var_1);
}

get_prefab_base_ent(var_0, var_1) {
  var_2 = getEntArray(var_0, var_1);

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_linkto))
      return var_4;
  }

  return undefined;
}

setup_scripted_door(var_0) {
  var_1 = getEntArray(var_0, "targetname");
  var_1 = scripts\engine\utility::array_combine(var_1, scripts\engine\utility::getStructArray(var_0, "targetname"));
  var_2 = undefined;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;

  foreach(var_9 in var_1) {
    switch (var_9.script_noteworthy) {
      case "clip":
        var_3 = var_9;
        break;
      case "open":
        var_4 = var_9;
        break;
      case "open_ccw":
        var_5 = var_9;
        break;
      case "closed":
        var_6 = var_9;
        break;
      case "door":
        var_2 = var_9;
        break;
      case "parent":
        var_7 = var_9;
        break;
    }
  }

  var_2.clip = var_3;
  var_2.clip linkTo(var_2);

  if(!isDefined(var_4)) {
    var_4 = spawnStruct();
    var_4.origin = var_2.origin;
    var_4.angles = var_2.angles;
  }

  var_2.open = var_4;

  if(!isDefined(var_5)) {
    var_5 = spawnStruct();
    var_5.origin = var_2.origin;
    var_5.angles = var_2.angles;
  }

  var_2.openccw = var_5;

  if(!isDefined(var_6)) {
    var_6 = spawnStruct();
    var_6.origin = var_2.origin;
    var_6.angles = var_2.angles;
  }

  var_2.closed = var_6;

  if(isDefined(var_7))
    var_7 linkTo(var_2);

  return var_2;
}

stub_path(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = [];
  var_5 = scripts\engine\utility::getStruct(var_1, "targetname");
  var_4 = scripts\engine\utility::array_add(var_4, var_5);
  var_6 = var_5;
  var_7 = 1;

  while(var_7) {
    if(isDefined(var_6.target)) {
      var_8 = scripts\engine\utility::getStruct(var_6.target, "targetname");
      var_4 = scripts\engine\utility::array_add(var_4, var_8);
      var_3++;
      var_6 = var_8;
      continue;
    }

    var_7 = 0;
  }

  var_9 = var_0 / var_3;

  if(isDefined(var_2))
    wait(var_2);

  foreach(var_11 in var_4)
  move_to_point_with_angles(var_9, var_11.origin, var_11.angles, 1);

  self notify("stub_path_complete");
}

default_prisoner_movement_speeds() {
  if(isalive(level.ayah))
    level.ayah scripts\engine\utility::set_movement_speed(100);

  if(isalive(level.nadia))
    level.nadia scripts\engine\utility::set_movement_speed(80);

  if(isalive(level.darine))
    level.darine scripts\engine\utility::set_movement_speed(90);

  if(isalive(level.ghalia))
    level.ghalia scripts\engine\utility::set_movement_speed(83);

  if(isalive(level.azadeh))
    level.azadeh scripts\engine\utility::set_movement_speed(85);
}

spawn_prisoners(var_0) {
  if(!isDefined(var_0))
    var_0 = 1;

  level.ayah = scripts\engine\sp\utility::spawn_script_noteworthy("ayah", 1);
  level.nadia = scripts\engine\sp\utility::spawn_script_noteworthy("nadia", 1);

  if(var_0) {
    level.darine = scripts\engine\sp\utility::spawn_script_noteworthy("darine", 1);
    level.ghalia = scripts\engine\sp\utility::spawn_script_noteworthy("ghalia", 1);
  }

  level.allprisoners = [level.ayah, level.nadia, level.darine, level.ghalia];
  level.fourprisoners = level.allprisoners;

  if(scripts\engine\utility::flag("saved_azadeh")) {
    level.azadeh = scripts\engine\sp\utility::spawn_script_noteworthy("azadeh");
    level.allprisoners[level.allprisoners.size] = level.azadeh;
  }
}

prisoner_spawn_func() {
  if(self.script_noteworthy == "azadeh" || self.script_noteworthy == "ghalia" || self.script_noteworthy == "nadia")
    thread mortal_in_player_view();
  else {
    thread scripts\common\ai::magic_bullet_shield();
    self.dontmeleeme = 1;
  }

  self.ignorerandombulletdamage = 1;
  self.ignoreexplosionevents = 1;
  self.noarmor = 1;
  self.baseaccuracy = 0.7;
  self.grenadereturnthrowchance = 0;
  ak_weapon_user_no_sidearm();
  self.aggressiveblindfire = 1;
  scripts\common\ai::set_rebel(1);
  scripts\asm\asm_bb::bb_setshort(1);
}

mortal_in_player_view() {
  self endon("death");
  var_0 = cos(60);
  var_1 = scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0, 1, 1);
  scripts\common\ai::magic_bullet_shield();
  waitframe();

  for(;;) {
    if(isDefined(self.magic_bullet_shield) && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, var_0) && scripts\engine\trace::ray_trace_passed(level.player getEye(), self getEye(), [level.player, self], var_1))
      scripts\common\ai::stop_magic_bullet_shield();
    else if(!isDefined(self.melee) && !isDefined(self.magic_bullet_shield) && !scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, var_0))
      scripts\common\ai::magic_bullet_shield();

    wait 1;
  }
}

spawn_sas() {
  level.sas = scripts\engine\sp\utility::array_spawn_targetname("sas", 1);
  level.price = getEnt("price", "script_noteworthy");
  level.price.script_friendname = "";
  level.price.name = level.price.script_friendname;
  level.sas1 = getEnt("sas1", "script_noteworthy");
  level.sas1.script_friendname = "";
  level.sas1.name = level.sas1.script_friendname;
  level.sas2 = getEnt("sas2", "script_noteworthy");
  level.sas2.script_friendname = "";
  level.sas2.name = level.sas2.script_friendname;
}

sas_spawn_func() {
  if(self.script_noteworthy == "price")
    self attach("hat_hero_price_gasmask");
  else
    self attach("hat_gasmask");

  self.base_accuracy = 10;
  scripts\common\ai::magic_bullet_shield();
  self.attackeraccuracy = 0;
  self.ignorerandombulletdamage = 1;
  self.ignoreexplosionevents = 1;
  self.ignoreme = 1;
  self.dontmelee = 1;
  var_0 = scripts\sp\utility::make_weapon("iw8_ar_kilo433", ["laserir", "reflex_west01", "silencer04"]);
  scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
}

notetrack_listener_close_cell_doors() {
  self endon("kill_listeners");

  for(;;) {
    level waittill("close_cell_doors");
    cell_close_doors();
  }
}

notetrack_listener_open_cell_doors() {
  self endon("kill_listeners");

  for(;;) {
    level waittill("open_cell_doors");
    cell_open_doors();
  }
}

notetrack_listener_close_cellblock_door() {
  self endon("kill_listeners");

  for(;;) {
    level waittill("close_cellblock_door");
    cellblock_close_door();
  }
}

notetrack_listener_open_cellblock_door() {
  self endon("kill_listeners");

  for(;;) {
    level waittill("open_cellblock_door");
    cellblock_open_door();
  }
}

setup_cell_doors() {
  var_0 = getEntArray("cell_door", "script_noteworthy");
  level.celldoors = [];

  foreach(var_2 in var_0) {
    var_2 notsolid();

    if(!isDefined(var_2.script_parameters))
      level.celldoors[level.celldoors.size] = var_2;
  }

  var_4 = getEntArray("upper_cell_door", "script_noteworthy");
  level.uppercelldoors = [];

  foreach(var_2 in var_4) {
    if(!isDefined(var_2.script_parameters))
      level.uppercelldoors[level.uppercelldoors.size] = var_2;
  }

  level.cellblockgate = undefined;
  var_7 = getEntArray("cell_exit_door", "script_noteworthy");

  foreach(var_2 in var_7) {
    if(!isDefined(var_2.script_parameters))
      level.cellblockgate = var_2;
  }

  var_10 = scripts\engine\sp\utility::array_merge(level.celldoors, level.uppercelldoors);
  var_10[var_10.size] = level.cellblockgate;

  foreach(var_12 in var_10) {
    var_13 = var_12 scripts\engine\utility::get_linked_structs();
    var_12.collision = var_12 scripts\engine\utility::get_linked_ent();
    var_12.collision linkTo(var_12);

    foreach(var_15 in var_13) {
      if(var_15.script_parameters == "open_pos") {
        var_12.open_pos = var_15;
        continue;
      }

      var_12.closed_pos = var_15;
    }
  }
}

enable_cell_door_collision() {
  var_0 = getEntArray("cell_door", "script_noteworthy");

  foreach(var_2 in var_0)
  var_2 solid();
}

cell_door_button_check() {
  self endon("end_button_checks");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4);
    self.health = 1000000;

    if(isDefined(var_4) && var_4 != "MOD_MELEE") {
      if(!isDefined(self.animname)) {
        self.animname = "button";
        scripts\common\anim::setanimtree();
      }

      if(!scripts\engine\utility::flag("hit_celldoor_button"))
        scripts\engine\utility::flag_set("hit_celldoor_button");

      cell_door_check();
    }
  }
}

cell_door_check() {
  if(!isDefined(level.celldoorsopen))
    level.celldoorsopen = 0;

  if(!isDefined(level.celldoorsinuse))
    level.celldoorsinuse = 0;

  if(!level.celldoorsinuse) {
    level.celldoorsinuse = 1;

    if(level.celldoorsopen) {
      cell_close_doors();
      wait 3.1;

      if(level.player istouching(getEnt("inside_far_cells", "targetname"))) {
        thread scripts\sp\player_death::set_custom_death_quote(45);
        scripts\sp\utility::missionfailedwrapper();
      }
    } else {
      cell_open_doors();
      wait 3.1;
    }

    level.celldoorsinuse = 0;
  }
}

cell_open_doors(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(isDefined(var_1))
    wait(var_1);

  if(!istrue(var_0)) {
    var_2 = getEnt("cell_door_button", "script_noteworthy");
    thread scripts\engine\utility::play_sound_in_space("alm_open_cell_buzzer", var_2.origin);

    if(!isDefined(var_2.animname)) {
      var_2.animname = "button";
      var_2 scripts\common\anim::setanimtree();
    }

    var_2 thread scripts\common\anim::anim_single_solo(var_2, "button_push");
  }

  getEnt("cell_door_button_lights", "script_noteworthy") setModel("electrical_cell_door_button_lights_green");

  if(!isDefined(level.celldoorsopen))
    level.celldoorsopen = 0;

  foreach(var_4 in level.celldoors) {
    if(var_0) {
      var_4 moveTo(var_4.open_pos.origin, 0.1, 0, 0);
      continue;
    }

    switch (var_4.script_wtf) {
      case "1":
        var_4 playSound("captive_jail_cell_door_01_open");
        var_4 moveTo(var_4.open_pos.origin, 3, 1, 0.5);
        break;
      case "2":
        var_4 playSound("captive_jail_cell_door_02_open");
        var_4 moveTo(var_4.open_pos.origin, 3, 1, 0.5);
        break;
      case "3":
        var_4 playSound("captive_jail_cell_door_03_open");
        var_4 moveTo(var_4.open_pos.origin, 3, 1, 0.5);
        break;
      case "4":
        var_4 playSound("captive_jail_cell_door_04_open");
        var_4 moveTo(var_4.open_pos.origin, 3, 1, 0.5);
        break;
      default:
        var_4 moveTo(var_4.open_pos.origin, 3, 1, 0.5);
        break;
    }
  }

  level.celldoorsopen = 1;
  level notify("cell_doors_open");
}

cell_close_doors(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(isDefined(var_1))
    wait(var_1);

  if(!istrue(var_0)) {
    var_2 = getEnt("cell_door_button", "script_noteworthy");
    thread scripts\engine\utility::play_sound_in_space("alm_open_cell_buzzer", var_2.origin);

    if(!isDefined(var_2.animname)) {
      var_2.animname = "button";
      var_2 scripts\common\anim::setanimtree();
    }

    var_2 thread scripts\common\anim::anim_single_solo(var_2, "button_push");
  }

  getEnt("cell_door_button_lights", "script_noteworthy") setModel("electrical_cell_door_button_lights_red");

  if(!isDefined(level.celldoorsopen))
    level.celldoorsopen = 0;

  if(!isDefined(level.celldoorsinuse))
    level.celldoorsinuse = 0;

  foreach(var_4 in level.celldoors) {
    if(var_0) {
      var_4 moveTo(var_4.closed_pos.origin, 0.1, 0, 0);
      continue;
    }

    switch (var_4.script_wtf) {
      case "1":
        var_4 playSound("captive_jail_cell_door_01_close");
        var_4 moveTo(var_4.closed_pos.origin, 3, 1, 0.5);
        break;
      case "2":
        var_4 playSound("captive_jail_cell_door_02_close");
        var_4 moveTo(var_4.closed_pos.origin, 3, 1, 0.5);
        break;
      case "3":
        var_4 playSound("captive_jail_cell_door_03_close");
        var_4 moveTo(var_4.closed_pos.origin, 3, 1, 0.5);
        break;
      case "4":
        var_4 playSound("captive_jail_cell_door_04_close");
        var_4 moveTo(var_4.closed_pos.origin, 3, 1, 0.5);
        break;
      default:
        var_4 moveTo(var_4.closed_pos.origin, 3, 1, 0.5);
        break;
    }
  }

  level.celldoorsopen = 0;
  level notify("cell_doors_closed");
}

cellblock_open_door(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(var_0)
    level.cellblockgate moveTo(level.cellblockgate.open_pos.origin, 0.1, 0, 0);
  else {
    level.cellblockgate playSound("captive_jail_cell_door_05_open");
    level.cellblockgate moveTo(level.cellblockgate.open_pos.origin, 3, 1, 0.5);
  }

  level.cellblockgate.collision connectpaths();
}

cellblock_close_door(var_0) {
  if(!isDefined(var_0))
    var_0 = 0;

  if(var_0)
    level.cellblockgate moveTo(level.cellblockgate.closed_pos.origin, 0.1, 0, 0);
  else {
    level.cellblockgate playSound("captive_jail_cell_door_05_close");
    level.cellblockgate moveTo(level.cellblockgate.closed_pos.origin, 3, 1, 0.5);
  }

  level.cellblockgate.collision connectpaths();
}

setup_linked_collision_entities(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\engine\utility::get_linked_ents();

    foreach(var_6 in var_4) {
      if(isDefined(var_6.script_parameters)) {
        if(var_6.script_parameters == "collision")
          var_3.collision = var_6;
      }

      var_6 linkTo(var_3);
    }
  }
}

init_low_vent_covers() {
  level.lowventcovers = getEntArray("vent", "targetname");

  foreach(var_1 in level.lowventcovers) {
    var_1.animname = "vent";
    var_1.open = 0;
    var_1 scripts\engine\sp\utility::assign_animtree();

    if(isDefined(var_1.script_noteworthy)) {
      switch (var_1.script_noteworthy) {
        case "first_low_vent":
          if(scripts\engine\utility::flag("hit_celldoor_button"))
            var_1 thread check_use_vent_cover(0, 1);
          else
            var_1 thread check_use_vent_cover(1, 0);

          break;
        default:
          var_1 thread check_use_vent_cover();
          break;
      }

      continue;
    }

    var_1 thread check_use_vent_cover();
  }
}

check_use_vent_cover(var_0, var_1, var_2) {
  self endon("death");

  foreach(var_4 in scripts\engine\utility::getStructArray(self.target, "targetname")) {
    switch (var_4.script_parameters) {
      case "low_vent_use_front":
        self.frontinteract = var_4;
        break;
      case "low_vent_use_rear":
        self.rearinteract = var_4;
        break;
      default:
        break;
    }
  }

  if(!isDefined(var_1))
    var_1 = 0;

  if(!var_1) {
    if(isDefined(var_0) && var_0) {
      if(!scripts\engine\utility::flag("got_spoon")) {
        self.frontinteract scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_OPEN", 180, 200, 32);
        var_6 = self.frontinteract scripts\engine\utility::waittill_any_return("trigger", "clear_interact");

        if(var_6 == "trigger") {
          scripts\engine\utility::flag_set("did_failed_open_vent");
          scripts\sp\player_rig::link_player_to_rig("vent_open_fail", "prone", 1, 0.3);
          level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ce_vent_open_fail();
          scripts\common\anim::anim_single([level.player_rig, self], "vent_open_fail");
          captive_vent_unlink_player_from_rig(0, "prone", 1);
          scripts\engine\utility::flag_wait("got_spoon");
        } else if(var_6 == "clear_interact") {
          self.frontinteract scripts\sp\player\cursor_hint::remove_cursor_hint();
          wait 1;
          scripts\engine\utility::flag_wait("got_spoon");
        }
      }
    }

    self.frontinteract scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_USE", 180, 200, 32);
    self.frontinteract thread vent_wait_interact(self, 1, var_2);
    self.rearinteract scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (1, 0, 0), &"CAPTIVE/CURSOR_USE", 180, 200, 32);
    self.rearinteract thread vent_wait_interact(self, 0, var_2);
  } else {
    self.frontinteract thread vent_wait_interact(self, 1, var_2);
    self.rearinteract thread vent_wait_interact(self, 0, var_2);
  }
}

captive_vent_unlink_player_from_rig(var_0, var_1, var_2, var_3) {
  var_4 = level.player_rig;
  var_4 notify("unlink_player");

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

  if(istrue(var_0))
    var_1 = var_4.ogstance;

  if(isDefined(var_1)) {
    if(istrue(var_2))
      level.player setstance(var_1, 1, 1, 1);
    else if(var_1 != var_4.stance)
      level.player setstance(var_1);
  }

  level.player unlink();

  if(!istrue(var_3))
    var_4 delete();

  level.player enablequickweaponswitch(0);
  level.player scripts\common\utility::allow_offhand_weapons(1, "player_rig");
  level.player scripts\common\utility::allow_weapon(1, "player_rig");
  level.player scripts\common\utility::allow_sprint(1, "player_rig");
  level.player scripts\common\utility::allow_jump(1, "player_rig");
  level.player scripts\common\utility::allow_armor(1, "player_rig");
  level.player scripts\common\utility::allow_melee(1, "player_rig");
  level.player scripts\common\utility::allow_mantle(1, "player_rig");
}

vent_wait_interact(var_0, var_1, var_2) {
  self endon("vent_interaction_done");
  self waittill("trigger");
  level thread open_vent_cover(var_0, var_1, var_2);
}

open_vent_cover(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_0.script_linkto)) {
    var_3 = var_0 scripts\engine\utility::get_linked_structs();

    foreach(var_5 in var_3) {
      if(!scripts\engine\utility::array_contains(anim.smartobjectpoints, var_5))
        var_3 = scripts\engine\utility::array_remove(var_3, var_5);

      var_5.donotuse = 1;
    }
  }

  var_0.open = 1;

  if(isDefined(var_2))
    scripts\engine\utility::flag_set(var_2);

  level.player setstance("prone");
  var_7 = getEntArray(var_0.target, "targetname");

  foreach(var_9 in var_7) {
    if(isDefined(var_9.script_parameters) && var_9.script_parameters == "collision")
      var_9 delete();
  }

  var_0.frontinteract scripts\sp\player\cursor_hint::remove_cursor_hint();
  var_0.frontinteract notify("vent_interaction_done");
  var_0.rearinteract scripts\sp\player\cursor_hint::remove_cursor_hint();
  var_0.rearinteract notify("vent_interaction_done");

  if(isDefined(var_0.script_wtf) && var_0.script_wtf == "cell_vent") {
    thread scripts\sp\analytics::analytics_kleenex_update("Final Day to 1st grate");
    level thread scripts\sp\maps\captive\captive_vo.gsc::vo_ce_opened_first_vent();
  }

  var_11 = var_0.origin + (0, 0, 12);
  scripts\engine\utility::delaythread(2, scripts\stealth\event::event_broadcast_axis_by_sight, "cover_blown", level.player, var_11, 70, 1, var_11);

  if(var_1) {
    if(player_being_tracked_in_stealth()) {
      var_0 scripts\sp\player_rig::link_player_to_rig("vent_open_front_combat", "prone", 1, 0.3);
      level.player_rig attach("weapon_wm_me_spoonshank", "tag_accessory_right");
      var_0 scripts\common\anim::anim_single([level.player_rig, var_0], "vent_open_front_combat");

      if(isDefined(level.guard2)) {
        if(isalive(level.guard2))
          level.guard2 aieventlistenerevent("cover_blown", level.player, level.player.origin);
      }
    } else {
      var_0 scripts\sp\player_rig::link_player_to_rig("vent_open_front", "prone", 1, 0.3);
      level.player_rig attach("weapon_wm_me_spoonshank", "tag_accessory_right");
      level.player playSound("cap_vm_grate_front_plr_lr");
      var_0 scripts\common\anim::anim_single([level.player_rig, var_0], "vent_open_front");

      if(isDefined(level.guard2)) {
        if(isalive(level.guard2))
          level.guard2 aieventlistenerevent("investigate", level.player, level.player.origin);
      }
    }

    level.player_rig detach("weapon_wm_me_spoonshank", "tag_accessory_right");
    captive_vent_unlink_player_from_rig(0, "prone", 1);
    scripts\sp\utility::nvidiaansel_scriptdisable(0);
  } else {
    if(player_being_tracked_in_stealth()) {
      var_0 scripts\sp\player_rig::link_player_to_rig("vent_open_back_combat", "prone", 1, 0.3);
      var_0 scripts\common\anim::anim_single([level.player_rig, var_0], "vent_open_back_combat");

      if(isDefined(level.guard2)) {
        if(isalive(level.guard2))
          level.guard2 aieventlistenerevent("cover_blown", level.player, level.player.origin);
      }
    } else {
      var_0 scripts\sp\player_rig::link_player_to_rig("vent_open_back", "prone", 1, 0.3);
      level.player_rig attach("weapon_wm_me_spoonshank", "tag_accessory_right");
      level.player playSound("cap_vm_grate_back_plr_lr");
      var_0 scripts\common\anim::anim_single([level.player_rig, var_0], "vent_open_back");
      level.player_rig detach("weapon_wm_me_spoonshank", "tag_accessory_right");

      if(isDefined(level.guard2)) {
        if(isalive(level.guard2))
          level.guard2 aieventlistenerevent("investigate", level.player, level.player.origin);
      }
    }

    captive_vent_unlink_player_from_rig(0, "prone", 1);
    scripts\sp\utility::nvidiaansel_scriptdisable(0);
  }

  if(isDefined(var_3)) {
    foreach(var_5 in var_3)
    var_5.donotuse = undefined;
  }
}

player_being_tracked_in_stealth() {
  var_0 = 0;
  var_1 = [level.guard1, level.guard2];

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && isalive(var_3)) {
      if(var_3[[var_3.fnisinstealthcombat]]()) {
        if(isDefined(var_3.enemy) && (gettime() - var_3 lastknowntime(var_3.enemy)) / 1000 < 10)
          var_0 = 1;
      }
    }
  }

  return var_0;
}

get_cell_chair() {
  if(!isDefined(level.cellchair)) {
    var_0 = getEntArray("cell_chair", "targetname");

    foreach(var_2 in var_0) {
      level.cellchair = var_2;
      var_3 = level.cellchair scripts\engine\utility::get_linked_ents();

      foreach(var_5 in var_3)
      var_5 linkTo(level.cellchair);
    }
  }
}

setup_noisemaker_pickups() {
  level.allownoisemakerpickups = 1;
  scripts\sp\equipment\noisemaker::noisemakersenablecursors();

  foreach(var_1 in getEntArray("offhand_noisemaker", "targetname"))
  var_1 thread scripts\sp\equipment\noisemaker::noisemakerwaitpickup();
}

captive_timeout(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "timeout";

  self endon("death");
  self endon("kill_checks");

  if(var_0 > 0)
    wait(var_0);

  if(!isDefined(self)) {
    return;
  }
  self notify(var_1);
}

start_new_patrol_route(var_0, var_1) {
  var_0.target = var_1;
  var_0 scripts\sp\spawner::go_to_node();
}

get_ai_from_array_by_targetname(var_0, var_1) {
  foreach(var_3 in var_0) {
    if(isDefined(var_3)) {
      if(var_3.targetname == var_1)
        return var_3;
    }
  }
}

deactivate_stealth_kill_check() {
  self endon("kill_checks");

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      disable_context_melee();
      waitframe();
    }

    enable_context_melee();
  }
}

enable_context_melee() {
  level.player.contextmeleeactive = 1;
  level thread scripts\sp\utility::context_melee_enable(1);
}

disable_context_melee() {
  if(!isDefined(level.player.contextmeleeactive) || level.player.contextmeleeactive == 1) {
    level.player.contextmeleeactive = 0;
    level thread scripts\sp\utility::context_melee_enable(0);
  }
}

link_player_and_move(var_0, var_1, var_2, var_3, var_4) {
  level.playermover.origin = level.player.origin;
  level.playermover.angles = level.player.angles;
  level.player playerlinktodelta(level.playermover, undefined, 0, 90, 90, 90, 90, 1);
  level.player lerpviewangleclamp(0.3, 0, 0.2, 5, 5, 10, 10);
  level.playermover move_to_point_with_angles(var_0, var_1, var_2, 1, undefined, var_3, var_4);
  level.player unlink();
}

go_to_targetname(var_0) {
  var_1 = getnode(var_0, "targetname");

  if(!isDefined(var_1))
    var_1 = scripts\engine\utility::getStruct(var_0, "targetname");

  if(!isDefined(var_1.radius))
    var_1.radius = 55;

  scripts\sp\spawner::go_to_node(var_1);
}

go_to_node_targetname(var_0) {
  scripts\sp\spawner::go_to_node(getnode(var_0, "targetname"));
}

go_to_struct_targetname(var_0) {
  scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct(var_0, "targetname"));
}

move_to_arrive_then_idle_with_path(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  level endon("kill_all_anim_instructions");
  level endon("end_move_and_idle");
  self endon("end_move_and_idle");
  go_to_targetname(var_0);

  if(isDefined(var_5))
    scripts\engine\utility::flag_set(var_5);

  move_to_arrive_then_idle(var_1, var_2, var_3, var_4, var_6);
}

move_to_arrive_then_idle(var_0, var_1, var_2, var_3, var_4) {
  level endon("kill_all_anim_instructions");
  level endon("end_move_and_idle");
  self endon("end_move_and_idle");

  if(!isDefined(var_3))
    var_3 = "end_move_and_idle";

  var_0 scripts\sp\anim::anim_reach_solo(self, var_1);

  if(isDefined(var_4))
    scripts\engine\utility::flag_set(var_4);

  var_0 scripts\common\anim::anim_single_solo(self, var_1);

  if(isDefined(var_0.arrivalcount))
    var_0.arrivalcount++;
  else
    var_0.arrivalcount = 1;

  var_0 thread scripts\common\anim::anim_loop_solo(self, var_2, var_3);
}

play_group_single_anim_into_idle_anim(var_0, var_1, var_2, var_3, var_4) {
  level endon("kill_all_anim_instructions");

  if(!isDefined(var_4))
    var_4 = 0;

  foreach(var_6 in self)
  var_6 thread play_single_anim_into_idle_anim(var_0, var_1, var_2, var_3, var_4);
}

play_single_anim_into_idle_anim(var_0, var_1, var_2, var_3, var_4) {
  level endon("kill_all_anim_instructions");
  self endon("kill_self_anim_instructions");

  if(!isDefined(var_4))
    var_4 = 0;

  if(var_4)
    var_0 scripts\sp\anim::anim_reach_solo(self, var_1);

  var_0 scripts\common\anim::anim_single_solo(self, var_1);
  var_0 thread scripts\common\anim::anim_loop_solo(self, var_2, var_3);

  if(isDefined(var_0.arrivalcount))
    var_0.arrivalcount++;
  else
    var_0.arrivalcount = 1;
}

play_group_single_anim_into_kill(var_0, var_1) {
  level endon("kill_all_anim_instructions");

  foreach(var_3 in self)
  var_3 thread play_single_anim_into_kill(var_0, var_1);
}

play_single_anim_into_kill(var_0, var_1) {
  level endon("kill_all_anim_instructions");
  var_0 scripts\common\anim::anim_single_solo(self, var_1);
  self.allowdeath = 1;
  scripts\engine\sp\utility::die();
}

play_single_anim_then_move_to(var_0, var_1, var_2) {
  var_0 scripts\common\anim::anim_single_solo(self, var_1);
  scripts\sp\spawner::go_to_node(var_2);
}

ak_weapon_user_no_sidearm() {
  swap_to_farah_frag();
  swap_to_farah_ak();
}

ak_weapon_user() {
  swap_to_farah_frag();
  swap_to_farah_pistol();
  swap_to_farah_ak();
}

swap_to_farah_frag() {
  scripts\engine\sp\utility::set_grenadeweapon("frag_farah");
}

swap_to_farah_ak() {
  thread drop_on_death("iw8_ar_akilo47_tfarah");
}

swap_to_farah_pistol() {
  var_0 = scripts\sp\utility::make_weapon("iw8_pi_golf21_tfarah");
  scripts\engine\utility::script_func("anim_placeweaponon", self.sidearm, "none");
  scripts\anim\shared.gsc::forceuseweapon(var_0, "sidearm");
}

drop_on_death(var_0) {
  self endon("entitydeleted");
  self.dropweapon = 0;
  var_1 = var_0;
  var_2 = undefined;

  foreach(var_4 in self.weapon.attachments)
  var_1 = var_1 + "+" + var_4;

  self waittill("death");

  if(isDefined(self))
    var_2 = self gettagorigin("tag_weapon_right");

  if(!isDefined(var_2) && isDefined(self.origin))
    var_2 = self.origin + (0, 0, 30);

  if(isDefined(var_2))
    var_6 = spawn("weapon_" + var_1, var_2, 0);
}

gas_factory_mid_spawn_func() {
  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\engine\sp\utility::disable_long_death();
}

pistol_weapon_user() {
  self.noarmor = 1;
  scripts\common\ai::gun_remove();
  var_0 = scripts\sp\utility::make_weapon("iw8_pi_golf21_tfarah");
  scripts\anim\shared.gsc::forceuseweapon(var_0, "primary");
}

print3d_ai(var_0, var_1) {
  self endon("death");
  self notify("print3d_ai");
  self endon("print3d_ai");
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, (1, 1, 1));

  for(;;)
    waitframe();
}

background_guard_not_reachable_spawn_func() {
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.sidearm = isundefinedweapon();
  self.allowdeath = 0;
  scripts\engine\sp\utility::clear_deathanim();
  self.skipdeathanim = 1;
  self.a.nodeath = 1;
  self.noragdoll = 1;
  self.context_melee_allowed = 0;
  scripts\sp\utility::context_melee_allow(0);
}

background_guard_spawn_func() {
  self.ignoreme = 1;
  self.ignoreall = 1;
  self.sidearm = isundefinedweapon();
  self.allowdeath = 0;
  scripts\engine\sp\utility::clear_deathanim();
  self.skipdeathanim = 1;
  self.a.nodeath = 1;
  self.noragdoll = 1;
  self.context_melee_allowed = 0;
  scripts\sp\utility::context_melee_allow(0);
  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\anim\shared.gsc::forceuseweapon(scripts\sp\utility::make_weapon("iw8_ar_akilo47_tfarah"), "primary");
}

check_item_interact() {
  level endon("kill_checks");
  self endon("death");
  self waittill("trigger");
  level notify("item_interact");
}

fill_linked_struct_array(var_0) {
  var_1 = [];
  var_2 = 0;

  foreach(var_4 in var_0) {
    var_5 = scripts\engine\utility::getStruct(var_4, "targetname");
    var_5.targetname = var_4;
    var_5.script_parameters = var_2;
    var_1[var_1.size] = var_5;
    var_2++;
  }

  return var_1;
}

array_removedeaddyingorundefined(var_0) {
  var_0 = scripts\engine\utility::array_removeundefined(var_0);
  var_0 = scripts\engine\utility::array_removedead(var_0);
  var_1 = [];

  foreach(var_3 in var_0) {
    if(isai(var_3) && var_3 scripts\engine\utility::doinglongdeath()) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

notify_end_of_anim(var_0) {
  self waittillmatch("single anim", "end");
  level notify(var_0);
}

player_speed_lerp(var_0, var_1, var_2) {
  var_3 = gettime();
  var_4 = 0;

  while(var_4 < 1) {
    var_4 = (gettime() - var_3) / 1000 / var_2;

    if(var_4 > 1)
      var_4 = 1;

    var_5 = scripts\engine\math::lerp(var_0, var_1, var_4);
    level.player.currentspeedscale = var_5;

    if(level.player getstance() != "prone")
      level.player setmovespeedscale(level.player.currentspeedscale);

    waitframe();
  }
}

lerp_fov_over_distance_trigger() {
  var_0 = strtok(self.script_parameters, " ");
  var_1 = [];

  foreach(var_3 in var_0)
  var_1[var_1.size] = scripts\engine\utility::getStruct(var_3, "targetname");

  var_5 = float(var_1[0].script_parameters);
  var_6 = float(var_1[1].script_parameters);
  var_7 = distance(var_1[0].origin, var_1[1].origin);

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      var_8 = pointonsegmentnearesttopoint(var_1[0].origin, var_1[1].origin, level.player.origin);
      var_9 = scripts\engine\math::normalize_value(0, var_7, distance(var_1[0].origin, var_8));
      var_10 = scripts\engine\math::factor_value(var_5, var_6, var_9);
      level.player modifybasefov(var_10, 0.05);

      if(level.player adsButtonPressed())
        wait 0.3;
      else
        level.player modifybasefov(var_10, 0.05);

      waitframe();
    }
  }
}

flag_wait_either_or_timeout(var_0, var_1, var_2) {
  var_3 = var_2 * 1000;
  var_4 = gettime();

  for(;;) {
    if(scripts\engine\utility::flag(var_0) || scripts\engine\utility::flag(var_1)) {
      break;
    }

    if(gettime() >= var_4 + var_3) {
      break;
    }

    var_5 = var_3 - (gettime() - var_4);
    var_6 = var_5 / 1000;
    wait_for_either_flag_or_time_elapses(var_0, var_1, var_6);
  }
}

wait_for_either_flag_or_time_elapses(var_0, var_1, var_2) {
  level endon(var_0);
  level endon(var_1);
  wait(var_2);
}

should_skip_torture_scene() {
  return scripts\common\utility::iswegameplatform();
}

bad_ak_monitor() {
  level.player endon("death");
  var_0 = ["none", "iw8_melee"];

  for(;;) {
    var_1 = waittill_player_switched_weapons(var_0);

    if(var_1.basename == "iw8_ar_akilo47") {
      level.player takeweapon(var_1);
      var_2 = scripts\sp\utility::make_weapon("iw8_ar_akilo47_tfarah");
      level.player giveweapon(var_2);
      level.player switchtoweaponimmediate(var_2);
    }
  }
}

waittill_player_switched_weapons(var_0) {
  var_1 = level.player getcurrentweapon();

  for(var_2 = var_1; var_2 == var_1 || scripts\engine\utility::array_contains(var_0, var_2.basename); var_2 = level.player getcurrentweapon())
    waitframe();

  return var_2;
}

wait_clear_friendname(var_0) {
  wait(var_0);

  if(!isDefined(self)) {
    return;
  }
  self.script_friendname = "";
  self.name = self.script_friendname;
}

say(var_0, var_1) {
  if(!soundexists(var_0))
    return 0;

  if(is_dead_or_dying(self))
    return 0;

  self notify("started_speaking", var_0);
  self.lastspoketime = gettime();
  self.lastaliassaid = var_0;

  if(istrue(var_1)) {
    if(isstruct(self))
      scripts\engine\sp\utility::smart_radio_dialogue_interrupt(var_0);
    else if(isPlayer(self))
      scripts\engine\sp\utility::smart_player_dialogue_interrupt(var_0);
    else if(isDefined(self.animname)) {
      self stopsounds();
      waitframe();
      scripts\engine\sp\utility::smart_dialogue(var_0);
    } else {
      if(issentient(self))
        self playsoundatviewheight(var_0);
      else
        self playSound(var_0);

      wait(lookupsoundlength(var_0) / 1000);
    }
  } else if(isstruct(self))
    scripts\engine\sp\utility::smart_radio_dialogue(var_0);
  else if(isPlayer(self))
    scripts\engine\sp\utility::smart_player_dialogue(var_0);
  else if(isDefined(self.animname))
    scripts\engine\sp\utility::smart_dialogue(var_0);
  else {
    if(issentient(self))
      self playsoundatviewheight(var_0);
    else
      self playSound(var_0);

    wait(lookupsoundlength(var_0) / 1000);
  }

  self notify("finished_speaking", var_0);
  return 1;
}

is_dead_or_dying(var_0) {
  if(!isDefined(var_0))
    return 1;

  if(isai(var_0))
    return !isalive(var_0) || var_0 scripts\engine\utility::doinglongdeath();
  else if(issentient(var_0))
    return !isalive(var_0);

  return 0;
}

is_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid))
    return 0;

  return scripts\engine\utility::time_has_passed(self.lastspoketime, lookupsoundlength(self.lastaliassaid) / 1000);
}

wait_finish_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid))
    return 0;

  var_0 = (gettime() - self.lastspoketime) / 1000;
  var_1 = lookupsoundlength(self.lastaliassaid) / 1000;

  if(var_0 < var_1)
    wait(var_1 - var_0);

  return 1;
}

time_since_spoke() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid))
    return undefined;

  var_0 = self.lastspoketime + lookupsoundlength(self.lastaliassaid);
  return (gettime() - var_0) / 1000;
}

init_chatter() {
  level.vo_chatter = spawnStruct();
  level.vo_chatter.speaking = 0;
  level.vo_chatter.waiting = [];
}

terminate_chatter() {
  level.vo_chatter notify("terminate_chatter");
  level.vo_chatter = undefined;
}

say_as_chatter(var_0, var_1, var_2) {
  return do_as_chatter(::say, [var_0, var_1], var_1, var_2);
}

wait_for_break_in_chatter(var_0) {
  var_1 = spawnStruct();
  var_2 = 0;

  if(!level.vo_chatter.speaking)
    return 1;

  level.vo_chatter.waiting = scripts\engine\utility::array_add(level.vo_chatter.waiting, var_1);

  if(isDefined(var_0))
    var_2 = var_1 scripts\engine\utility::waittill_notify_or_timeout_return("proceed", var_0) == "timeout";
  else
    var_1 waittill("proceed");

  level.vo_chatter.waiting = scripts\engine\utility::array_remove(level.vo_chatter.waiting, var_1);
  return var_2;
}

do_as_chatter(var_0, var_1, var_2, var_3) {
  if(!isDefined(level.vo_chatter))
    thread init_chatter();

  level.vo_chatter endon("terminate_chatter");
  var_4 = spawnStruct();
  thread do_as_chatter_internal(var_0, var_1, var_2, var_3, var_4);
  var_4 waittill("done", var_5);
  return var_5;
}

do_as_chatter_internal(var_0, var_1, var_2, var_3, var_4) {
  level.vo_chatter endon("terminate_chatter");

  if(!istrue(var_2) || isDefined(var_3))
    wait_for_break_in_chatter(var_3);

  var_5 = undefined;

  if(!level.vo_chatter.speaking || istrue(var_2)) {
    level.vo_chatter notify("started_speaking", self, var_0, var_1);
    level.vo_chatter.speaking++;
    var_5 = call_with_params(var_0, var_1);
    level.vo_chatter.speaking--;
    level.vo_chatter notify("done_speaking", self, var_0, var_1);
  }

  if(!level.vo_chatter.speaking && level.vo_chatter.waiting.size > 0)
    level.vo_chatter.waiting[0] notify("proceed");

  var_4 notify("done", var_5);
}

call_with_params(var_0, var_1) {
  if(isbuiltinfunction(var_0))
    return call_with_params_script(var_0, var_1);
  else if(isbuiltinmethod(var_0) || isanimation(var_0))
    return call_with_params_builtin(var_0, var_1);
  else {}
}

call_with_params_script(var_0, var_1) {
  if(!isDefined(var_1))
    return self[[var_0]]();

  if(!isarray(var_1))
    return self[[var_0]](var_1);

  switch (var_1.size) {
    case 0:
      return self[[var_0]]();
    case 1:
      return self[[var_0]](var_1[0]);
    case 2:
      return self[[var_0]](var_1[0], var_1[1]);
    case 3:
      return self[[var_0]](var_1[0], var_1[1], var_1[2]);
    case 4:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
    case 5:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
    case 6:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
    case 7:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
    case 8:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
    case 9:
      return self[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8]);
    default:
      break;
  }
}

call_with_params_builtin(var_0, var_1) {
  if(!isDefined(var_1))
    return self[[var_0]]();

  if(!isarray(var_1))
    return self call[[var_0]](var_1);

  switch (var_1.size) {
    case 0:
      return self call[[var_0]]();
    case 1:
      return self call[[var_0]](var_1[0]);
    case 2:
      return self call[[var_0]](var_1[0], var_1[1]);
    case 3:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2]);
    case 4:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3]);
    case 5:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4]);
    case 6:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5]);
    case 7:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6]);
    case 8:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7]);
    case 9:
      return self call[[var_0]](var_1[0], var_1[1], var_1[2], var_1[3], var_1[4], var_1[5], var_1[6], var_1[7], var_1[8]);
    default:
      break;
  }
}

nagtill_delayed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_1)) {
    if(!isarray(var_1))
      var_1 = [var_1];

    foreach(var_11 in var_1) {
      var_12 = scripts\engine\utility::flag_exist(var_11) && scripts\engine\utility::ter_op(istrue(var_9), !scripts\engine\utility::flag(var_11), scripts\engine\utility::flag(var_11));

      if(var_12) {
        return;
      }
      level endon(var_11);
      self endon(var_11);
    }
  }

  wait(var_0);
  nagtill(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
}

nagtill_open(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  return nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, 1);
}

nagtill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_2 = default_if_undefined(var_2, 3);
  var_3 = default_if_undefined(var_3, 1.5);
  var_4 = default_if_undefined(var_4, 20);
  var_5 = default_if_undefined(var_5, var_2 / 4);
  var_6 = default_if_undefined(var_6, var_3);
  var_7 = default_if_undefined(var_7, var_4 / 4);
  var_9 = var_4 > var_2;
  var_10 = var_7 > var_5;

  if(isDefined(var_0)) {
    if(!isarray(var_0))
      var_0 = [var_0];

    foreach(var_12 in var_0) {
      var_13 = scripts\engine\utility::flag_exist(var_12) && scripts\engine\utility::ter_op(istrue(var_8), !scripts\engine\utility::flag(var_12), scripts\engine\utility::flag(var_12));

      if(var_13) {
        return;
      }
      level endon(var_12);
    }
  }

  if(isarray(var_1)) {
    var_1 = scripts\engine\sp\utility::create_deck(var_1, 0);
    var_1.autoshuffle = 1;
  }

  for(;;) {
    var_15 = var_1 scripts\engine\sp\utility::deck_draw();

    if(isarray(var_15))
      var_15[0] say_as_chatter(var_15[1]);
    else
      say_as_chatter(var_15);

    wait(randomfloatrange(var_2 - var_5, var_2 + var_5));

    if(var_9)
      var_2 = min(var_2 * var_3, var_4);
    else
      var_2 = max(var_2 * var_3, var_4);

    if(var_10)
      var_5 = min(var_5 * var_6, var_7);
    else
      var_5 = max(var_5 * var_6, var_7);

    if(var_1 scripts\engine\sp\utility::deck_is_empty())
      var_1 array_deck_shuffle();
  }
}

compare(var_0, var_1) {
  if(isarray(var_0)) {
    if(isarray(var_1))
      return compare_arrays(var_0, var_1);
    else
      return 0;
  } else if(isarray(var_1))
    return 0;
  else
    return var_0 == var_1;
}

compare_arrays(var_0, var_1) {
  if(var_0.size != var_1.size)
    return 0;

  foreach(var_5, var_3 in var_0) {
    if(!isDefined(var_1[var_5]))
      return 0;

    var_4 = var_1[var_5];

    if(compare(var_4, var_3))
      return 0;
  }

  return 1;
}

array_deck_shuffle() {
  var_0 = self;
  var_0.index = 0;
  var_0.items = scripts\engine\utility::array_randomize(var_0.items);

  if(!var_0.prevent_redraw || !isDefined(var_0.last_drawn) || var_0.items.size <= 1) {
    return;
  }
  var_1 = compare(var_0.items[0], var_0.last_drawn);

  if(var_1) {
    var_2 = randomintrange(1, var_0.items.size);
    var_3 = var_0.items[0];
    var_0.items[0] = var_0.items[var_2];
    var_0.items[var_2] = var_3;
  }
}

default_if_undefined(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = var_1;

  return var_0;
}

wait_lookat_or_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return wait_lookat(var_0, var_1, var_3, var_4, var_5, var_6, var_2, 0);
}

wait_lookat_ads_or_timeout(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  return wait_lookat_ads(var_0, var_1, var_3, var_4, var_5, var_6, var_2);
}

wait_lookat_ads(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!istrue(var_5))
    var_5 = 0;

  return wait_lookat(var_0, var_1, var_2, var_3, var_4, var_5, var_6, 1);
}

wait_lookat(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(isDefined(var_3))
    var_3 = var_3 * 1000;
  else
    var_3 = 0;

  var_8 = undefined;

  while(!isDefined(var_8) || gettime() - var_8 <= var_3) {
    if(!isDefined(var_0)) {
      return;
    }
    var_9 = is_looking_at(var_0, var_1, var_2, var_5);

    if(var_9 && isDefined(var_4))
      var_9 = var_9 && level.player is_near(var_0, var_4);

    if(var_9 && istrue(var_7))
      var_9 = var_9 && level.player scripts\engine\sp\utility::isads();

    if(var_9 && !isDefined(var_8))
      var_8 = gettime();
    else if(!var_9)
      var_8 = undefined;

    if(var_9 && (!isDefined(var_3) || var_3 == 0)) {
      break;
    }

    waitframe();

    if(isDefined(var_6)) {
      var_6 = var_6 - 0.05;

      if(var_6 <= 0)
        return 0;
    }
  }

  return 1;
}

is_looking_at(var_0, var_1, var_2, var_3) {
  if(isent(var_0) && isDefined(var_2))
    var_4 = var_0 gettagorigin(var_2);
  else if(isDefined(var_0.origin))
    var_4 = var_0.origin;
  else
    var_4 = var_0;

  var_5 = level.player worldpointtoscreenpos(var_4, getdvarint("MRNKTKLLKP"));

  if(!isDefined(var_5))
    return 0;

  if(isDefined(var_1) && length2d(var_5) > var_1)
    return 0;

  if(!isDefined(var_3) || var_3) {
    if(isent(var_0))
      var_6 = [level.player, var_0];
    else
      var_6 = [level.player];

    var_7 = scripts\engine\trace::create_contents(0, 1, 0, 0, 0, 0, 0, 0, 0);
    var_8 = scripts\engine\trace::ray_trace_passed(level.player getEye(), var_4, var_6, var_7);
  } else
    var_8 = 1;

  return var_8;
}

wait_near(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = var_0;

  for(;;) {
    if(isent(var_0))
      var_3 = var_0.origin;

    if(distance2dsquared(self.origin, var_3) < var_2) {
      break;
    }

    waitframe();
  }
}

is_near(var_0, var_1) {
  var_2 = var_1 * var_1;
  var_3 = var_0;

  if(isent(var_0))
    var_3 = var_0.origin;

  return distance2dsquared(self.origin, var_3) < var_2;
}

wait_enemy_deaths_or_clear(var_0) {
  while(var_0 > 0) {
    level waittill("ai_killed", var_1);

    if(var_1.team == "axis")
      var_0--;

    if(getaiarray("axis").size == 0)
      return 1;
  }

  return 0;
}

wait_combat_cooldown(var_0, var_1) {
  while(!isDefined(var_1) || var_1 > 0) {
    if(!recently_in_combat(var_0))
      return 0;

    waitframe();

    if(isDefined(var_1))
      var_1 = var_1 - 0.05;
  }

  return 1;
}

recently_in_combat(var_0) {
  var_1 = isDefined(level.player.last_weapon_fire_time) && !scripts\engine\utility::time_has_passed(level.player.last_weapon_fire_time, var_0);
  var_2 = isDefined(level.player.last_damaged_time) && !scripts\engine\utility::time_has_passed(level.player.last_damaged_time, var_0);
  return level.player isfiring() || var_1 || var_2;
}

track_player_combat_time() {
  level.player endon("death");

  for(;;) {
    var_0 = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "damage") == "weapon_fired";

    if(var_0) {
      level.player.last_weapon_fire_time = gettime();
      continue;
    }

    level.player.last_damaged_time = gettime();
  }
}

wait_get_corpse(var_0) {
  if(!isDefined(var_0))
    var_0 = self.script_noteworthy;

  for(;;) {
    foreach(var_2 in getcorpsearray()) {
      if(isDefined(var_2.script_noteworthy) && var_2.script_noteworthy == var_0)
        return var_2;
    }

    waitframe();
  }
}

check_allow_mantle_hud() {
  level endon("used_vent");
  setomnvar("ui_hud_hidden_by_timer", 0);

  for(;;) {
    self waittill("trigger");
    setomnvar("ui_hide_weapon_info", 1);
    setomnvar("ui_hide_hud", 0);

    while(level.player istouching(self))
      waitframe();

    setomnvar("ui_hide_hud", 1);
    setomnvar("ui_hide_weapon_info", 0);
    waitframe();
  }
}