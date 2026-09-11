/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\captive\captive_util.gsc
****************************************************/

function always_win_melee() {
  self.meleealwayswin = 1;
}

function move_to_point_with_angles(var0, var1, var2, var3, var4, var5, var6) {
  if(isDefined(var4)) {
    wait var4;
  }

  if(!isDefined(var5)) {
    var5 = 0;
  }

  if(!isDefined(var6)) {
    var6 = 0;
  }

  self moveTo(var1, var0, var5, var6);

  if(isDefined(var2)) {
    self rotateTo(var2, var0, var5, var6);
  }

  if(!isDefined(var3)) {
    wait var0;
    return;
  }

  if(var3) {
    wait var0;
    return;
  }
}

function stub_move(var0, var1, var2, var3, var4) {
  var5 = scripts\engine\utility::spawn_script_origin(self.origin, self.angles);
  self linkTo(var5);
  move_to_point_with_angles(var5, var0, var1, var2, var3, var4);
  self unlink();
  var5 delete();
}

function stub_path_array(var0, var1) {
  foreach(var3 in var0) {
    var4 = scripts\engine\utility::getStruct(var3[0], "targetname");
    var5 = var3[1];
    var6 = var3[2];
    var7 = var3[3];
    self moveTo(var4.origin, var5, var6, var7);
    self rotateTo(var4.angles, var5, var6, var7);
    wait var5;
  }

  if(isDefined(var1)) {
    level notify(var1);
    return;
  }
}

function get_prefab_base_ent(var0, var1) {
  var2 = getEntArray(var0, var1);

  foreach(var4 in var2) {
    if(isDefined(var4.script_linkto)) {
      return var4;
    }
  }

  return undefined;
}

function setup_scripted_door(var0) {
  var1 = getEntArray(var0, "targetname");
  var1 = scripts\engine\utility::array_combine(var1, scripts\engine\utility::getStructArray(var0, "targetname"));
  var2 = undefined;
  var3 = undefined;
  var4 = undefined;
  var5 = undefined;
  var6 = undefined;
  var7 = undefined;

  foreach(var9 in var1) {
    switch (var9.script_noteworthy) {
      case "clip":
        var3 = var9;
        break;
      case "open":
        var4 = var9;
        break;
      case "open_ccw":
        var5 = var9;
        break;
      case "closed":
        var6 = var9;
        break;
      case "door":
        var2 = var9;
        break;
      case "parent":
        var7 = var9;
        break;
    }
  }

  var2.clip = var3;
  var2.clip linkTo(var2);

  if(!isDefined(var4)) {
    var4 = spawnStruct();
    var4.origin = var2.origin;
    var4.angles = var2.angles;
  }

  var2.open = var4;

  if(!isDefined(var5)) {
    var5 = spawnStruct();
    var5.origin = var2.origin;
    var5.angles = var2.angles;
  }

  var2.openccw = var5;

  if(!isDefined(var6)) {
    var6 = spawnStruct();
    var6.origin = var2.origin;
    var6.angles = var2.angles;
  }

  var2.closed = var6;

  if(isDefined(var7)) {
    var7 linkTo(var2);
  }

  return var2;
}

function stub_path(var0, var1, var2) {
  var3 = 1;
  var4 = [];
  var5 = scripts\engine\utility::getStruct(var1, "targetname");
  var4 = scripts\engine\utility::array_add(var4, var5);
  var6 = var5;

  for(var7 = 1; var7; var7 = 0) {
    if(isDefined(var6.target)) {
      var8 = scripts\engine\utility::getStruct(var6.target, "targetname");
      var4 = scripts\engine\utility::array_add(var4, var8);
      var3++;
      var6 = var8;
      continue;
    }
  }

  var9 = var0 / var3;

  if(isDefined(var2)) {
    wait var2;
  }

  foreach(var11 in var4) {
    move_to_point_with_angles(var9, var11.origin, var11.angles, 1);
  }

  self notify("stub_path_complete");
}

function default_prisoner_movement_speeds() {
  if(isalive(level.ayah)) {
    level.ayah scripts\engine\utility::set_movement_speed(100);
  }

  if(isalive(level.nadia)) {
    level.nadia scripts\engine\utility::set_movement_speed(80);
  }

  if(isalive(level.darine)) {
    level.darine scripts\engine\utility::set_movement_speed(90);
  }

  if(isalive(level.ghalia)) {
    level.ghalia scripts\engine\utility::set_movement_speed(83);
  }

  if(isalive(level.azadeh)) {
    level.azadeh scripts\engine\utility::set_movement_speed(85);
    return;
  }
}

function spawn_prisoners(var0) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  level.ayah = scripts\engine\sp\utility::spawn_script_noteworthy("ayah", 1);
  level.nadia = scripts\engine\sp\utility::spawn_script_noteworthy("nadia", 1);

  if(var0) {
    level.darine = scripts\engine\sp\utility::spawn_script_noteworthy("darine", 1);
    level.ghalia = scripts\engine\sp\utility::spawn_script_noteworthy("ghalia", 1);
  }

  level.allprisoners = [level.ayah, level.nadia, level.darine, level.ghalia];
  level.fourprisoners = level.allprisoners;

  if(scripts\engine\utility::flag("saved_azadeh")) {
    level.azadeh = scripts\engine\sp\utility::spawn_script_noteworthy("azadeh");
    level.allprisoners[level.allprisoners.size] = level.azadeh;
    return;
  }
}

function prisoner_spawn_func() {
  if(self.script_noteworthy == "azadeh" || self.script_noteworthy == "ghalia" || self.script_noteworthy == "nadia") {
    thread mortal_in_player_view();
  } else {
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

function mortal_in_player_view() {
  self endon("death");
  var0 = cos(60);
  var1 = scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0, 1, 1);
  scripts\common\ai::magic_bullet_shield();
  waitframe();

  for(;;) {
    if(isDefined(self.magic_bullet_shield) && scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, var0) && scripts\engine\trace::ray_trace_passed(level.player getEye(), self getEye(), [level.player, self], var1)) {
      scripts\common\ai::stop_magic_bullet_shield();
    } else if(!isDefined(self.melee) && !isDefined(self.magic_bullet_shield) && !scripts\engine\utility::within_fov(level.player.origin, level.player.angles, self.origin, var0)) {
      scripts\common\ai::magic_bullet_shield();
    }

    wait 1;
  }
}

