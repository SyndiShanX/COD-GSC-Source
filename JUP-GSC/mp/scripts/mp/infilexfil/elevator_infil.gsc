/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\infilexfil\elevator_infil.gsc
*******************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\class;
#using scripts\mp\flags;
#using scripts\mp\infilexfil\infilexfil;
#using scripts\mp\music_and_dialog;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;
#namespace elevator_infil;

function elevator_init(subtype) {
  function_f1aed36ab4598ea("elevator_infil");
  thread function_438c617a7d6892c8();

  setdevdvarifuninitialized(@ "hash_3dc902e1a71dd25d", 0);

  initanims(subtype);
  var_453e4fc2c649fea4 = [];
  var_453e4fc2c649fea4[0] = [0];
  var_453e4fc2c649fea4[1] = [4];
  var_453e4fc2c649fea4[2] = [1];
  var_453e4fc2c649fea4[3] = [3];
  var_453e4fc2c649fea4[4] = [2];
  var_453e4fc2c649fea4[5] = [5];
  thread infil_add("infil_elevator", subtype, 6, 4, var_453e4fc2c649fea4, &elevator_spawn, &function_84f93b207a7228ed, &function_950c2d7fd506dfe9);
}

function elevator_spawn(team, target, subtype, originalsubtype) {
  scene_node = getStruct(target, "targetname");
  infil = spawn("script_origin", scene_node.origin);

  if(!isDefined(scene_node.angles)) {
    scene_node.angles = (0, 0, 0);
  }

  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil thread infilthink(team, subtype);
  return infil;
}

function function_84f93b207a7228ed(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["elevator_infil"]);
  return animlength;
}

function function_950c2d7fd506dfe9(infil, spot_index) {
  self endon("player_free_spot");
  thread player_infil_end();

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("jup_preinfil_generic", 1);
  }

  thread infil_radio_idle(infil);
  spawnpos = infil.linktoent gettagorigin("tag_origin");
  spawnang = infil.linktoent gettagangles("tag_origin");
  thread infil_player_rig_updated("slot_" + spot_index, spawnpos, spawnang);
  self.player_rig linkTo(infil);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_van");
  self visionsetnakedforplayer("mp_core_infil_2", 0);
  self.player_rig.weapon_state_func = &handleweaponstatenotetrack;
  thread player_disconnect();
  level waittill("start_scene");

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("jup_infil_generic");
  }

  self playlocalsound("jup_infil_elevator_quad_lr");
  thread scripts\mp\music_and_dialog::function_3aa69e0e6827ce5("jup_mp_infil");
  self lerpfov(65, 0);
  self setcinematicmotionoverride("disabled");
  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  thread scripts\mp\infilexfil\infilexfil::function_d41cba513a03d958(0.1);
  thread giveinteractiveinfilweapon();
  self lerpfovscalefactor(0, 0);
  thread resetfov();
  self function_7e66e7ae96dd938(1);
  infil anim_player_solo(self, self.player_rig, "elevator_infil");
  scripts\mp\class::unblockclasschange();

  if(isDefined(level.scr_viewmodelanim[self.animname]) && isDefined(level.scr_viewmodelanim[self.animname]["elevator_infil" + "_" + infil.subtype + "_intro"])) {
    setDvar(@ "hash_7eb1641737ab83b7", 0);
  }

  thread clear_infil_ambient_zone();

  if(isDefined(self.player_rig) && self.player_rig islinked()) {
    self.player_rig unlink();
  }

  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
}

