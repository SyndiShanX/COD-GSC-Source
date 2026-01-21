/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_contextual_melee.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#using_animtree("generic_human");
setup() {
  if(isDefined(level.contextualMeleeFeature) && !level.contextualMeleeFeature)
    return;
  level._melee = spawnStruct();
  level._CONTEXTUAL_MELEE_DIST = 70;
  level._CONTEXTUAL_MELEE_DIST_SQ = level._CONTEXTUAL_MELEE_DIST *
    level._CONTEXTUAL_MELEE_DIST;
  level._CONTEXTUAL_MELEE_LERP_TIME = .3;
  level._contextual_melee_print_hintstring = true;
  level._contextual_melee_allow_fire_button = false;
  PrecacheRumble("melee_garrote");
  PrecacheModel("weapon_parabolic_knife");
  setup_fx();
  setup_info();
}

main(melee_id, set) {
  if(isDefined(melee_id) && !IsString(melee_id) && !melee_id) {
    self notify("stop_contextual_melee");
    return;
  }
  if(!isDefined(self._melee)) {
    self._melee = spawnStruct();
  }
  if(!isDefined(set) || set == "any") {
    self._melee.set = array_reverse(GetArrayKeys(level._melee.info));
    self._melee.set = array_remove(self._melee.set, "scripted");
  } else if(IsString(set) || IsArray(set)) {
    self._melee.set = set;
  } else {
    assertmsg("Contetual Melee set must be a string or an array of strings.");
  }
  self._melee.type = undefined;
  self._melee.ai_context = undefined;
  self._melee.player_context = undefined;
  if(isDefined(melee_id)) {
    melee_info = StrTok(ToLower(melee_id), "_");
    self._melee.type = melee_info[0];
    if(isDefined(melee_info[1])) {
      self._melee.ai_context = melee_info[1];
    }
    if(isDefined(melee_info[2])) {
      self._melee.player_context = melee_info[2];
    }
    self remove_weapon(melee_id);
    if(isDefined(self._melee.ai_context)) {
      self thread do_idle(self._melee.type, self._melee.ai_context);
    }
  }
  self thread contextual_melee_thread();
}

remove_weapon(melee_id) {
  if(IsSubStr(melee_id, "garrote_sit") || IsSubStr(melee_id, "neckstab_crouch")) {
    self gun_remove();
  }
}

get_context() {
  if(IsAI(self)) {
    if(isDefined(self._melee.ai_context)) {
      return self._melee.ai_context;
    } else {
      return self.a.pose;
    }
  } else if(IsPlayer(self)) {
    return self GetStance();
  } else {
    assertmsg("_contextual_melee: trying to get context for unsupported entity type.");
  }
}

waittill_melee() {
  while(true) {
    player = undefined;
    while(!isDefined(player)) {
      wait .05;
      if(!IsAlive(self)) {
        return;
      }
      players = get_players();
      for(i = 0; i < players.size; i++) {
        if(players[i] player_can_melee(self)) {
          player = players[i];
          break;
        }
      }
    }
    if(player player_interaction(self)) {
      player notify("melee_attack", self);
      self notify("melee_victim", player);
      return player;
    }
  }
}

cancel_waittill_melee(guy) {
  guy waittill_any("stop_contextual_melee", "death");
  player = get_players()[0];
  player SetScriptHintString("");
  self enable_weapon();
}

player_can_melee(guy) {
  info = get_potential_melee_info(guy);
  if(isDefined(info)) {
    guy._melee.info = info;
    dist = distanceSquared(guy.origin, self.origin);
    if(dist < level._CONTEXTUAL_MELEE_DIST_SQ) {
      looking_at = is_player_looking_at(guy GetTagOrigin("J_Neck"), .7, false);
      if(isDefined(guy._melee_ignore_angle_override)) {
        return looking_at;
      }
      facing_same_way = (VectorDot(anglesToForward(guy.angles), anglesToForward(self GetPlayerAngles())) > 0.4);
      return looking_at && facing_same_way;
    }
  }
  return false;
}

