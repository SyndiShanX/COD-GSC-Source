/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_skits.gsc
***********************************************/

#using_animtree("");

function setup_spawn_skits() {
  level.spawn_skits = [];
  add_spawn_skit("stealth_sitting_laptop", &stealth_sitting_laptop);
  add_spawn_skit("stealth_sitting_pistol", &stealth_sitting_pistol);
  add_spawn_skit("stealth_sitting_cell", &stealth_sitting_cell);
  add_spawn_skit("stealth_sitting_sleep", &stealth_sitting_sleep);
  add_spawn_skit("smoking", &smoking);
  add_spawn_skit("cell_phone", &standing_cellphone);
  add_spawn_skit("stealth_sitting_cell_no_props", &stealth_sitting_cell_no_props);
  add_spawn_skit("standing_cellphone", &standing_cellphone);
  add_spawn_skit("end_game_cheer", &movequestobjicon);
  level.scr_animtree["idle_chair"] = #animtree;
  level.scr_model["idle_chair"] = "cp_disco_folding_chair_lod0";
  level.scr_anim["idle_chair"]["sit_sleeping_react"] = $reb_stl_idle_sit_sleeping_react_chair;
  level.scr_anim["idle_chair"]["sit_sleeping_death"] = % reb_stl_idle_sit_sleeping_death01_chair;
  level.scr_anim["idle_chair"]["sit_cellphone_react"] = % reb_stl_idle_sit_phone01_react_chair;
  level.scr_anim["idle_chair"]["sit_cellphone_death"] = % reb_stl_idle_sit_phone01_death02_4_chair;
  level.scr_anim["idle_chair"]["sit_laptop_react"] = % reb_stl_idle_sit_laptop_react_chair;
  level.scr_anim["idle_chair"]["sit_laptop_death"] = % reb_stl_idle_sit_laptop_death02_2_chair;
  level.scr_anim["idle_chair"]["sit_pistol_clean_react"] = % reb_stl_idle_sit_gunmaintenance_react_chair;
  level.scr_anim["idle_chair"]["sit_pistol_clean_death"] = % reb_stl_idle_sit_gunmaintenance_death01_6_chair;
  level.scr_model["idle_cellphone"] = "offhand_wm_smartphone";
}

function skit_fx() {
  level.g_effect["cellphone_glow"] = loadfx("vfx/iw7/levels/piccadilly/vfx_pic_phone_light_01.vfx");
}

function add_spawn_skit(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.skit_name = var_0;
  var_2.skit_func = var_1;
  level.spawn_skits[var_0] = var_2;
}

function hostage_rescue_fight(var_0, var_1, var_2, var_3) {
  var_4 = scripts\mp\mp_agent::spawnnewagentaitype(var_2, var_0.origin, var_0.angles);
  var_5 = scripts\mp\mp_agent::spawnnewagentaitype(var_3, var_1.origin, var_1.angles);
  setup_fight_guy(var_4);
  setup_fight_guy(var_5);
  var_6 = var_4 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "fight1_attacker");
  var_7 = var_4 scripts\asm\asm::asm_getxanim("animscripted", var_6);
  var_8 = var_5 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "fight1_victim");
  var_9 = var_5 scripts\asm\asm::asm_getxanim("animscripted", var_8);
  var_4 aisetanim("animscripted", var_6);
  var_5 aisetanim("animscripted", var_8);
  var_5.deathstate = "animscripted";
  var_5.deathalias = "fight1_victim_death";
  var_10 = 30;
  thread waitfor_death(var_4, var_10, var_5, &death_fight1);
  thread waitfor_save(var_5, var_4);
  var_5 scripts\engine\utility::ref_143C0(30, "saved", "death");
}