function giveinteractiveinfilweapon() {
  self endon("disconnect");
  function_f7b243e6d0b2111d();

  if(isDefined(self.currentweapon)) {
    if(isbot(self)) {
      self switchtoweaponimmediate(nullweapon());
    } else {
      _takeweapon(self.currentweapon);
    }
  }

  fakeweapon = makeweapon("jup_jp02_ar_bromeo805_mp", ["jup_bromeo805_ironsdefault", "ammo_556n", "jup_jp02_ar_bromeo805_pgrip", "iw9_selectsemi", "jup_jp02_ar_bromeo805_mag_30_556n", "jup_jp02_ar_bromeo805_stock_folding", "jup_jp02_ar_bromeo805_bar", "jup_bromeo805_rec"]);
  self.infilweapon = fakeweapon;

  if(isbot(self) || isagent(self)) {
    _giveweapon(self.infilweapon, undefined, undefined, 0);
  } else {
    _giveweapon(self.infilweapon, undefined, undefined, 1);
  }

  level waittill("infil_countdown_show");
  wait 2;
  scripts\mp\class::giveloadout(self.team, self.pers["prev_class"], 0, 1);
}

function function_f7b243e6d0b2111d() {
  self.pers["prev_class"] = self.class;
  self.pers["prev_classCache"] = self.classstruct;
  scripts\mp\class::addclassstructtocache(self.classstruct, self.class);
}

function resetfov() {
  level waittill("infil_countdown_show");
  wait 2;
  self lerpfovbypreset("default_2seconds");
  self lerpfovscalefactor(1, 2);
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
  self lerpfovscalefactor(1, 2);
  self clearclienttriggeraudiozone(1);
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
  elevator_a = function_8c5763245370329b(scene_node, team, scene_name, "elevator_a");
  elevator_b = function_8c5763245370329b(scene_node, team, scene_name, "elevator_b");
  var_26f625463d642902 = elevator_a.origin;
  var_9c5ef79964136f29 = elevator_b.origin;
  thread function_ecdf95fdeff5b706(elevator_a, elevator_b);
  level waittill("infil_started");
  elevator_a.isinfilelevator = 1;
  elevator_b.isinfilelevator = 1;
  thread anim_single_solo(elevator_a, "elevator_infil");
  thread anim_single_solo(elevator_b, "elevator_infil");
  thread function_51293c8505f2ea4e(scene_node, elevator_a, elevator_b, getanimlength(level.scr_anim["elevator_a"]["elevator_infil"]), "elevator_a", "elevator_infil");
  level waittill("prematch_over");
  playsoundatpos(var_26f625463d642902, "mp_elevator_in_use_start");
  playsoundatpos(var_9c5ef79964136f29, "mp_elevator_in_use_start");
}

function actorthink(team, scene_node, scene_name, extra_crew) {
  thread spawnactor(1, team, scene_node, "body_mp_milsim_east_iw9_1_1", "head_mp_milsim_east_iw9_1_1", "crew_1");
  thread spawnactor(2, team, scene_node, "body_mp_milsim_east_iw9_1_1", "head_mp_milsim_east_iw9_1_1", "crew_2");
  thread function_bd10d10751076106(1, team, scene_node, "prop_un_military_duffle_bag_infil", "bag_1");
  thread function_bd10d10751076106(2, team, scene_node, "prop_un_military_duffle_bag_infil", "bag_2");
}

