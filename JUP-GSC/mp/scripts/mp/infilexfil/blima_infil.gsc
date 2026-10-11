/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\infilexfil\blima_infil.gsc
****************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\class;
#using scripts\mp\flags;
#using scripts\mp\infilexfil\infilexfil;
#using scripts\mp\music_and_dialog;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\player;
#namespace blima_infil;

function function_6cb969a7647dc10f(subtype) {
  snd_transient_load("blima_infil");
  thread function_f764364c2ac0250d();

  setdevdvarifuninitialized(@ "hash_3dc902e1a71dd25d", 0);

  setdvarifuninitialized(@ "mp_core_infil_marketing_capture", 0);
  thread infil_add("infil_blima", subtype, 6, 4, undefined, &function_41496c26b8d3660c, &function_807b3e73f0750918, &function_807c8f0e4f5ad6);
}

function function_41496c26b8d3660c(team, target, subtype, originalsubtype) {
  initanims(subtype, team, originalsubtype);
  scene_node = getStruct(target, "targetname");
  postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype);
  infil = spawn("script_origin", scene_node.origin);
  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;

  if(isDefined(scene_node.target)) {
    infil.introdur = getanimlength(level.scr_anim["blima"]["blima_infil_" + subtype]);
    infil.path = scene_node;
  }

  infil.subtype = subtype;
  infil.originalsubtype = originalsubtype;
  infil thread infilthink(team, subtype);
  return infil;
}

function postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case #"hash_32eaa112f8caa7e4":
      switch (originalsubtype) {
        case #"hash_6829ee5abc10c38b":
          if(team == "axis") {
            scene_node.angles += (0, 8, 0);
          } else {
            scene_node.angles += (0, 23, 0);
            scene_node.origin += anglesToForward(scene_node.angles) * 100;
          }

          break;
        case #"hash_ac5f2d60e641dce":
          if(team == "axis") {
            scene_node.angles += (0, -8, 0);
          } else {
            scene_node.angles += (0, -3, 0);
          }

          break;
        case #"hash_ac5f1d60e641c3b":
          if(team == "axis") {
            scene_node.angles += (0, -3, 0);
            scene_node.origin += anglesToForward(scene_node.angles) * 200;
          } else {
            scene_node.angles += (0, 12, 0);
          }

          break;
      }

      break;
    case #"hash_50de71be6e7469ff":
      switch (originalsubtype) {
        case #"hash_1cc79b02710cab23":
          if(team == "allies") {
            scene_node.origin -= (0, 0, 86);
          }

          break;
      }
    case #"hash_1bc93b88575e82eb":
      switch (originalsubtype) {
        case #"hash_6829ee5abc10c38b":
          if(team == "allies") {
            scene_node.angles -= (0, 30, 0);
          }

          break;
      }

      break;
  }
}

function function_807b3e73f0750918(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["blima_infil"]);
  return animlength;
}

function function_807c8f0e4f5ad6(infil, spot_index) {
  self endon("player_free_spot");

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("jup_preinfil_generic", 1);
  }

  thread infil_radio_idle(infil);
  thread player_infil_end();
  spawnpos = infil.linktoent gettagorigin("body_animate_jnt");
  spawnang = infil.linktoent gettagangles("body_animate_jnt");
  thread infil_player_rig_updated("slot_" + spot_index, spawnpos, spawnang);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");

  if(getdvarint(@ "mp_core_infil_marketing_capture") == 1) {
    self visionsetnakedforplayer("mp_core_infil_marketing_capture", 0);
    self setviewmodeldepthoffield(0, 0, 0);
    scripts\mp\utility\player::setdof_default();
  }

  if(isDefined(level.var_5a2c32f7f9efb252)) {
    self.currentvisionset = level.var_5a2c32f7f9efb252;
  } else {
    self.currentvisionset = "mp_core_infil_2";
  }

  self visionsetnakedforplayer(self.currentvisionset);
  thread player_disconnect();
  gameflagwait("infil_started");

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("jup_infil_generic");
  }

  infil.linktoent anim_first_frame_solo(self.player_rig, "blima_infil", "body_animate_jnt");
  self.player_rig linkTo(infil.linktoent, "body_animate_jnt");
  thread scripts\mp\music_and_dialog::function_3aa69e0e6827ce5("jup_mp_infil");

  if(isDefined(self.animname) && !isai(self)) {
    self playlocalsound("jup_infil_blima_lr");
  }

  self lerpfov(65, 0);
  self lerpfovscalefactor(0, 0);
  thread resetfov();
  self setcinematicmotionoverride("disabled");
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 5, 5);
  thread scripts\mp\infilexfil\infilexfil::function_d41cba513a03d958(1);
  infil.linktoent anim_player_solo(self, self.player_rig, "blima_infil");
  thread scripts\mp\class::unblockclasschange();

  if(isDefined(self.player_rig) && self.player_rig islinked()) {
    self.player_rig unlink();
  }

  self notify("infil_finished");
  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  thread clear_infil_ambient_zone();
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
}