function hostage_rescue_meatshield(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(!isDefined(var_4)) {
    var_4 = scripts\mp\mp_agent::spawnnewagentaitype(var_2, var_0.origin, var_0.angles);
  }

  if(!isDefined(var_5)) {
    var_5 = scripts\mp\mp_agent::spawnnewagentaitype(var_3, var_1.origin, var_1.angles);
  }

  setup_fight_guy(var_4);
  setup_fight_guy(var_5);
  var_7 = scripts\cp\cp_weapon::buildweapon("iw8_pi_golf21_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  var_4 giveweapon(var_7);
  var_4.og_weapon = var_4.weapon;
  var_4 setspawnweapon(var_7);
  var_4 scripts\common\utility::initweapon(var_7);
  var_4 scripts\anim\shared::placeweaponon(var_7, "right");
  var_4 scripts\anim\shared::placeweaponon(var_4.weapon, "back");
  var_4.sidearm = var_7;
  var_4.deathstate = "animscripted";
  var_4.deathalias = "fight3_attacker_death";
  var_8 = var_4 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "fight3_attacker");
  var_9 = var_4 scripts\asm\asm::asm_getxanim("animscripted", var_8);
  var_10 = var_5 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "fight3_victim");
  var_11 = var_5 scripts\asm\asm::asm_getxanim("animscripted", var_10);
  var_4 aisetanim("animscripted", var_8);
  var_5 aisetanim("animscripted", var_10);
  var_12 = getanimlength(var_9);
  var_13 = var_12 * 5;

  if(isDefined(var_6)) {
    var_13 = var_6;
  }

  thread waitfor_death(var_4, var_13, var_5, &death_fight2);
  thread waitfor_save(var_5, var_4);
  var_14 = gettime() + var_12 * 5 * 1000;

  if(isDefined(var_6)) {
    var_14 = gettime() + var_6 * 1000;
  }

  thread fight_idle(level, var_14, var_5, var_4, var_12, var_8);
}

function victim_saved_shield() {
  var_0 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", "fight3_victim_saved");
  var_1 = scripts\asm\asm::asm_getxanim("animscripted", var_0);
  self aisetanim("animscripted", var_0);
  wait 2;
  reset_guy(self);

  if(isDefined(self.anchor)) {
    self unlink();
    self.anchor delete();
    return;
  }
}

function fight_idle(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 endon("death");
  var_2 endon("death");

  if(var_0 <= 0) {
    for(;;) {
      wait var_3;
      var_2 aisetanim("animscripted", var_4);
      var_1 aisetanim("animscripted", var_5);
    }

    return;
  }

  while(gettime() < var_0) {
    wait var_3;
    var_2 aisetanim("animscripted", var_4);
    var_1 aisetanim("animscripted", var_5);
  }
}

function setup_fight_guy() {
  self.ignoreall = 1;
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  self setlookatentity();
  self.headlook_enabled = 0;
  self.disableautolookat = 1;
}

function setup_anim_guy() {
  scripts\asm\asm_mp::carepackage_get_dropped_entities();
  self.playing_skit = 1;
}

function death_fight2(var_0) {
  self endon("death");
  var_0.deathstate = "animscripted";
  var_0.deathalias = "fight3_victim_death";
  magicbullet(self.sidearm, self gettagorigin("tag_flash"), anglesToForward(self gettagangles("tag_flash")) * 1000);
  self shoot(10, var_0, 1, 1);
  var_0 dodamage(var_0.health + 100, var_0.origin);
  scripts\asm\shared\mp\utility::burndowntime("fight3_attacker_win");
  self giveweapon(self.og_weapon);
  self setspawnweapon(self.og_weapon);
  scripts\anim\shared::placeweaponon(self.og_weapon, "right");
  scripts\anim\shared::placeweaponon(self.sidearm, "none");
  reset_guy(self);
}

function death_fight1(var_0) {
  var_0.deathstate = "animscripted";
  var_0.deathalias = "fight1_victim_death";
  var_0 dodamage(var_0.health + 100, var_0.origin);
  reset_guy(self);
}

function victim_saved() {
  scripts\asm\shared\mp\utility::burndowntime("fight3_victim_saved");
  reset_guy(self);
}

function victim_killed_fight1() {
  reset_guy(self);
}

function victim_killed_fight2() {
  self giveweapon(self.og_weapon);
  self setspawnweapon(self.og_weapon);
  scripts\anim\shared::placeweaponon(self.og_weapon, "right");
  scripts\anim\shared::placeweaponon(self.sidearm, "none");
  reset_guy(self);
}