function initanims(subtype) {
  script_model_anims(subtype);
  vehicles_anims(subtype);
  addnotetrack_customfunction("slot_0", "free_look", &player_free_look, "elevator_infil");
  addnotetrack_customfunction("slot_1", "free_look", &player_free_look, "elevator_infil");
  addnotetrack_customfunction("slot_2", "free_look", &player_free_look, "elevator_infil");
  addnotetrack_customfunction("slot_3", "free_look", &player_free_look, "elevator_infil");
  addnotetrack_customfunction("slot_4", "free_look", &player_free_look, "elevator_infil");
  addnotetrack_customfunction("slot_5", "free_look", &player_free_look, "elevator_infil");
  addnotetrack_customfunction("slot_0", "shake_on", &rumble_low, "elevator_infil");
  addnotetrack_customfunction("slot_1", "shake_on", &rumble_low, "elevator_infil");
  addnotetrack_customfunction("slot_2", "shake_on", &rumble_low, "elevator_infil");
  addnotetrack_customfunction("slot_3", "shake_on", &rumble_low, "elevator_infil");
  addnotetrack_customfunction("slot_4", "shake_on", &rumble_low, "elevator_infil");
  addnotetrack_customfunction("slot_5", "shake_on", &rumble_low, "elevator_infil");
  addnotetrack_customfunction("slot_0", "shake_running", &cam_shake_running, "elevator_infil");
  addnotetrack_customfunction("slot_1", "shake_running", &cam_shake_running, "elevator_infil");
  addnotetrack_customfunction("slot_2", "shake_running", &cam_shake_running, "elevator_infil");
  addnotetrack_customfunction("slot_3", "shake_running", &cam_shake_running, "elevator_infil");
  addnotetrack_customfunction("slot_4", "shake_running", &cam_shake_running, "elevator_infil");
  addnotetrack_customfunction("slot_5", "shake_running", &cam_shake_running, "elevator_infil");
  addnotetrack_customfunction("slot_0", "fov_63_2", &player_fov_default_1, "elevator_infil");
  addnotetrack_customfunction("slot_1", "fov_63_2", &player_fov_default_1, "elevator_infil");
  addnotetrack_customfunction("slot_2", "fov_63_2", &player_fov_default_1, "elevator_infil");
  addnotetrack_customfunction("slot_3", "fov_63_2", &player_fov_default_1, "elevator_infil");
  addnotetrack_customfunction("slot_4", "fov_63_2", &player_fov_default_1, "elevator_infil");
  addnotetrack_customfunction("slot_5", "fov_63_2", &player_fov_default_1, "elevator_infil");
}

#using_animtree("script_model");

