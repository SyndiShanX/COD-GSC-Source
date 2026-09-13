/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_skits.gsc
***********************************************/

#using_animtree("script_model");

setup_spawn_skits() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("level_ready_for_script");
  level.spawn_skits = [];
  add_spawn_skit("stealth_sitting_laptop", ::stealth_sitting_laptop);
  add_spawn_skit("stealth_sitting_pistol", ::stealth_sitting_pistol);
  add_spawn_skit("stealth_sitting_cell", ::stealth_sitting_cell);
  add_spawn_skit("stealth_sitting_sleep", ::stealth_sitting_sleep);
  add_spawn_skit("smoking", ::smoking);
  add_spawn_skit("cell_phone", ::standing_cellphone);
  add_spawn_skit("stealth_sitting_cell_no_props", ::stealth_sitting_cell_no_props);
  add_spawn_skit("standing_cellphone", ::standing_cellphone);
  add_spawn_skit("end_game_cheer", ::end_game_cheer);
  level.scr_animtree["idle_chair"] = #animtree;
  level.scr_model["idle_chair"] = "cp_disco_folding_chair_lod0";
  level.scr_anim["idle_chair"]["sit_sleeping_react"] = % reb_stl_idle_sit_sleeping_react_chair;
  level.scr_anim["idle_chair"]["sit_sleeping_death"] = % reb_stl_idle_sit_sleeping_death01_chair;
  level.scr_anim["idle_chair"]["sit_cellphone_react"] = % reb_stl_idle_sit_phone01_react_chair;
  level.scr_anim["idle_chair"]["sit_cellphone_death"] = % reb_stl_idle_sit_phone01_death02_4_chair;
  level.scr_anim["idle_chair"]["sit_laptop_react"] = % reb_stl_idle_sit_laptop_react_chair;
  level.scr_anim["idle_chair"]["sit_laptop_death"] = % reb_stl_idle_sit_laptop_death02_2_chair;
  level.scr_anim["idle_chair"]["sit_pistol_clean_react"] = % reb_stl_idle_sit_gunmaintenance_react_chair;
  level.scr_anim["idle_chair"]["sit_pistol_clean_death"] = % reb_stl_idle_sit_gunmaintenance_death01_6_chair;
  level.scr_model["idle_cellphone"] = "offhand_wm_smartphone";
}

skit_fx() {
  level.g_effect["cellphone_glow"] = loadfx("vfx/iw7/levels/piccadilly/vfx_pic_phone_light_01.vfx");
}

add_spawn_skit(skit_name, skit_func) {
  struct = spawnStruct();
  struct.skit_name = skit_name;
  struct.skit_func = skit_func;
  level.spawn_skits[skit_name] = struct;
}

hostage_rescue_fight(_id_70F53FDF121FD882, _id_858C7BA2C134B169, _id_F2C3DD8D0F893F69, _id_F0CCEBC82F37D9F8) {
  attacker = scripts\mp\mp_agent::spawnnewagentaitype(_id_F2C3DD8D0F893F69, _id_70F53FDF121FD882.origin, _id_70F53FDF121FD882.angles);
  victim = scripts\mp\mp_agent::spawnnewagentaitype(_id_F0CCEBC82F37D9F8, _id_858C7BA2C134B169.origin, _id_858C7BA2C134B169.angles);
  attacker setup_fight_guy();
  victim setup_fight_guy();
  _id_47EC4E67ED48C949 = attacker scripts\asm\asm::asm_lookupanimfromalias("animscripted", "fight1_attacker");
  _id_582789DA7DAFC828 = attacker scripts\asm\asm::asm_getxanim("animscripted", _id_47EC4E67ED48C949);
  _id_E7B925EC7C8D5EA8 = victim scripts\asm\asm::asm_lookupanimfromalias("animscripted", "fight1_victim");
  _id_40D02A94EE458A77 = victim scripts\asm\asm::asm_getxanim("animscripted", _id_E7B925EC7C8D5EA8);
  attacker aisetanim("animscripted", _id_47EC4E67ED48C949);
  victim aisetanim("animscripted", _id_E7B925EC7C8D5EA8);
  victim.deathstate = "animscripted";
  victim.deathalias = "fight1_victim_death";
  _id_46F432042B3473D8 = 30;
  attacker thread waitfor_death(_id_46F432042B3473D8, victim, ::death_fight1, ::victim_killed_fight1);
  victim thread waitfor_save(attacker, ::victim_saved);
  victim scripts\engine\utility::waittill_any_timeout_no_endon_death_2(30, "saved", "death");
}

