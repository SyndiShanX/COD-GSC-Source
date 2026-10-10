/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\infilexfil\crossing_suv_infil.gsc
***********************************************************/

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
#namespace crossing_suv_infil;

function function_ff655c7837121a1f(subtype) {
  scripts\cp_mp\utility\audio_utility::function_f1aed36ab4598ea("crossing_suv_infil");
  thread function_b2a12312c1552d1d();

  setdevdvarifuninitialized(@ "hash_3dc902e1a71dd25d", 0);

  initanims(subtype);
  var_453e4fc2c649fea4 = [];
  var_453e4fc2c649fea4[0] = [2, 3];
  var_453e4fc2c649fea4[1] = [4, 5];
  var_453e4fc2c649fea4[2] = [0, 1];
  thread infil_add("infil_crossing_suv", subtype, 6, 4, var_453e4fc2c649fea4, &function_ddeb4e917bc30f7c, &function_b9ca07c05877b268, &function_4ff143ea37fffb46);
}

function function_ddeb4e917bc30f7c(team, target, subtype, originalsubtype) {
  scene_node = getStruct(target, "targetname");
  infil = spawn("script_origin", scene_node.origin);
  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil thread infilthink(team, subtype);
  return infil;
}

function function_b9ca07c05877b268(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["crossing_suv_infil"]);
  return animlength;
}

function function_4ff143ea37fffb46(infil, spot_index) {
  self endon("player_free_spot");

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("jup_preinfil_generic", 1);
  }

  thread infil_radio_idle(infil);
  thread player_infil_end();
  linktoent = ter_op(spot_index >= 3, infil.car2, infil.car1);
  spawnpos = linktoent gettagorigin("tag_origin_animate");
  spawnang = linktoent gettagangles("tag_origin_animate");
  thread infil_player_rig_updated("slot_" + spot_index, spawnpos, spawnang);
  self.player_rig linkTo(linktoent, "tag_origin_animate");
  self visionsetnakedforplayer("mp_core_infil", 0);
  self.player_rig.weapon_state_func = &handleweaponstatenotetrack;
  thread player_disconnect();
  level waittill("start_scene");

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("jup_infil_generic");
  }

  self setcinematicmotionoverride("disabled");
  thread scripts\mp\music_and_dialog::function_3aa69e0e6827ce5("jup_mp_infil");
  self lerpfov(65, 0);
  self playlocalsound("crossing_suv_lr");
  self lerpfovscalefactor(0, 0);
  thread scripts\mp\infilexfil\infilexfil::function_d41cba513a03d958(1);
  thread resetfov();
  linktoent anim_player_solo(self, self.player_rig, "crossing_suv_infil", "tag_origin_animate");
  thread scripts\mp\class::unblockclasschange();

  if(isDefined(level.scr_viewmodelanim[self.animname]) && isDefined(level.scr_viewmodelanim[self.animname]["crossing_suv_infil" + "_" + infil.subtype + "_intro"])) {
    setDvar(@ "hash_7eb1641737ab83b7", 0);
  }

  self lerpviewangleclamp(1, 0.25, 0.25, 30, 30, 30, 5);
  thread clear_infil_ambient_zone();
  self lerpfovscalefactor(1, 0.75);

  if(isDefined(self.player_rig) && self.player_rig islinked()) {
    self.player_rig unlink();
  }

  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
}