function spawn_sas() {
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

function sas_spawn_func() {
  if(self.script_noteworthy == "price") {
    self attach("hat_hero_price_gasmask");
  } else {
    self attach("hat_gasmask");
  }

  self.base_accuracy = 10;
  scripts\common\ai::magic_bullet_shield();
  self.attackeraccuracy = 0;
  self.ignorerandombulletdamage = 1;
  self.ignoreexplosionevents = 1;
  self.ignoreme = 1;
  self.dontmelee = 1;
  var0 = scripts\sp\utility::make_weapon("iw8_ar_kilo433", ["laserir", "reflex_west01", "silencer04"]);
  scripts\anim\shared::forceuseweapon(var0, "primary");
}

function notetrack_listener_close_cell_doors() {
  self endon("kill_listeners");

  for(;;) {
    level waittill("close_cell_doors");
    cell_close_doors();
  }
}

function notetrack_listener_open_cell_doors() {
  self endon("kill_listeners");

  for(;;) {
    level waittill("open_cell_doors");
    cell_open_doors();
  }
}

function notetrack_listener_close_cellblock_door() {
  self endon("kill_listeners");

  for(;;) {
    level waittill("close_cellblock_door");
    cellblock_close_door();
  }
}

function notetrack_listener_open_cellblock_door() {
  self endon("kill_listeners");

  for(;;) {
    level waittill("open_cellblock_door");
    cellblock_open_door();
  }
}

function setup_cell_doors() {
  var0 = getEntArray("cell_door", "script_noteworthy");
  level.celldoors = [];

  foreach(var2 in var0) {
    var2 notsolid();

    if(!isDefined(var2.script_parameters)) {
      level.celldoors[level.celldoors.size] = var2;
    }
  }

  var4 = getEntArray("upper_cell_door", "script_noteworthy");
  level.uppercelldoors = [];

  foreach(var2 in var4) {
    if(!isDefined(var2.script_parameters)) {
      level.uppercelldoors[level.uppercelldoors.size] = var2;
    }
  }

  level.cellblockgate = undefined;
  var7 = getEntArray("cell_exit_door", "script_noteworthy");

  foreach(var2 in var7) {
    if(!isDefined(var2.script_parameters)) {
      level.cellblockgate = var2;
    }
  }

  var10 = scripts\engine\sp\utility::array_merge(level.celldoors, level.uppercelldoors);
  GscBinSkip0(0x2e, var10.size, level.cellblockgate);
}

function enable_cell_door_collision() {
  var0 = getEntArray("cell_door", "script_noteworthy");

  foreach(var2 in var0) {
    var2 solid();
  }
}

function cell_door_button_check() {
  self endon("end_button_checks");

  for(;;) {
    self waittill("damage", var0, var1, var2, var3, var4);
    self.health = 1000000;

    if(isDefined(var4) && var4 != "MOD_MELEE") {
      if(!isDefined(self.animname)) {
        self.animname = "button";
        scripts\common\anim::setanimtree();
      }

      if(!scripts\engine\utility::flag("hit_celldoor_button")) {
        scripts\engine\utility::flag_set("hit_celldoor_button");
      }

      cell_door_check();
    }
  }
}

function cell_door_check() {
  if(!isDefined(level.celldoorsopen)) {
    level.celldoorsopen = 0;
  }

  if(!isDefined(level.celldoorsinuse)) {
    level.celldoorsinuse = 0;
  }

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
    return;
  }
}

function cell_open_doors(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(isDefined(var1)) {
    wait var1;
  }

  if(!istrue(var0)) {
    var2 = getEnt("cell_door_button", "script_noteworthy");
    thread scripts\engine\utility::play_sound_in_space("alm_open_cell_buzzer", var2.origin);

    if(!isDefined(var2.animname)) {
      var2.animname = "button";
      var2 scripts\common\anim::setanimtree();
    }

    var2 thread scripts\common\anim::anim_single_solo(var2, "button_push");
  }

  getEnt("cell_door_button_lights", "script_noteworthy") setModel("electrical_cell_door_button_lights_green");

  if(!isDefined(level.celldoorsopen)) {
    level.celldoorsopen = 0;
  }

  foreach(var4 in level.celldoors) {
    if(var0) {
      var4 moveTo(var4.open_pos.origin, 0.1, 0, 0);
      continue;
    }

    switch (var4.script_wtf) {
      case "1":
        var4 playSound("captive_jail_cell_door_01_open");
        var4 moveTo(var4.open_pos.origin, 3, 1, 0.5);
        break;
      case "2":
        var4 playSound("captive_jail_cell_door_02_open");
        var4 moveTo(var4.open_pos.origin, 3, 1, 0.5);
        break;
      case "3":
        var4 playSound("captive_jail_cell_door_03_open");
        var4 moveTo(var4.open_pos.origin, 3, 1, 0.5);
        break;
      case "4":
        var4 playSound("captive_jail_cell_door_04_open");
        var4 moveTo(var4.open_pos.origin, 3, 1, 0.5);
        break;
      default:
        var4 moveTo(var4.open_pos.origin, 3, 1, 0.5);
        break;
    }
  }

  level.celldoorsopen = 1;
  level notify("cell_doors_open");
}

function cell_close_doors(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(isDefined(var1)) {
    wait var1;
  }

  if(!istrue(var0)) {
    var2 = getEnt("cell_door_button", "script_noteworthy");
    thread scripts\engine\utility::play_sound_in_space("alm_open_cell_buzzer", var2.origin);

    if(!isDefined(var2.animname)) {
      var2.animname = "button";
      var2 scripts\common\anim::setanimtree();
    }

    var2 thread scripts\common\anim::anim_single_solo(var2, "button_push");
  }

  getEnt("cell_door_button_lights", "script_noteworthy") setModel("electrical_cell_door_button_lights_red");

  if(!isDefined(level.celldoorsopen)) {
    level.celldoorsopen = 0;
  }

  if(!isDefined(level.celldoorsinuse)) {
    level.celldoorsinuse = 0;
  }

  foreach(var4 in level.celldoors) {
    if(var0) {
      var4 moveTo(var4.closed_pos.origin, 0.1, 0, 0);
      continue;
    }

    switch (var4.script_wtf) {
      case "1":
        var4 playSound("captive_jail_cell_door_01_close");
        var4 moveTo(var4.closed_pos.origin, 3, 1, 0.5);
        break;
      case "2":
        var4 playSound("captive_jail_cell_door_02_close");
        var4 moveTo(var4.closed_pos.origin, 3, 1, 0.5);
        break;
      case "3":
        var4 playSound("captive_jail_cell_door_03_close");
        var4 moveTo(var4.closed_pos.origin, 3, 1, 0.5);
        break;
      case "4":
        var4 playSound("captive_jail_cell_door_04_close");
        var4 moveTo(var4.closed_pos.origin, 3, 1, 0.5);
        break;
      default:
        var4 moveTo(var4.closed_pos.origin, 3, 1, 0.5);
        break;
    }
  }

  level.celldoorsopen = 0;
  level notify("cell_doors_closed");
}