function clear_infil_ambient_zone() {
  self endon("disconnect");
  level waittill("prematch_over");
  wait 1;

  if(isDefined(self.submix)) {
    self clearsoundsubmix(self.submix, 2);
  }

  self clearclienttriggeraudiozone(2);
}

function player_infil_end() {
  self endon("disconnect");
  level waittill("prematch_over");
  self notify("remove_rig");
  self lerpfovbypreset("default_2seconds");
  self lerpfovscalefactor(1, 2.5);
  self clearclienttriggeraudiozone(1);
  scripts\mp\utility\player::setdof_default();
}

function infil_radio_idle(infil) {
  if(!flag("infil_started")) {
    if(isPlayer(self)) {
      if(!isDefined(self)) {
        return;
      }

      radio_sfx = spawn("script_origin", (0, 0, 0));
      radio_sfx showonlytoplayer(self);
      preinfil = spawn("script_origin", (0, 0, 0));
      preinfil showonlytoplayer(self);
      radio_sfx playLoopSound("dx_mpo_ukop_radio_chatter");
      preinfil playLoopSound("jup_infil_blima_preinfil_lp");
      function_7330aa81e1f66e19("infil_started", "death_or_disconnect");
      wait 1;
      radio_sfx stoploopsound("dx_mpo_ukop_radio_chatter");
      preinfil stoploopsound("jup_infil_blima_preinfil_lp");
      radio_sfx delete();
      preinfil delete();
    }

    return;
  }

  return;
}

function function_7330aa81e1f66e19(var_8068764aee94f2f4, playerstring) {
  assert(isDefined(var_8068764aee94f2f4));

  if(isDefined(playerstring)) {
    self endon(playerstring);
  }

  gameflagwait(var_8068764aee94f2f4);
}

function player_disconnect() {
  level endon("prematch_over");
  self waittill("disconnect");

  if(isDefined(self)) {
    self visionsetnakedforplayer("");
    self clearclienttriggeraudiozone(0);
    self lerpfovbypreset("default");
    self setviewmodeldepthoffield(0, 0, 18);
    scripts\mp\utility\player::setdof_default();
  }
}

function spawnactors(team, scene_name, extra_crew) {
  if(!isDefined(self.actors)) {
    self.actors = [];
  }

  self.actors[self.actors.size] = self.linktoent spawn_anim_model("crew1", "body_animate_jnt", "fullbody_sp_ally_helicopter_crew_chief");
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("crew2", "body_animate_jnt", "fullbody_sp_ally_helicopter_crew_chief");

  foreach(actor in self.actors) {
    actor.infil = self;
  }
}

function infilthink(team, scene_name) {
  var_e026a614f7467557 = getdvarfloat(@ "hash_ea4c44a08cd23d5d", 0.2);

  foreach(ent in getEntArray("infil_delete", "script_noteworthy")) {
    ent delete();
  }

  thread vehiclethink(team, self.scene_node, scene_name);
  thread actorthink(team, self.scene_node, scene_name);
  gameflagwait("infil_started");
  setDvar(@ "r_spotlightentityshadows", 1);
  setDvar(@ "hash_ea4c44a08cd23d5d", 1);
  level notify("start_scene");
  level waittill("prematch_over");
  setDvar(@ "r_spotlightentityshadows", 0);
  setDvar(@ "hash_ea4c44a08cd23d5d", var_e026a614f7467557);

  while(isDefined(self.linktoent) || isDefined(self.actors)) {
    waitframe();
  }

  level.infilsactive--;
  self delete();
}

