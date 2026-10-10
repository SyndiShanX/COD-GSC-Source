/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\infilexfil\mbravo_infil.gsc
*****************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\class;
#using scripts\mp\flags;
#using scripts\mp\infilexfil\infilexfil;
#using scripts\mp\music_and_dialog;
#using scripts\mp\utility\debug;
#using scripts\mp\utility\game;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\weapon;
#namespace mbravo_infil;

function function_a8bca89f5f67bf2b(subtype) {
  setdevdvarifuninitialized(@ "hash_3dc902e1a71dd25d", 0);

  function_f1aed36ab4598ea("mbravo_infil");
  thread function_5ae55d7eb7946799();
  var_453e4fc2c649fea4 = [];
  var_453e4fc2c649fea4[0] = [0, 1];
  var_453e4fc2c649fea4[1] = [2, 3];
  var_453e4fc2c649fea4[2] = [4];
  var_453e4fc2c649fea4[3] = [5];
  thread infil_add("infil_mbravo", subtype, 6, 4, var_453e4fc2c649fea4, &function_52416ea77b3b3e80, &function_fbecfca322b890c, &function_740ab38c4e4a258a);
}

function function_52416ea77b3b3e80(team, target, subtype, originalsubtype) {
  initanims(subtype, team, originalsubtype);
  scene_node = getStruct(target, "targetname");
  postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype);
  infil = spawn("script_origin", scene_node.origin);

  if(isDefined(scene_node.target)) {
    infil.path = scene_node;
  }

  if(!isDefined(scene_node.angles)) {
    scene_node.angles = (0, 0, 0);
  }

  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil.subtype = subtype;
  infil.originalsubtype = originalsubtype;
  infil thread infilthink(team, originalsubtype);

  if((scripts\mp\utility\game::getgametype() == "arm" || scripts\mp\utility\game::getgametype() == "conflict") && isDefined(scene_node.target)) {
    level.teamdata[team]["captureLocation_Next"] = scene_node.target;
  }

  return infil;
}

function printdata(infil, subtype, originalsubtype) {
  org = infil.scene_node.origin;
  ang = infil.scene_node.angles;

  while(true) {
    print3d(org, "<dev string:x1c>" + subtype + "<dev string:x27>" + originalsubtype + "<dev string:x2d>", (1, 1, 1), 1, 2);

    thread scripts\cp_mp\utility\debug_utility::drawangles(org, ang, level.framedurationseconds, 1);
    waitframe();
  }
}

function function_fbecfca322b890c(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["mbravo_infil" + subtype + "_intro"]);
  animlength += getanimlength(level.scr_anim["slot_0"]["mbravo_infil" + subtype + "_exit"]);
  return animlength;
}

function function_740ab38c4e4a258a(infil, spot_index) {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("jup_preinfil_generic", 1);
  }

  thread function_827c68636856cf78();
  thread player_infil_end(infil);
  spawnpos = infil.linktoent gettagorigin("tag_origin_animate");
  spawnang = infil.linktoent gettagangles("tag_origin_animate");
  thread infil_player_rig_updated("slot_" + spot_index, spawnpos, spawnang);
  self.player_rig linkTo(infil.linktoent, "tag_origin_animate", (0, 0, 0), (0, 0, 0));

  if(self islinked()) {
    if(spot_index < 4) {
      self lerpfovbypreset("80_instant");
    }
  }

  self lerpfovscalefactor(0, 0);

  if(isDefined(level.var_d00d30707bc41296)) {
    self.currentvisionset = level.var_d00d30707bc41296;
  } else {
    self.currentvisionset = "mp_core_infil";
  }

  self visionsetnakedforplayer(self.currentvisionset);
  self.manualoverridewindmaterial = 1;
  self setscriptablepartstate("wind", "100", 0);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  thread player_van_disconnect();
  thread cinematiccameratimeline(infil);
  gameflagwait("infil_started");

  if(scripts\cp_mp\utility\game_utility::function_d2d2b803a7b741a4()) {
    self nightvisionviewon();
  }

  println("<dev string:x32>" + self.name + "<dev string:x6a>" + self.animname + "<dev string:x7a>" + isDefined(self.player_rig));

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("jup_infil_generic");
  }

  thread scripts\mp\music_and_dialog::function_3aa69e0e6827ce5("jup_mp_infil");

  if(isDefined(self.animname) && !isai(self)) {
    thread function_ffdf6c99de481354();
  }

  self setcinematicmotionoverride("disabled");
  thread playerthinkanim(infil, spot_index);
  level waittill("prematch_over");
  self setscriptablepartstate("wind", "0", 0);
  self.manualoverridewindmaterial = 0;
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
}