function cellblock_open_door(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(var0) {
    level.cellblockgate moveTo(level.cellblockgate.open_pos.origin, 0.1, 0, 0);
  } else {
    level.cellblockgate playSound("captive_jail_cell_door_05_open");
    level.cellblockgate moveTo(level.cellblockgate.open_pos.origin, 3, 1, 0.5);
  }

  level.cellblockgate.collision connectpaths();
}

function cellblock_close_door(var0) {
  if(!isDefined(var0)) {
    var0 = 0;
  }

  if(var0) {
    level.cellblockgate moveTo(level.cellblockgate.closed_pos.origin, 0.1, 0, 0);
  } else {
    level.cellblockgate playSound("captive_jail_cell_door_05_close");
    level.cellblockgate moveTo(level.cellblockgate.closed_pos.origin, 3, 1, 0.5);
  }

  level.cellblockgate.collision connectpaths();
}

function setup_linked_collision_entities(var0) {
  var1 = getEntArray(var0, "targetname");

  foreach(var3 in var1) {
    var4 = var3 scripts\engine\utility::get_linked_ents();

    foreach(var6 in var4) {
      if(isDefined(var6.script_parameters)) {
        if(var6.script_parameters == "collision") {
          var3.collision = var6;
        }
      }

      var6 linkTo(var3);
    }
  }
}

function init_low_vent_covers() {
  level.lowventcovers = getEntArray("vent", "targetname");

  foreach(var1 in level.lowventcovers) {
    var1.animname = "vent";
    var1.open = 0;
    var1 scripts\engine\sp\utility::assign_animtree();

    if(isDefined(var1.script_noteworthy)) {
      switch (var1.script_noteworthy) {
        case "first_low_vent":
          if(scripts\engine\utility::flag("hit_celldoor_button")) {
            thread check_use_vent_cover(var1, 0);
          } else {
            thread check_use_vent_cover(var1, 1);
          }

          break;
        default:
          thread check_use_vent_cover();
          break;
      }

      continue;
    }

    thread check_use_vent_cover();
  }
}

function check_use_vent_cover(var0, var1, var2) {
  self endon("death");

  foreach(var4 in scripts\engine\utility::getStructArray(self.target, "targetname")) {
    switch (var4.script_parameters) {
      case "low_vent_use_front":
        self.frontinteract = var4;
        break;
      case "low_vent_use_rear":
        self.rearinteract = var4;
        break;
      default:
        break;
    }
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!var1) {
    if(isDefined(var0) && var0) {
      if(!scripts\engine\utility::flag("got_spoon")) {
        self.frontinteract scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_OPEN", 180, 200, 32);
        var6 = self.frontinteract scripts\engine\utility::waittill_any_return("trigger", "clear_interact");

        if(var6 == "trigger") {
          scripts\engine\utility::flag_set("did_failed_open_vent");
          scripts\sp\player_rig::link_player_to_rig("vent_open_fail", "prone", 1, 0.3);
          level thread scripts\sp\maps\captive\captive_vo::vo_ce_vent_open_fail();
          scripts\common\anim::anim_single([level.player_rig, self], "vent_open_fail");
          captive_vent_unlink_player_from_rig(0, "prone", 1);
          scripts\engine\utility::flag_wait("got_spoon");
        } else if(var6 == "clear_interact") {
          self.frontinteract scripts\sp\player\cursor_hint::remove_cursor_hint();
          wait 1;
          scripts\engine\utility::flag_wait("got_spoon");
        }
      }
    }

    self.frontinteract scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"CAPTIVE/CURSOR_USE", 180, 200, 32);
    thread vent_wait_interact(self.frontinteract, self, 1);
    self.rearinteract scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (1, 0, 0), &"CAPTIVE/CURSOR_USE", 180, 200, 32);
    thread vent_wait_interact(self.rearinteract, self, 0);
    return;
  }

  thread vent_wait_interact(self.frontinteract, self, 1);
  thread vent_wait_interact(self.rearinteract, self, 0);
}