function waitfor_death(var_0, var_1, var_2, var_3) {
  self endon("scene_interrupt");
  var_4 = scripts\engine\utility::waittill_any_ents_or_timeout_return(var_0, self, "death", var_1, "death");

  if(isDefined(var_4) && var_4 == "timeout") {
    self thread[[var_2]](var_1);
    return;
  }

  if(isalive(var_1)) {
    var_1 notify("saved");
  }

  if(isalive(self)) {
    self thread[[var_3]]();
    return;
  }
}

function waitfor_save(var_0, var_1) {
  self endon("death");
  self waittill("saved");

  if(isDefined(var_1)) {
    self[[var_1]]();
    return;
  }
}

function reset_guy(var_0) {
  var_0 allowedstances("prone", "stand", "crouch");
  var_0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var_0 setlookatentity();
  var_0.headlook_enabled = 1;
  var_0.disableautolookat = 0;
  var_0.deathstate = undefined;
  var_0.deathalias = undefined;
  var_0.ignoreall = 0;
  var_0.playing_skit = undefined;

  if(isDefined(self.anchor)) {
    self.anchor delete();
    return;
  }
}

function stealth_sitting_laptop(var_0) {
  if(scripts\cp\coop_stealth::ref_132D7()) {
    self._blackboard.idlenode = spawnStruct();
    self._blackboard.idlenode.script_idle = "sit_laptop";
    self._blackboard.idlenode.origin = self.origin;
    self._blackboard.idlenode.angles = self.angles;

    if(!have_props_spawned()) {
      spawn_table();
    }

    if(isDefined(self.spawnpoint)) {
      self.spawnpoint.props_spawned = 1;
      return;
    }

    return;
  }

  if(!have_props_spawned()) {
    var_1 = spawn_chair(var_0);
    thread stealth_sit_react(var_1, "sitting_laptop_react", "reb_stl_idle_sit_laptop_react_chair");
    thread stealth_sit_death(var_1, "reb_stl_idle_sit_laptop_death02_2_chair");
    var_2 = spawn_table();
    set_props_spawned();
  }

  if(isDefined(self.spawnpoint)) {
    self.spawnpoint.props_spawned = 1;
  }

  setup_anim_guy();
  self.deathstate = "patrol_sitting_laptop_death";
  self.deathalias = "death";
  thread stealth_sit_idle("sitting_laptop_idle");
}