function ropethink(scene_name) {
  self.linktoent.var_7d1a90814c8500ff = self.linktoent spawn_anim_model("rope_l", "origin_animate_jnt", "equipment_fast_rope_wm_01_infil_heli_l");
  self.linktoent.roper = self.linktoent spawn_anim_model("rope_r", "origin_animate_jnt", "equipment_fast_rope_wm_01_infil_heli_l");
  self.linktoent.var_7d1a90814c8500ff anim_first_frame_solo(self.linktoent.var_7d1a90814c8500ff, "blima_infil");
  self.linktoent.roper anim_first_frame_solo(self.linktoent.roper, "blima_infil");
  self.linktoent thread anim_single_solo(self.linktoent.var_7d1a90814c8500ff, "blima_infil", "origin_animate_jnt");
  self.linktoent thread anim_single_solo(self.linktoent.roper, "blima_infil", "origin_animate_jnt");
  duration = getanimlength(level.scr_anim[self.linktoent.var_7d1a90814c8500ff.animname]["blima_infil"]);
  wait duration;
  self.linktoent notify("rope_drop");
  self.linktoent.var_7d1a90814c8500ff unlink();
  self.linktoent.roper unlink();
}

function vehiclethink(team, scene_node, scene_name, extra_crew) {
  self.linktoent = spawninfilvehicle(scene_node, team, scene_name);
  self.var_addd3217bc59a7b8 = function_8c1c6f0a556c30e9(scene_name);
  self.linktoent vehicle_turnengineoff();

  if(self.originalsubtype != self.subtype && (getDvar(@ "g_mapname") == "mp_downtown_gw" || getDvar(@ "g_mapname") == "mp_port2_gw")) {
    scene_name = self.originalsubtype;
  }

  anim_first_frame_solo(self.linktoent, "blima_infil_" + scene_name);
  gameflagwait("infil_started");
  self.linktoent function_7e05c22e552b8eed(self.var_addd3217bc59a7b8);
  thread ropethink(scene_name);
  thread anim_single_solo(self.linktoent, "blima_infil_" + scene_name);
  animlength = getanimlength(level.scr_anim["blima"]["blima_infil_" + scene_name]);
  self.linktoent thread function_d3637718a981e89b(animlength, scene_name);

  if(isDefined(self.path)) {
    self.linktoent waittill("rope_drop");
    self.linktoent stopanimScripted();

    if(self.linktoent vehicle_isphysveh()) {
      self.linktoent vehphys_setdefaultmotion();
    }

    startstruct = spawnStruct();
    startstruct.origin = self.linktoent.origin;
    startstruct.angles = self.linktoent.angles;
    startstruct.radius = 500;
    startstruct.speed = 30;
    startstruct.target = self.path.target;
    self.linktoent scripts\common\vehicle_paths::vehicle_paths_helicopter(startstruct);
  } else {
    wait animlength;
    thread anim_single_solo(self.linktoent, "blima_infil_" + scene_name + "exit");
    var_c925c1aa50c8ee10 = getanimlength(level.scr_anim["blima"]["blima_infil_" + scene_name + "exit"]);
    wait var_c925c1aa50c8ee10;
  }

  function_89a2405953b84136(self.var_addd3217bc59a7b8, 0);
  self.linktoent delete();
  self.linktoent = undefined;
}

function function_d3637718a981e89b(animlength, scene_name) {
  if(level.mapname == "mp_jup_launchfacility") {
    var_5a9df12690b568d2 = spawn("script_model", (0, 0, 0));
    var_5a9df12690b568d2 linkTo(self, "tag_flash", (0, 0, 0), (0, 0, 0));
    wait 2;
    self playsoundonmovingent("jup_infil_blima_heli_ext_lr");
    wait animlength + 2.2;
    var_5a9df12690b568d2 playsoundonmovingent("jup_infil_blima_heli_ext_wm_crash");
    wait 4.9;
    var_5a9df12690b568d2 playsoundonmovingent("jup_infil_blima_heli_ext_wm_crashed_explosion");
    wait lookupsoundlength("jup_infil_blima_heli_ext_wm_crashed_explosion") + 1;
    var_5a9df12690b568d2 delete();
    return;
  }

  wait 2;
  self playsoundonmovingent("jup_infil_blima_heli_ext_lr");
}