function captive_vent_unlink_player_from_rig(var0, var1, var2, var3) {
  var4 = level.player_rig;
  var4 notify("unlink_player");

  switch (var4.stance) {
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

  if(istrue(var0)) {
    var1 = var4.ogstance;
  }

  if(isDefined(var1)) {
    if(istrue(var2)) {
      level.player setstance(var1, 1, 1, 1);
    } else if(var1 != var4.stance) {
      level.player setstance(var1);
    }
  }

  level.player unlink();

  if(!istrue(var3)) {
    var4 delete();
  }

  level.player enablequickweaponswitch(0);
  level.player scripts\common\utility::allow_offhand_weapons(1, "player_rig");
  level.player scripts\common\utility::allow_weapon(1, "player_rig");
  level.player scripts\common\utility::allow_sprint(1, "player_rig");
  level.player scripts\common\utility::allow_jump(1, "player_rig");
  level.player scripts\common\utility::allow_armor(1, "player_rig");
  level.player scripts\common\utility::allow_melee(1, "player_rig");
  level.player scripts\common\utility::allow_mantle(1, "player_rig");
}

function vent_wait_interact(var0, var1, var2) {
  self endon("vent_interaction_done");
  self waittill("trigger");
  thread open_vent_cover(level, var0, var1);
}

function open_vent_cover(var0, var1, var2) {
  var3 = undefined;

  if(isDefined(var0.script_linkto)) {
    var3 = var0 scripts\engine\utility::get_linked_structs();

    foreach(var5 in var3) {
      if(!scripts\engine\utility::array_contains(anim.smartobjectpoints, var5)) {
        var3 = scripts\engine\utility::array_remove(var3, var5);
      }

      var5.donotuse = 1;
    }
  }

  var0.open = 1;

  if(isDefined(var2)) {
    scripts\engine\utility::flag_set(var2);
  }

  level.player setstance("prone");
  var7 = getEntArray(var0.target, "targetname");

  foreach(var9 in var7) {
    if(isDefined(var9.script_parameters) && var9.script_parameters == "collision") {
      var9 delete();
    }
  }

  var0.frontinteract scripts\sp\player\cursor_hint::remove_cursor_hint();
  var0.frontinteract notify("vent_interaction_done");
  var0.rearinteract scripts\sp\player\cursor_hint::remove_cursor_hint();
  var0.rearinteract notify("vent_interaction_done");

  if(isDefined(var0.script_wtf) && var0.script_wtf == "cell_vent") {
    thread scripts\sp\analytics::analytics_kleenex_update("Final Day to 1st grate");
    level thread scripts\sp\maps\captive\captive_vo::vo_ce_opened_first_vent();
  }

  var11 = var0.origin + (0, 0, 12);
  scripts\engine\utility::delaythread(2, &scripts\stealth\event::event_broadcast_axis_by_sight, "cover_blown", level.player, var11, 70, 1, var11);

  if(var1) {
    if(player_being_tracked_in_stealth()) {
      var0 scripts\sp\player_rig::link_player_to_rig("vent_open_front_combat", "prone", 1, 0.3);
      level.player_rig attach("weapon_wm_me_spoonshank", "tag_accessory_right");
      var0 scripts\common\anim::anim_single([level.player_rig, var0], "vent_open_front_combat");

      if(isDefined(level.guard2)) {
        if(isalive(level.guard2)) {
          level.guard2 aieventlistenerevent("cover_blown", level.player, level.player.origin);
        }
      }
    } else {
      var0 scripts\sp\player_rig::link_player_to_rig("vent_open_front", "prone", 1, 0.3);
      level.player_rig attach("weapon_wm_me_spoonshank", "tag_accessory_right");
      level.player playSound("cap_vm_grate_front_plr_lr");
      var0 scripts\common\anim::anim_single([level.player_rig, var0], "vent_open_front");

      if(isDefined(level.guard2)) {
        if(isalive(level.guard2)) {
          level.guard2 aieventlistenerevent("investigate", level.player, level.player.origin);
        }
      }
    }

    level.player_rig detach("weapon_wm_me_spoonshank", "tag_accessory_right");
    captive_vent_unlink_player_from_rig(0, "prone", 1);
    scripts\sp\utility::nvidiaansel_scriptdisable(0);
  } else {
    if(player_being_tracked_in_stealth()) {
      var0 scripts\sp\player_rig::link_player_to_rig("vent_open_back_combat", "prone", 1, 0.3);
      var0 scripts\common\anim::anim_single([level.player_rig, var0], "vent_open_back_combat");

      if(isDefined(level.guard2)) {
        if(isalive(level.guard2)) {
          level.guard2 aieventlistenerevent("cover_blown", level.player, level.player.origin);
        }
      }
    } else {
      var0 scripts\sp\player_rig::link_player_to_rig("vent_open_back", "prone", 1, 0.3);
      level.player_rig attach("weapon_wm_me_spoonshank", "tag_accessory_right");
      level.player playSound("cap_vm_grate_back_plr_lr");
      var0 scripts\common\anim::anim_single([level.player_rig, var0], "vent_open_back");
      level.player_rig detach("weapon_wm_me_spoonshank", "tag_accessory_right");

      if(isDefined(level.guard2)) {
        if(isalive(level.guard2)) {
          level.guard2 aieventlistenerevent("investigate", level.player, level.player.origin);
        }
      }
    }

    captive_vent_unlink_player_from_rig(0, "prone", 1);
    scripts\sp\utility::nvidiaansel_scriptdisable(0);
  }

  if(isDefined(var3)) {
    foreach(var5 in var3) {
      var5.donotuse = undefined;
    }

    return;
  }
}

function player_being_tracked_in_stealth() {
  var0 = 0;
  var1 = [level.guard1, level.guard2];

  foreach(var3 in var1) {
    if(isDefined(var3) && isalive(var3)) {
      if(var3[[var3.fnisinstealthcombat]]()) {
        if(isDefined(var3.enemy) && (gettime() - var3 lastknowntime(var3.enemy)) / 1000 < 10) {
          var0 = 1;
        }
      }
    }
  }

  return var0;
}

function get_cell_chair() {
  if(!isDefined(level.cellchair)) {
    var0 = getEntArray("cell_chair", "targetname");

    foreach(var2 in var0) {
      level.cellchair = var2;
      var3 = level.cellchair scripts\engine\utility::get_linked_ents();

      foreach(var5 in var3) {
        var5 linkTo(level.cellchair);
      }
    }

    return;
  }
}

function setup_noisemaker_pickups() {
  level.allownoisemakerpickups = 1;
  scripts\sp\equipment\noisemaker::noisemakersenablecursors();

  foreach(var1 in getEntArray("offhand_noisemaker", "targetname")) {
    var1 thread scripts\sp\equipment\noisemaker::noisemakerwaitpickup();
  }
}

function captive_timeout(var0, var1) {
  if(!isDefined(var1)) {
    var1 = "timeout";
  }

  self endon("death");
  self endon("kill_checks");

  if(var0 > 0) {
    wait var0;
  }

  if(!isDefined(self)) {
    return;
  }

  self notify(var1);
}

function start_new_patrol_route(var0, var1) {
  var0.target = var1;
  var0 scripts\sp\spawner::go_to_node();
}

function get_ai_from_array_by_targetname(var0, var1) {
  foreach(var3 in var0) {
    if(isDefined(var3)) {
      if(var3.targetname == var1) {
        return var3;
      }
    }
  }
}

function deactivate_stealth_kill_check() {
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

function enable_context_melee() {
  level.player.contextmeleeactive = 1;
  level thread scripts\sp\utility::context_melee_enable(1);
}

function disable_context_melee() {
  if(!isDefined(level.player.contextmeleeactive) || level.player.contextmeleeactive == 1) {
    level.player.contextmeleeactive = 0;
    level thread scripts\sp\utility::context_melee_enable(0);
    return;
  }
}

function link_player_and_move(var0, var1, var2, var3, var4) {
  level.playermover.origin = level.player.origin;
  level.playermover.angles = level.player.angles;
  level.player playerlinktodelta(level.playermover, undefined, 0, 90, 90, 90, 90, 1);
  level.player lerpviewangleclamp(0.3, 0, 0.2, 5, 5, 10, 10);
  move_to_point_with_angles(level.playermover, var0, var1, var2, 1, undefined, var3, var4);
  level.player unlink();
}

function go_to_targetname(var0) {
  var1 = getnode(var0, "targetname");

  if(!isDefined(var1)) {
    var1 = scripts\engine\utility::getStruct(var0, "targetname");
  }

  if(!isDefined(var1.radius)) {
    var1.radius = 55;
  }

  scripts\sp\spawner::go_to_node(var1);
}

function go_to_node_targetname(var0) {
  scripts\sp\spawner::go_to_node(getnode(var0, "targetname"));
}

function go_to_struct_targetname(var0) {
  scripts\sp\spawner::go_to_node(scripts\engine\utility::getStruct(var0, "targetname"));
}

function move_to_arrive_then_idle_with_path(var0, var1, var2, var3, var4, var5, var6) {
  level endon("kill_all_anim_instructions");
  level endon("end_move_and_idle");
  self endon("end_move_and_idle");
  go_to_targetname(var0);

  if(isDefined(var5)) {
    scripts\engine\utility::flag_set(var5);
  }

  move_to_arrive_then_idle(var1, var2, var3, var4, var6);
}

function move_to_arrive_then_idle(var0, var1, var2, var3, var4) {
  level endon("kill_all_anim_instructions");
  level endon("end_move_and_idle");
  self endon("end_move_and_idle");

  if(!isDefined(var3)) {
    var3 = "end_move_and_idle";
  }

  var0 scripts\sp\anim::anim_reach_solo(self, var1);

  if(isDefined(var4)) {
    scripts\engine\utility::flag_set(var4);
  }

  var0 scripts\common\anim::anim_single_solo(self, var1);

  if(isDefined(var0.arrivalcount)) {
    var0.arrivalcount++;
  } else {
    var0.arrivalcount = 1;
  }

  var0 thread scripts\common\anim::anim_loop_solo(self, var2, var3);
}

function play_group_single_anim_into_idle_anim(var0, var1, var2, var3, var4) {
  level endon("kill_all_anim_instructions");

  if(!isDefined(var4)) {
    var4 = 0;
  }

  foreach(var6 in self) {
    thread play_single_anim_into_idle_anim(var6, var0, var1, var2, var3);
  }
}

function play_single_anim_into_idle_anim(var0, var1, var2, var3, var4) {
  level endon("kill_all_anim_instructions");
  self endon("kill_self_anim_instructions");

  if(!isDefined(var4)) {
    var4 = 0;
  }

  if(var4) {
    var0 scripts\sp\anim::anim_reach_solo(self, var1);
  }

  var0 scripts\common\anim::anim_single_solo(self, var1);
  var0 thread scripts\common\anim::anim_loop_solo(self, var2, var3);

  if(isDefined(var0.arrivalcount)) {
    var0.arrivalcount++;
    return;
  }

  var0.arrivalcount = 1;
}

function play_group_single_anim_into_kill(var0, var1) {
  level endon("kill_all_anim_instructions");

  foreach(var3 in self) {
    thread play_single_anim_into_kill(var3, var0);
  }
}

function play_single_anim_into_kill(var0, var1) {
  level endon("kill_all_anim_instructions");
  var0 scripts\common\anim::anim_single_solo(self, var1);
  self.allowdeath = 1;
  scripts\engine\sp\utility::die();
}

function play_single_anim_then_move_to(var0, var1, var2) {
  var0 scripts\common\anim::anim_single_solo(self, var1);
  scripts\sp\spawner::go_to_node(var2);
}

function ak_weapon_user_no_sidearm() {
  swap_to_farah_frag();
  swap_to_farah_ak();
}

function ak_weapon_user() {
  swap_to_farah_frag();
  swap_to_farah_pistol();
  swap_to_farah_ak();
}

function swap_to_farah_frag() {
  scripts\engine\sp\utility::set_grenadeweapon("frag_farah");
}

function swap_to_farah_ak() {
  thread drop_on_death("iw8_ar_akilo47_tfarah");
}

function swap_to_farah_pistol() {
  var0 = scripts\sp\utility::make_weapon("iw8_pi_golf21_tfarah");
  scripts\engine\utility::script_func("anim_placeweaponon", self.sidearm, "none");
  scripts\anim\shared::forceuseweapon(var0, "sidearm");
}

function drop_on_death(var0) {
  self endon("entitydeleted");
  self.dropweapon = 0;
  var1 = var0;
  var2 = undefined;

  foreach(var4 in self.weapon.attachments) {
    var1 = var1 + "+" + var4;
  }

  self waittill("death");

  if(isDefined(self)) {
    var2 = self gettagorigin("tag_weapon_right");
  }

  if(!isDefined(var2) && isDefined(self.origin)) {
    var2 = self.origin + (0, 0, 30);
  }

  if(isDefined(var2)) {
    var6 = spawn("weapon_" + var1, var2, 0);
    return;
  }
}

function gas_factory_mid_spawn_func() {
  scripts\engine\sp\utility::set_grenadeammo(0);
  scripts\engine\sp\utility::disable_long_death();
}

function pistol_weapon_user() {
  self.noarmor = 1;
  scripts\common\ai::gun_remove();
  var0 = scripts\sp\utility::make_weapon("iw8_pi_golf21_tfarah");
  scripts\anim\shared::forceuseweapon(var0, "primary");
}

function print3d_ai(var0, var1) {
  self endon("death");
  self notify("print3d_ai");
  self endon("print3d_ai");
  var1 = scripts\engine\utility::ter_op(isDefined(var1), var1, (1, 1, 1));

  for(;;) {
    waitframe();
  }
}

function background_guard_not_reachable_spawn_func() {
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

function background_guard_spawn_func() {
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
  scripts\anim\shared::forceuseweapon(scripts\sp\utility::make_weapon("iw8_ar_akilo47_tfarah"), "primary");
}

function check_item_interact() {
  level endon("kill_checks");
  self endon("death");
  self waittill("trigger");
  level notify("item_interact");
}

function fill_linked_struct_array(var0) {
  var1 = [];
  var2 = 0;

  foreach(var4 in var0) {
    var5 = scripts\engine\utility::getStruct(var4, "targetname");
    var5.targetname = var4;
    var5.script_parameters = var2;
    var1 = var5;
    var2++;
  }

  return var1;
}

function array_removedeaddyingorundefined(var0) {
  var0 = scripts\engine\utility::array_removeundefined(var0);
  var0 = scripts\engine\utility::array_removedead(var0);
  var1 = [];

  foreach(var3 in var0) {
    if(isai(var3) && var3 scripts\engine\utility::doinglongdeath()) {
      continue;
    }

    var1 = var3;
  }

  return var1;
}

function notify_end_of_anim(var0) {
  self waittillmatch("single anim", "end");
  level notify(var0);
}

function player_speed_lerp(var0, var1, var2) {
  var3 = gettime();
  var4 = 0;

  while(var4 < 1) {
    var4 = (gettime() - var3) / 1000 / var2;

    if(var4 > 1) {
      var4 = 1;
    }

    var5 = scripts\engine\math::lerp(var0, var1, var4);
    level.player.currentspeedscale = var5;

    if(level.player getstance() != "prone") {
      level.player setmovespeedscale(level.player.currentspeedscale);
    }

    waitframe();
  }
}

function lerp_fov_over_distance_trigger() {
  var0 = strtok(self.script_parameters, " ");
  var1 = [];

  foreach(var3 in var0) {
    var1 = scripts\engine\utility::getStruct(var3, "targetname");
  }

  var5 = float(var1[0].script_parameters);
  var6 = float(var1[1].script_parameters);
  var7 = distance(var1[0].origin, var1[1].origin);

  for(;;) {
    self waittill("trigger");

    while(level.player istouching(self)) {
      var8 = pointonsegmentnearesttopoint(var1[0].origin, var1[1].origin, level.player.origin);
      var9 = scripts\engine\math::normalize_value(0, var7, distance(var1[0].origin, var8));
      var10 = scripts\engine\math::factor_value(var5, var6, var9);
      level.player modifybasefov(var10, 0.05);

      if(level.player adsButtonPressed()) {
        wait 0.3;
      } else {
        level.player modifybasefov(var10, 0.05);
      }

      waitframe();
    }
  }
}

function flag_wait_either_or_timeout(var0, var1, var2) {
  var3 = var2 * 1000;
  var4 = gettime();

  for(;;) {
    if(scripts\engine\utility::flag(var0) || scripts\engine\utility::flag(var1)) {
      break;
    }

    if(gettime() >= var4 + var3) {
      break;
    }

    var5 = var3 - gettime() - var4;
    var6 = var5 / 1000;
    wait_for_either_flag_or_time_elapses(var0, var1, var6);
  }
}

function wait_for_either_flag_or_time_elapses(var0, var1, var2) {
  level endon(var0);
  level endon(var1);
  wait var2;
}

function should_skip_torture_scene() {
  return scripts\common\utility::iswegameplatform();
}

function bad_ak_monitor() {
  level.player endon("death");
  var0 = ["none", "iw8_melee"];

  for(;;) {
    var1 = waittill_player_switched_weapons(var0);

    if(var1.basename == "iw8_ar_akilo47") {
      level.player takeweapon(var1);
      var2 = scripts\sp\utility::make_weapon("iw8_ar_akilo47_tfarah");
      level.player giveweapon(var2);
      level.player switchtoweaponimmediate(var2);
    }
  }
}

function waittill_player_switched_weapons(var0) {
  var1 = level.player getcurrentweapon();

  for(var2 = var1; var2 == var1 || scripts\engine\utility::array_contains(var0, var2.basename); var2 = level.player getcurrentweapon()) {
    waitframe();
  }

  return var2;
}

function wait_clear_friendname(var0) {
  wait var0;

  if(!isDefined(self)) {
    return;
  }

  self.script_friendname = "";
  self.name = self.script_friendname;
}

function say(var0, var1) {
  if(!soundexists(var0)) {
    return false;
  }

  if(is_dead_or_dying(self)) {
    return false;
  }

  self notify("started_speaking", var0);
  self.lastspoketime = gettime();
  self.lastaliassaid = var0;

  if(istrue(var1)) {
    if(isstruct(self)) {
      scripts\engine\sp\utility::smart_radio_dialogue_interrupt(var0);
    } else if(isPlayer(self)) {
      scripts\engine\sp\utility::smart_player_dialogue_interrupt(var0);
    } else if(isDefined(self.animname)) {
      self stopsounds();
      waitframe();
      scripts\engine\sp\utility::smart_dialogue(var0);
    } else {
      if(issentient(self)) {
        self playsoundatviewheight(var0);
      } else {
        self playSound(var0);
      }

      wait lookupsoundlength(var0) / 1000;
    }
  } else if(isstruct(self)) {
    scripts\engine\sp\utility::smart_radio_dialogue(var0);
  } else if(isPlayer(self)) {
    scripts\engine\sp\utility::smart_player_dialogue(var0);
  } else if(isDefined(self.animname)) {
    scripts\engine\sp\utility::smart_dialogue(var0);
  } else {
    if(issentient(self)) {
      self playsoundatviewheight(var0);
    } else {
      self playSound(var0);
    }

    wait lookupsoundlength(var0) / 1000;
  }

  self notify("finished_speaking", var0);
  return true;
}

function is_dead_or_dying(var0) {
  if(!isDefined(var0)) {
    return true;
  }

  if(isai(var0)) {
    return (!isalive(var0) || var0 scripts\engine\utility::doinglongdeath());
  } else if(issentient(var0)) {
    return !isalive(var0);
  }

  return false;
}

function is_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return 0;
  }

  return scripts\engine\utility::time_has_passed(self.lastspoketime, lookupsoundlength(self.lastaliassaid) / 1000);
}

function wait_finish_speaking() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return false;
  }

  var0 = (gettime() - self.lastspoketime) / 1000;
  var1 = lookupsoundlength(self.lastaliassaid) / 1000;

  if(var0 < var1) {
    wait var1 - var0;
  }

  return true;
}

