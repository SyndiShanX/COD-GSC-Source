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

function add_spawn_skit(var0, var1) {
  var2 = spawnStruct();
  var2.skit_name = var0;
  var2.skit_func = var1;
  level.spawn_skits[var0] = var2;
}

function hostage_rescue_fight(var0, var1, var2, var3) {
  var4 = scripts\mp\mp_agent::spawnnewagentaitype(var2, var0.origin, var0.angles);
  var5 = scripts\mp\mp_agent::spawnnewagentaitype(var3, var1.origin, var1.angles);
  setup_fight_guy(var4);
  setup_fight_guy(var5);
  var6 = var4 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "fight1_attacker");
  var7 = var4 scripts\asm\asm::asm_getxanim("animscripted", var6);
  var8 = var5 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "fight1_victim");
  var9 = var5 scripts\asm\asm::asm_getxanim("animscripted", var8);
  var4 aisetanim("animscripted", var6);
  var5 aisetanim("animscripted", var8);
  var5.deathstate = "animscripted";
  var5.deathalias = "fight1_victim_death";
  var10 = 30;
  thread waitfor_death(var4, var10, var5, &death_fight1);
  thread waitfor_save(var5, var4);
  var5 scripts\engine\utility::ref_143c0(30, "saved", "death");
}

function hostage_rescue_meatshield(var0, var1, var2, var3, var4, var5, var6) {
  if(!isDefined(var4)) {
    var4 = scripts\mp\mp_agent::spawnnewagentaitype(var2, var0.origin, var0.angles);
  }

  if(!isDefined(var5)) {
    var5 = scripts\mp\mp_agent::spawnnewagentaitype(var3, var1.origin, var1.angles);
  }

  setup_fight_guy(var4);
  setup_fight_guy(var5);
  var7 = scripts\cp\cp_weapon::buildweapon("iw8_pi_golf21_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  var4 giveweapon(var7);
  var4.og_weapon = var4.weapon;
  var4 setspawnweapon(var7);
  var4 scripts\common\utility::initweapon(var7);
  var4 scripts\anim\shared::placeweaponon(var7, "right");
  var4 scripts\anim\shared::placeweaponon(var4.weapon, "back");
  var4.sidearm = var7;
  var4.deathstate = "animscripted";
  var4.deathalias = "fight3_attacker_death";
  var8 = var4 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "fight3_attacker");
  var9 = var4 scripts\asm\asm::asm_getxanim("animscripted", var8);
  var10 = var5 scripts\asm\asm::asm_lookupanimfromalias("animscripted", "fight3_victim");
  var11 = var5 scripts\asm\asm::asm_getxanim("animscripted", var10);
  var4 aisetanim("animscripted", var8);
  var5 aisetanim("animscripted", var10);
  var12 = getanimlength(var9);
  var13 = var12 * 5;

  if(isDefined(var6)) {
    var13 = var6;
  }

  thread waitfor_death(var4, var13, var5, &death_fight2);
  thread waitfor_save(var5, var4);
  var14 = gettime() + var12 * 5 * 1000;

  if(isDefined(var6)) {
    var14 = gettime() + var6 * 1000;
  }

  thread fight_idle(level, var14, var5, var4, var12, var8);
}

function victim_saved_shield() {
  var0 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", "fight3_victim_saved");
  var1 = scripts\asm\asm::asm_getxanim("animscripted", var0);
  self aisetanim("animscripted", var0);
  wait 2;
  reset_guy(self);

  if(isDefined(self.anchor)) {
    self unlink();
    self.anchor delete();
    return;
  }
}