function stealth_sitting_pistol(var_0) {
  if(scripts\cp\coop_stealth::ref_132D7()) {
    self._blackboard.idlenode = spawnStruct();
    self._blackboard.idlenode.script_idle = "sit_pistol_clean";
    self._blackboard.idlenode.origin = self.origin;
    self._blackboard.idlenode.angles = self.angles;

    if(!have_props_spawned()) {
      spawn_table();
    }

    if(isDefined(self.spawnpoint)) {
      self.spawnpoint.props_spawned = 1;
      return;
    }

    return;
  }

  if(!have_props_spawned()) {
    var_1 = spawn_chair(var_0);
    thread stealth_sit_react(var_1, "sitting_pistol_react", "reb_stl_idle_sit_gunmaintenance_react_chair");
    thread stealth_sit_death(var_1, "reb_stl_idle_sit_gunmaintenance_death01_6_chair");
    var_2 = spawn_table();
    set_props_spawned();
  }

  setup_anim_guy();
  self.idle_prop = spawn("script_model", self.origin);
  self.idle_prop setModel("weapon_g18_rare_wm");
  self.idle_prop linkTo(self, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  thread stealth_sit_idle("sitting_pistol_idle");
}

function crouching_phone() {
  setup_anim_guy();
  self.deathstate = "patrol_sitting_cellphone_death";
  self.deathalias = "death";
  thread idle_crouching_phone("sitting_cellphone_idle");
}

function idle_crouching_phone(var_0) {
  self endon("death");
  self endon("alerted");
  thread ai_notetrack_loop("smoking");

  for(;;) {
    smoking_idle_start("smoking_idle_start");
    scripts\asm\shared\mp\utility::burndowntime(var_0);
    smoking_idle_end("smoking_idle_end");
  }
}

function stealth_sitting_cell_no_props(var_0) {
  if(scripts\cp\coop_stealth::ref_132D7()) {
    self._blackboard.idlenode = spawnStruct();
    self._blackboard.idlenode.script_idle = "sit_cellphone";
    self._blackboard.idlenode.origin = self.origin;
    self._blackboard.idlenode.angles = self.angles;

    if(isDefined(self.spawnpoint)) {
      self.spawnpoint.props_spawned = 1;
      return;
    }

    return;
  }

  if(!have_props_spawned()) {
    var_1 = spawn_chair(var_0);
    thread stealth_sit_react(var_1, "sitting_cellphone_react", "reb_stl_idle_sit_phone01_react_chair");
    thread stealth_sit_death(var_1, "reb_stl_idle_sit_phone01_death02_4_chair");
    set_props_spawned();
  }

  setup_anim_guy();
  self.deathstate = "patrol_sitting_cellphone_death";
  self.deathalias = "death";
  self.idle_prop = spawn("script_model", self.origin);
  self.idle_prop setModel("offhand_vm_cellphone_old");
  self.idle_prop linkTo(self, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  thread stealth_sit_idle("sitting_cellphone_idle");
}

function stealth_sitting_cell(var_0) {
  if(scripts\cp\coop_stealth::ref_132D7()) {
    self._blackboard.idlenode = spawnStruct();
    self._blackboard.idlenode.script_idle = "sit_cellphone";
    self._blackboard.idlenode.origin = self.origin;
    self._blackboard.idlenode.angles = self.angles;

    if(!have_props_spawned()) {
      spawn_table();
    }

    if(isDefined(self.spawnpoint)) {
      self.spawnpoint.props_spawned = 1;
      return;
    }

    return;
  }

  if(!have_props_spawned()) {
    var_1 = spawn_chair(var_0);
    thread stealth_sit_react(var_1, "sitting_cellphone_react", "reb_stl_idle_sit_phone01_react_chair");
    thread stealth_sit_death(var_1, "reb_stl_idle_sit_phone01_death02_4_chair");
    var_2 = spawn_table();
    set_props_spawned();
  }

  setup_anim_guy();
  self.deathstate = "patrol_sitting_cellphone_death";
  self.deathalias = "death";
  self.idle_prop = spawn("script_model", self.origin);
  self.idle_prop setModel("equipment_personal_smartphone_01");
  self.idle_prop linkTo(self, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
  thread stealth_sit_idle("sitting_cellphone_idle");
}

function stealth_sitting_sleep(var_0) {
  if(scripts\cp\coop_stealth::ref_132D7()) {
    self._blackboard.idlenode = spawnStruct();
    self._blackboard.idlenode.script_idle = "sit_sleeping";
    self._blackboard.idlenode.origin = self.origin;
    self._blackboard.idlenode.angles = self.angles;

    if(isDefined(self.spawnpoint)) {
      self.spawnpoint.props_spawned = 1;
      return;
    }

    return;
  }

  if(!have_props_spawned()) {
    var_1 = spawn_chair(var_0);
    thread stealth_sit_react(var_1, "sitting_sleeping_react", "reb_stl_idle_sit_sleeping_react_chair");
    thread stealth_sit_death(var_1, "reb_stl_idle_sit_sleeping_death01_chair");
    set_props_spawned();
  }

  setup_anim_guy();
  self.deathstate = "patrol_sitting_sleeping_death";
  self.deathalias = "death";
  thread stealth_sit_idle("sitting_sleeping_idle");
}

function spawn_table() {
  var_0 = spawn("script_model", self.origin + anglesToForward(self.angles) * 32);
  var_0.angles = self.angles + (0, 90, 0);
  var_0 setModel("furniture_table_folding_01_open");
  var_0 disconnectPaths();
}

function spawn_chair(var_0) {
  if(!isDefined(var_0)) {
    var_0 = spawn("script_model", self.origin + anglesToForward(self.angles) * -8);
    var_0.angles = self.angles;
    var_0 setModel("cp_disco_folding_chair_lod0");
    var_0 disconnectPaths();
  }

  return var_0;
}

function stealth_sit_idle(var_0) {
  self endon("death");
  self endon("alerted");
  self endon("enter_combat");
  scripts\asm\shared\mp\utility::bunkerinteriorkeypads(var_0);
}

function stealth_sit_react(var_0, var_1, var_2) {
  self endon("death");
  self waittill("alerted");
  scripts\cp\cp_modular_spawning::set_kill_off_time(20);
  self.deathstate = undefined;
  self.deathalias = undefined;

  if(isDefined(self.idle_prop)) {
    self.idle_prop unlink();
    self.idle_prop physicslaunchserver(self.idle_prop.origin, (0, 0, -10));
    self.idle_prop = undefined;
  }

  var_0 scriptmodelplayanimdeltamotion(var_2);
  scripts\asm\shared\mp\utility::burndowntime(var_1);
  var_0 scriptmodelclearanim();
  var_0 physicslaunchserver(var_0.origin, (0, 0, 15));
  reset_guy(self);
}

function stealth_sit_death(var_0, var_1) {
  self endon("alerted");
  var_2 = undefined;

  if(isDefined(self.idle_prop)) {
    var_2 = self.idle_prop;
  }

  self waittill("death");

  if(isDefined(var_2)) {
    var_2 unlink();
    var_2 physicslaunchserver(var_2.origin, (0, 0, -10));
  }

  var_0 scriptmodelplayanimdeltamotion(var_1);
  wait 1;
  var_0 scriptmodelclearanim();
  var_0 physicslaunchserver(var_0.origin, (0, 0, 15));
}

function smoking() {
  self.playing_skit = 1;

  if(scripts\cp\coop_stealth::ref_132D7()) {
    self._blackboard.idlenode = spawnStruct();
    self._blackboard.idlenode.script_idle = "smoking";
    self._blackboard.idlenode.origin = self.origin;
    self._blackboard.idlenode.angles = self.angles;
    return;
  }

  setup_anim_guy();
  self.deathstate = "animscripted";
  self.deathalias = "smoking_death";
  thread smoking_idle("smoking_idle");
  thread smoking_react("smoking_react");
  thread smoking_death("smoking_death");
}

function smoking_idle(var_0) {
  level endon("weapons_free");
  self endon("death");
  self endon("alerted");
  thread ai_notetrack_loop("smoking");

  for(;;) {
    smoking_idle_start("smoking_idle_start");
    scripts\asm\shared\mp\utility::burndowntime(var_0);
    smoking_idle_end("smoking_idle_end");
    ai_smoking_cleanup();

    if(istrue(self.ref_133A4)) {
      self notify("ai_notetrack_Loop");
      self notify("cancel_loop");
      reset_guy(self);
      break;
    }
  }
}

function smoking_idle_start(var_0) {
  self endon("death");
  self endon("alerted");
  scripts\asm\shared\mp\utility::burndowntime(var_0);
}

function smoking_idle_end(var_0) {
  self endon("death");
  self endon("alerted");
  scripts\asm\shared\mp\utility::burndowntime(var_0);
}

function smoking_react(var_0) {
  self endon("death");
  self endon("cancel_loop");
  level scripts\cp\utility::add_wait(&scripts\cp\utility::waittill_msg, "weapons_free");
  scripts\cp\utility::add_wait(&scripts\engine\utility::ref_143A5, "alerted", "checking_friendly_corpse");
  scripts\cp\utility::do_wait_any();
  scripts\cp\cp_modular_spawning::set_kill_off_time(20);
  ai_smoking_cleanup();
  self.deathstate = undefined;
  self.deathalias = undefined;

  if(isDefined(self.idle_prop)) {
    self.idle_prop unlink();
    self.idle_prop physicslaunchserver(self.idle_prop.origin, (0, 0, -10));
    self.idle_prop = undefined;
  }

  scripts\asm\shared\mp\utility::burndowntime(var_0);
  reset_guy(self);
}

function smoking_death(var_0) {
  self endon("alerted");
  self endon("cancel_loop");
  self waittill("death");
  ai_smoking_cleanup();
}

function ai_notetrack_loop(var_0) {
  self endon("death");
  self notify("ai_notetrack_Loop");
  self endon("ai_notetrack_Loop");
  self endon("alerted");

  for(;;) {
    self waittill("animscripted", var_1);

    if(!isDefined(var_1)) {
      var_1 = ["undefined"];
    }

    if(!isarray(var_1)) {
      var_1 = [var_1];
    }

    var_2 = undefined;

    foreach(var_4 in var_1) {
      if(var_0 == "smoking") {
        ai_notehandler_smoking(var_4);
        continue;
      }

      if(var_0 == "standing_cellphone") {
        ai_notehandler_cellphone(var_4);
      }
    }
  }
}

function ai_notehandler_smoking(var_0) {
  switch (var_0) {
    case "attach":
      playFXOnTag(level.g_effect["cigarette_unlit"], self, "tag_accessory_right");
      break;
    case "light":
      playFXOnTag(level.g_effect["cigarette_lit"], self, "tag_accessory_right");
      stopFXOnTag(level.g_effect["cigarette_unlit"], self, "tag_accessory_right");
      playFX(level.g_effect["lighter_glow"], self gettagorigin("tag_accessory_right"));
      thread ai_smoking_blowsmoke();
      break;
    case "detach":
      stopFXOnTag(level.g_effect["cigarette_lit"], self, "tag_accessory_right");
      stopFXOnTag(level.g_effect["cigarette_unlit"], self, "tag_accessory_right");
      playFX(level.g_effect["cigarette_lit_toss"], self gettagorigin("tag_accessory_right"), anglesToForward(self gettagangles("tag_accessory_right")));
      break;
  }
}

function ai_smoking_blowsmoke() {
  self endon("smoking_end");
  self endon("death");
  self notify("ai_notetrack_Loop");
  self endon("ai_notetrack_Loop");
  self endon("alerted");

  for(;;) {
    playFX(level.g_effect["cigarette_smoke"], self getEye() - (0, 0, 2), anglesToForward(self gettagangles("tag_eye")));
    var_0 = randomintrange(5, 8);
    wait var_0;
  }
}

function ai_smoking_cleanup() {
  self notify("smoking_end");

  if(isDefined(self gettagorigin("tag_accessory_right", 1))) {
    killfxontag(level.g_effect["cigarette_lit"], self, "tag_accessory_right");
    killfxontag(level.g_effect["cigarette_unlit"], self, "tag_accessory_right");
    return;
  }
}

function standing_cellphone(var_0) {
  if(scripts\cp\coop_stealth::ref_132D7()) {
    self._blackboard.idlenode = spawnStruct();
    self._blackboard.idlenode.script_idle = "cellphone";
    self._blackboard.idlenode.origin = self.origin;
    self._blackboard.idlenode.angles = self.angles;
    return;
  }

  if(!isDefined(var_0)) {
    var_0 = 1;
  }

  setup_anim_guy();
  self.deathstate = "animscripted";
  self.deathalias = "stand_cellphone_death";
  thread ai_notetrack_loop("standing_cellphone");
  thread standing_cellphone_anim_seq(var_0);
}

function standing_cellphone_anim_seq(var_0) {
  self endon("death");
  self endon("alerted");
  thread cellphone_react("smoking_react");
  standing_cellphone_anim("stand_cellphone_intro");

  if(var_0 > 0) {
    standing_cellphone_loop("stand_cellphone_loop", var_0);
  }

  standing_cellphone_anim("stand_cellphone_exit");
}

function standing_cellphone_anim(var_0) {
  self endon("death");
  self endon("alerted");
  scripts\asm\shared\mp\utility::burndowntime(var_0);
}

function standing_cellphone_loop(var_0, var_1) {
  level endon("weapons_free");
  self endon("death");
  self endon("alerted");
  scripts\asm\shared\mp\utility::bunkeropened(var_0, var_1);
  reset_guy(self);
}

function ai_notehandler_cellphone(var_0) {
  self endon("death");
  self endon("alerted");

  switch (var_0) {
    case "attach":
      self.idle_prop = scripts\common\anim::anim_link_tag_model("offhand_wm_smartphone", "tag_accessory_right");
      break;
    case "detach":
      if(isDefined(self.idle_prop)) {
        self.idle_prop delete();
        self.idle_prop = undefined;
      }

      break;
  }
}

function cellphone_react(var_0) {
  self endon("death");
  level scripts\cp\utility::add_wait(&scripts\cp\utility::waittill_msg, "weapons_free");
  scripts\cp\utility::add_wait(&scripts\engine\utility::ref_143A5, "alerted", "checking_friendly_corpse");
  scripts\cp\utility::do_wait_any();
  scripts\cp\cp_modular_spawning::set_kill_off_time(20);
  ai_cellphone_cleanup();
  self.deathstate = undefined;
  self.deathalias = undefined;

  if(isDefined(self.idle_prop)) {
    self.idle_prop unlink();
    self.idle_prop physicslaunchserver(self.idle_prop.origin, (0, 0, -10));
    self.idle_prop = undefined;
  }

  scripts\asm\shared\mp\utility::burndowntime(var_0);
  reset_guy(self);
}

function ai_cellphone_cleanup() {
  self endon("death");
}

function have_props_spawned() {
  return isDefined(self.spawnpoint) && istrue(self.spawnpoint.props_spawned);
}

function set_props_spawned() {
  if(isDefined(self.spawnpoint)) {
    self.spawnpoint.props_spawned = 1;
    return;
  }
}

function movequestobjicon() {
  self endon("death");
  self endon("alerted");
  scripts\cp\cp_modular_spawning::set_demeanor_from_unittype("patrol");
  scripts\cp\cp_modular_spawning::set_goal_radius(4);
  scripts\cp\cp_modular_spawning::set_goal_pos(self.origin);
  self.ignoreall = 1;
  self.ignoreme = 1;
  self takeallweapons();
  var_0 = scripts\cp\cp_weapon::buildweapon("iw8_fists_mp", [], "none", "none", -1);
  self giveweapon(var_0);
  scripts\anim\shared::forceuseweapon(var_0, "primary");
  wait 0.5;
  var_1 = scripts\engine\utility::getclosest(self.origin, level.players);
  self setlookatentity(var_1);
  wait 0.5;
  setup_anim_guy();
  var_2 = ["cap_ff_010_cheer_scene_civ01", "cap_ff_010_cheer_scene_civ02", "cap_ff_010_cheer_scene_civ03", "cap_ff_010_cheer_scene_civ04", "cap_ff_010_cheer_scene_civ06", "cap_ff_010_cheer_scene_civ07", "cap_ff_010_cheer_scene_civ08", "cap_ff_010_cheer_scene_civ09", "cap_ff_010_cheer_scene_civ10", "cap_ff_010_cheer_scene_civ11", "cap_ff_010_cheer_scene_civ12", "cap_ff_010_cheer_scene_civ13"];
  var_3 = [];
  GscBinSkip0(0x2e, var_3.size, [ &play_looping_skit_anim, "animscripted2", var_2, undefined, undefined]);
}

function setup_gulag_weapon_check() {
  add_spawn_skit("checkin_guard_idle", &checkin_guard_idle);
}

function checkin_guard_idle() {
  self endon("death");
  self endon("alerted");
  setup_anim_guy();
  var_0 = [];
  GscBinSkip0(0x2e, var_0.size, [ &play_looping_skit_anim, "animscripted2", "cp_informant_checkin_sit_idle", 2, self.spawnpoint]);
}

function play_anim_sequence(var_0, var_1, var_2) {
  jumpiffalse(isDefined(var_2)) LOC_000000aa;

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];
    var_5 = var_4[0];
    var_6 = scripts\engine\utility::ter_op(isDefined(var_4[1]), var_4[1], undefined);
    var_7 = scripts\engine\utility::ter_op(isDefined(var_4[2]), var_4[2], undefined);
    var_8 = scripts\engine\utility::ter_op(isDefined(var_4[3]), var_4[3], undefined);
    var_9 = scripts\engine\utility::ter_op(isDefined(var_4[4]), var_4[4], undefined);
    var_10 = scripts\engine\utility::ter_op(isDefined(var_4[5]), var_4[5], undefined);
    var_11 = scripts\engine\utility::ter_op(isDefined(var_4[6]), var_4[6], undefined);
    self childthread[[var_5]](var_6, var_7, var_8, var_9, var_10);
  }

  for(;;) {
    for(var_12 = 0; var_12 < var_0.size; var_12++) {
      var_4 = var_0[var_12];
      var_5 = var_4[0];
      var_6 = scripts\engine\utility::ter_op(isDefined(var_4[1]), var_4[1], undefined);
      var_7 = scripts\engine\utility::ter_op(isDefined(var_4[2]), var_4[2], undefined);
      var_8 = scripts\engine\utility::ter_op(isDefined(var_4[3]), var_4[3], undefined);
      var_9 = scripts\engine\utility::ter_op(isDefined(var_4[4]), var_4[4], undefined);
      self[[var_5]](var_6, var_7, var_8, var_9);
    }

    if(!istrue(var_1)) {
      break;
    }
  }
}

function play_looping_skit_anim(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level endon("end_current_skit_anim");
  self endon("end_current_skit_anim");

  if(isDefined(var_1) && !isarray(var_1)) {
    var_4 = [var_1];
    var_1 = var_4;
    var_4 = undefined;
  }

  var_5 = scripts\engine\utility::random(var_1);

  if(!isDefined(var_0)) {
    var_0 = "animscripted";
  }

  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_0, var_5);
  var_7 = scripts\asm\asm::asm_getxanim(var_0, var_6);
  var_8 = 0;
  var_9 = undefined;
  var_10 = undefined;

  if(isDefined(var_3)) {
    var_9 = var_3.origin;
    var_10 = var_3.angles;
  }

  for(;;) {
    if(isDefined(var_3)) {
      var_11 = getstartorigin(var_9, var_10, var_7);
      var_12 = getstartangles(var_9, var_10, var_7);
      self dontinterpolate();
      self forceteleport(var_11, var_12);
      self notify("actor_position_determined");
    }

    self aisetanim(var_0, var_6);
    wait getanimlength(var_7);

    if(isDefined(var_2)) {
      var_8++;

      if(var_8 >= var_2) {
        return;
      }
    }
  }
}