function time_since_spoke() {
  if(!isDefined(self.lastspoketime) || !isDefined(self.lastaliassaid)) {
    return undefined;
  }

  var0 = self.lastspoketime + lookupsoundlength(self.lastaliassaid);
  return (gettime() - var0) / 1000;
}

function init_chatter() {
  level.vo_chatter = spawnStruct();
  level.vo_chatter.speaking = 0;
  level.vo_chatter.waiting = [];
}

function terminate_chatter() {
  level.vo_chatter notify("terminate_chatter");
  level.vo_chatter = undefined;
}

function say_as_chatter(var0, var1, var2) {
  return do_as_chatter(&say, [var0, var1], var1, var2);
}

function wait_for_break_in_chatter(var0) {
  var1 = spawnStruct();
  var2 = 0;

  if(!level.vo_chatter.speaking) {
    return 1;
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_add(level.vo_chatter.waiting, var1);

  if(isDefined(var0)) {
    var2 = var1 scripts\engine\utility::waittill_notify_or_timeout_return("proceed", var0) == "timeout";
  } else {
    var1 waittill("proceed");
  }

  level.vo_chatter.waiting = scripts\engine\utility::array_remove(level.vo_chatter.waiting, var1);
  return var2;
}

function do_as_chatter(var0, var1, var2, var3) {
  if(!isDefined(level.vo_chatter)) {
    thread init_chatter();
  }

  level.vo_chatter endon("terminate_chatter");
  var4 = spawnStruct();
  thread do_as_chatter_internal(var0, var1, var2, var3, var4);
  var4 waittill("done", var5);
  return var5;
}

function do_as_chatter_internal(var0, var1, var2, var3, var4) {
  level.vo_chatter endon("terminate_chatter");

  if(!istrue(var2) || isDefined(var3)) {
    wait_for_break_in_chatter(var3);
  }

  var5 = undefined;

  if(!level.vo_chatter.speaking || istrue(var2)) {
    level.vo_chatter notify("started_speaking", self, var0, var1);
    level.vo_chatter.speaking++;
    var5 = call_with_params(var0, var1);
    level.vo_chatter.speaking--;
    level.vo_chatter notify("done_speaking", self, var0, var1);
  }

  if(!level.vo_chatter.speaking && level.vo_chatter.waiting.size > 0) {
    level.vo_chatter.waiting[0] notify("proceed");
  }

  var4 notify("done", var5);
}

function call_with_params(var0, var1) {
  if(isbuiltinfunction(var0)) {
    return call_with_params_script(var0, var1);
  }

  if(isbuiltinmethod(var0) || isanimation(var0)) {
    return call_with_params_builtin(var0, var1);
  }
}

function call_with_params_script(var0, var1) {
  if(!isDefined(var1)) {
    return self[[var0]]();
  }

  if(!isarray(var1)) {
    return self[[var0]](var1);
  }

  switch (var1.size) {
    case 0:
      return self[[var0]]();
    case 1:
      return self[[var0]](var1[0]);
    case 2:
      return self[[var0]](var1[0], var1[1]);
    case 3:
      return self[[var0]](var1[0], var1[1], var1[2]);
    case 4:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3]);
    case 5:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4]);
    case 6:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5]);
    case 7:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6]);
    case 8:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7]);
    case 9:
      return self[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7], var1[8]);
    default:
      break;
  }
}