function actorthink(team, scene_node, scene_name, extra_crew) {
  thread spawnactors(team, scene_name, extra_crew);
  self.linktoent anim_first_frame(self.actors, "blima_infil", "body_animate_jnt");
  gameflagwait("infil_started");
  self.linktoent anim_single(self.actors, "blima_infil", "body_animate_jnt");
  duration = getanimlength(level.scr_anim["crew1"]["blima_infil"]);
  wait duration;

  foreach(actor in self.actors) {
    if(isDefined(actor)) {
      actor delete();
    }
  }

  self.actors = undefined;
}

function spawn_anim_model(animname, linkto_ent, body, head, weapon) {
  male = 1;

  if(cointoss()) {
    male = 0;
  }

  if(body == "random") {
    if(male) {
      index = randomint(3);

      if(index == 0) {
        body = "c_civ_pic_male_2_brown";
      } else if(index == 1) {
        body = "body_opforce_london_civ_1_1";
      } else if(index == 2) {
        body = "civ_london_male_2_5";
      }
    } else if(cointoss()) {
      body = "civ_london_female_1_4";
    } else {
      body = "c_civ_pic_female_5_6";
    }
  }

  guy = spawn("script_model", (0, 0, 0));
  guy setModel(body);

  if(isDefined(head)) {
    if(head == "random") {
      if(male) {
        if(cointoss()) {
          head = "head_bg_var_head_bg_male_09_head_sc_male_14";
        } else {
          head = "head_bg_var_head_male_bc_01_head_hero_gator";
        }
      } else if(cointoss()) {
        head = "head_bg_var_head_female_bc_01_head_sc_female_10";
      } else {
        head = "head_bg_var_head_sc_female_04_head_female_bc_02";
      }
    }

    guy_head = spawn("script_model", (0, 0, 0));
    guy_head setModel(head);
    guy_head linkTo(guy, "j_spine4", (0, 0, 0), (0, 0, 0));
    guy.head = guy_head;
    guy thread delete_on_death(guy_head);
  }

  if(isDefined(weapon)) {
    guy_weapon = spawn("script_model", (0, 0, 0));
    guy_weapon setModel(weapon);
    guy_weapon linkTo(guy, "j_gun", (0, 0, 0), (0, 0, 0));
    guy thread delete_on_death(guy_weapon);
    guy.weapon = guy_weapon;
  }

  guy.animname = animname;
  guy setanimtree();

  if(isDefined(linkto_ent)) {
    thread delete_on_death(guy);
    guy linkTo(self, linkto_ent, (0, 0, 0), (0, 0, 0));
  }

  return guy;
}

