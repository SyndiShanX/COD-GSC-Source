/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\infilexfil\mi8_infil.gsc
**************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\flags;
#using scripts\mp\infilexfil\infilexfil;
#using scripts\mp\music_and_dialog;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\player;
#namespace mi8_infil;

function mi8_init(subtype) {
  scripts\cp_mp\utility\audio_utility::snd_transient_load("mi8_infil");
  thread function_247774c600595ace();

  setdevdvarifuninitialized(@ "hash_3dc902e1a71dd25d", 0);

  var_453e4fc2c649fea4 = [];
  var_453e4fc2c649fea4[0] = [11, 10];
  var_453e4fc2c649fea4[1] = [9, 8];
  var_453e4fc2c649fea4[2] = [7, 6];
  var_453e4fc2c649fea4[3] = [5, 4];
  var_453e4fc2c649fea4[4] = [3, 2];
  var_453e4fc2c649fea4[5] = [1, 0];
  thread infil_add("infil_mi8", subtype, 12, 4, var_453e4fc2c649fea4, &mi8_spawn, &mi8_get_length, &player_mi8_infil_think);
}

function mi8_spawn(team, target, subtype, originalsubtype) {
  initanims(subtype, team, originalsubtype);
  scene_node = getStruct(target, "targetname");
  postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype);
  infil = spawn("script_origin", scene_node.origin);
  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil.subtype = subtype;
  infil.originalsubtype = originalsubtype;
  infil thread infilthink(team, subtype);
  return infil;
}

function printdata(infil, subtype, originalsubtype) {
  org = infil.scene_node.origin;
  ang = infil.scene_node.angles;

  while(true) {
    print3d(org, "<dev string:x1c>" + subtype + "<dev string:x24>" + originalsubtype + "<dev string:x2a>", (1, 1, 1), 1, 2);

    thread scripts\cp_mp\utility\debug_utility::drawangles(org, ang, level.framedurationseconds, 1);
    waitframe();
  }
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

function mi8_get_length(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["mi8_infil"]);
  return animlength;
}

function function_901b254bea1ab19f(infil) {
  return infil.scene_node.origin;
}

function player_mi8_infil_think(infil, spot_index) {
  self endon("player_free_spot");

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("jup_preinfil_generic", 1);
  }

  thread infil_radio_idle(infil);
  thread player_infil_end();
  self setadditionalstreamposuntilcleared(function_901b254bea1ab19f(infil));
  spawnpos = infil.origin;
  spawnang = infil.angles;
  thread infil_player_rig_updated("slot_" + spot_index, spawnpos, spawnang);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");

  if(isDefined(level.var_17c3d95c013a7e67)) {
    self.currentvisionset = level.var_17c3d95c013a7e67;
  } else {
    self.currentvisionset = "mp_core_infil";
  }

  self visionsetnakedforplayer(self.currentvisionset);
  self lerpfovbypreset("80_instant");
  self lerpfovscalefactor(0, 0);
  self.player_rig linkTo(infil);
  infil anim_first_frame_solo(self.player_rig, "mi8_infil");
  thread player_disconnect();
  gameflagwait("infil_started");

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("jup_infil_generic");
  }

  thread scripts\mp\music_and_dialog::function_3aa69e0e6827ce5("jup_mp_infil");
  self playlocalsound("jup_infil_mi8_heli_int_lr");
  self setcinematicmotionoverride("disabled");
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 30, 30);
  thread clear_infil_ambient_zone();
  infil anim_player_solo(self, self.player_rig, "mi8_infil");

  if(isDefined(self.player_rig) && self.player_rig islinked()) {
    self.player_rig unlink();
  }

  self lerpfovscalefactor(1, 2);
  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
  self clearadditionalstreampos();
}

function clear_infil_ambient_zone() {
  self endon("death_or_disconnect");
  wait 4;

  if(isDefined(self.submix)) {
    self clearsoundsubmix(self.submix, 2);
  }

  self clearclienttriggeraudiozone(2);
}

function player_infil_end() {
  self endon("disconnect");
  level waittill("prematch_over");
  self notify("remove_rig");
  self clearclienttriggeraudiozone(1);
  scripts\mp\utility\player::setdof_default();
  self clearclienttriggeraudiozone(1);
}