function call_with_params_builtin(var0, var1) {
  if(!isDefined(var1)) {
    return self[[var0]]();
  }

  if(!isarray(var1)) {
    return self builtin[[var0]](var1);
  }

  switch (var1.size) {
    case 0:
      return self builtin[[var0]]();
    case 1:
      return self builtin[[var0]](var1[0]);
    case 2:
      return self builtin[[var0]](var1[0], var1[1]);
    case 3:
      return self builtin[[var0]](var1[0], var1[1], var1[2]);
    case 4:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3]);
    case 5:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4]);
    case 6:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5]);
    case 7:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6]);
    case 8:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7]);
    case 9:
      return self builtin[[var0]](var1[0], var1[1], var1[2], var1[3], var1[4], var1[5], var1[6], var1[7], var1[8]);
    default:
      break;
  }
}

function nagtill_delayed(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var1)) {
    if(!isarray(var1)) {
      var1 = [var1];
    }

    foreach(var11 in var1) {
      var12 = scripts\engine\utility::flag_exist(var11) && scripts\engine\utility::ter_op(istrue(var9), !scripts\engine\utility::flag(var11), scripts\engine\utility::flag(var11));

      if(var12) {
        return;
      }

      level endon(var11);
      self endon(var11);
    }
  }

  wait var0;
  nagtill(var1, var2, var3, var4, var5, var6, var7, var8, var9);
}