function initanims(subtype, team, originalsubtype) {
  script_model_alpha_anims(subtype);
  vehicles_alpha_anims(subtype, team, originalsubtype);
  addnotetrack_customfunction("slot_0", "fov_63_2", &player_fov_default_1, "blima_infil");
  addnotetrack_customfunction("slot_1", "fov_63_2", &player_fov_default_1, "blima_infil");
  addnotetrack_customfunction("slot_2", "fov_63_2", &player_fov_default_1, "blima_infil");
  addnotetrack_customfunction("slot_3", "fov_63_2", &player_fov_default_1, "blima_infil");
  addnotetrack_customfunction("slot_4", "fov_63_2", &player_fov_default_1, "blima_infil");
  addnotetrack_customfunction("slot_5", "fov_63_2", &player_fov_default_1, "blima_infil");
  addnotetrack_customfunction("slot_6", "fov_63_2", &player_fov_default_1, "blima_infil");
  addnotetrack_customfunction("slot_7", "fov_63_2", &player_fov_default_1, "blima_infil");
  addnotetrack_customfunction("slot_8", "fov_63_2", &player_fov_default_1, "blima_infil");
  addnotetrack_customfunction("slot_9", "fov_63_2", &player_fov_default_1, "blima_infil");
  addnotetrack_customfunction("slot_10", "fov_63_2", &player_fov_default_1, "blima_infil");
  addnotetrack_customfunction("slot_11", "fov_63_2", &player_fov_default_1, "blima_infil");
  addnotetrack_customfunction("slot_0", "shake_running", &cam_shake_running, "blima_infil");
  addnotetrack_customfunction("slot_1", "shake_running", &cam_shake_running, "blima_infil");
  addnotetrack_customfunction("slot_2", "shake_running", &cam_shake_running, "blima_infil");
  addnotetrack_customfunction("slot_3", "shake_running", &cam_shake_running, "blima_infil");
  addnotetrack_customfunction("slot_4", "shake_running", &cam_shake_running, "blima_infil");
  addnotetrack_customfunction("slot_5", "shake_running", &cam_shake_running, "blima_infil");
  addnotetrack_customfunction("slot_6", "shake_running", &cam_shake_running, "blima_infil");
  addnotetrack_customfunction("slot_7", "shake_running", &cam_shake_running, "blima_infil");
  addnotetrack_customfunction("slot_8", "shake_running", &cam_shake_running, "blima_infil");
  addnotetrack_customfunction("slot_9", "shake_running", &cam_shake_running, "blima_infil");
  addnotetrack_customfunction("slot_10", "shake_running", &cam_shake_running, "blima_infil");
  addnotetrack_customfunction("slot_11", "shake_running", &cam_shake_running, "blima_infil");
  addnotetrack_customfunction("slot_0", "shake_off", &customground, "blima_infil");
  addnotetrack_customfunction("slot_1", "shake_off", &customground, "blima_infil");
  addnotetrack_customfunction("slot_2", "shake_off", &customground, "blima_infil");
  addnotetrack_customfunction("slot_3", "shake_off", &customground, "blima_infil");
  addnotetrack_customfunction("slot_4", "shake_off", &customground, "blima_infil");
  addnotetrack_customfunction("slot_5", "shake_off", &customground, "blima_infil");
  addnotetrack_customfunction("slot_6", "shake_off", &customground, "blima_infil");
  addnotetrack_customfunction("slot_7", "shake_off", &customground, "blima_infil");
  addnotetrack_customfunction("slot_8", "shake_off", &customground, "blima_infil");
  addnotetrack_customfunction("slot_9", "shake_off", &customground, "blima_infil");
  addnotetrack_customfunction("slot_10", "shake_off", &customground, "blima_infil");
  addnotetrack_customfunction("slot_11", "shake_off", &customground, "blima_infil");
  addnotetrack_customfunction("slot_0", "equip_nvg", &player_equip_nvg, "blima_infil");
  addnotetrack_customfunction("slot_1", "equip_nvg", &player_equip_nvg, "blima_infil");
  addnotetrack_customfunction("slot_2", "equip_nvg", &player_equip_nvg, "blima_infil");
  addnotetrack_customfunction("slot_3", "equip_nvg", &player_equip_nvg, "blima_infil");
  addnotetrack_customfunction("slot_4", "equip_nvg", &player_equip_nvg, "blima_infil");
  addnotetrack_customfunction("slot_5", "equip_nvg", &player_equip_nvg, "blima_infil");
  addnotetrack_customfunction("slot_6", "equip_nvg", &player_equip_nvg, "blima_infil");
  addnotetrack_customfunction("slot_7", "equip_nvg", &player_equip_nvg, "blima_infil");
  addnotetrack_customfunction("slot_8", "equip_nvg", &player_equip_nvg, "blima_infil");
  addnotetrack_customfunction("slot_9", "equip_nvg", &player_equip_nvg, "blima_infil");
  addnotetrack_customfunction("slot_10", "equip_nvg", &player_equip_nvg, "blima_infil");
  addnotetrack_customfunction("slot_11", "equip_nvg", &player_equip_nvg, "blima_infil");
  addnotetrack_customfunction("slot_0", "player_lock_look_1_second", &player_lock_look_1_second);
  addnotetrack_customfunction("slot_1", "player_lock_look_1_second", &player_lock_look_1_second);
  addnotetrack_customfunction("slot_2", "player_lock_look_1_second", &player_lock_look_1_second);
  addnotetrack_customfunction("slot_3", "player_lock_look_1_second", &player_lock_look_1_second);
  addnotetrack_customfunction("slot_4", "player_lock_look_1_second", &player_lock_look_1_second);
  addnotetrack_customfunction("slot_5", "player_lock_look_1_second", &player_lock_look_1_second);
  addnotetrack_customfunction("slot_6", "player_lock_look_1_second", &player_lock_look_1_second);
  addnotetrack_customfunction("slot_7", "player_lock_look_1_second", &player_lock_look_1_second);
  addnotetrack_customfunction("slot_8", "player_lock_look_1_second", &player_lock_look_1_second);
  addnotetrack_customfunction("slot_9", "player_lock_look_1_second", &player_lock_look_1_second);
  addnotetrack_customfunction("slot_10", "player_lock_look_1_second", &player_lock_look_1_second);
  addnotetrack_customfunction("slot_11", "player_lock_look_1_second", &player_lock_look_1_second);
  addnotetrack_customfunction("slot_0", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_1", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_2", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_3", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_4", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_5", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_6", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_7", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_8", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_9", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_10", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_11", "free_look", &player_free_look);
}

#using_animtree("script_model");

function script_model_alpha_anims(subtype) {
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["blima_infil"] = % iw9_mp_infil_blima_seat_0;
  level.scr_eventanim["slot_0"]["blima_infil"] = % "hash_260c79659d363de0";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["blima_infil"] = % iw9_mp_infil_blima_seat_1;
  level.scr_eventanim["slot_1"]["blima_infil"] = % "hash_260c7c659d3642f9";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["blima_infil"] = % iw9_mp_infil_blima_seat_2;
  level.scr_eventanim["slot_2"]["blima_infil"] = % "hash_260c7b659d364146";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["blima_infil"] = % iw9_mp_infil_blima_seat_3;
  level.scr_eventanim["slot_3"]["blima_infil"] = % "hash_260c7e659d36465f";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["blima_infil"] = % iw9_mp_infil_blima_seat_4;
  level.scr_eventanim["slot_4"]["blima_infil"] = % "hash_260c7d659d3644ac";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["blima_infil"] = % iw9_mp_infil_blima_seat_5;
  level.scr_eventanim["slot_5"]["blima_infil"] = % "hash_260c80659d3649c5";
  level.scr_animtree["crew1"] = #animtree;
  level.scr_anim["crew1"]["blima_infil"] = % iw9_mp_infil_blima_crew_1;
  level.scr_eventanim["crew1"]["blima_infil"] = % "hash_d53d1710cb1e814";
  level.scr_animtree["crew2"] = #animtree;
  level.scr_anim["crew2"]["blima_infil"] = % iw9_mp_infil_blima_crew_2;
  level.scr_eventanim["crew2"]["blima_infil"] = % "hash_d53d1710cb1e814";
  level.scr_animtree["rope_l"] = #animtree;
  level.scr_anim["rope_l"]["blima_infil"] = % iw9_mp_infil_blima_rope_l;
  level.scr_animtree["rope_r"] = #animtree;
  level.scr_anim["rope_r"]["blima_infil"] = % iw9_mp_infil_blima_rope_r;
}

#using_animtree("mp_vehicles_always_loaded");

function vehicles_alpha_anims(subtype, team, originalsubtype) {
  level.scr_anim["blima"]["blima_infil_" + subtype] = % iw9_mp_infil_blima_heli;

  switch (level.mapname) {
    case #"hash_5f400f0334a4a47b":
      level.scr_anim["blima"]["blima_infil_" + subtype + "exit"] = % jup_war_mp_infil_blima_heli_exit;
      break;
    case #"hash_6a5d186e4f67ddee":
    default:
      level.scr_anim["blima"]["blima_infil_" + subtype + "exit"] = % iw9_mp_infil_blima_heli_exit_grandprix;
      break;
  }
}

function spawninfilvehicle(scene_node, team, scene_name) {
  spawnpos = scene_node.origin;
  spawnang = scene_node.angles;
  model = "veh9_mil_air_heli_blima_mp";

  if(team == "allies") {
    model = "veh9_mil_air_heli_blima_mp";
  }

  var_ab5cd311f5dc80a6 = "blima_cp";
  var_e29c89ae4c29e698 = getdvarint(@ "hash_3f9319692595c13a", 1);

  if(var_e29c89ae4c29e698 > 0) {
    var_ab5cd311f5dc80a6 = "veh9_mil_air_heli_blima_physics_mp";
  }

  vehicle = spawnVehicle(model, scene_name, var_ab5cd311f5dc80a6, spawnpos, spawnang);
  vehicle setvehicleteam(team);
  vehicle.animname = "blima";
  vehicle setCanDamage(0);

  if(vehicle vehicle_isphysveh()) {
    vehicle function_247ad6a91f6a4ffe(1);
    vehicle vehphys_forcekeyframedmotion();
  } else {
    vehicle notsolid();
  }

  vehicle hidepart("tag_main_rotor_blade_01");
  vehicle hidepart("tag_main_rotor_blade_02");
  vehicle hidepart("tag_main_rotor_blade_03");
  vehicle hidepart("tag_main_rotor_blade_04");
  vehicle hidepart("tag_tail_rotor_blade_01");
  vehicle hidepart("tag_tail_rotor_blade_02");
  vehicle hidepart("tag_tail_rotor_blade_03");
  vehicle hidepart("tag_tail_rotor_blade_04");
  vehicle.infil = self;
  return vehicle;
}

function getcommanderassets(team) {
  data = spawnStruct();
  data.body = "body_pilot_helicopter_british";
  data.head = "head_pilot_helicopter_british";
  return data;
}

function customground(guy) {
  cam_shake_off(guy);

  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
    return;
  }

  player = guy;
}