hostage_rescue_meatshield(_id_70F53FDF121FD882, _id_858C7BA2C134B169, _id_F2C3DD8D0F893F69, _id_F0CCEBC82F37D9F8, attacker, victim, _id_09155C5B9009D8F6) {
  if(!isDefined(attacker))
    attacker = scripts\mp\mp_agent::spawnnewagentaitype(_id_F2C3DD8D0F893F69, _id_70F53FDF121FD882.origin, _id_70F53FDF121FD882.angles);

  if(!isDefined(victim))
    victim = scripts\mp\mp_agent::spawnnewagentaitype(_id_F0CCEBC82F37D9F8, _id_858C7BA2C134B169.origin, _id_858C7BA2C134B169.angles);

  attacker setup_fight_guy();
  victim setup_fight_guy();
  _id_B6B8860FDF2A975B = _id_2669878CF5A1B6BC::buildweapon("iw8_pi_golf21_mp", ["none", "none", "none", "none", "none", "none"], "none", "none");
  attacker giveweapon(_id_B6B8860FDF2A975B);
  attacker.og_weapon = attacker.weapon;
  attacker setspawnweapon(_id_B6B8860FDF2A975B);
  attacker scripts\common\utility::initweapon(_id_B6B8860FDF2A975B);
  attacker _id_3433EE6B63C7E243::placeweaponon(_id_B6B8860FDF2A975B, "right");
  attacker _id_3433EE6B63C7E243::placeweaponon(attacker.weapon, "back");
  attacker.sidearm = _id_B6B8860FDF2A975B;
  attacker.deathstate = "animscripted";
  attacker.deathalias = "fight3_attacker_death";
  _id_47EC4E67ED48C949 = attacker scripts\asm\asm::asm_lookupanimfromalias("animscripted", "fight3_attacker");
  _id_582789DA7DAFC828 = attacker scripts\asm\asm::asm_getxanim("animscripted", _id_47EC4E67ED48C949);
  _id_E7B925EC7C8D5EA8 = victim scripts\asm\asm::asm_lookupanimfromalias("animscripted", "fight3_victim");
  _id_40D02A94EE458A77 = victim scripts\asm\asm::asm_getxanim("animscripted", _id_E7B925EC7C8D5EA8);
  attacker aisetanim("animscripted", _id_47EC4E67ED48C949);
  victim aisetanim("animscripted", _id_E7B925EC7C8D5EA8);
  _id_46F432042B3473D8 = getanimlength(_id_582789DA7DAFC828);
  _id_E354D4BC1D4F4D4E = _id_46F432042B3473D8 * 5;

  if(isDefined(_id_09155C5B9009D8F6))
    _id_E354D4BC1D4F4D4E = _id_09155C5B9009D8F6;

  attacker thread waitfor_death(_id_E354D4BC1D4F4D4E, victim, ::death_fight2, ::victim_killed_fight2);
  victim thread waitfor_save(attacker, ::victim_saved_shield);
  time = gettime() + _id_46F432042B3473D8 * 5 * 1000;

  if(isDefined(_id_09155C5B9009D8F6))
    time = gettime() + _id_09155C5B9009D8F6 * 1000;

  level thread fight_idle(time, victim, attacker, _id_46F432042B3473D8, _id_47EC4E67ED48C949, _id_E7B925EC7C8D5EA8);
}

victim_saved_shield() {
  _id_B94D3FF91445983F = scripts\asm\asm::asm_lookupanimfromalias("animscripted", "fight3_victim_saved");
  xanim = scripts\asm\asm::asm_getxanim("animscripted", _id_B94D3FF91445983F);
  self aisetanim("animscripted", _id_B94D3FF91445983F);
  wait 2;
  reset_guy(self);

  if(isDefined(self.anchor)) {
    self unlink();
    self.anchor delete();
  }
}

fight_idle(time, victim, attacker, _id_46F432042B3473D8, _id_47EC4E67ED48C949, _id_E7B925EC7C8D5EA8) {
  victim endon("death");
  attacker endon("death");

  if(time <= 0) {
    for(;;) {
      wait(_id_46F432042B3473D8);
      attacker aisetanim("animscripted", _id_47EC4E67ED48C949);
      victim aisetanim("animscripted", _id_E7B925EC7C8D5EA8);
    }
  } else {
    while(gettime() < time) {
      wait(_id_46F432042B3473D8);
      attacker aisetanim("animscripted", _id_47EC4E67ED48C949);
      victim aisetanim("animscripted", _id_E7B925EC7C8D5EA8);
    }
  }
}

setup_fight_guy() {
  self.ignoreall = 1;
  scripts\asm\asm_mp::asm_setanimScripted();
  self setlookatentity();
  self.headlook_enabled = 0;
  self.disableautolookat = 1;
}

