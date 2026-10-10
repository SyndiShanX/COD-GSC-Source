/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_5f8bc60756b1eafb.gsc
*************************************************/

#using script_372d8c5f69b0ae2e;
#using scripts\anim\shared;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\fakeactor;
#namespace namespace_491e31b31cdf2a0a;

function init() {
  if(!isDefined(level.scripted_melee)) {
    level.scripted_melee = spawnStruct();
  }

  if(istrue(level.scripted_melee.disabled)) {
    return;
  }

  level.scripted_melee.var_1fc4fd3ef975e8c8 = &function_78748799de25da5f;
  level.scripted_melee.var_2ec260ca66f2378 = &function_65bbb083561fa648;
  level.scripted_melee.var_efaa5d51e08521eb = &enable_victims;
  level.scripted_melee.var_3522908002cc5af = &function_b3cab4bbbd2f27bf;
  level.scripted_melee.var_16a2ad3bccc62bb5 = &function_53bc249de0d47b05;
  level.scripted_melee.var_2eda72772d041081 = &function_6410c0421b1874ac;
  level.scripted_melee.fndeath = &function_d8f48ab0dfd5ef51;
  level.scripted_melee.fnragdoll = &function_91c24157247ef2fc;
  level.scripted_melee.fnfx = &function_497a27b31d43d6af;
  level.scripted_melee.playerlinkeduselinkedvelocity = &function_5e2b19fd9204a302;
  namespace_db6d5eb4a31b23a::main();
}

#using_animtree("generic_human");

function function_78748799de25da5f() {
  function_b0c99390cdb7edd5();
  anims = [];
  anims["vm_sp_takedown_knife_left_02"] = % vm_sp_takedown_knife_left_02_enemy;
  anims["vm_sp_takedown_knife_right_01"] = % vm_sp_takedown_knife_right_01_enemy;
  anims["vm_sp_takedown_knife_front_03"] = % vm_sp_takedown_knife_front_03_enemy;
  anims["vm_sp_takedown_knife_back_01"] = % vm_sp_takedown_knife_back_01_enemy;
  anims["vm_sp_takedown_knife_left_03"] = % vm_sp_takedown_knife_left_03_enemy;
  anims["vm_sp_takedown_knife_right_03"] = % vm_sp_takedown_knife_right_03_enemy;
  anims["vm_sp_takedown_knife_front_04"] = % vm_sp_takedown_knife_front_04_enemy;
  anims["vm_sp_takedown_knife_back_02"] = % vm_sp_takedown_knife_back_02_enemy;
  anims["vm_sp_takedown_pistol_left_01"] = % vm_sp_takedown_pistol_left_01_enemy;
  anims["vm_sp_takedown_pistol_right_01"] = % vm_sp_takedown_pistol_right_01_enemy;
  anims["vm_sp_takedown_pistol_front_01"] = % vm_sp_takedown_pistol_front_01_enemy;
  anims["vm_sp_takedown_pistol_back_01"] = % vm_sp_takedown_pistol_back_01_enemy;
  anims["vm_sp_takedown_pistol_left_02"] = % vm_sp_takedown_pistol_left_02_enemy;
  anims["vm_sp_takedown_pistol_right_02"] = % vm_sp_takedown_pistol_right_02_enemy;
  anims["vm_sp_takedown_pistol_front_02"] = % vm_sp_takedown_pistol_front_02_enemy;
  anims["vm_sp_takedown_pistol_back_02"] = % vm_sp_takedown_pistol_back_02_enemy;
  anims["vm_sp_takedown_knife_crouch_back_01"] = % vm_sp_takedown_knife_crouch_back_01_enemy;
  anims["vm_sp_takedown_knife_crouch_back_02"] = % vm_sp_takedown_knife_crouch_back_02_enemy;
  anims["vm_sp_takedown_knife_crouch_left_01"] = % vm_sp_takedown_knife_crouch_left_01_enemy;
  anims["vm_sp_takedown_knife_crouch_left_02"] = % vm_sp_takedown_knife_crouch_left_02_enemy;
  anims["vm_sp_takedown_knife_crouch_right_01"] = % vm_sp_takedown_knife_crouch_right_01_enemy;
  anims["vm_sp_takedown_knife_crouch_right_02"] = % vm_sp_takedown_knife_crouch_right_02_enemy;

  foreach(key, animasset in anims) {
    level.scr_anim["generic"][key] = animasset;
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_death", &function_d8f48ab0dfd5ef51, key);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_ragdoll", &function_91c24157247ef2fc, key);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_fx", &function_497a27b31d43d6af, key);
  }
}

#using_animtree("player");