function nagtill_open(var0, var1, var2, var3, var4, var5, var6, var7) {
  return nagtill(var0, var1, var2, var3, var4, var5, var6, var7, 1);
}

function nagtill(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var2 = default_if_undefined(var2, 3);
  var3 = default_if_undefined(var3, 1.5);
  var4 = default_if_undefined(var4, 20);
  var5 = default_if_undefined(var5, var2 / 4);
  var6 = default_if_undefined(var6, var3);
  var7 = default_if_undefined(var7, var4 / 4);
  var9 = var4 > var2;
  var10 = var7 > var5;

  if(isDefined(var0)) {
    if(!isarray(var0)) {
      var0 = [var0];
    }

    foreach(var12 in var0) {
      var13 = scripts\engine\utility::flag_exist(var12) && scripts\engine\utility::ter_op(istrue(var8), !scripts\engine\utility::flag(var12), scripts\engine\utility::flag(var12));

      if(var13) {
        return;
      }

      level endon(var12);
    }
  }

  jumpiffalse(isarray(var1)) LOC_000000d9;
  var1 = scripts\engine\sp\utility::create_deck(var1, 0);
  var1.autoshuffle = 1;

  for(;;) {
    var15 = var1 scripts\engine\sp\utility::deck_draw();

    if(isarray(var15)) {
      say_as_chatter(var15[0], var15[1]);
    } else {
      say_as_chatter(var15);
    }

    wait randomfloatrange(var2 - var5, var2 + var5);

    if(var9) {
      var2 = min(var2 * var3, var4);
    } else {
      var2 = max(var2 * var3, var4);
    }

    if(var10) {
      var5 = min(var5 * var6, var7);
    } else {
      var5 = max(var5 * var6, var7);
    }

    if(var1 scripts\engine\sp\utility::deck_is_empty()) {
      array_deck_shuffle(var1);
    }
  }
}

