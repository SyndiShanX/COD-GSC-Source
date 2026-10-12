/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\van_infil.gsc
***********************************************/

#using scripts\common\anim;
#using scripts\common\utility;
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
#namespace van_infil;

function van_init(subtype) {
  setdevdvarifuninitialized(@ "hash_3dc902e1a71dd25d", 0);

  snd_transient_load("van_infil");
  thread function_e85c746a9eaa79f3();
  initanims(subtype);
  var_453e4fc2c649fea4 = [];
  var_453e4fc2c649fea4[0] = [0];
  var_453e4fc2c649fea4[1] = [1];
  var_453e4fc2c649fea4[2] = [2, 3, 4, 5];
  thread infil_add("infil_van", subtype, 6, 4, var_453e4fc2c649fea4, &van_spawn, &function_91f416a3ece2ef9a, &function_f67856e4fbb899a0);
}

function van_spawn(team, target, subtype, originalsubtype) {
  scene_node = getStruct(target, "targetname");
  infil = spawn("script_origin", scene_node.origin);
  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil thread infilthink(team, subtype);
  return infil;
}

function function_91f416a3ece2ef9a(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["van_infil"]);
  return animlength;
}

function function_f67856e4fbb899a0(infil, spot_index) {
  self endon("player_free_spot");
  thread player_infil_end();

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("jup_preinfil_generic", 1);
  }

  thread infil_radio_idle(infil);
  spawnpos = infil.linktoent gettagorigin("tag_origin_animate");
  spawnang = infil.linktoent gettagangles("tag_origin_animate");
  thread infil_player_rig_updated("slot_" + spot_index, spawnpos, spawnang);
  self.player_rig linkTo(infil.linktoent, "tag_origin_animate");
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_van");

  if(isDefined(level.var_ad1fa45af76b9948)) {
    self.currentvisionset = level.var_ad1fa45af76b9948;
  } else {
    self.currentvisionset = "mp_core_infil_2";
  }

  self visionsetnakedforplayer(self.currentvisionset);
  self.player_rig.weapon_state_func = &handleweaponstatenotetrack;
  thread player_disconnect();
  level waittill("start_scene");
  self playlocalsound("amb_infil_van_lr");

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("jup_infil_generic");
  }

  thread scripts\mp\music_and_dialog::function_3aa69e0e6827ce5("jup_mp_infil");

  if(isDefined(self.animname) && !isai(self)) {
    thread function_acb0a5ef09f5f702();
  }

  self lerpfov(65, 0);
  self setcinematicmotionoverride("disabled");
  self lerpviewangleclamp(1, 0.25, 0.25, 15, 15, 30, 5);
  thread scripts\mp\infilexfil\infilexfil::function_d41cba513a03d958(0.5);
  self lerpfovscalefactor(0, 0);
  thread resetfov();
  infil.linktoent anim_player_solo(self, self.player_rig, "van_infil", "tag_origin_animate");
  thread scripts\mp\class::unblockclasschange();

  if(isDefined(level.scr_viewmodelanim[self.animname]) && isDefined(level.scr_viewmodelanim[self.animname]["van_infil" + "_" + infil.subtype + "_intro"])) {
    setDvar(@ "hash_7eb1641737ab83b7", 0);
  }

  thread clear_infil_ambient_zone();

  if(isDefined(self.player_rig) && self.player_rig islinked()) {
    self.player_rig unlink();
  }

  self notify("infil_finished");
  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
}

function resetfov() {
  level waittill("infil_countdown_show");
  wait 2;

  if(!isDefined(self)) {
    return;
  }

  self lerpfovbypreset("default_2seconds");
  self lerpfovscalefactor(1, 2);
}