function infil_radio_idle(infil) {
  if(!flag("infil_started")) {
    if(isPlayer(self)) {
      if(!isDefined(self)) {
        return;
      }

      radio_sfx = spawn("script_origin", (0, 0, 0));
      radio_sfx showonlytoplayer(self);
      var_9742aa030e46f6c0 = spawn("script_origin", (0, 0, 0));
      var_9742aa030e46f6c0 showonlytoplayer(self);
      radio_sfx playLoopSound("dx_mpo_ukop_radio_chatter");
      var_9742aa030e46f6c0 playLoopSound("jup_infil_mi8_heli_prestart");
      function_7330aa81e1f66e19("infil_started", "death_or_disconnect");
      wait 1;
      radio_sfx stoploopsound("dx_mpo_ukop_radio_chatter");
      var_9742aa030e46f6c0 stoploopsound("jup_infil_mi8_heli_prestart");
      var_9742aa030e46f6c0 delete();
      radio_sfx delete();
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
    self clearadditionalstreampos();
  }
}

function spawnactors(team, scene_name, extra_crew) {
  if(!isDefined(self.actors)) {
    self.actors = [];
  }

  var_46959f58cbaba3ac = getcommanderassets(team);
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("commander", "tag_origin", var_46959f58cbaba3ac.body, var_46959f58cbaba3ac.head);
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("driver", "tag_origin", var_46959f58cbaba3ac.body, var_46959f58cbaba3ac.head);

  foreach(actor in self.actors) {
    actor.infil = self;
  }

  self.actors[0].anim_playsound_func = &commander_play_sound_func;
  self.actors[1].anim_playsound_func = &driver_play_sound_func;
}

function blima_chief_play_sound_func(alias, notification, stoppable) {
  foreach(player in self.blima.players) {
    player playsoundtoplayer(alias, player);
  }
}

function infilthink(team, scene_name) {
  var_e026a614f7467557 = getdvarfloat(@ "hash_ea4c44a08cd23d5d", 0.2);

  foreach(ent in getEntArray("infil_delete", "script_noteworthy")) {
    ent delete();
  }

  thread vehiclethink(team, self.scene_node, scene_name);
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

function vehiclethink(team, scene_node, scene_name, extra_crew) {
  self.linktoent = spawninfilvehicle(scene_node, team, scene_name);

  if(self.originalsubtype != self.subtype && (getDvar(@ "g_mapname") == "mp_downtown_gw" || getDvar(@ "g_mapname") == "mp_port2_gw")) {
    scene_name = self.originalsubtype;
  }

  anim_first_frame_solo(self.linktoent, "mi8_infil_" + scene_name + "_" + team);
  self.linktoent thread function_3a4301c7ea8a3b7f();
  gameflagwait("infil_started");
  self.linktoent playsoundonmovingent("jup_infil_mi8_heli_ext");
  self.linktoent setscriptablepartstate("blinking_light", "red", 0);
  self.linktoent setscriptablepartstate("infil_lights", "on", 0);
  thread anim_single_solo(self.linktoent, "mi8_infil_" + scene_name + "_" + team);
  animlength = getanimlength(level.scr_anim["mi8"]["mi8_infil_" + scene_name + "_" + team]);
  wait animlength;
  self.linktoent delete();
  self.linktoent = undefined;
}

function function_3a4301c7ea8a3b7f() {
  var_3a4301c7ea8a3b7f = spawn("script_model", self.origin);
  var_3a4301c7ea8a3b7f linkTo(self, "tag_origin", (0, 0, 15), (0, 0, 0));
  gameflagwait("infil_started");
  var_3a4301c7ea8a3b7f playsoundonmovingent("jup_infil_mi8_heli_land");
  level waittill("prematch_over");
  var_3a4301c7ea8a3b7f delete();
}

function actorthink(team, scene_node, scene_name, extra_crew) {
  thread spawnactors(team, scene_name, extra_crew);
  self.linktoent anim_first_frame(self.actors, "mi8_infil_" + scene_name, "tag_origin");
  gameflagwait("infil_started");
  self.linktoent thread anim_single(self.actors, "mi8_infil_" + scene_name, "tag_origin");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["mi8_infil_" + scene_name]);
  duration = getanimlength(level.scr_anim["commander"]["mi8_infil_" + scene_name]);
  wait duration;

  foreach(actor in self.actors) {
    actor delete();
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
  addnotetrack_customfunction("slot_0", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_1", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_2", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_3", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_4", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_5", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_6", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_7", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_8", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_9", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_10", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_11", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_0", "shake_running", &cam_shake_running, "mi8_infil");
  addnotetrack_customfunction("slot_1", "shake_running", &cam_shake_running, "mi8_infil");
  addnotetrack_customfunction("slot_2", "shake_running", &cam_shake_running, "mi8_infil");
  addnotetrack_customfunction("slot_3", "shake_running", &cam_shake_running, "mi8_infil");
  addnotetrack_customfunction("slot_4", "shake_running", &cam_shake_running, "mi8_infil");
  addnotetrack_customfunction("slot_5", "shake_running", &cam_shake_running, "mi8_infil");
  addnotetrack_customfunction("slot_6", "shake_running", &cam_shake_running, "mi8_infil");
  addnotetrack_customfunction("slot_7", "shake_running", &cam_shake_running, "mi8_infil");
  addnotetrack_customfunction("slot_8", "shake_running", &cam_shake_running, "mi8_infil");
  addnotetrack_customfunction("slot_9", "shake_running", &cam_shake_running, "mi8_infil");
  addnotetrack_customfunction("slot_10", "shake_running", &cam_shake_running, "mi8_infil");
  addnotetrack_customfunction("slot_11", "shake_running", &cam_shake_running, "mi8_infil");
  addnotetrack_customfunction("slot_0", "shake_off", &customground, "mi8_infil");
  addnotetrack_customfunction("slot_1", "shake_off", &customground, "mi8_infil");
  addnotetrack_customfunction("slot_2", "shake_off", &customground, "mi8_infil");
  addnotetrack_customfunction("slot_3", "shake_off", &customground, "mi8_infil");
  addnotetrack_customfunction("slot_4", "shake_off", &customground, "mi8_infil");
  addnotetrack_customfunction("slot_5", "shake_off", &customground, "mi8_infil");
  addnotetrack_customfunction("slot_6", "shake_off", &customground, "mi8_infil");
  addnotetrack_customfunction("slot_7", "shake_off", &customground, "mi8_infil");
  addnotetrack_customfunction("slot_8", "shake_off", &customground, "mi8_infil");
  addnotetrack_customfunction("slot_9", "shake_off", &customground, "mi8_infil");
  addnotetrack_customfunction("slot_10", "shake_off", &customground, "mi8_infil");
  addnotetrack_customfunction("slot_11", "shake_off", &customground, "mi8_infil");
  addnotetrack_customfunction("slot_0", "equip_nvg", &player_equip_nvg, "mi8_infil");
  addnotetrack_customfunction("slot_1", "equip_nvg", &player_equip_nvg, "mi8_infil");
  addnotetrack_customfunction("slot_2", "equip_nvg", &player_equip_nvg, "mi8_infil");
  addnotetrack_customfunction("slot_3", "equip_nvg", &player_equip_nvg, "mi8_infil");
  addnotetrack_customfunction("slot_4", "equip_nvg", &player_equip_nvg, "mi8_infil");
  addnotetrack_customfunction("slot_5", "equip_nvg", &player_equip_nvg, "mi8_infil");
  addnotetrack_customfunction("slot_6", "equip_nvg", &player_equip_nvg, "mi8_infil");
  addnotetrack_customfunction("slot_7", "equip_nvg", &player_equip_nvg, "mi8_infil");
  addnotetrack_customfunction("slot_8", "equip_nvg", &player_equip_nvg, "mi8_infil");
  addnotetrack_customfunction("slot_9", "equip_nvg", &player_equip_nvg, "mi8_infil");
  addnotetrack_customfunction("slot_10", "equip_nvg", &player_equip_nvg, "mi8_infil");
  addnotetrack_customfunction("slot_11", "equip_nvg", &player_equip_nvg, "mi8_infil");
  addnotetrack_customfunction("slot_0", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil");
  addnotetrack_customfunction("slot_1", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil");
  addnotetrack_customfunction("slot_2", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil");
  addnotetrack_customfunction("slot_3", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil");
  addnotetrack_customfunction("slot_4", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil");
  addnotetrack_customfunction("slot_5", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil");
  addnotetrack_customfunction("slot_6", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil");
  addnotetrack_customfunction("slot_7", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil");
  addnotetrack_customfunction("slot_8", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil");
  addnotetrack_customfunction("slot_9", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil");
  addnotetrack_customfunction("slot_10", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil");
  addnotetrack_customfunction("slot_11", "player_lock_look_1_second", &player_lock_look_1_second, "mi8_infil");
  addnotetrack_customfunction("slot_0", "free_look", &player_free_look, "mi8_infil");
  addnotetrack_customfunction("slot_1", "free_look", &player_free_look, "mi8_infil");
  addnotetrack_customfunction("slot_2", "free_look", &player_free_look, "mi8_infil");
  addnotetrack_customfunction("slot_3", "free_look", &player_free_look, "mi8_infil");
  addnotetrack_customfunction("slot_4", "free_look", &player_free_look, "mi8_infil");
  addnotetrack_customfunction("slot_5", "free_look", &player_free_look, "mi8_infil");
  addnotetrack_customfunction("slot_6", "free_look", &player_free_look, "mi8_infil");
  addnotetrack_customfunction("slot_7", "free_look", &player_free_look, "mi8_infil");
  addnotetrack_customfunction("slot_8", "free_look", &player_free_look, "mi8_infil");
  addnotetrack_customfunction("slot_9", "free_look", &player_free_look, "mi8_infil");
  addnotetrack_customfunction("slot_10", "free_look", &player_free_look, "mi8_infil");
  addnotetrack_customfunction("slot_11", "free_look", &player_free_look, "mi8_infil");
}

#using_animtree("script_model");

function script_model_alpha_anims(subtype) {
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["mi8_infil"] = % mp_infil_mi8_guyl_01;
  level.scr_eventanim["slot_0"]["mi8_infil"] = % "hash_37ebccc46f9dcb6f";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["mi8_infil"] = % mp_infil_mi8_guyl_02;
  level.scr_eventanim["slot_1"]["mi8_infil"] = % "hash_37ebcdc46f9dcd22";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["mi8_infil"] = % mp_infil_mi8_guyl_03;
  level.scr_eventanim["slot_2"]["mi8_infil"] = % "hash_37ebcec46f9dced5";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["mi8_infil"] = % mp_infil_mi8_guyl_04;
  level.scr_eventanim["slot_3"]["mi8_infil"] = % "hash_37ebc7c46f9dc2f0";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["mi8_infil"] = % mp_infil_mi8_guyl_05;
  level.scr_eventanim["slot_4"]["mi8_infil"] = % "hash_37ebc8c46f9dc4a3";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["mi8_infil"] = % mp_infil_mi8_guyl_06;
  level.scr_eventanim["slot_5"]["mi8_infil"] = % "hash_37ebc9c46f9dc656";
  level.scr_animtree["slot_6"] = #animtree;
  level.scr_anim["slot_6"]["mi8_infil"] = % mp_infil_mi8_guyr_01;
  level.scr_eventanim["slot_6"]["mi8_infil"] = % "hash_1c6f6126013decf8";
  level.scr_animtree["slot_7"] = #animtree;
  level.scr_anim["slot_7"]["mi8_infil"] = % mp_infil_mi8_guyr_02;
  level.scr_eventanim["slot_7"]["mi8_infil"] = % "hash_1c6f6426013df211";
  level.scr_animtree["slot_8"] = #animtree;
  level.scr_anim["slot_8"]["mi8_infil"] = % mp_infil_mi8_guyr_03;
  level.scr_eventanim["slot_8"]["mi8_infil"] = % "hash_1c6f6326013df05e";
  level.scr_animtree["slot_9"] = #animtree;
  level.scr_anim["slot_9"]["mi8_infil"] = % mp_infil_mi8_guyr_04;
  level.scr_eventanim["slot_9"]["mi8_infil"] = % "hash_1c6f6626013df577";
  level.scr_animtree["slot_10"] = #animtree;
  level.scr_anim["slot_10"]["mi8_infil"] = % mp_infil_mi8_guyr_05;
  level.scr_eventanim["slot_10"]["mi8_infil"] = % "hash_1c6f6526013df3c4";
  level.scr_animtree["slot_11"] = #animtree;
  level.scr_anim["slot_11"]["mi8_infil"] = % mp_infil_mi8_guyr_06;
  level.scr_eventanim["slot_11"]["mi8_infil"] = % "hash_1c6f6826013df8dd";
}

#using_animtree("mp_vehicles_always_loaded");

function vehicles_alpha_anims(subtype, team, originalsubtype) {
  mapname = getDvar(@ "g_mapname");

  if(isDefined(originalsubtype) && subtype != originalsubtype && (mapname == "mp_downtown_gw" || mapname == "mp_port2_gw")) {
    switch (originalsubtype) {
      case #"hash_ac5f2d60e641dce":
        if(team == "axis") {
          if(mapname == "mp_downtown_gw") {
            level.scr_anim["mi8"]["mi8_infil_" + originalsubtype + "_" + team] = % mp_infil_mi8_a1_heli_downtown_east;
          }

          if(mapname == "mp_port2_gw") {
            level.scr_anim["mi8"]["mi8_infil_" + originalsubtype + "_" + team] = % mp_infil_mi8_a1_heli_port_east;
          }
        } else {
          if(mapname == "mp_downtown_gw") {
            level.scr_anim["mi8"]["mi8_infil_" + originalsubtype + "_" + team] = % mp_infil_mi8_a1_heli_downtown_west;
          }

          if(mapname == "mp_port2_gw") {
            level.scr_anim["mi8"]["mi8_infil_" + originalsubtype + "_" + team] = % mp_infil_mi8_a1_heli_port_west;
          }
        }

        break;
      case #"hash_ac5f1d60e641c3b":
        if(team == "axis") {
          level.scr_anim["mi8"]["mi8_infil_" + originalsubtype + "_" + team] = % mp_infil_mi8_a2_heli_downtown_east;
        } else {
          level.scr_anim["mi8"]["mi8_infil_" + originalsubtype + "_" + team] = % mp_infil_mi8_a2_heli_downtown_west;
        }

        break;
    }

    return;
  }

  switch (subtype) {
    case #"hash_6829ee5abc10c38b":
      level.scr_animtree["mi8"] = #animtree;

      switch (getDvar(@ "g_mapname")) {
        case #"hash_32eaa112f8caa7e4":
          if(team == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_a_heli_downtown_east;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_a_heli_downtown_west;
          }

          break;
        case #"hash_50de71be6e7469ff":
        case #"hash_7a28db3c5928c489":
          if(team == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_a_heli_quarry_east;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_a_heli_quarry_east;
          }

          break;
        case #"hash_12f3765ef24b4037":
          if(team == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_a_heli_port_east;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_a_heli_port_west;
          }

          break;
        default:
          level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_heli;
          break;
      }

      break;
    case #"hash_1cc79b02710cab23":
      level.scr_animtree["mi8"] = #animtree;

      switch (getDvar(@ "g_mapname")) {
        case #"hash_50de71be6e7469ff":
        case #"hash_7a28db3c5928c489":
          if(team == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_b_heli_quarry_east;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_b_heli_quarry_east;
          }

          break;
        case #"hash_12f3765ef24b4037":
          if(team == "axis") {
            level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_b_heli_port_east;
          } else {
            level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_b_heli_port_west;
          }

          break;
        default:
          level.scr_anim["mi8"]["mi8_infil_" + subtype + "_" + team] = % mp_infil_mi8_heli;
          break;
      }

      break;
    default:
      level.scr_anim["mi8"]["mi8_infil_" + subtype] = % mp_infil_mi8_heli;
      break;
  }
}

function spawninfilvehicle(scene_node, team, scene_name) {
  spawnpos = scene_node.origin;
  spawnang = scene_node.angles;
  model = "veh8_mil_air_mindia8_infil_x";

  if(team == "allies") {
    model = "veh8_mil_air_mindia8_west_infil_x";
  }

  vehicle = spawnVehicle(model, scene_name, "mi8_infil_mp", spawnpos, spawnang);
  vehicle setvehicleteam(team);
  vehicle.animname = "mi8";
  vehicle setCanDamage(0);
  vehicle notsolid();
  vehicle.infil = self;
  return vehicle;
}

function commander_play_sound_func(alias, notification, stoppable) {
  foreach(player in self.infil.players) {
    if(soundexists(alias)) {
      self playsoundtoplayer(alias, player);
    }
  }
}

function driver_play_sound_func(alias, notification, stoppable) {
  foreach(player in self.infil.players) {
    self playsoundtoplayer(alias, player);
  }
}

function getcommanderassets(team) {
  data = spawnStruct();
  data.body = "body_mp_eastern_fireteam_east_sg_no_sling";
  data.head = "head_mp_eastern_fireteam_east_ar_4";
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

function function_247774c600595ace() {
  level waittill("prematch_over");
  wait 55;
  scripts\cp_mp\utility\audio_utility::snd_transient_unload("mi8_infil");
}

function function_6158ef142e9bd640() {
  wait 20;
  self visionsetnakedforplayer("mp_core_infil_2", 3);
}