function compare(var0, var1) {
  if(isarray(var0)) {
    if(isarray(var1)) {
      return compare_arrays(var0, var1);
    }

    return 0;
  }

  if(isarray(var1)) {
    return 0;
  }

  return var0 == var1;
}

function compare_arrays(var0, var1) {
  if(var0.size != var1.size) {
    return false;
  }

  foreach(var3 in var0) {
    if(!isDefined(var1[var5])) {
      return false;
    }

    var4 = var1[var5];

    if(compare(var4, var3)) {
      return false;
    }
  }

  return true;
}

function array_deck_shuffle() {
  var0 = self;
  var0.index = 0;
  var0.items = scripts\engine\utility::array_randomize(var0.items);

  if(!var0.prevent_redraw || !isDefined(var0.last_drawn) || var0.items.size <= 1) {
    return;
  }

  var1 = compare(var0.items[0], var0.last_drawn);

  if(var1) {
    var2 = randomintrange(1, var0.items.size);
    var3 = var0.items[0];
    var0.items[0] = var0.items[var2];
    var0.items[var2] = var3;
    return;
  }
}

function default_if_undefined(var0, var1) {
  if(!isDefined(var0)) {
    var0 = var1;
  }

  return var0;
}

function wait_lookat_or_timeout(var0, var1, var2, var3, var4, var5, var6) {
  return wait_lookat(var0, var1, var3, var4, var5, var6, var2, 0);
}

function wait_lookat_ads_or_timeout(var0, var1, var2, var3, var4, var5, var6) {
  return wait_lookat_ads(var0, var1, var3, var4, var5, var6, var2);
}

function wait_lookat_ads(var0, var1, var2, var3, var4, var5, var6) {
  if(!istrue(var5)) {
    var5 = 0;
  }

  return wait_lookat(var0, var1, var2, var3, var4, var5, var6, 1);
}

function wait_lookat(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(isDefined(var3)) {
    var3 *= 1000;
  } else {
    var3 = 0;
  }

  var8 = undefined;

  while(!isDefined(var8) || gettime() - var8 <= var3) {
    if(!isDefined(var0)) {
      return;
    }

    var9 = is_looking_at(var0, var1, var2, var5);

    if(var9 && isDefined(var4)) {
      var9 = var9 && is_near(level.player, var0, var4);
    }

    if(var9 && istrue(var7)) {
      var9 = var9 && level.player scripts\engine\sp\utility::isads();
    }

    if(var9 && !isDefined(var8)) {
      var8 = gettime();
    } else if(!var9) {
      var8 = undefined;
    }

    if(var9 && (!isDefined(var3) || var3 == 0)) {
      break;
    }

    waitframe();

    if(isDefined(var6)) {
      var6 -= 0.05;

      if(var6 <= 0) {
        return 0;
      }
    }
  }

  return 1;
}

function is_looking_at(var0, var1, var2, var3) {
  if(isent(var0) && isDefined(var2)) {
    var4 = var0 gettagorigin(var2);
  } else if(isDefined(var1.origin)) {
    var4 = var1.origin;
  } else {
    var4 = var2;
  }

  var5 = level.player worldpointtoscreenpos(var4, getdvarint("MRNKTKLLKP"));

  if(!isDefined(var5)) {
    return 0;
  }

  if(isDefined(var3) && length2d(var5) > var3) {
    return 0;
  }

  if(!isDefined(var4) || var4) {
    jumpiffalse(isent(var2)) LOC_00000089;
    var6 = [level.player, var2];
    goto LOC_00000094;
  } else {
    var8 = 1;
  }

  return var8;
}

function wait_near(var0, var1) {
  var2 = var1 * var1;
  var3 = var0;

  for(;;) {
    if(isent(var0)) {
      var3 = var0.origin;
    }

    if(distance2dsquared(self.origin, var3) < var2) {
      break;
    }

    waitframe();
  }
}

function is_near(var0, var1) {
  var2 = var1 * var1;
  var3 = var0;

  if(isent(var0)) {
    var3 = var0.origin;
  }

  return distance2dsquared(self.origin, var3) < var2;
}

function wait_enemy_deaths_or_clear(var0) {
  while(var0 > 0) {
    level waittill("ai_killed", var1);

    if(var1.team == "axis") {
      var0--;
    }

    if(getaiarray("axis").size == 0) {
      return true;
    }
  }

  return false;
}

function wait_combat_cooldown(var0, var1) {
  while(!isDefined(var1) || var1 > 0) {
    if(!recently_in_combat(var0)) {
      return false;
    }

    waitframe();

    if(isDefined(var1)) {
      var1 -= 0.05;
    }
  }

  return true;
}

function recently_in_combat(var0) {
  var1 = isDefined(level.player.last_weapon_fire_time) && !scripts\engine\utility::time_has_passed(level.player.last_weapon_fire_time, var0);
  var2 = isDefined(level.player.last_damaged_time) && !scripts\engine\utility::time_has_passed(level.player.last_damaged_time, var0);
  return level.player isfiring() || var1 || var2;
}

function track_player_combat_time() {
  level.player endon("death");

  for(;;) {
    var0 = level.player scripts\engine\utility::waittill_any_return("weapon_fired", "damage") == "weapon_fired";

    if(var0) {
      level.player.last_weapon_fire_time = gettime();
      continue;
    }

    level.player.last_damaged_time = gettime();
  }
}

function wait_get_corpse(var0) {
  jumpiftrue(isDefined(var0)) LOC_0000000e;
  var0 = self.script_noteworthy;

  for(;;) {
    foreach(var2 in getcorpsearray()) {
      if(isDefined(var2.script_noteworthy) && var2.script_noteworthy == var0) {
        return var2;
      }
    }

    waitframe();
  }
}

function check_allow_mantle_hud() {
  level endon("used_vent");
  setomnvar("ui_hud_hidden_by_timer", 0);

  for(;;) {
    self waittill("trigger");
    setomnvar("ui_hide_weapon_info", 1);
    setomnvar("ui_hide_hud", 0);

    while(level.player istouching(self)) {
      waitframe();
    }

    setomnvar("ui_hide_hud", 1);
    setomnvar("ui_hide_weapon_info", 0);
    waitframe();
  }
}