function function_acb0a5ef09f5f702() {
  soundalias = "scn_infil_van_plr1";
  waittime = 4.9;

  switch (self.animname) {
    case #"hash_9f02a28a98823bce":
      soundalias = "scn_infil_van_plr1";
      waittime = 4.9;
      break;
    case #"hash_9f02a38a98823d61":
      soundalias = "scn_infil_van_plr2";
      waittime = 2.1;
      break;
    case #"hash_9f02a08a988238a8":
      soundalias = "scn_infil_van_plr3";
      waittime = 8.3;
      break;
    case #"hash_9f02a18a98823a3b":
      soundalias = "scn_infil_van_plr4";
      waittime = 9.5;
      break;
    case #"hash_9f02a68a9882421a":
      soundalias = "scn_infil_van_plr5";
      waittime = 9.5;
      break;
    case #"hash_9f02a78a988243ad":
      soundalias = "scn_infil_van_plr6";
      waittime = 3;
      break;
    default:
      soundalias = "scn_infil_van_plr1";
      waittime = 4.9;
      break;
  }

  wait waittime;

  if(soundexists(soundalias)) {
    if(isDefined(self)) {
      self playlocalsound(soundalias);
    }
  }
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
  self clearclienttriggeraudiozone(1);
  self lerpfovbypreset("default_2seconds");
  self lerpfovscalefactor(1, 2);
  scripts\mp\utility\player::setdof_default();
  setDvar(@ "hash_7eb1641737ab83b7", 0);
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

function actorthink(team, scene_node, scene_name, extra_crew) {
  thread spawnactors(team, scene_name, extra_crew);
  self.linktoent anim_first_frame(self.actors, "van_infil", "tag_origin_animate");
  gameflagwait("infil_started");
  self.linktoent thread anim_single(self.actors, "van_infil", "tag_origin_animate");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["van_infil"]);
  self.actors[1].head scriptmodelplayanim(level.scr_anim[self.actors[1].animname]["van_infil"]);
  duration = getanimlength(level.scr_anim["chief"]["van_infil"]);
  wait duration;

  foreach(actor in self.actors) {
    if(isDefined(actor)) {
      actor delete();
    }
  }

  self.actors = undefined;
}

function spawnactors(team, scene_name, extra_crew) {
  if(!isDefined(self.actors)) {
    self.actors = [];
  }

  switch (team) {
    case #"hash_7c2d091e6337bf54":
      self.actors[self.actors.size] = self.linktoent spawn_anim_model("driver", "tag_origin_animate", "body_mp_milsim_east_iw9_1_1", "head_mp_milsim_east_iw9_1_1");
      self.actors[self.actors.size] = self.linktoent spawn_anim_model("chief", "tag_origin_animate", "body_mp_milsim_east_iw9_1_1", "head_mp_milsim_east_iw9_1_1");
      break;
    case #"hash_5f54b9bf7583687f":
      self.actors[self.actors.size] = self.linktoent spawn_anim_model("driver", "tag_origin_animate", "body_mp_milsim_west_iw9_1_1", "head_mp_milsim_west_iw9_1_1");
      self.actors[self.actors.size] = self.linktoent spawn_anim_model("chief", "tag_origin_animate", "body_mp_milsim_west_iw9_1_1", "head_mp_milsim_west_iw9_1_1");
      break;
    default:
      self.actors[self.actors.size] = self.linktoent spawn_anim_model("driver", "tag_origin_animate", "body_mp_milsim_east_iw9_1_1", "head_mp_milsim_east_iw9_1_1");
      self.actors[self.actors.size] = self.linktoent spawn_anim_model("chief", "tag_origin_animate", "body_mp_milsim_east_iw9_1_1", "head_mp_milsim_east_iw9_1_1");
      break;
  }

  foreach(actor in self.actors) {
    actor.infil = self;
  }
}