get_potential_melee_info(guy) {
  info = [];
  set = [];
  if(IsArray(guy._melee.set)) {
    set = guy._melee.set;
  } else {
    set[0] = guy._melee.set;
  }
  for(i = 0; i < set.size; i++) {
    if(isDefined(guy._melee.type)) {
      info = get_info_by_type(guy._melee.type, guy get_context(), self get_context(), set[i]);
    } else {
      info = get_info(self get_context(), guy get_context(), set[i]);
    }
    if(isDefined(info) && info.size > 0) {
      return info;
    }
  }
}

player_interaction(guy) {
  self AllowMelee(false);
  if(level._contextual_melee_print_hintstring) {
    self SetScriptHintString(&"SCRIPT_HINT_MELEE");
  }
  self thread cancel_waittill_melee(guy);
  cancled = false;
  if(level._contextual_melee_allow_fire_button) {
    while(!guy is_auto_melee() && !self MeleeButtonPressed() && !cancled && !self MeleeButtonPressed()) {
      if(!self player_can_melee(guy) || !IsAlive(guy)) {
        self enable_weapon();
        cancled = true;
      } else {
        self notify("melee_in_position");
      }
      wait(0.05);
    }
  } else {
    while(!guy is_auto_melee() && !self MeleeButtonPressed() && !cancled) {
      if(!self player_can_melee(guy) || !IsAlive(guy)) {
        self enable_weapon();
        cancled = true;
      } else {
        self notify("melee_in_position");
      }
      wait(0.05);
    }
  }
  self SetScriptHintString("");
  if(!cancled) {
    self disable_weapon();
  }
  return !cancled;
}

is_auto_melee() {
  return (is_true(self.automatic_contextual_melee));
}

disable_weapon() {
  self HideViewModel();
  self DisableWeapons();
}

enable_weapon() {
  self ShowViewModel();
  self EnableWeapons();
  self AllowMelee(true);
}

get_alignment_object() {
  if(isDefined(level._contextual_melee_align_obj)) {
    return level._contextual_melee_align_obj;
  } else if(isDefined(self.target)) {
    obj = getEnt(self.target, "targetname");
    if(!isDefined(obj)) {
      obj = getstruct(self.target, "targetname");
    }
    if(isDefined(obj)) {
      return obj;
    }
  }
  return self;
}

contextual_melee_thread() {
  self notify("_contextual_melee_thread");
  self endon("_contextual_melee_thread");
  self endon("stop_contextual_melee");
  if(self is_scripted_melee()) {
    self waittill("start_scripted_melee", player);
    self._melee.info = get_info_by_type(self._melee.type, "scripted", "scripted", "scripted");
    player disable_weapon();
  } else {
    player = waittill_melee();
  }
  if(IsAlive(self) && isDefined(player)) {
    self thread do_contextual_melee(player);
  }
}

is_scripted_melee() {
  return (isDefined(self._melee.set) && IsString(self._melee.set) && (self._melee.set == "scripted"));
}

do_idle(type, ai_context) {
  self endon("stop_contextual_melee_idle");
  if(is_valid_stance(ai_context)) {
    self AllowedStances(ai_context);
  } else {
    set = self._melee.set;
    if(IsArray(set)) {
      set = set[0];
    }
    ai_idle = get_idle_anim(type, ai_context, set);
    if(isDefined(ai_idle)) {
      self._melee.set = set;
      self._contextual_melee_align_obj = get_alignment_object();
      origin = self._contextual_melee_align_obj.origin;
      angles = self._contextual_melee_align_obj.angles;
      while(true) {
        self AnimScripted("contextual_melee_idle_anim", origin, angles, ai_idle);
        self animscripts\shared::DoNoteTracks("contextual_melee_idle_anim");
      }
    }
  }
}

get_idle_anim(type, ai_context, which_set) {
  info = get_info_set(which_set, true);
  if(isDefined(info[type])) {
    if(isDefined(info[type][ai_context])) {
      info = random(info[type][ai_context]);
      if(isDefined(info["ai_idle"])) {
        return info["ai_idle"];
      }
    }
  }
}