setup_anim_guy() {
  scripts\asm\asm_mp::asm_setanimScripted();
  self.playing_skit = 1;
}

death_fight2(victim) {
  self endon("death");
  victim.deathstate = "animscripted";
  victim.deathalias = "fight3_victim_death";
  magicbullet(self.sidearm, self gettagorigin("tag_flash"), anglesToForward(self gettagangles("tag_flash")) * 1000);
  self shoot(10, victim, 1, 1);
  victim dodamage(victim.health + 100, victim.origin);
  scripts\asm\shared\mp\utility::animscripted_single("fight3_attacker_win");
  self giveweapon(self.og_weapon);
  self setspawnweapon(self.og_weapon);
  _id_3433EE6B63C7E243::placeweaponon(self.og_weapon, "right");
  _id_3433EE6B63C7E243::placeweaponon(self.sidearm, "none");
  reset_guy(self);
}

death_fight1(victim) {
  victim.deathstate = "animscripted";
  victim.deathalias = "fight1_victim_death";
  victim dodamage(victim.health + 100, victim.origin);
  reset_guy(self);
}

victim_saved() {
  scripts\asm\shared\mp\utility::animscripted_single("fight3_victim_saved");
  reset_guy(self);
}

victim_killed_fight1() {
  reset_guy(self);
}

victim_killed_fight2() {
  self giveweapon(self.og_weapon);
  self setspawnweapon(self.og_weapon);
  _id_3433EE6B63C7E243::placeweaponon(self.og_weapon, "right");
  _id_3433EE6B63C7E243::placeweaponon(self.sidearm, "none");
  reset_guy(self);
}

waitfor_death(time, victim, _id_DE83F22326E4B833, _id_9443C17D464B753E) {
  self endon("scene_interrupt");
  result = scripts\engine\utility::waittill_any_ents_or_timeout_return(time, self, "death", victim, "death");

  if(isDefined(result) && result == "timeout")
    self thread[[_id_DE83F22326E4B833]](victim);
  else {
    if(isalive(victim))
      victim notify("saved");

    if(isalive(self))
      self thread[[_id_9443C17D464B753E]]();
  }
}

waitfor_save(attacker, _id_4F43716B1B2279DB) {
  self endon("death");
  self waittill("saved");

  if(isDefined(_id_4F43716B1B2279DB))
    self[[_id_4F43716B1B2279DB]]();
}

reset_guy(guy) {
  guy allowedstances("prone", "stand", "crouch");
  guy scripts\asm\shared\mp\utility::animscripted_clear();
  guy setlookatentity();
  guy.headlook_enabled = 1;
  guy.disableautolookat = 0;
  guy.deathstate = undefined;
  guy.deathalias = undefined;
  guy.ignoreall = 0;
  guy.playing_skit = undefined;

  if(isDefined(self.anchor))
    self.anchor delete();
}

stealth_sitting_laptop(chair) {
  if(scripts\cp\coop_stealth::should_run_sp_stealth()) {
    self _meth_E4B58A023E0DA030(self.origin, self.angles, "sit_laptop");

    if(!have_props_spawned())
      spawn_table();

    if(isDefined(self.spawnpoint))
      self.spawnpoint.props_spawned = 1;
  } else {
    if(!have_props_spawned()) {
      _id_7D73D5424FDD4BA6 = spawn_chair(chair);
      thread stealth_sit_react(_id_7D73D5424FDD4BA6, "sitting_laptop_react", "reb_stl_idle_sit_laptop_react_chair");
      thread stealth_sit_death(_id_7D73D5424FDD4BA6, "reb_stl_idle_sit_laptop_death02_2_chair");
      table = spawn_table();
      set_props_spawned();
    }

    if(isDefined(self.spawnpoint))
      self.spawnpoint.props_spawned = 1;

    setup_anim_guy();
    self.deathstate = "patrol_sitting_laptop_death";
    self.deathalias = "death";
    thread stealth_sit_idle("sitting_laptop_idle");
  }
}