function spawn_anim_model(animname, linkto_ent, body, head, weapon) {
  guy = spawn("script_model", (0, 0, 0));
  guy setModel(body);

  if(isDefined(head)) {
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

  if(animname == "chief") {
    guy hidepart("j_sling_pivot");
  }

  return guy;
}

function infilthink(team, scene_name) {
  foreach(ent in getEntArray("infil_delete", "script_noteworthy")) {
    ent delete();
  }

  thread vehiclethink(team, self.scene_node, scene_name);
  thread actorthink(team, self.scene_node, scene_name);
  level waittill("infil_started");
  setDvar(@ "r_spotlightentityshadows", 1);
  level notify("start_scene");
  level waittill("prematch_over");
  setDvar(@ "r_spotlightentityshadows", 0);

  while(isDefined(self.actors)) {
    waitframe();
  }

  level.infilsactive--;
  self delete();
}

function vehiclethink(team, scene_node, scene_name, extra_crew) {
  van = spawnvan(scene_node, team, scene_name);
  self.var_addd3217bc59a7b8 = function_bbfdaed21b5cddbb(scene_name);

  if(!isDefined(self.path)) {
    anim_first_frame_solo(van, "van_infil");
  }

  van vehicle_turnengineoff();
  van thread function_e3e8566b27b746cb();
  level waittill("infil_started");
  self.linktoent function_ffa1124c73da1ab3(self.var_addd3217bc59a7b8);
  thread anim_single_solo(van, "van_infil");
  function_4dca5340dfd36c76(scene_node, van, getanimlength(level.scr_anim["chief"]["van_infil"]), "van", "van_infil");
  level waittill("prematch_over");
}

function function_e85c746a9eaa79f3() {
  level waittill("prematch_over");
  wait 51;
  snd_transient_unload("van_infil");
}

function function_e3e8566b27b746cb() {
  van_sfx = spawn("script_model", self.origin);
  var_2a4b36bf48cbb639 = spawn("script_model", self.origin);
  level waittill("infil_started");
  waitframe();
  van_sfx linkTo(self, "tag_origin", (100, 0, 50), (0, 0, 0));
  var_2a4b36bf48cbb639 linkTo(self, "tag_origin", (-174, 0, 47), (0, 0, 0));
  waitframe();
  van_sfx playsoundonmovingent("scn_infil_van_driving_front");
  var_2a4b36bf48cbb639 playsoundonmovingent("scn_infil_van_driving_rear");
  level waittill("prematch_over");
  van_sfx delete();
  var_2a4b36bf48cbb639 delete();
}

function initanims(subtype) {
  function_487431cf3b99e0b8(subtype);
  function_7b7d0c2db72b128(subtype);
  addnotetrack_customfunction("slot_0", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_1", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_2", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_3", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_4", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_5", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_0", "free_look", &player_free_look, "van_infil");
  addnotetrack_customfunction("slot_1", "free_look", &player_free_look, "van_infil");
  addnotetrack_customfunction("slot_2", "free_look", &player_free_look, "van_infil");
  addnotetrack_customfunction("slot_3", "free_look", &player_free_look, "van_infil");
  addnotetrack_customfunction("slot_4", "free_look", &player_free_look, "van_infil");
  addnotetrack_customfunction("slot_5", "free_look", &player_free_look, "van_infil");
  addnotetrack_customfunction("slot_0", "shake_on", &rumble_low, "van_infil");
  addnotetrack_customfunction("slot_1", "shake_on", &rumble_low, "van_infil");
  addnotetrack_customfunction("slot_2", "shake_on", &rumble_low, "van_infil");
  addnotetrack_customfunction("slot_3", "shake_on", &rumble_low, "van_infil");
  addnotetrack_customfunction("slot_4", "shake_on", &rumble_low, "van_infil");
  addnotetrack_customfunction("slot_5", "shake_on", &rumble_low, "van_infil");
  addnotetrack_customfunction("slot_0", "shake_running", &cam_shake_running, "van_infil");
  addnotetrack_customfunction("slot_1", "shake_running", &cam_shake_running, "van_infil");
  addnotetrack_customfunction("slot_2", "shake_running", &cam_shake_running, "van_infil");
  addnotetrack_customfunction("slot_3", "shake_running", &cam_shake_running, "van_infil");
  addnotetrack_customfunction("slot_4", "shake_running", &cam_shake_running, "van_infil");
  addnotetrack_customfunction("slot_5", "shake_running", &cam_shake_running, "van_infil");
  addnotetrack_customfunction("chief", "van_chief_sfx", &van_chief_sfx, "van_infil");
  addnotetrack_customfunction("chief", "van_door_sfx", &van_door_sfx, "van_infil");
  addnotetrack_customfunction("chief", "van_close_sfx", &van_close_sfx, "van_infil");
  addnotetrack_customfunction("slot_0", "scn_infil_van_npc1", &scn_infil_van_npc1, "van_infil");
  addnotetrack_customfunction("slot_1", "scn_infil_van_npc2", &scn_infil_van_npc2, "van_infil");
  addnotetrack_customfunction("slot_2", "scn_infil_van_npc3", &scn_infil_van_npc3, "van_infil");
  addnotetrack_customfunction("slot_3", "scn_infil_van_npc4", &scn_infil_van_npc4, "van_infil");
  addnotetrack_customfunction("slot_4", "scn_infil_van_npc5", &scn_infil_van_npc5, "van_infil");
  addnotetrack_customfunction("slot_5", "scn_infil_van_npc6", &scn_infil_van_npc6, "van_infil");
}

#using_animtree("script_model");

function script_model_anims(subtype) {
  switch (subtype) {
    case #"hash_1cc79b02710cab23":
    case #"hash_6829ee5abc10c38b":
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["van_infil"] = % iw9_mp_infil_van_seat_0;
      level.scr_eventanim["slot_0"]["van_infil"] = % "infil_van_seat_0";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["van_infil"] = % iw9_mp_infil_van_seat_1;
      level.scr_eventanim["slot_1"]["van_infil"] = % "infil_van_seat_1";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["van_infil"] = % iw9_mp_infil_van_seat_2;
      level.scr_eventanim["slot_2"]["van_infil"] = % "infil_van_seat_2";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["van_infil"] = % iw9_mp_infil_van_seat_3;
      level.scr_eventanim["slot_3"]["van_infil"] = % "infil_van_seat_3";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["van_infil"] = % iw9_mp_infil_van_seat_4;
      level.scr_eventanim["slot_4"]["van_infil"] = % "infil_van_seat_4";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["van_infil"] = % iw9_mp_infil_van_seat_5;
      level.scr_eventanim["slot_5"]["van_infil"] = % "infil_van_seat_5";
      level.scr_animtree["chief"] = #animtree;
      level.scr_anim["chief"]["van_infil"] = % iw9_mp_infil_van_chief;
      level.scr_eventanim["chief"]["van_infil"] = % "infil_van_chief";
      level.scr_animtree["driver"] = #animtree;
      level.scr_anim["driver"]["van_infil"] = % iw9_mp_infil_van_driver;
      level.scr_eventanim["driver"]["van_infil"] = % "infil_van_driver";
      break;
  }
}

function function_487431cf3b99e0b8(subtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case #"hash_c860b74f2269590c":
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["van_infil"] = % iw9_mp_infil_van_fort_seat_0;
      level.scr_eventanim["slot_0"]["van_infil"] = % "infil_van_fort_seat_0";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["van_infil"] = % iw9_mp_infil_van_fort_seat_1;
      level.scr_eventanim["slot_1"]["van_infil"] = % "infil_van_fort_seat_1";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["van_infil"] = % iw9_mp_infil_van_fort_seat_2;
      level.scr_eventanim["slot_2"]["van_infil"] = % "infil_van_fort_seat_2";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["van_infil"] = % iw9_mp_infil_van_fort_seat_3;
      level.scr_eventanim["slot_3"]["van_infil"] = % "infil_van_fort_seat_3";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["van_infil"] = % iw9_mp_infil_van_fort_seat_4;
      level.scr_eventanim["slot_4"]["van_infil"] = % "infil_van_fort_seat_4";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["van_infil"] = % iw9_mp_infil_van_fort_seat_5;
      level.scr_eventanim["slot_5"]["van_infil"] = % "infil_van_fort_seat_5";
      level.scr_animtree["chief"] = #animtree;
      level.scr_anim["chief"]["van_infil"] = % iw9_mp_infil_van_fort_chief;
      level.scr_eventanim["chief"]["van_infil"] = % "infil_van_fort_chief";
      level.scr_animtree["driver"] = #animtree;
      level.scr_anim["driver"]["van_infil"] = % iw9_mp_infil_van_driver;
      level.scr_eventanim["driver"]["van_infil"] = % "infil_van_driver";
      break;
    default:
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["van_infil"] = % iw9_mp_infil_van_seat_0;
      level.scr_eventanim["slot_0"]["van_infil"] = % "infil_van_seat_0";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["van_infil"] = % iw9_mp_infil_van_seat_1;
      level.scr_eventanim["slot_1"]["van_infil"] = % "infil_van_seat_1";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["van_infil"] = % iw9_mp_infil_van_seat_2;
      level.scr_eventanim["slot_2"]["van_infil"] = % "infil_van_seat_2";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["van_infil"] = % iw9_mp_infil_van_seat_3;
      level.scr_eventanim["slot_3"]["van_infil"] = % "infil_van_seat_3";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["van_infil"] = % iw9_mp_infil_van_seat_4;
      level.scr_eventanim["slot_4"]["van_infil"] = % "infil_van_seat_4";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["van_infil"] = % iw9_mp_infil_van_seat_5;
      level.scr_eventanim["slot_5"]["van_infil"] = % "infil_van_seat_5";
      level.scr_animtree["chief"] = #animtree;
      level.scr_anim["chief"]["van_infil"] = % iw9_mp_infil_van_chief;
      level.scr_eventanim["chief"]["van_infil"] = % "infil_van_chief";
      level.scr_animtree["driver"] = #animtree;
      level.scr_anim["driver"]["van_infil"] = % iw9_mp_infil_van_driver;
      level.scr_eventanim["driver"]["van_infil"] = % "infil_van_driver";
      break;
  }
}