function script_model_anims(subtype) {
  switch (subtype) {
    case #"hash_1cc79b02710cab23":
    case #"hash_6829ee5abc10c38b":
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["elevator_infil"] = % jup_mp_infil_elevator_player1;
      level.scr_viewmodelanim["slot_0"]["elevator_infil"] = "jup_mp_infil_elevator_player1_vm";
      level.scr_eventanim["slot_0"]["elevator_infil"] = % "hash_64dd94987420cf3d";
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["elevator_infil"] = % jup_mp_infil_elevator_player2;
      level.scr_viewmodelanim["slot_1"]["elevator_infil"] = "jup_mp_infil_elevator_player2_vm";
      level.scr_eventanim["slot_1"]["elevator_infil"] = % "hash_64dd91987420ca24";
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["elevator_infil"] = % jup_mp_infil_elevator_player3;
      level.scr_viewmodelanim["slot_2"]["elevator_infil"] = "jup_mp_infil_elevator_player3_vm";
      level.scr_eventanim["slot_2"]["elevator_infil"] = % "hash_64dd92987420cbd7";
      level.scr_animtree["slot_3"] = #animtree;
      level.scr_anim["slot_3"]["elevator_infil"] = % jup_mp_infil_elevator_player4;
      level.scr_viewmodelanim["slot_3"]["elevator_infil"] = "jup_mp_infil_elevator_player4_vm";
      level.scr_eventanim["slot_3"]["elevator_infil"] = % "hash_64dd8f987420c6be";
      level.scr_animtree["slot_4"] = #animtree;
      level.scr_anim["slot_4"]["elevator_infil"] = % jup_mp_infil_elevator_player5;
      level.scr_viewmodelanim["slot_4"]["elevator_infil"] = "jup_mp_infil_elevator_player5_vm";
      level.scr_eventanim["slot_4"]["elevator_infil"] = % "hash_64dd90987420c871";
      level.scr_animtree["slot_5"] = #animtree;
      level.scr_anim["slot_5"]["elevator_infil"] = % jup_mp_infil_elevator_player6;
      level.scr_viewmodelanim["slot_5"]["elevator_infil"] = "jup_mp_infil_elevator_player6_vm";
      level.scr_eventanim["slot_5"]["elevator_infil"] = % "hash_64dd8d987420c358";
      level.scr_animtree["crew_1"] = #animtree;
      level.scr_anim["crew_1"]["elevator_infil"] = % jup_mp_infil_elevator_usher1;
      level.scr_animtree["crew_1_1"] = #animtree;
      level.scr_anim["crew_1_1"]["elevator_infil"] = % jup_mp_infil_elevator_usher1_1;
      level.scr_animtree["crew_1_2"] = #animtree;
      level.scr_anim["crew_1_2"]["elevator_infil"] = % jup_mp_infil_elevator_usher1_2;
      level.scr_animtree["crew_1_close"] = #animtree;
      level.scr_anim["crew_1_close"]["elevator_infil"] = % jup_mp_infil_elevator_usher1_close;
      level.scr_animtree["crew_2"] = #animtree;
      level.scr_anim["crew_2"]["elevator_infil"] = % jup_mp_infil_elevator_usher2;
      level.scr_animtree["crew_2_1"] = #animtree;
      level.scr_anim["crew_2_1"]["elevator_infil"] = % jup_mp_infil_elevator_usher2_1;
      level.scr_animtree["crew_2_2"] = #animtree;
      level.scr_anim["crew_2_2"]["elevator_infil"] = % jup_mp_infil_elevator_usher2_2;
      level.scr_animtree["crew_2_close"] = #animtree;
      level.scr_anim["crew_2_close"]["elevator_infil"] = % jup_mp_infil_elevator_usher2_close;
      level.scr_animtree["bag_1"] = #animtree;
      level.scr_anim["bag_1"]["elevator_infil"] = % jup_mp_infil_elevator_bag1;
      level.scr_animtree["bag_1_1"] = #animtree;
      level.scr_anim["bag_1_1"]["elevator_infil"] = % jup_mp_infil_elevator_bag1_1;
      level.scr_animtree["bag_1_2"] = #animtree;
      level.scr_anim["bag_1_2"]["elevator_infil"] = % jup_mp_infil_elevator_bag1_2;
      level.scr_animtree["bag_1_close"] = #animtree;
      level.scr_anim["bag_1_close"]["elevator_infil"] = % jup_mp_infil_elevator_bag1_close;
      level.scr_animtree["bag_2"] = #animtree;
      level.scr_anim["bag_2"]["elevator_infil"] = % jup_mp_infil_elevator_bag2;
      level.scr_animtree["bag_2_1"] = #animtree;
      level.scr_anim["bag_2_1"]["elevator_infil"] = % jup_mp_infil_elevator_bag2_1;
      level.scr_animtree["bag_2_2"] = #animtree;
      level.scr_anim["bag_2_2"]["elevator_infil"] = % jup_mp_infil_elevator_bag2_2;
      level.scr_animtree["bag_2_close"] = #animtree;
      level.scr_anim["bag_2_close"]["elevator_infil"] = % jup_mp_infil_elevator_bag2_close;
      break;
  }
}

#using_animtree("mp_vehicles_always_loaded");

function vehicles_anims(subtype) {
  switch (subtype) {
    case #"hash_1cc79b02710cab23":
    case #"hash_6829ee5abc10c38b":
      level.scr_animtree["elevator_a"] = #animtree;
      level.scr_anim["elevator_a"]["elevator_infil"] = % jup_mp_infil_elevator_door1;
      level.scr_animtree["elevator_b"] = #animtree;
      level.scr_anim["elevator_b"]["elevator_infil"] = % jup_mp_infil_elevator_door2;
      break;
  }
}