function resetfov() {
  level waittill("infil_countdown_show");
  wait 2;

  if(isDefined(self)) {
    self lerpfovbypreset("default_2seconds");
    self lerpfovscalefactor(1, 2.5);
  }
}

function function_8c1c6f0a556c30e9(subtype) {
  var_addd3217bc59a7b8 = spawnStruct();
  var_5e0676140eecdf2d = "blima_" + subtype + "_probe";
  light_name = "blima_" + subtype + "_light";
  probe = getEnt(var_5e0676140eecdf2d, "script_noteworthy");
  lights = getEntArray(light_name, "targetname");

  if(!isDefined(probe)) {
    return undefined;
  }

  foreach(l in lights) {
    if(!isDefined(l)) {
      return undefined;
    }
  }

  var_addd3217bc59a7b8.probe = probe;
  var_addd3217bc59a7b8.lights = lights;
  function_89a2405953b84136(var_addd3217bc59a7b8, 1);
  return var_addd3217bc59a7b8;
}

function function_7e05c22e552b8eed(var_addd3217bc59a7b8) {
  if(!isDefined(var_addd3217bc59a7b8)) {
    return;
  }

  var_addd3217bc59a7b8.probe show();
  var_addd3217bc59a7b8.probe linkTo(self, "tag_origin", (0, 0, -48), (0, 0, 0));

  foreach(l in var_addd3217bc59a7b8.lights) {
    if(isDefined(l.original_intensity)) {
      l setlightintensity(l.original_intensity);
    }

    l linkTo(self);
  }
}