function van_chief_sfx(guy) {
  guy playsoundonmovingent("scn_infil_van_chief");
}

function van_door_sfx(guy) {
  guy playsoundonmovingent("scn_infil_van_door");
}

function van_close_sfx(guy) {
  guy playsoundonmovingent("scn_infil_van_door_close");
}

#using_animtree("mp_vehicles_always_loaded");

function vehicles_anims(subtype) {
  switch (subtype) {
    case #"hash_6829ee5abc10c38b":
      level.scr_animtree["van"] = #animtree;
      level.scr_anim["van"]["van_infil"] = % iw9_mp_infil_van_vehicule_grandprix;
      break;
    case #"hash_1cc79b02710cab23":
      level.scr_animtree["van"] = #animtree;
      level.scr_anim["van"]["van_infil"] = % iw9_mp_infil_van_vehicule_grandprix;
      break;
  }
}

function function_7b7d0c2db72b128(subtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case #"hash_c860b74f2269590c":
      level.scr_anim["van"]["van_infil"] = % iw9_mp_infil_van_vehicle_fort;
      break;
    default:
      level.scr_anim["van"]["van_infil"] = % iw9_mp_infil_van_vehicule_grandprix;
      break;
  }
}

function spawnvan(scene_node, team, scene_name) {
  spawnpos = scene_node.origin;
  spawnang = scene_node.angles;

  if(isDefined(self.path)) {
    spawnpos = self.path.origin;
    spawnang = self.path.angles;
  }

  vehicle = spawnVehicle("veh9_civ_lnd_van_cargo_windows_infil", scene_name, "veh9_civ_lnd_van_cargo_physics_mp", spawnpos, spawnang);
  vehicle setvehicleteam(team);
  vehicle vehphys_forcekeyframedmotion();
  vehicle.animname = "van";
  self.linktoent = vehicle;
  vehicle.infil = self;
  return vehicle;
}