is_valid_stance(stance) {
  return (stance == "stand" || stance == "crouch" || stance == "prone");
}

do_contextual_melee(player) {
  info = self._melee.info;
  player FreezeControls(true);
  player notify("do_contextual_melee");
  self notify("do_contextual_melee");
  self stop_everything();
  assertex(isDefined(info) && (info.size > 0), "Invalid info array for melee.");
  self._contextual_melee_align_obj = get_alignment_object();
  if(does_melee_type_need_legs(info["type"])) {
    player spawn_player_model(self._contextual_melee_align_obj, info);
  } else {
    player spawn_player_hands(self._contextual_melee_align_obj, info);
  }
  player thread animate_player_hands(self, info);
  self waittill("contextual_melee_start_anim");
  self notify("stop_contextual_melee_idle");
  self AnimScripted("contextual_melee_anim", self._contextual_melee_align_obj.origin, self._contextual_melee_align_obj.angles, info["ai"]);
  self thread do_fx();
  self animate_prop();
  self thread contextual_melee_watch_for_anim_end();
  self waittill_either("finish_contextual_melee", "death");
  finish = true;
  if(isDefined(info["callback"])) {
    finish = player[[info["callback"]]](self);
  } else {
    player thread end_contextual_melee(self);
  }
  self notify("melee_done");
  player notify("melee_done");
  if(!is_false(finish)) {
    player.player_hands Delete();
    if(!IsAlive(self)) {
      return;
    }
    if(isDefined(info["ai_deathpose"])) {
      self.takedamage = false;
      self death_notify_wrapper();
      while(true) {
        self AnimScripted("contextual_melee_deathpose", self._contextual_melee_align_obj.origin, self._contextual_melee_align_obj.angles, info["ai_deathpose"]);
        self animscripts\shared::DoNoteTracks("contextual_melee_deathpose");
      }
    }
  }
}

stop_everything() {
  self notify("end_patrol");
  self notify("_stealth_stop_stealth_logic");
  self notify("_stealth_stop_corpse_logic");
  self.ignoreall = true;
  self.goalradius = 0;
  self SetGoalPos(self.origin);
  self Unlink();
  self anim_stopAnimScripted();
}

contextual_melee_watch_for_anim_end() {
  self animscripts\shared::DoNoteTracks("contextual_melee_anim");
  self notify("finish_contextual_melee");
}

contextual_melee_watch_for_victim_died() {
  self waittill("death");
  self notify("finish_contextual_melee");
}

end_contextual_melee(victim) {
  level waittill_any_ents(victim, "death", self, "melee_done");
  self Unlink();
  self notify("contextual_melee_complete");
  if(!is_false(level._contextual_melee_hack)) {
    trace_start = self.origin + (0, 0, 100);
    trace_end = self.origin + (0, 0, -100);
    player_trace = bulletTrace(trace_start, trace_end, false, victim);
    self SetOrigin(player_trace["position"]);
  }
  self FreezeControls(false);
  self enable_weapon();
}

setup_fx() {
  level._effect["neckstab_stand_blood"] = LoadFX("impacts/fx_melee_neck_stab");
  level._effect["neckstab_crouch_blood"] = LoadFX("impacts/fx_melee_neck_stab_crouching");
  level._effect["neckstab_stand_blood_left"] = LoadFX("impacts/fx_melee_neck_stab_left");
  level._effect["hatchet_arm_blood"] = LoadFX("maps/rebirth/fx_axe_to_the_arm");
}

get_info_by_type(type, ai_context, player_context, which_set) {
  info = get_info_set(which_set, true);
  if(isDefined(info[type])) {
    if(isDefined(info[type][ai_context])) {
      if(isDefined(info[type][ai_context][player_context])) {
        return info[type][ai_context][player_context];
      }
    }
  }
}