function function_89a2405953b84136(var_addd3217bc59a7b8, override_og) {
  if(!isDefined(var_addd3217bc59a7b8)) {
    return;
  }

  var_addd3217bc59a7b8.probe hide();

  foreach(l in var_addd3217bc59a7b8.lights) {
    if(override_og) {
      l.original_intensity = l getlightintensity();
    }

    l setlightintensity(0);
  }
}

function modifyscenenode(infil, team, subtype) {
  switch (level.mapname) {
    case #"hash_7a28db3c5928c489":
      switch (team) {
        case #"hash_5f54b9bf7583687f":
          switch (subtype) {
            case #"hash_6829ee5abc10c38b":
              break;
            case #"hash_1cc79b02710cab23":
              infil.origin += anglesToForward(infil.angles) * 200;
              break;
          }

          break;
        case #"hash_7c2d091e6337bf54":
          switch (subtype) {
            case #"hash_6829ee5abc10c38b":
              break;
            case #"hash_1cc79b02710cab23":
              infil.origin += anglestoup(infil.angles) * 281.907;
              break;
          }

          break;
      }

      break;
  }
}

function function_f764364c2ac0250d() {
  level waittill("prematch_over");

  if(level.mapname == "mp_jup_launchfacility") {
    wait 70;
    snd_transient_unload("blima_infil");
    return;
  }

  wait 56;
  snd_transient_unload("blima_infil");
}

function function_6158ef142e9bd640() {
  level endon("game_ended");
  self endon("infil_finished");
  wait 27;
  self visionsetnakedforplayer("mp_core_infil_2", 3);
}