function function_ffdf6c99de481354() {
  self endon("disconnect");
  soundalias = "scn_infil_mbravo_heli_plr1";
  waittime = 11.25;

  switch (self.animname) {
    case #"hash_9f02a28a98823bce":
      soundalias = "scn_infil_mbravo_heli_plr1";
      waittime = 11.25;
      break;
    case #"hash_9f02a38a98823d61":
      soundalias = "scn_infil_mbravo_heli_plr2";
      waittime = 11.7;
      break;
    case #"hash_9f02a08a988238a8":
      soundalias = "scn_infil_mbravo_heli_plr3";
      waittime = 11.9;
      break;
    case #"hash_9f02a18a98823a3b":
      soundalias = "scn_infil_mbravo_heli_plr4";
      waittime = 11.3;
      break;
    case #"hash_9f02a68a9882421a":
      soundalias = "scn_infil_mbravo_heli_plr5";
      waittime = 11.7;
      break;
    case #"hash_9f02a78a988243ad":
      soundalias = "scn_infil_mbravo_heli_plr6";
      waittime = 11.7;
      break;
    default:
      soundalias = "scn_infil_mbravo_heli_plr1";
      waittime = 11.25;
      break;
  }

  self setclienttriggeraudiozone("jup_infil_generic", 2);
  self playlocalsound("scn_infil_mbravo_heli_wind");
  wait waittime;

  if(isDefined(self) && soundexists(soundalias)) {
    self playlocalsound(soundalias);
  }
}

function playerthinkanim(infil, spot_index) {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  scene_name = infil.subtype;

  if(getDvar(@ "g_mapname") == "mp_downtown_gw") {
    if(self.team == "allies" && (infil.originalsubtype == "alpha1" || infil.originalsubtype == "alpha2")) {
      scene_name = "bravo";
    }

    if(self.team == "axis" && infil.originalsubtype == "bravo") {
      scene_name = "alpha";
    }
  }

  println("<dev string:x85>" + self.name + "<dev string:x6a>" + self.animname + "<dev string:x7a>" + isDefined(self.player_rig));

  if(self islinked()) {
    if(spot_index == 0 || spot_index == 2 || spot_index == 4) {
      self lerpviewangleclamp(1, 0.25, 0.25, 15, 45, 45, 25);
    } else {
      self lerpviewangleclamp(1, 0.25, 0.25, 45, 15, 45, 25);
    }
  }

  thread scripts\mp\infilexfil\infilexfil::function_d41cba513a03d958(7);
  infil.linktoent anim_player_solo(self, self.player_rig, "mbravo_infil" + infil.originalsubtype + "_intro", "tag_origin_animate");
  println("<dev string:xc5>" + self.name + "<dev string:x6a>" + self.animname + "<dev string:x7a>" + isDefined(self.player_rig));
  self lerpfovscalefactor(1, 2);
  self.player_rig unlink();
  infil anim_player_solo(self, self.player_rig, "mbravo_infil" + infil.originalsubtype + "_exit");
  thread scripts\mp\class::unblockclasschange();
  thread scriptswitchweaponhack();
  thread clear_infil_ambient_zone();
  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
}