function play_single_skit_anim(var_0, var_1, var_2, var_3) {
  level endon("game_ended");
  level endon("end_current_skit_anim");
  self endon("end_current_skit_anim");

  if(isDefined(var_1) && !isarray(var_1)) {
    var_4 = [var_1];
    var_1 = var_4;
    var_4 = undefined;
  }

  var_5 = scripts\engine\utility::random(var_1);

  if(!isDefined(var_0)) {
    var_0 = "animscripted";
  }

  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_0, var_5);
  var_7 = scripts\asm\asm::asm_getxanim(var_0, var_6);
  var_8 = undefined;
  var_9 = undefined;

  if(isDefined(var_2)) {
    var_8 = var_2.origin;
    var_9 = var_2.angles;
  }

  if(isDefined(var_2)) {
    var_10 = getstartorigin(var_8, var_9, var_7);
    var_11 = getstartangles(var_8, var_9, var_7);
    self dontinterpolate();
    self forceteleport(var_10, var_11);
    self notify("actor_position_determined");
  }

  self aisetanim(var_0, var_6);
  wait getanimlength(var_7);
}

function spawn_skit_prop(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_0)) {
    self waittill(var_0);
  }

  if(isbuiltinfunction(var_1)) {
    var_1 = self[[var_1]]();
  }

  if(isbuiltinfunction(var_2)) {
    var_2 = self[[var_2]]();
  }

  var_5 = spawn("script_model", var_1);
  var_5.angles = self.angles;
  var_5 setModel(var_3);

  if(istrue(var_4)) {
    var_5 disconnectPaths();
  }

  return var_5;
}

function get_position_from_actor() {
  var_0 = self gettagorigin("j_mainroot");
  thread scripts\engine\utility::draw_line_for_time(var_0, var_0 + (0, 0, 128), 1, 1, 1, 30);
  return var_0;
}

function get_angles_from_actor() {
  var_0 = self gettagangles("j_mainroot");
  thread scripts\engine\utility::draw_angles(var_0, var_0 + (0, 0, 128), 1, 1, 1, 30);
  return var_0;
}