function function_b0c99390cdb7edd5() {
  level.scr_animtree["scripted_melee_player_rig"] = #animtree;

  if(!isDefined(level.scr_model) || !isDefined(level.scr_model["scripted_melee_player_rig"])) {
    level.scr_model["scripted_melee_player_rig"] = "viewhands_base_fullbody_iw8";
  }

  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_left_02"] = % vm_sp_takedown_knife_left_02_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_right_01"] = % vm_sp_takedown_knife_right_01_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_front_03"] = % vm_sp_takedown_knife_front_03_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_back_01"] = % vm_sp_takedown_knife_back_01_player;
  utility::function_7a5a6498179656fc("vm_sp_takedown_knife_left_02", "left", &function_a3356321f4375b10, undefined, undefined, undefined, undefined, undefined, undefined, "TAG_ACCESSORY_LEFT");
  utility::function_7a5a6498179656fc("vm_sp_takedown_knife_right_01", "right", &function_a3356321f4375b10, undefined, undefined, undefined, undefined, undefined, undefined, "TAG_ACCESSORY_LEFT");
  utility::function_7a5a6498179656fc("vm_sp_takedown_knife_front_03", "front", &function_b767805ca0e381e);
  utility::function_7a5a6498179656fc("vm_sp_takedown_knife_back_01", "back", &function_279a32b2cdce2b2b);
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_left_03"] = % vm_sp_takedown_knife_left_03_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_right_03"] = % vm_sp_takedown_knife_right_03_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_front_04"] = % vm_sp_takedown_knife_front_04_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_back_02"] = % vm_sp_takedown_knife_back_02_player;
  utility::function_7a5a6498179656fc("vm_sp_takedown_knife_left_03", "left", &function_a3356321f4375b10);
  utility::function_7a5a6498179656fc("vm_sp_takedown_knife_right_03", "right", &function_a3356321f4375b10);
  utility::function_7a5a6498179656fc("vm_sp_takedown_knife_front_04", "front", &function_b767805ca0e381e, undefined, undefined, undefined, undefined, undefined, undefined, "TAG_ACCESSORY_LEFT");
  utility::function_7a5a6498179656fc("vm_sp_takedown_knife_back_02", "back", &function_279a32b2cdce2b2b);
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_left_01"] = % vm_sp_takedown_pistol_left_01_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_right_01"] = % vm_sp_takedown_pistol_right_01_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_front_01"] = % vm_sp_takedown_pistol_front_01_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_back_01"] = % vm_sp_takedown_pistol_back_01_player;
  utility::function_7a5a6498179656fc("vm_sp_takedown_pistol_left_01", "left", &function_199c2718c1a3385f, undefined, undefined, undefined, undefined, undefined, 1);
  utility::function_7a5a6498179656fc("vm_sp_takedown_pistol_right_01", "right", &function_199c2718c1a3385f, undefined, undefined, undefined, undefined, undefined, 1);
  utility::function_7a5a6498179656fc("vm_sp_takedown_pistol_front_01", "front", &function_199c2718c1a3385f, undefined, undefined, undefined, undefined, undefined, 1);
  utility::function_7a5a6498179656fc("vm_sp_takedown_pistol_back_01", "back", &function_fdfbaa517a1c4018, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", &function_ebea6b350af8fb8d, "vm_sp_takedown_pistol_left_01");
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", &function_ebea6b350af8fb8d, "vm_sp_takedown_pistol_right_01");
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", &function_ebea6b350af8fb8d, "vm_sp_takedown_pistol_front_01");
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", &function_ebea6b350af8fb8d, "vm_sp_takedown_pistol_back_01");
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_left_02"] = % vm_sp_takedown_pistol_left_02_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_right_02"] = % vm_sp_takedown_pistol_right_02_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_front_02"] = % vm_sp_takedown_pistol_front_02_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_pistol_back_02"] = % vm_sp_takedown_pistol_back_02_player;
  utility::function_7a5a6498179656fc("vm_sp_takedown_pistol_left_02", "left", &function_199c2718c1a3385f, undefined, undefined, undefined, undefined, undefined, 1);
  utility::function_7a5a6498179656fc("vm_sp_takedown_pistol_right_02", "right", &function_199c2718c1a3385f, undefined, undefined, undefined, undefined, undefined, 1);
  utility::function_7a5a6498179656fc("vm_sp_takedown_pistol_front_02", "front", &function_199c2718c1a3385f, undefined, undefined, undefined, undefined, undefined, 1);
  utility::function_7a5a6498179656fc("vm_sp_takedown_pistol_back_02", "back", &function_fdfbaa517a1c4018, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", &function_ebea6b350af8fb8d, "vm_sp_takedown_pistol_left_02");
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", &function_ebea6b350af8fb8d, "vm_sp_takedown_pistol_right_02");
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", &function_ebea6b350af8fb8d, "vm_sp_takedown_pistol_front_02");
  scripts\common\anim::addnotetrack_customfunction("scripted_melee_player_rig", "fire", &function_ebea6b350af8fb8d, "vm_sp_takedown_pistol_back_02");
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_crouch_back_01"] = % vm_sp_takedown_knife_crouch_back_01_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_crouch_back_02"] = % vm_sp_takedown_knife_crouch_back_02_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_crouch_left_01"] = % vm_sp_takedown_knife_crouch_left_01_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_crouch_left_02"] = % vm_sp_takedown_knife_crouch_left_02_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_crouch_right_01"] = % vm_sp_takedown_knife_crouch_right_01_player;
  level.scr_anim["scripted_melee_player_rig"]["vm_sp_takedown_knife_crouch_right_02"] = % vm_sp_takedown_knife_crouch_right_02_player;
  utility::function_7a5a6498179656fc("vm_sp_takedown_knife_crouch_back_01", "back", &function_fa7cc1ad28b01833, undefined, "crouch", "crouch", undefined, undefined, undefined, "TAG_ACCESSORY_LEFT");
  utility::function_7a5a6498179656fc("vm_sp_takedown_knife_crouch_back_02", "back", &function_fa7cc1ad28b01833, undefined, "crouch", "crouch");
  utility::function_7a5a6498179656fc("vm_sp_takedown_knife_crouch_left_01", "left", &function_65931e2cbca86748, undefined, "crouch", "crouch");
  utility::function_7a5a6498179656fc("vm_sp_takedown_knife_crouch_left_02", "left", &function_65931e2cbca86748, undefined, "crouch", "crouch");
  utility::function_7a5a6498179656fc("vm_sp_takedown_knife_crouch_right_01", "right", &function_65931e2cbca86748, undefined, "crouch", "crouch");
  utility::function_7a5a6498179656fc("vm_sp_takedown_knife_crouch_right_02", "right", &function_65931e2cbca86748, undefined, "crouch", "crouch");
}