function resetfov() {
  level waittill("infil_countdown_show");
  wait 2;

  if(isDefined(self)) {
    self lerpfovbypreset("default_2seconds");
    self lerpfovscalefactor(1, 2);
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
  self lerpfovbypreset("default_2seconds");
  scripts\mp\utility\player::setdof_default();
  setDvar(@ "hash_7eb1641737ab83b7", 0);
  self clearclienttriggeraudiozone(1);
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
  car1 = function_ea3e584a9e826a0d(scene_node, team, scene_name, "fbi::veh9_civ_lnd_suv_2020", "crossing_suv_front", "veh9_suv_1996_physics_mp");
  car2 = function_ea3e584a9e826a0d(scene_node, team, scene_name, "fbi::veh9_civ_lnd_suv_2020", "crossing_suv_back", "veh9_suv_1996_physics_mp");
  car1 vehicle_turnengineoff();
  car2 vehicle_turnengineoff();
  self.car1 = car1;
  self.car2 = car2;
  thread function_796536b99a772738(car1, car2);
  level waittill("infil_started");
  car2 thread function_f9f9146c527fbdd2("crossing_suv_horn_01", 1);
  thread anim_single_solo(car1, "crossing_suv_infil");
  thread anim_single_solo(car2, "crossing_suv_infil");
  thread function_70a8a2aae30f4847(scene_node, car1, "crossing_suv_front", "crossing_suv_infil", "veh9_civ_lnd_suv_2020", 0);
  thread function_70a8a2aae30f4847(scene_node, car2, "crossing_suv_back", "crossing_suv_infil", "veh9_civ_lnd_suv_2020", 1);
  level waittill("prematch_over");
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
      var_9742aa030e46f6c0 playLoopSound("crossing_suv_preinfil");
      function_7330aa81e1f66e19("infil_started", "death_or_disconnect");
      wait 1;
      radio_sfx stoploopsound("dx_mpo_ukop_radio_chatter");
      var_9742aa030e46f6c0 stoploopsound("crossing_suv_preinfil");
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

function actorthink(team, scene_node, scene_name, extra_crew) {
  function_9a4c5c52093e3d42(scene_node);

  switch (scripts\cp_mp\utility\game_utility::getmapname()) {
    case #"hash_4033f158816791f7":
      break;
    default:
      thread function_d7fef246b7636b4d(scene_node, "veh9_civ_lnd_minivan_1993", "civ_vehicle_1", 0);
      thread function_d7fef246b7636b4d(scene_node, "veh9_civ_lnd_pickup_1990", "civ_vehicle_3", 1);
      thread function_d7fef246b7636b4d(scene_node, "veh9_civ_lnd_pickup_1990", "civ_vehicle_4", 2);
      thread spawnactor(scene_node, "body_civ_mexico_male_1_1", "head_sc_m_bruce", "civ_1");
      thread spawnactor(scene_node, "body_civ_mexico_female_12_1", "head_sc_f_alfar_var_1_civ", "civ_2");
      thread spawnactor(scene_node, "body_civ_mexico_female_6_1", "head_sc_f_senat", "civ_3");
      thread spawnactor(scene_node, "body_civ_mexico_male_3_1", "head_sc_m_allen_hat", "civ_4");
      thread spawnactor(scene_node, "body_civ_mexico_male_4_1", "head_sc_m_bruce", "civ_5");
      thread spawnactor(scene_node, "body_civ_mexico_male_10_1", "head_sc_m_cueto", "civ_6");
      break;
  }

  function_999ee46cd79d9633(scene_node);
}

function initanims(subtype) {
  script_model_anims(subtype);
  vehicles_anims(subtype);
  addnotetrack_customfunction("slot_0", "free_look", &player_free_look, "crossing_suv_infil");
  addnotetrack_customfunction("slot_1", "free_look", &player_free_look, "crossing_suv_infil");
  addnotetrack_customfunction("slot_2", "free_look", &player_free_look, "crossing_suv_infil");
  addnotetrack_customfunction("slot_3", "free_look", &player_free_look, "crossing_suv_infil");
  addnotetrack_customfunction("slot_4", "free_look", &player_free_look, "crossing_suv_infil");
  addnotetrack_customfunction("slot_5", "free_look", &player_free_look, "crossing_suv_infil");
  addnotetrack_customfunction("slot_0", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_1", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_2", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_3", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_4", "fov_63_2", &player_fov_default_2);
  addnotetrack_customfunction("slot_5", "fov_63_2", &player_fov_default_2);
}

#using_animtree("script_model");

function script_model_anims(subtype) {
  switch (subtype) {
    case #"hash_1cc79b02710cab23":
    case #"hash_6829ee5abc10c38b":
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["crossing_suv_infil"] = % iw9_mp_infil_suv_seat_0;
      level.scr_eventanim["slot_0"]["crossing_suv_infil"] = % "hash_43b006b19688cd83";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["crossing_suv_infil"] = % iw9_mp_infil_suv_seat_1;
      level.scr_eventanim["slot_1"]["crossing_suv_infil"] = % "hash_43b005b19688cbd0";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["crossing_suv_infil"] = % iw9_mp_infil_suv_seat_2;
      level.scr_eventanim["slot_2"]["crossing_suv_infil"] = % "hash_43b008b19688d0e9";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["crossing_suv_infil"] = % iw9_mp_infil_suv_seat_3;
      level.scr_eventanim["slot_3"]["crossing_suv_infil"] = % "hash_43b007b19688cf36";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["crossing_suv_infil"] = % iw9_mp_infil_suv_seat_4;
      level.scr_eventanim["slot_4"]["crossing_suv_infil"] = % "hash_43b00ab19688d44f";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["crossing_suv_infil"] = % iw9_mp_infil_suv_seat_5;
      level.scr_eventanim["slot_5"]["crossing_suv_infil"] = % "hash_43b009b19688d29c";
      level.scr_animtree["civ_1"] = #animtree;
      level.scr_anim["civ_1"]["crossing_suv_infil"] = % iw9_mp_infil_suv_civilian_1_crossing;
      level.scr_eventanim["civ_1"]["crossing_suv_infil"] = % "hash_2df9ec396db7f741";
      level.scr_animtree["civ_2"] = #animtree;
      level.scr_anim["civ_2"]["crossing_suv_infil"] = % iw9_mp_infil_suv_civilian_2_crossing;
      level.scr_eventanim["civ_2"]["crossing_suv_infil"] = % "hash_2df9e9396db7f228";
      level.scr_animtree["civ_3"] = #animtree;
      level.scr_anim["civ_3"]["crossing_suv_infil"] = % iw9_mp_infil_suv_civilian_3_crossing;
      level.scr_eventanim["civ_3"]["crossing_suv_infil"] = % "hash_2df9ea396db7f3db";
      level.scr_animtree["civ_4"] = #animtree;
      level.scr_anim["civ_4"]["crossing_suv_infil"] = % iw9_mp_infil_suv_civilian_4_crossing;
      level.scr_eventanim["civ_4"]["crossing_suv_infil"] = % "hash_2df9ef396db7fc5a";
      level.scr_animtree["civ_5"] = #animtree;
      level.scr_anim["civ_5"]["crossing_suv_infil"] = % iw9_mp_infil_suv_civilian_5_crossing;
      level.scr_eventanim["civ_5"]["crossing_suv_infil"] = % "hash_2df9f0396db7fe0d";
      level.scr_animtree["civ_6"] = #animtree;
      level.scr_anim["civ_6"]["crossing_suv_infil"] = % iw9_mp_infil_suv_civilian_6_crossing;
      level.scr_eventanim["civ_6"]["crossing_suv_infil"] = % "hash_2df9ed396db7f8f4";
      level.scr_animtree["civ_vehicle_1"] = #animtree;
      level.scr_anim["civ_vehicle_1"]["crossing_suv_infil"] = % iw9_mp_infil_suv_civilian_car01_crossing;
      level.scr_animtree["civ_vehicle_2"] = #animtree;
      level.scr_anim["civ_vehicle_2"]["crossing_suv_infil"] = % iw9_mp_infil_suv_civilian_car02_crossing;
      level.scr_animtree["civ_vehicle_3"] = #animtree;
      level.scr_anim["civ_vehicle_3"]["crossing_suv_infil"] = % iw9_mp_infil_suv_civilian_car03_crossing;
      level.scr_animtree["civ_vehicle_4"] = #animtree;
      level.scr_anim["civ_vehicle_4"]["crossing_suv_infil"] = % iw9_mp_infil_suv_civilian_car04_crossing;
      break;
  }
}

#using_animtree("mp_vehicles_always_loaded");

function vehicles_anims(subtype) {
  switch (subtype) {
    case #"hash_1cc79b02710cab23":
    case #"hash_6829ee5abc10c38b":
      level.scr_animtree["crossing_suv_front"] = #animtree;
      level.scr_anim["crossing_suv_front"]["crossing_suv_infil"] = % iw9_mp_infil_suv_vehicule_front_crossing;
      level.scr_animtree["crossing_suv_back"] = #animtree;
      level.scr_anim["crossing_suv_back"]["crossing_suv_infil"] = % iw9_mp_infil_suv_vehicule_back_crossing;
      break;
  }
}

function function_ea3e584a9e826a0d(scene_node, team, scene_name, model, animname, vehicle) {
  spawnpos = scene_node.origin;
  spawnang = scene_node.angles;

  if(isDefined(self.path)) {
    spawnpos = self.path.origin;
    spawnang = self.path.angles;
  }

  vehicle = spawnVehicle(model, animname, vehicle, spawnpos, spawnang);
  vehicle setvehicleteam(team);
  vehicle vehphys_forcekeyframedmotion();
  vehicle vehicleshowonminimap(0);
  vehicle.animname = animname;
  self.linktoent = vehicle;
  vehicle.infil = self;
  return vehicle;
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
  return guy;
}

function spawnactor(scene_node, model_body, model_head, animname) {
  actor = self.linktoent spawn_anim_model(animname, scene_node, model_body, model_head);
  actor.infil = self;
  level waittill("infil_started");

  if(isDefined(actor.head)) {
    actor.head scriptmodelplayanim(level.scr_anim[actor.animname]["crossing_suv_infil"]);
  }

  anim_single_solo(actor, "crossing_suv_infil");
  actor delete();
}

function function_d7fef246b7636b4d(scene_node, model, animname, number) {
  spawnpos = scene_node.origin;
  spawnang = scene_node.angles;
  actor = spawn("script_model", scene_node.origin);
  actor setModel(model);
  actor.animname = animname;
  actor setanimtree();
  actor.infil = self;
  level waittill("infil_started");

  if(animname == "civ_vehicle_2") {
    actor function_f9f9146c527fbdd2("crossing_suv_horn_02", 5);
  }

  thread anim_single_solo(actor, "crossing_suv_infil");
  level waittill("prematch_over");
  actor delete();
}

function function_70a8a2aae30f4847(scene_node, vehicle, animname, infil_type, vehiclename, number) {
  var_1f8ecc46988ca358 = 0;
  var_2280df582dd843c = getEntArray(scene_node.target, "targetname");
  temporigin = scene_node.origin;
  tempangle = scene_node.angles;
  destructibleversion = undefined;

  if(!isDefined(var_2280df582dd843c)) {
    iprintlnbold("<dev string:x1c>");

    return;
  }

  for(i = 0; i < var_2280df582dd843c.size; i++) {
    if(isDefined(var_2280df582dd843c[i])) {
      if(var_2280df582dd843c[i].script_noteworthy == vehiclename) {
        if(number == 0) {
          destructibleversion = var_2280df582dd843c[i];
          var_1f8ecc46988ca358 = 1;
          break;
        }

        number--;
      }
    }
  }

  if(!isDefined(destructibleversion) || var_1f8ecc46988ca358 == 0) {
    iprintlnbold("<dev string:x3d>" + vehiclename);

    return;
  }

  waittime = getanimlength(level.scr_anim[animname][infil_type]);
  destructibleversion.canmove = 1;
  destructibleversion setscriptablepartstate("visibility", "hide");
  level waittill("prematch_over");
  vehicle delete();
  destructibleversion setscriptablepartstate("visibility", "show");
}

function function_9a4c5c52093e3d42(scene_node) {
  var_2280df582dd843c = getEntArray(scene_node.target, "targetname");
  destructibleversion = undefined;
  temporigin = scene_node.origin;
  tempangle = scene_node.angles;

  for(i = 0; i < var_2280df582dd843c.size; i++) {
    if(isDefined(var_2280df582dd843c[i])) {
      if(var_2280df582dd843c[i].script_noteworthy == "veh9_civ_lnd_pickup_1990_middle") {
        destructibleversion = var_2280df582dd843c[i];
        destructibleversion setscriptablepartstate("visibility", "show");
        break;
      }

      destructibleversion = var_2280df582dd843c[i];
      destructibleversion setscriptablepartstate("visibility", "hide");
    }
  }
}

function function_999ee46cd79d9633(scene_node) {
  var_2280df582dd843c = getEntArray(scene_node.target, "targetname");
  destructibleversion = undefined;
  temporigin = scene_node.origin;
  tempangle = scene_node.angles;
  level waittill("prematch_over");

  for(i = 0; i < var_2280df582dd843c.size; i++) {
    if(isDefined(var_2280df582dd843c[i])) {
      if(var_2280df582dd843c[i].script_noteworthy == "veh9_civ_lnd_pickup_1990_middle") {
        break;
      }

      destructibleversion = var_2280df582dd843c[i];
      destructibleversion setscriptablepartstate("visibility", "show");
    }
  }
}

function function_a2938e8d1926687d(var_c3dbf88a21ae118b) {
  wait 23.72;
  var_c3dbf88a21ae118b setscriptablepartstate("visibility", "hide");
  level waittill("prematch_over");
  var_c3dbf88a21ae118b setscriptablepartstate("visibility", "show");
}

function function_b2a12312c1552d1d() {
  level waittill("prematch_over");
  wait 51;
  scripts\cp_mp\utility\audio_utility::function_f4e0ff5cb899686d("crossing_suv_infil");
}

function function_f9f9146c527fbdd2(alias, delay) {
  wait delay;
  self playsoundonmovingent(alias);
}

function function_6158ef142e9bd640() {
  wait 27;
  self visionsetnakedforplayer("mp_core_infil_2", 3);
}

function function_796536b99a772738(car1, car2) {
  var_60e225c44aa37548 = spawn("script_model", car1.origin);
  var_60e228c44aa37be1 = spawn("script_model", car2.origin);
  level waittill("infil_started");
  waitframe();
  var_60e225c44aa37548 linkTo(car1, "tag_origin", (100, 0, 25), (0, 0, 0));
  var_60e228c44aa37be1 linkTo(car2, "tag_origin", (100, 0, 25), (0, 0, 0));
  var_60e225c44aa37548 playsoundonmovingent("crossing_suv_engine_front");
  var_60e228c44aa37be1 playsoundonmovingent("crossing_suv_engine_back");
  level waittill("prematch_over");
  var_60e225c44aa37548 delete();
  var_60e228c44aa37be1 delete();
}