function function_bbfdaed21b5cddbb(subtype) {
  var_addd3217bc59a7b8 = spawnStruct();
  var_5e0676140eecdf2d = "van_" + subtype + "_probe";
  light_name = "van_" + subtype + "_light";
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

function function_ffa1124c73da1ab3(var_addd3217bc59a7b8) {
  if(!isDefined(var_addd3217bc59a7b8)) {
    return;
  }

  var_addd3217bc59a7b8.probe show();
  var_addd3217bc59a7b8.probe linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));

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

function scn_infil_van_npc1(guy) {
  if(!isDefined(guy.var_8655d6f4c9340db1)) {
    guy playsoundonmovingent("scn_infil_van_npc1");
  }

  guy.var_8655d6f4c9340db1 = 1;
}

function scn_infil_van_npc2(guy) {
  if(!isDefined(guy.var_8655d6f4c9340db1)) {
    guy playsoundonmovingent("scn_infil_van_npc2");
  }

  guy.var_8655d6f4c9340db1 = 1;
}

function scn_infil_van_npc3(guy) {
  if(!isDefined(guy.var_8655d6f4c9340db1)) {
    guy playsoundonmovingent("scn_infil_van_npc3");
  }

  guy.var_8655d6f4c9340db1 = 1;
}

function scn_infil_van_npc4(guy) {
  if(!isDefined(guy.var_8655d6f4c9340db1)) {
    guy playsoundonmovingent("scn_infil_van_npc4");
  }

  guy.var_8655d6f4c9340db1 = 1;
}

function scn_infil_van_npc5(guy) {
  if(!isDefined(guy.var_8655d6f4c9340db1)) {
    guy playsoundonmovingent("scn_infil_van_npc5");
  }

  guy.var_8655d6f4c9340db1 = 1;
}

function scn_infil_van_npc6(guy) {
  if(!isDefined(guy.var_8655d6f4c9340db1)) {
    guy playsoundonmovingent("scn_infil_van_npc6");
  }

  guy.var_8655d6f4c9340db1 = 1;
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
      var_9742aa030e46f6c0 playLoopSound("amb_infil_van");
      function_7330aa81e1f66e19("infil_started", "death_or_disconnect");
      wait 1;
      radio_sfx stoploopsound("dx_mpo_ukop_radio_chatter");
      var_9742aa030e46f6c0 stoploopsound("amb_infil_van");
      radio_sfx delete();
      var_9742aa030e46f6c0 delete();
    }

    return;
  }

  return;
}

function function_6158ef142e9bd640() {
  level endon("game_ended");
  self endon("infil_finished");
  wait 26;
  self visionsetnakedforplayer("mp_core_infil_2", 3);
}

function function_7330aa81e1f66e19(var_8068764aee94f2f4, playerstring) {
  assert(isDefined(var_8068764aee94f2f4));

  if(isDefined(playerstring)) {
    self endon(playerstring);
  }

  gameflagwait(var_8068764aee94f2f4);
}