get_info(player_context, ai_context, which_set) {
  info = get_info_set(which_set);
  if(isDefined(info[player_context])) {
    if(isDefined(info[player_context][ai_context])) {
      info = info[player_context][ai_context];
      keys = GetArrayKeys(info);
      type = keys[randomInt(keys.size)];
      info = info[type];
      return info;
    }
  }
}

get_info_set(which_set, by_type) {
  if(!isDefined(which_set)) {
    which_set = "default";
  }
  if(is_true(by_type)) {
    return level._melee.info_by_type[which_set];
  } else {
    return level._melee.info[which_set];
  }
}

setup_info() {
  add_melee_sequence("default", "garrote", "stand", "stand", %int_contextual_melee_garrote, %ai_contextual_melee_garrote);
  add_melee_sequence("default", "garrote", "stand", "sit", %int_contextual_melee_garrotesit, %ai_contextual_melee_garrotesit_death, %ai_contextual_melee_garrotesit_idle, %ai_contextual_melee_garrotesit_deathpose);
  add_melee_sequence("default", "necksnap", "stand", "stand", %int_contextual_melee_necksnap, %ai_contextual_melee_necksnap);
  add_melee_sequence("default", "neckstab", "stand", "stand", %int_contextual_melee_neckstab, %ai_contextual_melee_neckstab);
  add_melee_sequence("default", "neckstab", "stand", "crouch", %int_contextual_melee_neckstabcrouch, %ai_contextual_melee_neckstabcrouch_death, %ai_contextual_melee_neckstabcrouch_idle);
  add_melee_sequence("quick", "garrote", "stand", "stand", %int_contextual_melee_garrote_quick, %ai_contextual_melee_garrote_quick);
  add_melee_sequence("quick", "garrote", "stand", "sit", %int_contextual_melee_garrotesit_quick, %ai_contextual_melee_garrotesit_death_quick, %ai_contextual_melee_garrotesit_idle, %ai_contextual_melee_garrotesit_deathpose);
  add_melee_sequence("quick", "necksnap", "stand", "stand", %int_contextual_melee_necksnap_quick, %ai_contextual_melee_necksnap_quick);
  add_melee_sequence("quick", "neckstab", "stand", "stand", %int_contextual_melee_neckstab_quick, %ai_contextual_melee_neckstab_quick);
  add_melee_sequence("quick", "neckstab", "stand", "crouch", %int_contextual_melee_neckstabcrouch_quick, %ai_contextual_melee_neckstabcrouch_death_quick, %ai_contextual_melee_neckstabcrouch_idle);
  add_melee_sequence("quick", "neckstab", "crouch", "stand", %int_contextual_melee_crouch_neckstab_quick, %ai_contextual_melee_crouch_neckstab_quick);
  add_melee_sequence("quick", "kneekick", "stand", "stand", %int_contextual_melee_kneekick_quick, %ai_contextual_melee_kneekick_quick);
  add_melee_sequence("quick", "elbowhit", "stand", "stand", %int_contextual_melee_elbow_hit_quick, %ai_contextual_melee_elbow_hit_quick);
  add_melee_sequence("quick", "judochop", "stand", "stand", %int_contextual_melee_judochop_quick, %ai_contextual_melee_judochop_quick);
  add_melee_sequence("quick", "headpunch", "stand", "stand", %int_contextual_melee_headpunch_quick, %ai_contextual_melee_headpunch_quick);
  level.scr_animtree["player_hands_contextual_melee"] = #animtree;
  level.scr_model["player_hands_contextual_melee"] = level.player_interactive_hands;
  level.scr_animtree["player_model_contextual_melee"] = #animtree;
  level.scr_model["player_model_contextual_melee"] = level.player_interactive_model;
  setup_props();
}