function function_65bbb083561fa648() {
  self.scripted_melee_player_rig = scripts\engine\sp\utility::spawn_anim_model("scripted_melee_player_rig", self.origin, self.angles);
  self.scripted_melee_player_rig scripts\common\anim::function_1cb661b457551a3(1, self, 0.35);
}

function enable_victims() {
  team3 = scripts\engine\sp\utility::get_all_closest_living(self.origin, getaiarray("team3"), 128, 0);
  enemies = scripts\engine\sp\utility::get_all_closest_living(self.origin, getaiarray("axis"), 128, 0);
  possible_victims = scripts\engine\utility::array_combine(team3, enemies);
  scripts\engine\utility::array_call(possible_victims, &function_f23f106f8976771d);

  scripts\engine\utility::array_thread(possible_victims, &function_7eaecc1fbfd9ad25, self);
}

function function_b3cab4bbbd2f27bf() {
  if(!getdvarint(@ "hash_301100a436cfdb2c")) {
    self enableinvulnerability();
  }

  self enablequickweaponswitch(1);
}

function function_53bc249de0d47b05() {
  self disableinvulnerability();
  self enablequickweaponswitch(0);
}

function function_91c24157247ef2fc(guy) {
  debug_print("start ragdoll via note");

  if(!isDefined(guy) && isDefined(guy.var_540e3c006ce71d3a.var_4187711225445340)) {
    foreach(corpse in getcorpsearray()) {
      if(istrue(corpse.var_91c24157247ef2fc)) {
        continue;
      }

      if(corpse isragdoll()) {
        continue;
      }

      corpseorigin = corpse scripts\engine\sp\utility::get_corpse_origin();

      if(isDefined(corpseorigin) && distancesquared(corpseorigin, guy.var_540e3c006ce71d3a.var_4187711225445340) < squared(60)) {
        debug_print("do ragdoll via note");
        corpse startragdoll();
        corpse.var_91c24157247ef2fc = 1;
      }
    }
  } else if(isDefined(guy) && !istrue(guy.var_91c24157247ef2fc)) {
    guy thread scripts\anim\shared::dropallaiweapons();
    debug_print("do ragdoll via note");
    guy startragdoll();
    guy.var_91c24157247ef2fc = 1;
  }

  guy.var_540e3c006ce71d3a.var_4187711225445340 = undefined;
}

function function_6410c0421b1874ac() {
  rules = scripts\engine\utility::array_combine(rules_default(), [ &function_29377f3b78dcb609]);
  return rules;
}

function function_29377f3b78dcb609(player, victim) {
  if(victim scripts\sp\fakeactor::is_fakeactor() || !isai(victim)) {
    return false;
  }

  return true;
}

function function_5e2b19fd9204a302(bool) {
  self playerlinkeduselinkedvelocity(bool);
}