function scriptswitchweaponhack() {
  waitframe();
  self notify("complete_late_infil_allows");
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

function scn_infil_mbravo_heli_npc1(guy) {
  if(!isDefined(guy.var_8655d6f4c9340db1)) {
    guy playsoundonmovingent("scn_infil_mbravo_heli_npc1");
  }

  guy.var_8655d6f4c9340db1 = 1;
}

function scn_infil_mbravo_heli_npc2(guy) {
  if(!isDefined(guy.var_8655d6f4c9340db1)) {
    guy playsoundonmovingent("scn_infil_mbravo_heli_npc2");
  }

  guy.var_8655d6f4c9340db1 = 1;
}

function scn_infil_mbravo_heli_npc3(guy) {
  if(!isDefined(guy.var_8655d6f4c9340db1)) {
    guy playsoundonmovingent("scn_infil_mbravo_heli_npc3");
  }

  guy.var_8655d6f4c9340db1 = 1;
}

function scn_infil_mbravo_heli_npc4(guy) {
  if(!isDefined(guy.var_8655d6f4c9340db1)) {
    guy playsoundonmovingent("scn_infil_mbravo_heli_npc4");
  }

  guy.var_8655d6f4c9340db1 = 1;
}

function scn_infil_mbravo_heli_npc5(guy) {
  if(!isDefined(guy.var_8655d6f4c9340db1)) {
    guy playsoundonmovingent("scn_infil_mbravo_heli_npc5");
  }

  guy.var_8655d6f4c9340db1 = 1;
}

function scn_infil_mbravo_heli_npc6(guy) {
  if(!isDefined(guy.var_8655d6f4c9340db1)) {
    guy playsoundonmovingent("scn_infil_mbravo_heli_npc6");
  }

  guy.var_8655d6f4c9340db1 = 1;
}

function function_827c68636856cf78() {
  if(!flag("infil_started")) {
    if(isPlayer(self)) {
      radio_sfx = spawn("script_origin", (0, 0, 0));
      radio_sfx showonlytoplayer(self);
      var_9742aa030e46f6c0 = spawn("script_origin", (0, 0, 0));
      var_9742aa030e46f6c0 showonlytoplayer(self);
      radio_sfx playLoopSound("dx_mpo_ukop_radio_chatter");
      var_9742aa030e46f6c0 playLoopSound("amb_infil_mbravo_heli");
      function_7330aa81e1f66e19("infil_started", "death_or_disconnect");
      wait 2;
      radio_sfx stoploopsound("dx_mpo_ukop_radio_chatter");
      var_9742aa030e46f6c0 stoploopsound("amb_infil_mbravo_heli");
      radio_sfx delete();
      var_9742aa030e46f6c0 delete();
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

function player_infil_end(infil) {
  self endon("disconnect");
  waittill_any_ents(level, "prematch_over", infil, "prematch_over");
  self notify("remove_rig");
  self clearclienttriggeraudiozone(1);
  self lerpfovbypreset("default_2seconds");
  scripts\mp\utility\player::setdof_default();
}

function player_van_disconnect() {
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
  self notify("start_scene");
  waittill_any_ents(level, "prematch_over", self, "prematch_over");
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
  thread vehiclethinkanim(team, scene_node, scene_name, extra_crew);
  thread heli_interior_sfx(scene_name);
  level waittill("prematch_over");
  wait 3;

  if(!isDefined(self) || !isDefined(self.linktoent)) {
    return;
  }

  self.linktoent solid();
}

function vehiclethinkanim(team, scene_node, scene_name, extra_crew) {
  if(self.originalsubtype != self.subtype && getDvar(@ "g_mapname") == "mp_downtown_gw") {
    scene_name = self.originalsubtype;
  }

  if(team == "allies" && (self.originalsubtype == "alpha" || self.originalsubtype == "alpha2") && getDvar(@ "mapname") == "mp_boneyard_gw") {
    scene_name = self.originalsubtype;
  }

  anim_first_frame_solo(self.linktoent, "mbravo_infil" + scene_name);
  gameflagwait("infil_started");
  self.linktoent vehicle_turnengineoff();
  self.linktoent setscriptablepartstate("engine", "on", 0);
  self.linktoent setscriptablepartstate("infil_lights", "on", 0);
  thread anim_single_solo(self.linktoent, "mbravo_infil" + scene_name);

  if(isDefined(self.path)) {
    duration = getanimlength(level.scr_anim["slot_0"]["mbravo_infil" + scene_name + "_intro"]);
    wait duration;
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
    duration = getanimlength(level.scr_anim[self.linktoent.animname]["mbravo_infil" + scene_name]);
    wait duration;
  }

  if(isDefined(self.linktoent)) {
    self.linktoent delete();
    self.linktoent = undefined;
  }
}

function spawninfilvehicle(scene_node, team, scene_name) {
  spawnpos = scene_node.origin;
  spawnang = scene_node.angles;

  if(team == "allies") {
    model = "veh9_mil_air_heli_medium_personnel";
  } else {
    model = "veh9_mil_air_heli_medium_personnel";
  }

  setdevdvarifuninitialized(@ "hash_8d5aa772209c7806", 1);

  var_ab5cd311f5dc80a6 = "veh9_mil_air_heli_medium_mp";
  var_e29c89ae4c29e698 = getdvarint(@ "hash_8d5aa772209c7806", 0);

  if(var_e29c89ae4c29e698 > 0) {
    var_ab5cd311f5dc80a6 = "veh9_mil_air_heli_medium_physics_mp";
  }

  vehicle = spawnVehicle(model, scene_name, var_ab5cd311f5dc80a6, spawnpos, spawnang);
  vehicle setvehicleteam(team);
  vehicle.animname = "mbravo";
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
  vehicle.infil = self;
  vehicle vehicle_turnengineoff();
  return vehicle;
}

function actorthink(team, scene_node, scene_name, extra_crew) {
  self.actors = thread spawnactors(team, scene_name, extra_crew);
  self.actors[0].anim_playsound_func = &commander_play_sound_func;
  self.linktoent anim_first_frame(self.actors, "mbravo_infil" + scene_name, "tag_origin_animate");
  hideactors();
  gameflagwait("infil_started");
  showactors();
  actorthinkanim(team, scene_node, scene_name, extra_crew);
}

function actorthinkanim(team, scene_node, scene_name, extra_crew) {
  self.linktoent thread anim_single(self.actors, "mbravo_infil" + scene_name, "tag_origin_animate");
  duration = getanimlength(level.scr_anim["pilot"]["mbravo_infil" + scene_name]);
  wait duration;

  foreach(actor in self.actors) {
    if(isDefined(actor)) {
      actor delete();
    }
  }

  self.actors = undefined;
}

function spawnactors(team, scene_name, extra_crew) {
  actors = [];

  switch (team) {
    case #"hash_7c2d091e6337bf54":
      actors[actors.size] = self.linktoent spawn_anim_model("pilot", "tag_origin_animate", "body_russian_helicopter_pilot", "head_russian_helicopter_pilot_opaque");
      actors[actors.size] = self.linktoent spawn_anim_model("copilot", "tag_origin_animate", "body_russian_helicopter_pilot", "head_mp_helicopter_crew");
      break;
    case #"hash_5f54b9bf7583687f":
      actors[actors.size] = self.linktoent spawn_anim_model("pilot", "tag_origin_animate", "body_pilot_helicopter_british", "head_pilot_helicopter_british");
      actors[actors.size] = self.linktoent spawn_anim_model("copilot", "tag_origin_animate", "body_pilot_helicopter_british", "head_mp_helicopter_crew");
      break;
    default:
      actors[actors.size] = self.linktoent spawn_anim_model("pilot", "tag_origin_animate", "body_russian_helicopter_pilot", "head_russian_helicopter_pilot_opaque");
      actors[actors.size] = self.linktoent spawn_anim_model("copilot", "tag_origin_animate", "body_russian_helicopter_pilot", "head_mp_helicopter_crew");
      break;
  }

  foreach(actor in actors) {
    actor.infil = self;
  }

  return actors;
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

  return guy;
}

function initanims(subtype, team, originalsubtype) {
  if(issubstr(originalsubtype, "alt")) {
    function_adea51195e19842d(originalsubtype);
    function_1e9ed96027e5d5dd(subtype, team, originalsubtype);
  } else {
    function_7477f93e18524711(subtype);
    function_83d11c9ec4313021(subtype, team, originalsubtype);
  }

  addnotetrack_customfunction("slot_0", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_1", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_2", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_3", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_4", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_5", "free_look", &player_free_look);
  addnotetrack_customfunction("slot_0", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_1", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_2", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_3", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_4", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_5", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_0", "scn_infil_mbravo_heli_npc1", &scn_infil_mbravo_heli_npc1);
  addnotetrack_customfunction("slot_1", "scn_infil_mbravo_heli_npc2", &scn_infil_mbravo_heli_npc2);
  addnotetrack_customfunction("slot_2", "scn_infil_mbravo_heli_npc3", &scn_infil_mbravo_heli_npc3);
  addnotetrack_customfunction("slot_3", "scn_infil_mbravo_heli_npc4", &scn_infil_mbravo_heli_npc4);
  addnotetrack_customfunction("slot_4", "scn_infil_mbravo_heli_npc5", &scn_infil_mbravo_heli_npc5);
  addnotetrack_customfunction("slot_5", "scn_infil_mbravo_heli_npc6", &scn_infil_mbravo_heli_npc6);
}

#using_animtree("script_model");

function function_adea51195e19842d(subtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_1_intro;
  level.scr_eventanim["slot_0"]["mbravo_infil" + subtype + "_intro"] = % "hash_673ed7b85130799";
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_1_exit;
  level.scr_eventanim["slot_0"]["mbravo_infil" + subtype + "_exit"] = % "hash_1c8bcd7d2913e965";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_2_intro;
  level.scr_eventanim["slot_1"]["mbravo_infil" + subtype + "_intro"] = % "hash_673ea7b85130280";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_2_exit;
  level.scr_eventanim["slot_1"]["mbravo_infil" + subtype + "_exit"] = % "hash_1c8bca7d2913e44c";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_3_intro;
  level.scr_eventanim["slot_2"]["mbravo_infil" + subtype + "_intro"] = % "hash_673eb7b85130433";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_3_exit;
  level.scr_eventanim["slot_2"]["mbravo_infil" + subtype + "_exit"] = % "hash_1c8bcb7d2913e5ff";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_4_intro;
  level.scr_eventanim["slot_3"]["mbravo_infil" + subtype + "_intro"] = % "hash_673f07b85130cb2";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_4_exit;
  level.scr_eventanim["slot_3"]["mbravo_infil" + subtype + "_exit"] = % "hash_1c8bc87d2913e0e6";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_5_intro;
  level.scr_eventanim["slot_4"]["mbravo_infil" + subtype + "_intro"] = % "hash_673f17b85130e65";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_5_exit;
  level.scr_eventanim["slot_4"]["mbravo_infil" + subtype + "_exit"] = % "hash_1c8bc97d2913e299";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_6_intro;
  level.scr_eventanim["slot_5"]["mbravo_infil" + subtype + "_intro"] = % "hash_673ee7b8513094c";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_6_exit;
  level.scr_eventanim["slot_5"]["mbravo_infil" + subtype + "_exit"] = % "hash_1c8bc67d2913dd80";
  level.scr_animtree["pilot"] = #animtree;
  level.scr_anim["pilot"]["mbravo_infil" + subtype] = % iw9_mp_infil_mbravo_pilot;
  level.scr_animtree["copilot"] = #animtree;
  level.scr_anim["copilot"]["mbravo_infil" + subtype] = % iw9_mp_infil_mbravo_copilot;
}

function function_7477f93e18524711(subtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_1_intro;
  level.scr_eventanim["slot_0"]["mbravo_infil" + subtype + "_intro"] = % "hash_673ed7b85130799";
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_1_exit;
  level.scr_eventanim["slot_0"]["mbravo_infil" + subtype + "_exit"] = % "hash_1c8bcd7d2913e965";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_2_intro;
  level.scr_eventanim["slot_1"]["mbravo_infil" + subtype + "_intro"] = % "hash_673ea7b85130280";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_2_exit;
  level.scr_eventanim["slot_1"]["mbravo_infil" + subtype + "_exit"] = % "hash_1c8bca7d2913e44c";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_3_intro;
  level.scr_eventanim["slot_2"]["mbravo_infil" + subtype + "_intro"] = % "hash_673eb7b85130433";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_3_exit;
  level.scr_eventanim["slot_2"]["mbravo_infil" + subtype + "_exit"] = % "hash_1c8bcb7d2913e5ff";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_4_intro;
  level.scr_eventanim["slot_3"]["mbravo_infil" + subtype + "_intro"] = % "hash_673f07b85130cb2";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_4_exit;
  level.scr_eventanim["slot_3"]["mbravo_infil" + subtype + "_exit"] = % "hash_1c8bc87d2913e0e6";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_5_intro;
  level.scr_eventanim["slot_4"]["mbravo_infil" + subtype + "_intro"] = % "hash_673f17b85130e65";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_5_exit;
  level.scr_eventanim["slot_4"]["mbravo_infil" + subtype + "_exit"] = % "hash_1c8bc97d2913e299";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["mbravo_infil" + subtype + "_intro"] = % iw9_mp_infil_mbravo_seat_6_intro;
  level.scr_eventanim["slot_5"]["mbravo_infil" + subtype + "_intro"] = % "hash_673ee7b8513094c";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["mbravo_infil" + subtype + "_exit"] = % iw9_mp_infil_mbravo_seat_6_exit;
  level.scr_eventanim["slot_5"]["mbravo_infil" + subtype + "_exit"] = % "hash_1c8bc67d2913dd80";
  level.scr_animtree["pilot"] = #animtree;
  level.scr_anim["pilot"]["mbravo_infil" + subtype] = % iw9_mp_infil_mbravo_pilot;
  level.scr_animtree["copilot"] = #animtree;
  level.scr_anim["copilot"]["mbravo_infil" + subtype] = % iw9_mp_infil_mbravo_copilot;
}

#using_animtree("mp_vehicles_always_loaded");

function function_1e9ed96027e5d5dd(subtype, team, originalsubtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();
  level.scr_anim["mbravo"]["mbravo_infil" + originalsubtype] = % iw9_mp_infil_mbravo_alt_heli;
}

function function_83d11c9ec4313021(subtype, team, originalsubtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case #"hash_1373c0a36e3cab54":
      level.scr_anim["mbravo"]["mbravo_infil" + originalsubtype] = % iw9_mp_infil_mbravo_swapmeet_heli;
      break;
    case #"hash_afcbd31dbcac0848":
      level.scr_anim["mbravo"]["mbravo_infil" + originalsubtype] = % iw9_mp_infil_mbravo_luxury_heli;
      break;
    case #"hash_ae56d5b65ad78351":
      level.scr_anim["mbravo"]["mbravo_infil" + originalsubtype] = % iw9_mp_infil_mbravo_catedral_heli;
      break;
    default:
      level.scr_anim["mbravo"]["mbravo_infil" + originalsubtype] = % iw9_mp_infil_mbravo_heli;
      break;
  }
}

function commander_play_sound_func(alias, notification, var_9a0afe8ff3d2508f) {
  foreach(player in self.infil.players) {
    if(soundexists(alias)) {
      self playsoundtoplayer(alias, player);
    }
  }
}

function heli_interior_sfx(scene_name) {
  gameflagwait("infil_started");

  if(scene_name == "alpha") {
    if(soundexists("scn_infil_mbravo_heli1_lr")) {
      self.linktoent playsoundonmovingent("scn_infil_mbravo_heli1_lr");
      self.linktoent playsoundonmovingent("scn_infil_mbravo_heli1_feet");
    }
  } else if(soundexists("scn_infil_mbravo_heli2_lr")) {
    self.linktoent playsoundonmovingent("scn_infil_mbravo_heli2_lr");
    self.linktoent playsoundonmovingent("scn_infil_mbravo_heli2_feet");
  }

  level waittill("prematch_over");
}

function deleteoninfilcomplete() {
  level waittill("prematch_over");

  if(!isDefined(self)) {
    return;
  }

  if(istrue(self.isbonus) && !isai(self)) {
    self setscriptablepartstate("base", "hide");
    return;
  }

  if(isalive(self)) {
    self suicide();
  }
}

function function_5ae55d7eb7946799() {
  level waittill("prematch_over");
  wait 55;
  function_f4e0ff5cb899686d("mbravo_infil");
}

function cinematiccameratimeline(infil) {
  self endon("death_or_disconnect");
  self endon("player_free_spot");
  self endon("joined_team");
  gameflagwait("infil_started");

  switch (level.mapname) {
    case #"hash_688334408379d4fb":
    case #"hash_d32ec8c7ac2ec13b":
      wait 2.15;
      thread set_cinematicmotionomnvarovertime(0, 1, 0.75);
      wait 0.75;
      thread set_cinematicmotionomnvarovertime(1, 0, 0.75);
      break;
  }
}

function postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case #"hash_5586b38644ed9b26":
      if(scripts\mp\utility\game::getgametype() == "arm" && team == "axis" && originalsubtype == "alpha") {
        scene_node.origin += anglestoright(scene_node.angles) * 50;
        scene_node.origin = (scene_node.origin[0], scene_node.origin[1], 174);
      }

      break;
    case #"hash_3e552e81b4a21fff":
      if(team == "axis") {
        scene_node.origin -= (0, 0, 22.5);
      } else {
        scene_node.origin -= (0, 380, -25);
      }

      break;
    case #"hash_1373c0a36e3cab54":
      if(team == "axis") {
        scene_node.origin += (10, 25, 0);
      }

      break;
  }
}

function function_6158ef142e9bd640() {
  wait 27;
  self visionsetnakedforplayer("mp_core_infil_2", 3);
}