function fight_idle(var0, var1, var2, var3, var4, var5) {
  var1 endon("death");
  var2 endon("death");

  if(var0 <= 0) {
    for(;;) {
      wait var3;
      var2 aisetanim("animscripted", var4);
      var1 aisetanim("animscripted", var5);
    }

    return;
  }

  while(gettime() < var0) {
    wait var3;
    var2 aisetanim("animscripted", var4);
    var1 aisetanim("animscripted", var5);
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

function death_fight2(var0) {
  self endon("death");
  var0.deathstate = "animscripted";
  var0.deathalias = "fight3_victim_death";
  magicbullet(self.sidearm, self gettagorigin("tag_flash"), anglesToForward(self gettagangles("tag_flash")) * 1000);
  self shoot(10, var0, 1, 1);
  var0 dodamage(var0.health + 100, var0.origin);
  scripts\asm\shared\mp\utility::burndowntime("fight3_attacker_win");
  self giveweapon(self.og_weapon);
  self setspawnweapon(self.og_weapon);
  scripts\anim\shared::placeweaponon(self.og_weapon, "right");
  scripts\anim\shared::placeweaponon(self.sidearm, "none");
  reset_guy(self);
}

function death_fight1(var0) {
  var0.deathstate = "animscripted";
  var0.deathalias = "fight1_victim_death";
  var0 dodamage(var0.health + 100, var0.origin);
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

function waitfor_death(var0, var1, var2, var3) {
  self endon("scene_interrupt");
  var4 = scripts\engine\utility::waittill_any_ents_or_timeout_return(var0, self, "death", var1, "death");

  if(isDefined(var4) && var4 == "timeout") {
    self thread[[var2]](var1);
    return;
  }

  if(isalive(var1)) {
    var1 notify("saved");
  }

  if(isalive(self)) {
    self thread[[var3]]();
    return;
  }
}

function waitfor_save(var0, var1) {
  self endon("death");
  self waittill("saved");

  if(isDefined(var1)) {
    self[[var1]]();
    return;
  }
}

function reset_guy(var0) {
  var0 allowedstances("prone", "stand", "crouch");
  var0 scripts\asm\shared\mp\utility::bunkercounteruav();
  var0 setlookatentity();
  var0.headlook_enabled = 1;
  var0.disableautolookat = 0;
  var0.deathstate = undefined;
  var0.deathalias = undefined;
  var0.ignoreall = 0;
  var0.playing_skit = undefined;

  if(isDefined(self.anchor)) {
    self.anchor delete();
    return;
  }
}

function stealth_sitting_laptop(var0) {
  if(scripts\cp\coop_stealth::ref_132d7()) {
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
    var1 = spawn_chair(var0);
    thread stealth_sit_react(var1, "sitting_laptop_react", "reb_stl_idle_sit_laptop_react_chair");
    thread stealth_sit_death(var1, "reb_stl_idle_sit_laptop_death02_2_chair");
    var2 = spawn_table();
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

function stealth_sitting_pistol(var0) {
  if(scripts\cp\coop_stealth::ref_132d7()) {
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
    var1 = spawn_chair(var0);
    thread stealth_sit_react(var1, "sitting_pistol_react", "reb_stl_idle_sit_gunmaintenance_react_chair");
    thread stealth_sit_death(var1, "reb_stl_idle_sit_gunmaintenance_death01_6_chair");
    var2 = spawn_table();
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

function idle_crouching_phone(var0) {
  self endon("death");
  self endon("alerted");
  thread ai_notetrack_loop("smoking");

  for(;;) {
    smoking_idle_start("smoking_idle_start");
    scripts\asm\shared\mp\utility::burndowntime(var0);
    smoking_idle_end("smoking_idle_end");
  }
}

function stealth_sitting_cell_no_props(var0) {
  if(scripts\cp\coop_stealth::ref_132d7()) {
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
    var1 = spawn_chair(var0);
    thread stealth_sit_react(var1, "sitting_cellphone_react", "reb_stl_idle_sit_phone01_react_chair");
    thread stealth_sit_death(var1, "reb_stl_idle_sit_phone01_death02_4_chair");
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

function stealth_sitting_cell(var0) {
  if(scripts\cp\coop_stealth::ref_132d7()) {
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
    var1 = spawn_chair(var0);
    thread stealth_sit_react(var1, "sitting_cellphone_react", "reb_stl_idle_sit_phone01_react_chair");
    thread stealth_sit_death(var1, "reb_stl_idle_sit_phone01_death02_4_chair");
    var2 = spawn_table();
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

function stealth_sitting_sleep(var0) {
  if(scripts\cp\coop_stealth::ref_132d7()) {
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
    var1 = spawn_chair(var0);
    thread stealth_sit_react(var1, "sitting_sleeping_react", "reb_stl_idle_sit_sleeping_react_chair");
    thread stealth_sit_death(var1, "reb_stl_idle_sit_sleeping_death01_chair");
    set_props_spawned();
  }

  setup_anim_guy();
  self.deathstate = "patrol_sitting_sleeping_death";
  self.deathalias = "death";
  thread stealth_sit_idle("sitting_sleeping_idle");
}

function spawn_table() {
  var0 = spawn("script_model", self.origin + anglesToForward(self.angles) * 32);
  var0.angles = self.angles + (0, 90, 0);
  var0 setModel("furniture_table_folding_01_open");
  var0 disconnectPaths();
}

function spawn_chair(var0) {
  if(!isDefined(var0)) {
    var0 = spawn("script_model", self.origin + anglesToForward(self.angles) * -8);
    var0.angles = self.angles;
    var0 setModel("cp_disco_folding_chair_lod0");
    var0 disconnectPaths();
  }

  return var0;
}

function stealth_sit_idle(var0) {
  self endon("death");
  self endon("alerted");
  self endon("enter_combat");
  scripts\asm\shared\mp\utility::bunkerinteriorkeypads(var0);
}

function stealth_sit_react(var0, var1, var2) {
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

  var0 scriptmodelplayanimdeltamotion(var2);
  scripts\asm\shared\mp\utility::burndowntime(var1);
  var0 scriptmodelclearanim();
  var0 physicslaunchserver(var0.origin, (0, 0, 15));
  reset_guy(self);
}

function stealth_sit_death(var0, var1) {
  self endon("alerted");
  var2 = undefined;

  if(isDefined(self.idle_prop)) {
    var2 = self.idle_prop;
  }

  self waittill("death");

  if(isDefined(var2)) {
    var2 unlink();
    var2 physicslaunchserver(var2.origin, (0, 0, -10));
  }

  var0 scriptmodelplayanimdeltamotion(var1);
  wait 1;
  var0 scriptmodelclearanim();
  var0 physicslaunchserver(var0.origin, (0, 0, 15));
}

function smoking() {
  self.playing_skit = 1;

  if(scripts\cp\coop_stealth::ref_132d7()) {
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

function smoking_idle(var0) {
  level endon("weapons_free");
  self endon("death");
  self endon("alerted");
  thread ai_notetrack_loop("smoking");

  for(;;) {
    smoking_idle_start("smoking_idle_start");
    scripts\asm\shared\mp\utility::burndowntime(var0);
    smoking_idle_end("smoking_idle_end");
    ai_smoking_cleanup();

    if(istrue(self.ref_133a4)) {
      self notify("ai_notetrack_Loop");
      self notify("cancel_loop");
      reset_guy(self);
      break;
    }
  }
}

function smoking_idle_start(var0) {
  self endon("death");
  self endon("alerted");
  scripts\asm\shared\mp\utility::burndowntime(var0);
}

function smoking_idle_end(var0) {
  self endon("death");
  self endon("alerted");
  scripts\asm\shared\mp\utility::burndowntime(var0);
}

function smoking_react(var0) {
  self endon("death");
  self endon("cancel_loop");
  level scripts\cp\utility::add_wait(&scripts\cp\utility::waittill_msg, "weapons_free");
  scripts\cp\utility::add_wait(&scripts\engine\utility::ref_143a5, "alerted", "checking_friendly_corpse");
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

  scripts\asm\shared\mp\utility::burndowntime(var0);
  reset_guy(self);
}

function smoking_death(var0) {
  self endon("alerted");
  self endon("cancel_loop");
  self waittill("death");
  ai_smoking_cleanup();
}

function ai_notetrack_loop(var0) {
  self endon("death");
  self notify("ai_notetrack_Loop");
  self endon("ai_notetrack_Loop");
  self endon("alerted");

  for(;;) {
    self waittill("animscripted", var1);

    if(!isDefined(var1)) {
      var1 = ["undefined"];
    }

    if(!isarray(var1)) {
      var1 = [var1];
    }

    var2 = undefined;

    foreach(var4 in var1) {
      if(var0 == "smoking") {
        ai_notehandler_smoking(var4);
        continue;
      }

      if(var0 == "standing_cellphone") {
        ai_notehandler_cellphone(var4);
      }
    }
  }
}

function ai_notehandler_smoking(var0) {
  switch (var0) {
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
    var0 = randomintrange(5, 8);
    wait var0;
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

function standing_cellphone(var0) {
  if(scripts\cp\coop_stealth::ref_132d7()) {
    self._blackboard.idlenode = spawnStruct();
    self._blackboard.idlenode.script_idle = "cellphone";
    self._blackboard.idlenode.origin = self.origin;
    self._blackboard.idlenode.angles = self.angles;
    return;
  }

  if(!isDefined(var0)) {
    var0 = 1;
  }

  setup_anim_guy();
  self.deathstate = "animscripted";
  self.deathalias = "stand_cellphone_death";
  thread ai_notetrack_loop("standing_cellphone");
  thread standing_cellphone_anim_seq(var0);
}

function standing_cellphone_anim_seq(var0) {
  self endon("death");
  self endon("alerted");
  thread cellphone_react("smoking_react");
  standing_cellphone_anim("stand_cellphone_intro");

  if(var0 > 0) {
    standing_cellphone_loop("stand_cellphone_loop", var0);
  }

  standing_cellphone_anim("stand_cellphone_exit");
}

function standing_cellphone_anim(var0) {
  self endon("death");
  self endon("alerted");
  scripts\asm\shared\mp\utility::burndowntime(var0);
}

function standing_cellphone_loop(var0, var1) {
  level endon("weapons_free");
  self endon("death");
  self endon("alerted");
  scripts\asm\shared\mp\utility::bunkeropened(var0, var1);
  reset_guy(self);
}

function ai_notehandler_cellphone(var0) {
  self endon("death");
  self endon("alerted");

  switch (var0) {
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

function cellphone_react(var0) {
  self endon("death");
  level scripts\cp\utility::add_wait(&scripts\cp\utility::waittill_msg, "weapons_free");
  scripts\cp\utility::add_wait(&scripts\engine\utility::ref_143a5, "alerted", "checking_friendly_corpse");
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

  scripts\asm\shared\mp\utility::burndowntime(var0);
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
  var0 = scripts\cp\cp_weapon::buildweapon("iw8_fists_mp", [], "none", "none", -1);
  self giveweapon(var0);
  scripts\anim\shared::forceuseweapon(var0, "primary");
  wait 0.5;
  var1 = scripts\engine\utility::getclosest(self.origin, level.players);
  self setlookatentity(var1);
  wait 0.5;
  setup_anim_guy();
  var2 = ["cap_ff_010_cheer_scene_civ01", "cap_ff_010_cheer_scene_civ02", "cap_ff_010_cheer_scene_civ03", "cap_ff_010_cheer_scene_civ04", "cap_ff_010_cheer_scene_civ06", "cap_ff_010_cheer_scene_civ07", "cap_ff_010_cheer_scene_civ08", "cap_ff_010_cheer_scene_civ09", "cap_ff_010_cheer_scene_civ10", "cap_ff_010_cheer_scene_civ11", "cap_ff_010_cheer_scene_civ12", "cap_ff_010_cheer_scene_civ13"];
  var3 = [];
  GscBinSkip0(0x2e, var3.size, [ &play_looping_skit_anim, "animscripted2", var2, undefined, undefined]);
}

function setup_gulag_weapon_check() {
  add_spawn_skit("checkin_guard_idle", &checkin_guard_idle);
}

function checkin_guard_idle() {
  self endon("death");
  self endon("alerted");
  setup_anim_guy();
  var0 = [];
  GscBinSkip0(0x2e, var0.size, [ &play_looping_skit_anim, "animscripted2", "cp_informant_checkin_sit_idle", 2, self.spawnpoint]);
}

function play_anim_sequence(var0, var1, var2) {
  jumpiffalse(isDefined(var2)) LOC_000000aa;

  for(var3 = 0; var3 < var2.size; var3++) {
    var4 = var2[var3];
    var5 = var4[0];
    var6 = scripts\engine\utility::ter_op(isDefined(var4[1]), var4[1], undefined);
    var7 = scripts\engine\utility::ter_op(isDefined(var4[2]), var4[2], undefined);
    var8 = scripts\engine\utility::ter_op(isDefined(var4[3]), var4[3], undefined);
    var9 = scripts\engine\utility::ter_op(isDefined(var4[4]), var4[4], undefined);
    var10 = scripts\engine\utility::ter_op(isDefined(var4[5]), var4[5], undefined);
    var11 = scripts\engine\utility::ter_op(isDefined(var4[6]), var4[6], undefined);
    self childthread[[var5]](var6, var7, var8, var9, var10);
  }

  for(;;) {
    for(var12 = 0; var12 < var0.size; var12++) {
      var4 = var0[var12];
      var5 = var4[0];
      var6 = scripts\engine\utility::ter_op(isDefined(var4[1]), var4[1], undefined);
      var7 = scripts\engine\utility::ter_op(isDefined(var4[2]), var4[2], undefined);
      var8 = scripts\engine\utility::ter_op(isDefined(var4[3]), var4[3], undefined);
      var9 = scripts\engine\utility::ter_op(isDefined(var4[4]), var4[4], undefined);
      self[[var5]](var6, var7, var8, var9);
    }

    if(!istrue(var1)) {
      break;
    }
  }
}

function play_looping_skit_anim(var0, var1, var2, var3) {
  level endon("game_ended");
  level endon("end_current_skit_anim");
  self endon("end_current_skit_anim");

  if(isDefined(var1) && !isarray(var1)) {
    var4 = [var1];
    var1 = var4;
    var4 = undefined;
  }

  var5 = scripts\engine\utility::random(var1);

  if(!isDefined(var0)) {
    var0 = "animscripted";
  }

  var6 = scripts\asm\asm::asm_lookupanimfromalias(var0, var5);
  var7 = scripts\asm\asm::asm_getxanim(var0, var6);
  var8 = 0;
  var9 = undefined;
  var10 = undefined;

  if(isDefined(var3)) {
    var9 = var3.origin;
    var10 = var3.angles;
  }

  for(;;) {
    if(isDefined(var3)) {
      var11 = getstartorigin(var9, var10, var7);
      var12 = getstartangles(var9, var10, var7);
      self dontinterpolate();
      self forceteleport(var11, var12);
      self notify("actor_position_determined");
    }

    self aisetanim(var0, var6);
    wait getanimlength(var7);

    if(isDefined(var2)) {
      var8++;

      if(var8 >= var2) {
        return;
      }
    }
  }
}

function play_single_skit_anim(var0, var1, var2, var3) {
  level endon("game_ended");
  level endon("end_current_skit_anim");
  self endon("end_current_skit_anim");

  if(isDefined(var1) && !isarray(var1)) {
    var4 = [var1];
    var1 = var4;
    var4 = undefined;
  }

  var5 = scripts\engine\utility::random(var1);

  if(!isDefined(var0)) {
    var0 = "animscripted";
  }

  var6 = scripts\asm\asm::asm_lookupanimfromalias(var0, var5);
  var7 = scripts\asm\asm::asm_getxanim(var0, var6);
  var8 = undefined;
  var9 = undefined;

  if(isDefined(var2)) {
    var8 = var2.origin;
    var9 = var2.angles;
  }

  if(isDefined(var2)) {
    var10 = getstartorigin(var8, var9, var7);
    var11 = getstartangles(var8, var9, var7);
    self dontinterpolate();
    self forceteleport(var10, var11);
    self notify("actor_position_determined");
  }

  self aisetanim(var0, var6);
  wait getanimlength(var7);
}

function spawn_skit_prop(var0, var1, var2, var3, var4) {
  if(isDefined(var0)) {
    self waittill(var0);
  }

  if(isbuiltinfunction(var1)) {
    var1 = self[[var1]]();
  }

  if(isbuiltinfunction(var2)) {
    var2 = self[[var2]]();
  }

  var5 = spawn("script_model", var1);
  var5.angles = self.angles;
  var5 setModel(var3);

  if(istrue(var4)) {
    var5 disconnectPaths();
  }

  return var5;
}

function get_position_from_actor() {
  var0 = self gettagorigin("j_mainroot");
  thread scripts\engine\utility::draw_line_for_time(var0, var0 + (0, 0, 128), 1, 1, 1, 30);
  return var0;
}

function get_angles_from_actor() {
  var0 = self gettagangles("j_mainroot");
  thread scripts\engine\utility::draw_angles(var0, var0 + (0, 0, 128), 1, 1, 1, 30);
  return var0;
}