add_melee_sequence(set, type, player_context, ai_context, player_anim, ai_anim, ai_idle, ai_deathpose) {
  if(!isDefined(level._melee.info)) {
    level._melee.info = [];
  }
  level._melee.info[set][player_context][ai_context][type]["player"] = player_anim;
  level._melee.info[set][player_context][ai_context][type]["ai"] = ai_anim;
  level._melee.info[set][player_context][ai_context][type]["type"] = type;
  if(isDefined(ai_idle)) {
    level._melee.info[set][player_context][ai_context][type]["ai_idle"] = ai_idle;
  }
  if(isDefined(ai_deathpose)) {
    level._melee.info[set][player_context][ai_context][type]["ai_deathpose"] = ai_deathpose;
  }
  if(!isDefined(level._melee.info_by_type)) {
    level._melee.info_by_type = [];
  }
  level._melee.info_by_type[set][type][ai_context][player_context]["player"] = player_anim;
  level._melee.info_by_type[set][type][ai_context][player_context]["ai"] = ai_anim;
  level._melee.info_by_type[set][type][ai_context][player_context]["type"] = type;
  if(isDefined(ai_idle)) {
    level._melee.info_by_type[set][type][ai_context][player_context]["ai_idle"] = ai_idle;
  }
  if(isDefined(ai_deathpose)) {
    level._melee.info_by_type[set][type][ai_context][player_context]["ai_deathpose"] = ai_deathpose;
  }
}

add_scripted_melee(name, player_anim, ai_anim, ai_idle, ai_deathpose) {
  add_melee_sequence("scripted", name, "scripted", "scripted", player_anim, ai_anim, ai_idle, ai_deathpose);
}

add_melee_callback(set, type, player_context, ai_context, callback) {
  level._melee.info[set][player_context][ai_context][type]["callback"] = callback;
  level._melee.info_by_type[set][type][ai_context][player_context]["callback"] = callback;
}

do_fx() {
  while(true) {
    self waittill("contextual_melee_anim", note);
    switch (note) {
      case "fx_blood":
        playFXOnTag(level._effect["neckstab_stand_blood"], self, "J_Neck");
        break;
      case "fx_blood_karambit":
        AssertEx(isDefined(level._effect["karambit_stand_blood"]), "No blood effect setup for the karambit contextual melee");
        if(is_mature()) {
          playFXOnTag(level._effect["karambit_stand_blood"], self, "J_Neck");
        }
        level notify("karambit_stand_blood_now");
        break;
      case "fx_blood_arm_hatchet":
        playFXOnTag(level._effect["hatchet_arm_blood"], self, "J_Wrist_LE");
        break;
      case "fx_blood_neck_hatchet":
        playFXOnTag(level._effect["neckstab_stand_blood_left"], self, "J_Neck");
        break;
      case "end":
        break;
    }
  }
}

get_weapon(type) {
  if(isDefined(level._melee.weapon_info[type])) {
    return level._melee.weapon_info[type];
  }
}

does_melee_type_need_legs(type) {
  switch (type) {
    case "shovelslam":
    case "kneekick":
    case "karambit":
      return true;
    default:
      return false;
  }
}

spawn_player_hands(align_ent, info) {
  if(isDefined(self.early_contextual_player_hands)) {
    self.player_hands = self.early_contextual_player_hands;
  } else {
    start_org = GetStartOrigin(align_ent.origin, align_ent.angles, info["player"]);
    start_ang = GetStartAngles(align_ent.origin, align_ent.angles, info["player"]);
    self.player_hands = spawn_anim_model("player_hands_contextual_melee", start_org, start_ang);
  }
  if(!isDefined(level._contextual_melee_hide)) {
    self.player_hands hide();
  }
}

spawn_player_model(align_ent, info) {
  start_org = GetStartOrigin(align_ent.origin, align_ent.angles, info["player"]);
  start_ang = GetStartAngles(align_ent.origin, align_ent.angles, info["player"]);
  self.player_hands = spawn_anim_model("player_model_contextual_melee", start_org, start_ang);
  self.player_hands hide();
}