function function_8c5763245370329b(scene_node, team, scene_name, anim_name) {
  spawnpos = scene_node.origin;
  spawnang = scene_node.angles;

  if(isDefined(self.path)) {
    spawnpos = self.path.origin;
    spawnang = self.path.angles;
  }

  vehicle = spawn("script_model", scene_node.origin);
  vehicle setModel("building_saba_elevator_set");
  origin_angles = vehicle gettagangles("tag_origin");
  animate_angles = vehicle gettagangles("tag_origin_animate");
  vehicle.animname = anim_name;
  self.linktoent = vehicle;
  vehicle.infil = self;
  return vehicle;
}

function spawnactor(var_850c2b49aa0be5c1, team, scene_node, model_body, model_head, animname) {
  actor = self.linktoent spawn_anim_model(animname, scene_node, model_body, model_head);
  actor.infil = self;
  level waittill("infil_started");
  anim_single_solo(actor, "elevator_infil");
  actor delete();
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

function function_bd10d10751076106(var_850c2b49aa0be5c1, team, scene_node, model, animname) {
  spawnpos = scene_node.origin;
  spawnang = scene_node.angles;
  actor = spawn("script_model", scene_node.origin);
  actor setModel(model);
  actor.animname = animname;
  actor setanimtree();
  actor.infil = self;
  level waittill("infil_started");
  anim_single_solo(actor, "elevator_infil");
  actor delete();
}

function infil_radio_idle(infil) {
  if(!flag("infil_started")) {
    if(isPlayer(self)) {
      if(!isDefined(self)) {
        return;
      }

      thread function_e629aaf4ab9ae901(3);
      var_9742aa030e46f6c0 = spawn("script_origin", (0, 0, 0));
      var_9742aa030e46f6c0 showonlytoplayer(self);
      var_9742aa030e46f6c0 playLoopSound("jup_infil_elevator_preinfil_lp");
      function_7330aa81e1f66e19("infil_started", "death_or_disconnect");
      wait 1;
      var_9742aa030e46f6c0 stoploopsound("jup_infil_elevator_preinfil_lp");
      var_9742aa030e46f6c0 delete();
    }

    return;
  }

  return;
}

function function_ecdf95fdeff5b706(elevator_a, elevator_b) {
  self endon("death_or_disconnect");
  level waittill("infil_started");
  var_726543c7240d445f = spawn("script_origin", elevator_a.origin);
  var_eff9604f32e9e852 = spawn("script_origin", elevator_b.origin);
  var_726543c7240d445f linkTo(elevator_a);
  var_eff9604f32e9e852 linkTo(elevator_b);
  var_726543c7240d445f playLoopSound("jup_infil_elevator_moving_lp");
  var_eff9604f32e9e852 playLoopSound("jup_infil_elevator_moving_lp");
  wait 8;
  earthquake(0.2, 1, elevator_a.origin, 500);
  earthquake(0.2, 1, elevator_b.origin, 500);
  var_726543c7240d445f stoploopsound("jup_infil_elevator_moving_lp");
  var_726543c7240d445f delete();
  var_eff9604f32e9e852 stoploopsound("jup_infil_elevator_moving_lp");
  var_eff9604f32e9e852 delete();
}

function function_e629aaf4ab9ae901(timer) {
  self endon("death_or_disconnect");

  while(true) {
    self playlocalsound("jup_infil_elevator_bell");
    wait timer;

    if(isDefined(level.matchcountdowntime) && level.matchcountdowntime < 15) {
      break;
    }
  }
}

function function_7330aa81e1f66e19(var_8068764aee94f2f4, playerstring) {
  assert(isDefined(var_8068764aee94f2f4));

  if(isDefined(playerstring)) {
    self endon(playerstring);
  }

  gameflagwait(var_8068764aee94f2f4);
}

function function_438c617a7d6892c8() {
  level waittill("prematch_over");
  wait 51;
  function_f4e0ff5cb899686d("elevator_infil");
}

function function_6158ef142e9bd640() {
  wait 27;
  self visionsetnakedforplayer("mp_core_infil_2", 3);
}