stealth_sitting_pistol(chair) {
  if(scripts\cp\coop_stealth::should_run_sp_stealth()) {
    self _meth_E4B58A023E0DA030(self.origin, self.angles, "sit_pistol_clean");

    if(!have_props_spawned())
      spawn_table();

    if(isDefined(self.spawnpoint))
      self.spawnpoint.props_spawned = 1;
  } else {
    if(!have_props_spawned()) {
      _id_7D73D5424FDD4BA6 = spawn_chair(chair);
      thread stealth_sit_react(_id_7D73D5424FDD4BA6, "sitting_pistol_react", "reb_stl_idle_sit_gunmaintenance_react_chair");
      thread stealth_sit_death(_id_7D73D5424FDD4BA6, "reb_stl_idle_sit_gunmaintenance_death01_6_chair");
      table = spawn_table();
      set_props_spawned();
    }

    setup_anim_guy();
    self.idle_prop = spawn("script_model", self.origin);
    self.idle_prop setModel("weapon_g18_rare_wm");
    self.idle_prop linkTo(self, "tag_accessory_right", (0, 0, 0), (0, 0, 0));
    thread stealth_sit_idle("sitting_pistol_idle");
  }
}

crouching_phone() {
  setup_anim_guy();
  self.deathstate = "patrol_sitting_cellphone_death";
  self.deathalias = "death";
  thread idle_crouching_phone("sitting_cellphone_idle");
}

idle_crouching_phone(animalias) {
  self endon("death");
  self endon("alerted");
  thread ai_notetrack_loop("smoking");

  for(;;) {
    smoking_idle_start("smoking_idle_start");
    scripts\asm\shared\mp\utility::animscripted_single(animalias);
    smoking_idle_end("smoking_idle_end");
  }
}