animate_player_hands(victim, info) {
  self.player_hands SetAnim(info["player"], 1, 0, 0);
  self StartCameraTween(level._CONTEXTUAL_MELEE_LERP_TIME);
  self PlayerLinkToAbsolute(self.player_hands, "tag_player");
  wait(level._CONTEXTUAL_MELEE_LERP_TIME / 2);
  victim notify("contextual_melee_start_anim");
  self.player_hands AnimScripted("contextual_melee_anim", victim._contextual_melee_align_obj.origin, victim._contextual_melee_align_obj.angles, info["player"]);
  if(isDefined(info["weapon_name"])) {
    weapon = info["weapon_name"];
    if(isDefined(info["weapon_anim"])) {
      self thread animate_weapon(weapon, info["weapon_anim"]);
    } else {
      self.player_hands Attach(weapon, "tag_weapon", true);
    }
  }
  wait(.05);
  self.player_hands Show();
  self.player_hands animscripts\shared::DoNoteTracks("contextual_melee_anim");
}

#using_animtree("animated_props");
setup_props() {
  add_melee_weapon("default", "neckstab", "stand", "stand", "weapon_parabolic_knife");
  add_melee_weapon("default", "neckstab", "stand", "crouch", "weapon_parabolic_knife");
  add_melee_weapon("quick", "neckstab", "stand", "stand", "weapon_parabolic_knife");
  add_melee_weapon("quick", "neckstab", "stand", "crouch", "weapon_parabolic_knife");
  add_melee_weapon("default", "garrote", "stand", "stand", "t5_weapon_garrot_wire", %prop_contextual_melee_garrote_garrotewire);
  add_melee_weapon("default", "garrote", "stand", "sit", "t5_weapon_garrot_wire", %prop_contextual_melee_garrotesit_garrotewire);
  add_melee_weapon("quick", "garrote", "stand", "stand", "t5_weapon_garrot_wire", %prop_contextual_melee_garrote_garrotewire_quick);
  add_melee_weapon("quick", "garrote", "stand", "sit", "t5_weapon_garrot_wire", %prop_contextual_melee_garrotesit_garrotewire_quick);
  add_melee_prop_anim("default", "garrote", "stand", "sit", %prop_contextual_melee_garrotesit_chair);
  add_melee_prop_anim("quick", "garrote", "stand", "sit", %prop_contextual_melee_garrotesit_chair_quick);
}

add_melee_weapon(set, type, player_context, ai_context, weapon_name, weapon_anim) {
  level._melee.info[set][player_context][ai_context][type]["weapon_name"] = weapon_name;
  level._melee.info[set][player_context][ai_context][type]["weapon_anim"] = weapon_anim;
  level._melee.info_by_type[set][type][ai_context][player_context]["weapon_name"] = weapon_name;
  level._melee.info_by_type[set][type][ai_context][player_context]["weapon_anim"] = weapon_anim;
}

add_melee_prop_anim(set, type, player_context, ai_context, animation) {
  level._melee.info[set][player_context][ai_context][type]["prop_anim"] = animation;
  level._melee.info_by_type[set][type][ai_context][player_context]["prop_anim"] = animation;
}

animate_weapon(weapon_name, animation) {
  weapon_org = self.player_hands GetTagOrigin("tag_weapon");
  weapon_ang = self.player_hands GetTagAngles("tag_weapon");
  weapon = spawn("script_model", weapon_org);
  weapon setModel(weapon_name);
  weapon UseAnimTree(#animtree);
  weapon LinkTo(self.player_hands, "tag_weapon");
  weapon AnimScripted("contextual_melee_weapon_anim", weapon_org, weapon_ang, animation);
  weapon animscripts\shared::DoNoteTracks("contextual_melee_weapon_anim");
  weapon Delete();
}

animate_prop() {
  if(isDefined(self._melee.info["prop_anim"])) {
    self._contextual_melee_align_obj UseAnimTree(#animtree);
    self._contextual_melee_align_obj AnimScripted("contextual_melee_prop_anim", self._contextual_melee_align_obj.origin, self._contextual_melee_align_obj.angles, self._melee.info["prop_anim"]);
  }
}

contextual_melee_show_hintstring(string_on) {
  level._contextual_melee_print_hintstring = string_on;
}

contextual_melee_allow_fire_button(string_on) {
  level._contextual_melee_allow_fire_button = string_on;
}