stealth_sitting_cell_no_props(chair) {
  if(scripts\cp\coop_stealth::should_run_sp_stealth()) {
    self _meth_E4B58A023E0DA030(self.origin, self.angles, "sit_cellphone");

    if(isDefined(self.spawnpoint))
      self.spawnpoint.props_spawned = 1;
  } else {
    if(!have_props_spawned()) {
      _id_7D73D5424FDD4BA6 = spawn_chair(chair);
      thread stealth_sit_react(_id_7D73D5424FDD4BA6, "sitting_cellphone_react", "reb_stl_idle_sit_phone01_react_chair");
      thread stealth_sit_death(_id_7D73D5424FDD4BA6, "reb_stl_idle_sit_phone01_death02_4_chair");
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
}

stealth_sitting_cell(chair) {
  if(scripts\cp\coop_stealth::should_run_sp_stealth()) {
    self _meth_E4B58A023E0DA030(self.origin, self.angles, "sit_cellphone");

    if(!have_props_spawned())
      spawn_table();

    if(isDefined(self.spawnpoint))
      self.spawnpoint.props_spawned = 1;
  } else {
    if(!have_props_spawned()) {
      _id_7D73D5424FDD4BA6 = spawn_chair(chair);
      thread stealth_sit_react(_id_7D73D5424FDD4BA6, "sitting_cellphone_react", "reb_stl_idle_sit_phone01_react_chair");
      thread stealth_sit_death(_id_7D73D5424FDD4BA6, "reb_stl_idle_sit_phone01_death02_4_chair");
      table = spawn_table();
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
}

stealth_sitting_sleep(chair) {
  if(scripts\cp\coop_stealth::should_run_sp_stealth()) {
    self _meth_E4B58A023E0DA030(self.origin, self.angles, "sit_sleeping");

    if(isDefined(self.spawnpoint))
      self.spawnpoint.props_spawned = 1;
  } else {
    if(!have_props_spawned()) {
      _id_7D73D5424FDD4BA6 = spawn_chair(chair);
      thread stealth_sit_react(_id_7D73D5424FDD4BA6, "sitting_sleeping_react", "reb_stl_idle_sit_sleeping_react_chair");
      thread stealth_sit_death(_id_7D73D5424FDD4BA6, "reb_stl_idle_sit_sleeping_death01_chair");
      set_props_spawned();
    }

    setup_anim_guy();
    self.deathstate = "patrol_sitting_sleeping_death";
    self.deathalias = "death";
    thread stealth_sit_idle("sitting_sleeping_idle");
  }
}

spawn_table() {
  table = spawn("script_model", self.origin + anglesToForward(self.angles) * 32);
  table.angles = self.angles + (0, 90, 0);
  table setModel("furniture_table_folding_01_open");
  table disconnectPaths();
}

spawn_chair(chair) {
  if(!isDefined(chair)) {
    chair = spawn("script_model", self.origin + anglesToForward(self.angles) * -8);
    chair.angles = self.angles;
    chair setModel("cp_disco_folding_chair_lod0");
    chair disconnectPaths();
  }

  return chair;
}

stealth_sit_idle(animalias) {
  self endon("death");
  self endon("alerted");
  self endon("enter_combat");
  scripts\asm\shared\mp\utility::animscripted_loop(animalias);
}

stealth_sit_react(chair, _id_E25CA6F64FDB941F, _id_EE76FA65682C4E3A) {
  self endon("death");
  self waittill("alerted");
  _id_18A73A64992DD07D::set_kill_off_time(20);
  self.deathstate = undefined;
  self.deathalias = undefined;

  if(isDefined(self.idle_prop)) {
    self.idle_prop unlink();
    self.idle_prop physicslaunchserver(self.idle_prop.origin, (0, 0, -10));
    self.idle_prop = undefined;
  }

  chair scriptmodelplayanimdeltamotion(_id_EE76FA65682C4E3A);
  scripts\asm\shared\mp\utility::animscripted_single(_id_E25CA6F64FDB941F);
  chair scriptmodelclearanim();
  chair physicslaunchserver(chair.origin, (0, 0, 15));
  reset_guy(self);
}

stealth_sit_death(chair, _id_EE76FA65682C4E3A) {
  self endon("alerted");
  idle_prop = undefined;

  if(isDefined(self.idle_prop))
    idle_prop = self.idle_prop;

  self waittill("death");

  if(isDefined(idle_prop)) {
    idle_prop unlink();
    idle_prop physicslaunchserver(idle_prop.origin, (0, 0, -10));
  }

  chair scriptmodelplayanimdeltamotion(_id_EE76FA65682C4E3A);
  wait 1;
  chair scriptmodelclearanim();
  chair physicslaunchserver(chair.origin, (0, 0, 15));
}

smoking() {
  self.playing_skit = 1;

  if(scripts\cp\coop_stealth::should_run_sp_stealth())
    self _meth_E4B58A023E0DA030(self.origin, self.angles, "smoking");
  else {
    setup_anim_guy();
    self.deathstate = "animscripted";
    self.deathalias = "smoking_death";
    thread smoking_idle("smoking_idle");
    thread smoking_react("smoking_react");
    thread smoking_death("smoking_death");
  }
}

smoking_idle(animalias) {
  level endon("weapons_free");
  self endon("death");
  self endon("alerted");
  thread ai_notetrack_loop("smoking");

  for(;;) {
    smoking_idle_start("smoking_idle_start");
    scripts\asm\shared\mp\utility::animscripted_single(animalias);
    smoking_idle_end("smoking_idle_end");
    ai_smoking_cleanup();

    if(istrue(self.single_loop)) {
      self notify("ai_notetrack_Loop");
      self notify("cancel_loop");
      reset_guy(self);
      break;
    }
  }
}

smoking_idle_start(animalias) {
  self endon("death");
  self endon("alerted");
  scripts\asm\shared\mp\utility::animscripted_single(animalias);
}

smoking_idle_end(animalias) {
  self endon("death");
  self endon("alerted");
  scripts\asm\shared\mp\utility::animscripted_single(animalias);
}

smoking_react(_id_E25CA6F64FDB941F) {
  self endon("death");
  self endon("cancel_loop");
  level scripts\cp\utility::add_wait(scripts\cp\utility::waittill_msg, "weapons_free");
  scripts\cp\utility::add_wait(scripts\engine\utility::waittill_any_2, "alerted", "checking_friendly_corpse");
  scripts\cp\utility::do_wait_any();
  _id_18A73A64992DD07D::set_kill_off_time(20);
  ai_smoking_cleanup();
  self.deathstate = undefined;
  self.deathalias = undefined;

  if(isDefined(self.idle_prop)) {
    self.idle_prop unlink();
    self.idle_prop physicslaunchserver(self.idle_prop.origin, (0, 0, -10));
    self.idle_prop = undefined;
  }

  scripts\asm\shared\mp\utility::animscripted_single(_id_E25CA6F64FDB941F);
  reset_guy(self);
}

smoking_death(_id_85DD2D48556B2B7F) {
  self endon("alerted");
  self endon("cancel_loop");
  self waittill("death");
  ai_smoking_cleanup();
}

ai_notetrack_loop(_id_887D46B1410C42CA) {
  self endon("death");
  self notify("ai_notetrack_Loop");
  self endon("ai_notetrack_Loop");
  self endon("alerted");

  for(;;) {
    self waittill("animscripted", notes);

    if(!isDefined(notes))
      notes = ["undefined"];

    if(!isarray(notes))
      notes = [notes];

    _id_FC9A12FE1F57542A = undefined;

    foreach(_id_A234A65C378F3289 in notes) {
      if(_id_887D46B1410C42CA == "smoking") {
        ai_notehandler_smoking(_id_A234A65C378F3289);
        continue;
      }

      if(_id_887D46B1410C42CA == "standing_cellphone")
        ai_notehandler_cellphone(_id_A234A65C378F3289);
    }
  }
}

ai_notehandler_smoking(_id_A234A65C378F3289) {
  switch (_id_A234A65C378F3289) {
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

ai_smoking_blowsmoke() {
  self endon("smoking_end");
  self endon("death");
  self notify("ai_notetrack_Loop");
  self endon("ai_notetrack_Loop");
  self endon("alerted");

  for(;;) {
    playFX(level.g_effect["cigarette_smoke"], self getEye() - (0, 0, 2), anglesToForward(self gettagangles("tag_eye")));
    waittime = randomintrange(5, 8);
    wait(waittime);
  }
}

ai_smoking_cleanup() {
  self notify("smoking_end");

  if(isDefined(self gettagorigin("tag_accessory_right", 1))) {
    killfxontag(level.g_effect["cigarette_lit"], self, "tag_accessory_right");
    killfxontag(level.g_effect["cigarette_unlit"], self, "tag_accessory_right");
  }
}

standing_cellphone(_id_FF75B4157A7AA48A) {
  if(scripts\cp\coop_stealth::should_run_sp_stealth())
    self _meth_E4B58A023E0DA030(self.origin, self.angles, "cellphone");
  else {
    if(!isDefined(_id_FF75B4157A7AA48A))
      _id_FF75B4157A7AA48A = 1;

    setup_anim_guy();
    self.deathstate = "animscripted";
    self.deathalias = "stand_cellphone_death";
    thread ai_notetrack_loop("standing_cellphone");
    thread standing_cellphone_anim_seq(_id_FF75B4157A7AA48A);
  }
}

standing_cellphone_anim_seq(_id_FF75B4157A7AA48A) {
  self endon("death");
  self endon("alerted");
  thread cellphone_react("smoking_react");
  standing_cellphone_anim("stand_cellphone_intro");

  if(_id_FF75B4157A7AA48A > 0)
    standing_cellphone_loop("stand_cellphone_loop", _id_FF75B4157A7AA48A);

  standing_cellphone_anim("stand_cellphone_exit");
}

standing_cellphone_anim(animalias) {
  self endon("death");
  self endon("alerted");
  scripts\asm\shared\mp\utility::animscripted_single(animalias);
}

standing_cellphone_loop(animalias, loops) {
  level endon("weapons_free");
  self endon("death");
  self endon("alerted");
  scripts\asm\shared\mp\utility::animscripted_loop_n_times(animalias, loops);
  reset_guy(self);
}

ai_notehandler_cellphone(_id_A234A65C378F3289) {
  self endon("death");
  self endon("alerted");

  switch (_id_A234A65C378F3289) {
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

cellphone_react(_id_E25CA6F64FDB941F) {
  self endon("death");
  level scripts\cp\utility::add_wait(scripts\cp\utility::waittill_msg, "weapons_free");
  scripts\cp\utility::add_wait(scripts\engine\utility::waittill_any_2, "alerted", "checking_friendly_corpse");
  scripts\cp\utility::do_wait_any();
  _id_18A73A64992DD07D::set_kill_off_time(20);
  ai_cellphone_cleanup();
  self.deathstate = undefined;
  self.deathalias = undefined;

  if(isDefined(self.idle_prop)) {
    self.idle_prop unlink();
    self.idle_prop physicslaunchserver(self.idle_prop.origin, (0, 0, -10));
    self.idle_prop = undefined;
  }

  scripts\asm\shared\mp\utility::animscripted_single(_id_E25CA6F64FDB941F);
  reset_guy(self);
}

ai_cellphone_cleanup() {
  self endon("death");
}

have_props_spawned() {
  return isDefined(self.spawnpoint) && istrue(self.spawnpoint.props_spawned);
}

set_props_spawned() {
  if(isDefined(self.spawnpoint))
    self.spawnpoint.props_spawned = 1;
}

end_game_cheer() {
  self endon("death");
  self endon("alerted");
  _id_18A73A64992DD07D::set_demeanor_from_unittype("patrol");
  _id_18A73A64992DD07D::set_goal_radius(4);
  _id_18A73A64992DD07D::set_goal_pos(self.origin);
  self.ignoreall = 1;
  self.ignoreme = 1;
  self takeallweapons();
  _id_2B1D0E57C66A43D0 = _id_2669878CF5A1B6BC::buildweapon("iw9_me_fists_mp", [], "none", "none", -1);
  self giveweapon(_id_2B1D0E57C66A43D0);
  _id_3433EE6B63C7E243::forceuseweapon(_id_2B1D0E57C66A43D0, "primary");
  wait 0.5;
  _id_C729D49D406ACED8 = scripts\engine\utility::getclosest(self.origin, level.players);
  self setlookatentity(_id_C729D49D406ACED8);
  wait 0.5;
  setup_anim_guy();
  anims = ["cap_ff_010_cheer_scene_civ01", "cap_ff_010_cheer_scene_civ02", "cap_ff_010_cheer_scene_civ03", "cap_ff_010_cheer_scene_civ04", "cap_ff_010_cheer_scene_civ06", "cap_ff_010_cheer_scene_civ07", "cap_ff_010_cheer_scene_civ08", "cap_ff_010_cheer_scene_civ09", "cap_ff_010_cheer_scene_civ10", "cap_ff_010_cheer_scene_civ11", "cap_ff_010_cheer_scene_civ12", "cap_ff_010_cheer_scene_civ13"];
  anim_sequence = [];
  anim_sequence[anim_sequence.size] = [::play_looping_skit_anim, "animscripted2", anims, undefined, undefined];
  play_anim_sequence(anim_sequence, 1);
}

setup_gulag_weapon_check() {
  add_spawn_skit("checkin_guard_idle", ::checkin_guard_idle);
}

checkin_guard_idle() {
  self endon("death");
  self endon("alerted");
  setup_anim_guy();
  anim_sequence = [];
  anim_sequence[anim_sequence.size] = [::play_looping_skit_anim, "animscripted2", "cp_informant_checkin_sit_idle", 2, self.spawnpoint];
  anim_sequence[anim_sequence.size] = [::play_single_skit_anim, "animscripted2", "cp_informant_checkin_sit_2_stand", undefined, undefined, undefined];
  anim_sequence[anim_sequence.size] = [::play_looping_skit_anim, "animscripted2", ["cp_informant_checkin_stand_idle_01", "cp_informant_checkin_stand_idle_02"], 2, self.spawnpoint];
  anim_sequence[anim_sequence.size] = [::play_single_skit_anim, "animscripted2", ["cp_informant_checkin_stand_payment_01", "cp_informant_checkin_stand_payment_02"], undefined];
  anim_sequence[anim_sequence.size] = [::play_single_skit_anim, "animscripted2", "cp_informant_checkin_stand_2_sit", undefined];
  anim_sequence[anim_sequence.size] = [::play_looping_skit_anim, "animscripted2", "cp_informant_checkin_sit_idle", undefined, self.spawnpoint];
  _id_3690C2F8DA0EA87D = [];
  _id_3690C2F8DA0EA87D[_id_3690C2F8DA0EA87D.size] = [::spawn_skit_prop, "actor_position_determined", ::get_position_from_actor, ::get_angles_from_actor, "ee_furniture_chair_metal_folding_open", 1];
  play_anim_sequence(anim_sequence, 1);
}

play_anim_sequence(anim_sequence, _id_1208CA5973245D19, _id_3690C2F8DA0EA87D) {
  if(isDefined(_id_3690C2F8DA0EA87D)) {
    for(_id_AC0E424AC96A7113 = 0; _id_AC0E424AC96A7113 < _id_3690C2F8DA0EA87D.size; _id_AC0E424AC96A7113++) {
      data = _id_3690C2F8DA0EA87D[_id_AC0E424AC96A7113];
      func = data[0];
      parm1 = scripts\engine\utility::ter_op(isDefined(data[1]), data[1], undefined);
      parm2 = scripts\engine\utility::ter_op(isDefined(data[2]), data[2], undefined);
      parm3 = scripts\engine\utility::ter_op(isDefined(data[3]), data[3], undefined);
      parm4 = scripts\engine\utility::ter_op(isDefined(data[4]), data[4], undefined);
      _id_77895A5B8A625552 = scripts\engine\utility::ter_op(isDefined(data[5]), data[5], undefined);
      _id_7789595B8A62531F = scripts\engine\utility::ter_op(isDefined(data[6]), data[6], undefined);
      self childthread[[func]](parm1, parm2, parm3, parm4, _id_77895A5B8A625552);
    }
  }

  for(;;) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < anim_sequence.size; _id_AC0E594AC96AA3A8++) {
      data = anim_sequence[_id_AC0E594AC96AA3A8];
      func = data[0];
      parm1 = scripts\engine\utility::ter_op(isDefined(data[1]), data[1], undefined);
      parm2 = scripts\engine\utility::ter_op(isDefined(data[2]), data[2], undefined);
      parm3 = scripts\engine\utility::ter_op(isDefined(data[3]), data[3], undefined);
      parm4 = scripts\engine\utility::ter_op(isDefined(data[4]), data[4], undefined);
      self[[func]](parm1, parm2, parm3, parm4);
    }

    if(!istrue(_id_1208CA5973245D19)) {
      break;
    }
  }
}

play_looping_skit_anim(statename, _id_75ECB34D5A496906, loops, scene_node) {
  level endon("game_ended");
  level endon("end_current_skit_anim");
  self endon("end_current_skit_anim");

  if(isDefined(_id_75ECB34D5A496906) && !isarray(_id_75ECB34D5A496906)) {
    _id_6D906809844C7CB1 = [_id_75ECB34D5A496906];
    _id_75ECB34D5A496906 = _id_6D906809844C7CB1;
    _id_6D906809844C7CB1 = undefined;
  }

  animalias = scripts\engine\utility::random(_id_75ECB34D5A496906);

  if(!isDefined(statename))
    statename = "animscripted";

  _id_B94D3FF91445983F = scripts\asm\asm::asm_lookupanimfromalias(statename, animalias);
  xanim = scripts\asm\asm::asm_getxanim(statename, _id_B94D3FF91445983F);
  _id_0106BDA484C78A52 = 0;
  org = undefined;
  _id_8BC14603A27FA3E7 = undefined;

  if(isDefined(scene_node)) {
    org = scene_node.origin;
    _id_8BC14603A27FA3E7 = scene_node.angles;
  }

  for(;;) {
    if(isDefined(scene_node)) {
      _id_D917428537562C1F = getstartorigin(org, _id_8BC14603A27FA3E7, xanim);
      startangles = getstartangles(org, _id_8BC14603A27FA3E7, xanim);
      self dontinterpolate();
      self forceteleport(_id_D917428537562C1F, startangles);
      self notify("actor_position_determined");
    }

    self aisetanim(statename, _id_B94D3FF91445983F);
    wait(getanimlength(xanim));

    if(isDefined(loops)) {
      _id_0106BDA484C78A52++;

      if(_id_0106BDA484C78A52 >= loops)
        return;
    }
  }
}

play_single_skit_anim(statename, _id_75ECB34D5A496906, scene_node, _id_97282C14346A7FCF) {
  level endon("game_ended");
  level endon("end_current_skit_anim");
  self endon("end_current_skit_anim");

  if(isDefined(_id_75ECB34D5A496906) && !isarray(_id_75ECB34D5A496906)) {
    _id_6D906809844C7CB1 = [_id_75ECB34D5A496906];
    _id_75ECB34D5A496906 = _id_6D906809844C7CB1;
    _id_6D906809844C7CB1 = undefined;
  }

  animalias = scripts\engine\utility::random(_id_75ECB34D5A496906);

  if(!isDefined(statename))
    statename = "animscripted";

  _id_B94D3FF91445983F = scripts\asm\asm::asm_lookupanimfromalias(statename, animalias);
  xanim = scripts\asm\asm::asm_getxanim(statename, _id_B94D3FF91445983F);
  org = undefined;
  _id_8BC14603A27FA3E7 = undefined;

  if(isDefined(scene_node)) {
    org = scene_node.origin;
    _id_8BC14603A27FA3E7 = scene_node.angles;
  }

  if(isDefined(scene_node)) {
    _id_D917428537562C1F = getstartorigin(org, _id_8BC14603A27FA3E7, xanim);
    startangles = getstartangles(org, _id_8BC14603A27FA3E7, xanim);
    self dontinterpolate();
    self forceteleport(_id_D917428537562C1F, startangles);
    self notify("actor_position_determined");
  }

  self aisetanim(statename, _id_B94D3FF91445983F);
  wait(getanimlength(xanim));
}

spawn_skit_prop(_id_3051146A717A14FB, _id_D917428537562C1F, startangles, _id_514E5F7F4670B33E, _id_889E8A0FC335AA9B) {
  if(isDefined(_id_3051146A717A14FB))
    self waittill(_id_3051146A717A14FB);

  if(isfunction(_id_D917428537562C1F))
    _id_D917428537562C1F = self[[_id_D917428537562C1F]]();

  if(isfunction(startangles))
    startangles = self[[startangles]]();

  prop = spawn("script_model", _id_D917428537562C1F);
  prop.angles = self.angles;
  prop setModel(_id_514E5F7F4670B33E);

  if(istrue(_id_889E8A0FC335AA9B))
    prop disconnectPaths();

  return prop;
}

get_position_from_actor() {
  pos = self gettagorigin("j_mainroot");
  thread scripts\engine\utility::draw_line_for_time(pos, pos + (0, 0, 128), 1, 1, 1, 30);
  return pos;
}

get_angles_from_actor() {
  angles = self gettagangles("j_mainroot");
  thread scripts\engine\utility::draw_angles(angles, angles + (0, 0, 128), 1, 1, 1, 30);
  return angles;
}