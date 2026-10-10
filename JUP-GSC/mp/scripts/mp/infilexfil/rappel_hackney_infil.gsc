/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\infilexfil\rappel_hackney_infil.gsc
*************************************************************/

#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_common;
#using scripts\mp\anim;
#using scripts\mp\flags;
#using scripts\mp\infilexfil\infilexfil;
#using scripts\mp\killstreaks\jackal;
#using scripts\mp\mp_agent;
#using scripts\mp\music_and_dialog;
#using scripts\mp\utility\infilexfil;
#using scripts\mp\utility\inventory;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\player;
#using scripts\mp\utility\script;
#using scripts\mp\utility\weapon;
#namespace rappel_hackney_infil;

function rappel_hackney_init(subtype) {
  setdevdvarifuninitialized(@ "hash_3dc902e1a71dd25d", 0);

  initanims(subtype);
  var_453e4fc2c649fea4 = [];
  var_453e4fc2c649fea4[0] = [0, 1];
  var_453e4fc2c649fea4[1] = [2];
  thread infil_add("infil_rappel_hackney", subtype, 3, 2, var_453e4fc2c649fea4, &rappel_hackney_spawn, &rappel_hackney_get_length, &player_rappel_hackney_infil_think);
}

function rappel_hackney_spawn(team, target, subtype, originalsubtype) {
  scene_node = getStruct(target, "targetname");
  infil = spawn("script_origin", scene_node.origin);
  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil thread infilthink(team, subtype);

  if(getdvarint(@ "hash_d7d1a955f81e3693", 0) == 1 && subtype == "<dev string:x1c>") {
    thread dummychopper();
  }

  return infil;
}

function rappel_hackney_get_length(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["rappel_hackney_infil_" + subtype]);
  return animlength;
}

function player_rappel_hackney_infil_think(infil, spot_index) {
  self endon("player_free_spot");

  if(isPlayer(self)) {
    self setclienttriggeraudiozone("hackney_infil_heli_intro", 1);
  }

  applymapvisionset();
  thread player_infil_end();
  thread heli_infil_radio_idle();
  spawnpos = infil.linktoent gettagorigin("origin_animate_jnt");
  spawnang = infil.linktoent gettagangles("origin_animate_jnt");
  thread infil_player_rig_updated("slot_" + spot_index, spawnpos, spawnang);
  self.player_rig linkTo(infil.linktoent, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  infil.linktoent anim_first_frame_solo(self.player_rig, "rappel_hackney_infil_" + infil.subtype);
  thread player_rappel_disconnect();
  self.manualoverridewindmaterial = 1;
  self setscriptablepartstate("wind", "100", 0);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  gameflagwait("infil_started");
  self lerpfovscalefactor(0, 0);

  if(spot_index == 0) {
    self lerpfovbypreset("80_instant");
  }

  thread scripts\mp\music_and_dialog::function_3aa69e0e6827ce5();

  if(isDefined(self.animname) && isPlayer(self)) {
    soundalias = "scn_infil_hackney_heli_plr1";

    if(isDefined(infil.subtype)) {
      if(infil.subtype == "alpha") {
        switch (self.animname) {
          case #"hash_9f02a28a98823bce":
            soundalias = "scn_infil_hackney_heli_plr1";
            break;
          case #"hash_9f02a38a98823d61":
            soundalias = "scn_infil_hackney_heli_plr2";
            break;
          case #"hash_9f02a08a988238a8":
            soundalias = "scn_infil_hackney_heli_plr3";
            break;
          default:
            soundalias = "scn_infil_hackney_heli_plr1";
            break;
        }
      } else {
        switch (self.animname) {
          case #"hash_9f02a28a98823bce":
            soundalias = "scn_infil_hackney_heli_plr4";
            break;
          case #"hash_9f02a38a98823d61":
            soundalias = "scn_infil_hackney_heli_plr5";
            break;
          case #"hash_9f02a08a988238a8":
            soundalias = "scn_infil_hackney_heli_plr6";
            break;
          default:
            soundalias = "scn_infil_hackney_heli_plr4";
            break;
        }
      }
    }

    self setclienttriggeraudiozone("hackney_infil_heli", 2);
    self playlocalsound(soundalias);
  }

  self setcinematicmotionoverride("disabled");
  thread player_normal_think(infil);
}

function player_normal_think(infil) {
  self endon("player_free_spot");
  self lerpviewangleclamp(1, 0.25, 0.25, 30, 30, 30, 10);
  infil.linktoent anim_player_solo(self, self.player_rig, "rappel_hackney_infil_" + infil.subtype);

  if(isDefined(self.player_rig) && self.player_rig islinked()) {
    self.player_rig unlink();
  }

  if(self isnightvisionon()) {
    self visionsetnakedforplayer("", 0.75);
  }

  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
  self setscriptablepartstate("wind", "0", 0);
  self.manualoverridewindmaterial = 0;
}

function clear_infil_ambient_zone() {
  self endon("death_or_disconnect");
  wait 1;

  if(isDefined(self.submix)) {
    self clearsoundsubmix(self.submix, 2);
  }

  self clearclienttriggeraudiozone(2);
}

function heli_infil_radio_idle() {
  if(isPlayer(self)) {
    radio_sfx = spawn("script_origin", (0, 0, 0));
    radio_sfx showonlytoplayer(self);
    radio_sfx playLoopSound("dx_mpo_ukop_radio_chatter");
    gameflagwait("infil_started");
    wait 2;
    radio_sfx stoploopsound("dx_mpo_ukop_radio_chatter");
    radio_sfx delete();
  }
}

function player_interactive_think(infil) {
  self endon("player_free_spot");
  self.player_rig linkTo(infil.linktoent, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  self lerpviewangleclamp(1, 0.25, 0.25, 80, 80, 30, 70);
  infil anim_player_solo(self, self.player_rig, "rappel_hackney_infil_" + infil.subtype + "_interactive_intro");
  thread combat_start();
  wait 15;
  thread combat_end();

  if(!isai(self)) {
    scripts\cp_mp\utility\inventory_utility::function_fc6a5b145563be33();
  }

  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  infil.linktoent anim_player_solo(self, self.player_rig, "rappel_hackney_infil_" + infil.subtype + "_interactive_exit");

  if(isDefined(self.player_rig) && self.player_rig islinked()) {
    self.player_rig unlink();
  }

  if(self isnightvisionon()) {
    self visionsetnakedforplayer("", 0.75);
  }

  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
}

function player_infil_end() {
  self endon("disconnect");
  level waittill("prematch_over");
  self notify("remove_rig");

  if(isDefined(self.submix)) {
    self clearsoundsubmix(self.submix, 2);
  }

  self clearclienttriggeraudiozone(1);
  scripts\mp\utility\player::setdof_default();
}

function player_rappel_disconnect() {
  level endon("prematch_over");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    self visionsetnakedforplayer("");

    if(isDefined(self.submix)) {
      self clearsoundsubmix(self.submix, 2);
    }

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

  var_46959f58cbaba3ac = getcommanderassets(team);
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("commander", "origin_animate_jnt", var_46959f58cbaba3ac.body, var_46959f58cbaba3ac.head);
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("pilot", "origin_animate_jnt", "body_pilot_helicopter_british", "head_pilot_helicopter_british");
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("copilot", "origin_animate_jnt", "body_pilot_helicopter_british", "head_mp_helicopter_crew");

  foreach(actor in self.actors) {
    actor.infil = self;
  }

  gameflagwait("infil_started");
  self.actors[0].anim_playsound_func = &blima_commander_play_sound_func;
}

function infilthink(team, scene_name) {
  var_e026a614f7467557 = getdvarfloat(@ "hash_ea4c44a08cd23d5d", 0.2);

  foreach(ent in getEntArray("infil_delete", "script_noteworthy")) {
    ent delete();
  }

  thread helithink(team, self.scene_node, scene_name);
  thread actorthink(team, self.scene_node, scene_name);
  gameflagwait("infil_started");
  setDvar(@ "r_spotlightentityshadows", 1);
  setDvar(@ "hash_ea4c44a08cd23d5d", 1);

  if(level.prematchperiodend > self.infillength) {
    wait level.prematchperiodend - self.infillength;
  }

  level waittill("prematch_over");
  setDvar(@ "r_spotlightentityshadows", 0);
  setDvar(@ "hash_ea4c44a08cd23d5d", var_e026a614f7467557);
}

function helithink(team, scene_node, scene_name) {
  spawnheli(scene_node, team, scene_name);
  anim_first_frame_solo(self.linktoent, "rappel_hackney_infil_" + scene_name);
  gameflagwait("infil_started");
  self.linktoent setscriptablepartstate("engine", "on", 0);
  self.linktoent setscriptablepartstate("running_lights", "on", 0);
  self.linktoent setscriptablepartstate("infil_lights", "on", 0);
  self.var_addd3217bc59a7b8 = function_aa9c0268656debfc(scene_name);
  self.linktoent function_40ab1094757333e0(self.var_addd3217bc59a7b8);
  thread heli_normal_think(team, scene_node, scene_name);
  thread heli_interior_sfx(scene_name);
}

function heli_interior_sfx(scene_name) {
  ceiling_sfx = spawn("script_model", self.linktoent.origin);
  cockpit_sfx = spawn("script_model", self.linktoent.origin);
  cockpit_sfx linkTo(self.linktoent, "tag_light_cockpit01");
  wait 0.1;

  if(scene_name == "alpha") {
    self.linktoent playsoundonmovingent("scn_mp_hackney_heli1_lr");
    ceiling_sfx linkTo(self.linktoent, "j_tied_cable_02");
    wait 0.1;
    ceiling_sfx playsoundonmovingent("scn_infil_hackney_heli1_ceiling_rattles");
    cockpit_sfx playsoundonmovingent("scn_infil_hackney_heli1_cockpit_rattles");
  } else {
    self.linktoent playsoundonmovingent("scn_mp_hackney_heli2_lr");
    ceiling_sfx linkTo(self.linktoent, "j_ceiling_cable_02");
    wait 0.1;
    ceiling_sfx playsoundonmovingent("scn_infil_hackney_heli2_ceiling_rattles");
    cockpit_sfx playsoundonmovingent("scn_infil_hackney_heli2_cockpit_rattles");
  }

  level waittill("prematch_over");
  ceiling_sfx delete();
  cockpit_sfx delete();
}

function heli_interactive_think(team, scene_node, scene_name) {
  thread anim_single_solo(self.linktoent, "rappel_hackney_infil_" + scene_name + "_interactive");
  wait level.interactivecombatduration - 15;
  thread ropethink(scene_name);
  wait 15;
  cleanup();
}

function heli_normal_think(team, scene_node, scene_name) {
  thread ropethink(scene_name);

  if(isDefined(self.path)) {
    thread anim_single_solo(self.linktoent, "rappel_hackney_infil_" + scene_name);
    vehiclethinkpath(team, scene_node, scene_name);
  } else {
    thread anim_single_solo(self.linktoent, "rappel_hackney_infil_" + scene_name);
    duration = getanimlength(level.scr_anim[self.linktoent.animname]["rappel_hackney_infil_" + scene_name]);
    wait duration;
  }

  cleanup();
}

function ropethink(scene_name) {
  self.linktoent thread anim_single_solo(self.linktoent.rope, "rappel_hackney_infil_" + scene_name, "origin_animate_jnt");
  duration = getanimlength(level.scr_anim[self.linktoent.rope.animname]["rappel_hackney_infil_" + scene_name]);
  wait duration;
  self.linktoent.rope unlink();
  thread anim_single_solo(self.linktoent.rope, "rappel_hackney_infil_" + scene_name + "_fall");
}

function sfx_infil_hackney_heli1_rope(guy) {
  guy playsoundonmovingent("scn_infil_hackney_heli1_rope");
}

function sfx_infil_hackney_heli2_rope(guy) {
  guy playsoundonmovingent("scn_infil_hackney_heli2_rope");
}

function actorthink(team, scene_node, scene_name, extra_crew) {
  thread spawnactors(team, scene_name, extra_crew);
  actor_normal_think(team, scene_node, scene_name);
}

function actor_interactive_think(team, scene_node, scene_name) {
  self.linktoent anim_first_frame(self.actors, "rappel_hackney_infil_" + scene_name + "_interactive", "origin_animate_jnt");
  hideactors();
  level waittill("infil_started");
  showactors();
  self.linktoent thread anim_single(self.actors, "rappel_hackney_infil_" + scene_name + "_interactive", "origin_animate_jnt");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["rappel_hackney_infil_" + scene_name + "_interactive"]);
}

function actor_normal_think(team, scene_node, scene_name) {
  self.linktoent anim_first_frame(self.actors, "rappel_hackney_infil_" + scene_name, "origin_animate_jnt");
  hideactors();
  gameflagwait("infil_started");
  showactors();
  self.linktoent thread anim_single(self.actors, "rappel_hackney_infil_" + scene_name, "origin_animate_jnt");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["rappel_hackney_infil_" + scene_name]);
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

function initanims(subtype) {
  script_model_alpha_anims(subtype);
  vehicles_alpha_anims(subtype);

  if(!isDefined(level.scr_notetrack) || !isDefined(level.scr_notetrack["commander"])) {
    addnotetrack_customfunction("commander", "door_slam", &blima_door_slam);
    addnotetrack_customfunction("commander", "shake_low", &blima_cam_shake_low);
    addnotetrack_customfunction("commander", "shake_bump", &blima_cam_shake_bump);
    addnotetrack_customfunction("commander", "door_open_sfx", &heli_door_open_sfx);
    addnotetrack_customfunction("commander", "sfx_infil_hackney_heli_commander", &heli_commander_sfx);
    addnotetrack_customfunction("commander", "scn_infil_hackney_heli1_rope", &sfx_infil_hackney_heli1_rope);
    addnotetrack_customfunction("commander", "scn_infil_hackney_heli2_rope", &sfx_infil_hackney_heli2_rope);
  }

  switch (subtype) {
    case #"hash_6829ee5abc10c38b":
      addnotetrack_customfunction("slot_0", "player_lock_look_1_second", &player_lock_look_1_second, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_0", "outside_heli", &outsideheli, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_0", "rumble_rope", &blima_rumble_rope, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_0", "rumble_ground", &blima_rumble_ground, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_0", "free_look", &player_free_look, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_0", "fov_63_2", &player_fov_default_2, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_0", "equip_nvg", &player_equip_nvg, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_1", "player_lock_look_1_second", &player_lock_look_1_second, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_1", "outside_heli", &outsideheli, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_1", "rumble_rope", &blima_rumble_rope, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_1", "rumble_ground", &blima_rumble_ground, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_1", "free_look", &player_free_look, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_1", "fov_63_2", &player_fov_default_2, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_1", "equip_nvg", &player_equip_nvg, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_2", "player_lock_look_1_second", &player_lock_look_1_second, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_2", "outside_heli", &outsideheli, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_2", "rumble_rope", &blima_rumble_rope, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_2", "rumble_ground", &blima_rumble_ground, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_2", "free_look", &player_free_look, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_2", "fov_63_2", &player_fov_default_2, "rappel_hackney_infil_alpha");
      addnotetrack_customfunction("slot_2", "equip_nvg", &player_equip_nvg, "rappel_hackney_infil_alpha");
      break;
    case #"hash_1cc79b02710cab23":
      addnotetrack_customfunction("slot_0", "player_lock_look_1_second", &player_lock_look_1_second, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_0", "outside_heli", &outsideheli, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_0", "rumble_rope", &blima_rumble_rope, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_0", "rumble_ground", &blima_rumble_ground, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_0", "free_look", &player_free_look, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_0", "fov_63_2", &player_fov_default_2, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_0", "equip_nvg", &player_equip_nvg, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_1", "player_lock_look_1_second", &player_lock_look_1_second, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_1", "outside_heli", &outsideheli, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_1", "rumble_rope", &blima_rumble_rope, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_1", "rumble_ground", &blima_rumble_ground, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_1", "free_look", &player_free_look, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_1", "fov_63_2", &player_fov_default_2, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_1", "equip_nvg", &player_equip_nvg, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_2", "player_lock_look_1_second", &player_lock_look_1_second, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_2", "outside_heli", &outsideheli, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_2", "rumble_rope", &blima_rumble_rope, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_2", "rumble_ground", &blima_rumble_ground, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_2", "free_look", &player_free_look, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_2", "fov_63_2", &player_fov_default_2, "rappel_hackney_infil_bravo");
      addnotetrack_customfunction("slot_2", "equip_nvg", &player_equip_nvg, "rappel_hackney_infil_bravo");
      break;
  }
}

#using_animtree("script_model");

function script_model_alpha_anims(subtype) {
  switch (subtype) {
    case #"hash_6829ee5abc10c38b":
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["rappel_hackney_infil_alpha"] = % mp_faridah_infill_bird_a_pilot_idle;
      level.scr_anim["pilot"]["rappel_hackney_infil_alpha_interactive"] = % mp_faridah_infill_bird_a_pilot_idle;
      level.scr_animtree["copilot"] = #animtree;
      level.scr_anim["copilot"]["rappel_hackney_infil_alpha"] = % mp_faridah_infill_bird_a_copilot_idle;
      level.scr_anim["copilot"]["rappel_hackney_infil_alpha_interactive"] = % mp_faridah_infill_bird_a_copilot_idle;
      level.scr_animtree["commander"] = #animtree;
      level.scr_anim["commander"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_chief;
      level.scr_anim["commander"]["rappel_hackney_infil_alpha_interactive"] = % mp_infil_act_blima_chief;
      level.scr_animtree["rope"] = #animtree;
      level.scr_anim["rope"]["rappel_hackney_infil_alpha"] = % equipment_fast_rope_wm_01_infil_heli_l;
      level.scr_anim["rope"]["rappel_hackney_infil_alpha_fall"] = % equipment_fast_rope_wm_01_infil_heli_l_fall;
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_guy01;
      level.scr_eventanim["slot_0"]["rappel_hackney_infil_alpha"] = % "hash_52fde03f57e5b2ed";
      addnotetrack_customfunction("slot_0", "scn_infil_hackney_heli_npc1", &scn_infil_hackney_heli_npc1);
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_guy02;
      level.scr_eventanim["slot_1"]["rappel_hackney_infil_alpha"] = % "hash_52fddd3f57e5add4";
      addnotetrack_customfunction("slot_1", "scn_infil_hackney_heli_npc2", &scn_infil_hackney_heli_npc2);
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_guy03;
      level.scr_eventanim["slot_2"]["rappel_hackney_infil_alpha"] = % "hash_52fdde3f57e5af87";
      addnotetrack_customfunction("slot_2", "scn_infil_hackney_heli_npc3", &scn_infil_hackney_heli_npc3);
      break;
    case #"hash_1cc79b02710cab23":
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["rappel_hackney_infil_bravo"] = % mp_faridah_infill_bird_a_pilot_idle;
      level.scr_anim["pilot"]["rappel_hackney_infil_bravo_interactive"] = % mp_faridah_infill_bird_a_pilot_idle;
      level.scr_animtree["copilot"] = #animtree;
      level.scr_anim["copilot"]["rappel_hackney_infil_bravo"] = % mp_faridah_infill_bird_a_copilot_idle;
      level.scr_anim["copilot"]["rappel_hackney_infil_bravo_interactive"] = % mp_faridah_infill_bird_a_copilot_idle;
      level.scr_animtree["commander"] = #animtree;
      level.scr_anim["commander"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_r_chief;
      level.scr_anim["commander"]["rappel_hackney_infil_bravo_interactive"] = % mp_infil_act_blima_b_chief;
      level.scr_animtree["rope"] = #animtree;
      level.scr_anim["rope"]["rappel_hackney_infil_bravo"] = % equipment_fast_rope_wm_01_infil_heli_r;
      level.scr_anim["rope"]["rappel_hackney_infil_bravo_fall"] = % equipment_fast_rope_wm_01_infil_heli_r_fall;
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_r_guy01;
      level.scr_eventanim["slot_0"]["rappel_hackney_infil_bravo"] = % "hash_37b7330f46f053cd";
      addnotetrack_customfunction("slot_0", "scn_infil_hackney_heli_npc4", &scn_infil_hackney_heli_npc4);
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_r_guy02;
      level.scr_eventanim["slot_1"]["rappel_hackney_infil_bravo"] = % "hash_37b7300f46f04eb4";
      addnotetrack_customfunction("slot_1", "scn_infil_hackney_heli_npc5", &scn_infil_hackney_heli_npc5);
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_r_guy03;
      level.scr_eventanim["slot_2"]["rappel_hackney_infil_bravo"] = % "hash_37b7310f46f05067";
      addnotetrack_customfunction("slot_2", "scn_infil_hackney_heli_npc6", &scn_infil_hackney_heli_npc6);
      break;
  }
}

#using_animtree("mp_vehicles_always_loaded");

function vehicles_alpha_anims(subtype) {
  switch (subtype) {
    case #"hash_6829ee5abc10c38b":
      level.scr_animtree["blima"] = #animtree;

      switch (getDvar(@ "g_mapname")) {
        case #"hash_be52fbd3b8746bc":
        case #"hash_d83171ba75f8b8fe":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mpspear_alpha;
          break;
        case #"hash_66ce5cdcd3b547f3":
        case #"hash_ff009e5fab42b778":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mpcave_alpha;
          break;
        case #"hash_9c2fdccb75b37f7e":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mpcrash_alpha;
          break;
        case #"hash_d39c51733bbe5712":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mpaniyah_tactical_alpha;
          break;
        case #"hash_4de7e97cab81c8f3":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mp_oilrig_alpha;
          break;
        case #"hash_cce4bca393df84eb":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mpharbor_alpha;
          break;
        default:
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli;
          break;
      }

      level.scr_anim["blima"]["rappel_hackney_infil_alpha_interactive"] = % mp_infil_act_blima_heli;
      break;
    case #"hash_1cc79b02710cab23":
      level.scr_animtree["blima"] = #animtree;

      switch (getDvar(@ "g_mapname")) {
        case #"hash_be52fbd3b8746bc":
        case #"hash_d83171ba75f8b8fe":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mpspear_bravo;
          break;
        case #"hash_66ce5cdcd3b547f3":
        case #"hash_ff009e5fab42b778":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mpcave_bravo;
          break;
        case #"hash_9c2fdccb75b37f7e":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mpcrash_bravo;
          break;
        case #"hash_d39c51733bbe5712":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mpaniyah_tactical_bravo;
          break;
        case #"hash_4de7e97cab81c8f3":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mp_oilrig_bravo;
          break;
        case #"hash_cce4bca393df84eb":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mpharbor_bravo;
          break;
        default:
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_r_heli;
          break;
      }

      level.scr_anim["blima"]["rappel_hackney_infil_bravo_interactive"] = % mp_infil_act_blima_b_heli;
      break;
  }
}

function spawnheli(scene_node, team, scene_name) {
  vehicle = "blima_desert_day_infil_mp";

  if(level.mapname == "mp_hackney_yard") {
    vehicle = "blima_hackney_infil_mp";
  }

  blima = spawnVehicle("veh8_mil_air_blima_infils", scene_name, vehicle, scene_node.origin, scene_node.angles);
  blima setvehicleteam(team);
  blima setCanDamage(0);
  blima.animname = "blima";
  self.linktoent = blima;
  blima.infil = self;
  self.linktoent.rope = self.linktoent spawn_anim_model("rope", "origin_animate_jnt", "equipment_fast_rope_wm_01_infil_heli_l");
  self.linktoent.rope anim_first_frame_solo(self.linktoent.rope, "rappel_hackney_infil_" + scene_name);
  return blima;
}

function helifollowpath(var_ba4c16ad30a65991) {
  if(!isDefined(var_ba4c16ad30a65991)) {
    return;
  }

  currentnode = getStruct(var_ba4c16ad30a65991, "targetname");

  if(!isDefined(currentnode)) {
    return;
  }

  nextnode = getStruct(currentnode.target, "targetname");
  self.speed = 500;
  self.accel = 175;
  self.combatmode = "guard_location";
  self notify(self.combatmode);

  while(isDefined(currentnode.target)) {
    thread guardpositionescort(nextnode.origin, undefined, 800);

    while(true) {
      dist = distance(self.origin, nextnode.origin);

      if(dist < 2000) {
        break;
      }

      waitframe();
    }

    self notify("leaving");

    if(!isDefined(nextnode.target)) {
      break;
    }

    currentnode = nextnode;
    nextnode = getStruct(currentnode.target, "targetname");
  }
}

function cleanup() {
  foreach(actor in self.actors) {
    actor delete();
  }

  self.linktoent.rope delete();
  function_89a2405953b84136(self.var_addd3217bc59a7b8, 0);
  self.linktoent delete();
  level.infilsactive--;
  self delete();
}

function spawn_infil_axis_ai(lane, spawn_loc, spawn_ang, weapon_override) {
  level.gameskill = 0;
  agent = scripts\mp\mp_agent::spawnnewagent("soldier_agent", "axis", spawn_loc, spawn_ang, ter_op(isDefined(weapon_override), weapon_override, "iw8_ar_mike4_mp"));

  if(!isDefined(agent)) {
    return undefined;
  }

  agent.desiredmovetype = "combat";
  agent clearpath();
  agent.goalradius = 999;
  agent.fixednode = 0;
  agent scripts\mp\agents\agent_common::set_agent_health(50);
  return agent;
}

function spawninteractiveinfilai() {
  level thread alphaai();
  level thread bravoai();
}

function alphaai() {
  level endon("interactive_infil_complete");
  level endon("prematch_over");
  level endon("infil_done");
  level.alphaagents = [];
  var_b2c3325aa4f3fcb9 = getStructArray("ai_alpha_start", "targetname");
  var_bdc35e9715db3cda = getStructArray("ai_alpha_respawn", "targetname");

  foreach(start in var_b2c3325aa4f3fcb9) {
    agent = spawn_infil_axis_ai("alpha", start.origin, start.angles);

    if(isDefined(agent)) {
      level thread alpha_ai_array_handler(agent);
    }

    if(level.alphaagents.size == 5) {
      break;
    }
  }

  while(true) {
    if(level.alphaagents.size < 5) {
      i = randomint(var_bdc35e9715db3cda.size);

      if(randomint(100) > 75) {
        weaponoverride = "iw8_la_rpapa7_mp";
      } else {
        weaponoverride = undefined;
      }

      agent = spawn_infil_axis_ai("alpha", var_bdc35e9715db3cda[i].origin, var_bdc35e9715db3cda[i].angles, weaponoverride);

      if(isDefined(agent)) {
        level thread alpha_ai_array_handler(agent, weaponoverride);
      }
    }

    waitframe();
  }
}

function alpha_ai_array_handler(agent, var_cb5616a26c79121f) {
  level.alphaagents = array_add(level.alphaagents, agent);
  outlineid = outlineenableforteam(agent, "allies", ter_op(isDefined(var_cb5616a26c79121f), "outline_depth_red", "outline_depth_orange"), "level_script");
  agent waittill("death");
  outlinedisable(outlineid, agent);
  level.alphaagents = array_remove(level.alphaagents, agent);
}

function bravoai() {
  level endon("interactive_infil_complete");
  level endon("prematch_over");
  level endon("infil_done");
  level.bravoagents = [];
  var_177e57346abd5299 = getStructArray("ai_bravo_start", "targetname");
  var_19a57b9c0f61e73a = getStructArray("ai_bravo_respawn", "targetname");

  foreach(start in var_177e57346abd5299) {
    agent = spawn_infil_axis_ai("bravo", start.origin, start.angles);

    if(isDefined(agent)) {
      level thread bravo_ai_array_handler(agent);
    }

    if(level.bravoagents.size == 5) {
      break;
    }
  }

  while(true) {
    if(level.bravoagents.size < 5) {
      i = randomint(var_19a57b9c0f61e73a.size);

      if(randomint(100) > 75) {
        weaponoverride = "iw8_la_rpapa7_mp";
      } else {
        weaponoverride = undefined;
      }

      agent = spawn_infil_axis_ai("bravo", var_19a57b9c0f61e73a[i].origin, var_19a57b9c0f61e73a[i].angles, weaponoverride);

      if(isDefined(agent)) {
        level thread bravo_ai_array_handler(agent, weaponoverride);
      }
    }

    waitframe();
  }
}

function bravo_ai_array_handler(agent, var_cb5616a26c79121f) {
  level.bravoagents = array_add(level.bravoagents, agent);
  outlineid = outlineenableforteam(agent, "allies", ter_op(isDefined(var_cb5616a26c79121f), "outline_depth_red", "outline_depth_orange"), "level_script");
  agent waittill("death");
  outlinedisable(outlineid, agent);
  level.bravoagents = array_remove(level.bravoagents, agent);
}

function cleanupinteractiveinfilai() {
  animlength = getanimlength(level.scr_anim["slot_0"]["rappel_hackney_infil_alpha_interactive_intro"]);
  animlength += 15;
  wait animlength;

  foreach(agent in level.alphaagents) {
    if(isalive(agent)) {
      agent kill();
    }
  }

  foreach(agent in level.bravoagents) {
    if(isalive(agent)) {
      agent kill();
    }
  }
}

function agent_handledamagefeedback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname) {
  if(isDefined(eattacker) && eattacker.team != "axis") {
    eattacker updatedamagefeedback("", idamage >= self.health);

    if(idamage >= self.health) {
      if(!isDefined(eattacker.infilscore)) {
        eattacker.infilscore = 1;
      } else {
        eattacker.infilscore++;
      }

      if(eattacker.infilscore > level.highestinfilscore) {
        level updatehighinfilscore(eattacker);
      }
    }
  }
}

function blima_door_slam(guy) {
  foreach(player in guy.infil.players) {
    player earthquakeforplayer(randomfloatrange(0.135, 0.15), 2, self.origin, 8000);
    player playrumbleonpositionforclient("ground_pound_land", player.origin);
  }
}

function blima_cam_shake_low(guy) {
  foreach(player in guy.infil.players) {
    player updateshakeonplayer(0.06, 0.075, 2, player.origin, 8000, "mig_rumble", 0.05, 0.1);
  }
}

function blima_cam_shake_bump(guy) {
  foreach(player in guy.infil.players) {
    player updateshakeonplayer(0.145, 0.16, 2, player.origin, 8000, "pistol_fire", 0.05, 0.15);
  }
}

function heli_door_open_sfx(guy) {
  if(guy.infil.subtype == "alpha") {
    var_15df0f22135ec326 = spawn("script_origin", guy.infil.linktoent.origin);
    var_15df0f22135ec326 linkTo(guy.infil.linktoent, "side_door_l_jnt");
    var_15df0f22135ec326 playSound("scn_infil_hackney_heli1_door_open");
    wait 3;
    var_15df0f22135ec326 delete();
    return;
  }

  var_15df0f22135ec326 = spawn("script_origin", guy.infil.linktoent.origin);
  var_15df0f22135ec326 linkTo(guy.infil.linktoent, "side_door_r_jnt");
  var_15df0f22135ec326 playSound("scn_infil_hackney_heli2_door_open");
  wait 3;
  var_15df0f22135ec326 delete();
}

function heli_commander_sfx(guy) {
  if(guy.infil.subtype == "alpha") {
    alias = "scn_infil_hackney_heli1_commander";
  } else {
    alias = "scn_infil_hackney_heli1_commander";
  }

  if(soundexists(alias)) {
    guy playsoundonmovingent(alias);
  }
}

function scn_infil_hackney_heli_npc1(guy) {
  if(soundexists("scn_infil_hackney_heli_npc1")) {
    guy playsoundonmovingent("scn_infil_hackney_heli_npc1");
  }
}

function scn_infil_hackney_heli_npc2(guy) {
  if(soundexists("scn_infil_hackney_heli_npc2")) {
    guy playsoundonmovingent("scn_infil_hackney_heli_npc2");
  }
}

function scn_infil_hackney_heli_npc3(guy) {
  if(soundexists("scn_infil_hackney_heli_npc3")) {
    guy playsoundonmovingent("scn_infil_hackney_heli_npc3");
  }
}

function scn_infil_hackney_heli_npc4(guy) {
  if(soundexists("scn_infil_hackney_heli_npc4")) {
    guy playsoundonmovingent("scn_infil_hackney_heli_npc4");
  }
}

function scn_infil_hackney_heli_npc5(guy) {
  if(soundexists("scn_infil_hackney_heli_npc5")) {
    guy playsoundonmovingent("scn_infil_hackney_heli_npc5");
  }
}

function scn_infil_hackney_heli_npc6(guy) {
  if(soundexists("scn_infil_hackney_heli_npc6")) {
    guy playsoundonmovingent("scn_infil_hackney_heli_npc6");
  }
}

function blima_rumble_rope(guy) {
  level endon("prematch_over");
  level endon("infil_done");
  player = guy.player;
  player notify("stop_cam_shake");
  player endon("stop_cam_shake");
  player endon("death_or_disconnect");

  while(true) {
    player playrumbleonpositionforclient("pistol_fire", player.origin);
    wait randomfloatrange(0.05, 0.15);
  }
}

function blima_rumble_ground(guy) {
  player = guy.player;
  player notify("stop_cam_shake");
  player playRumbleOnEntity("ground_pound_land");
  player lerpfovscalefactor(1, 0.5);
}

function combat_start() {
  self notify("stop_cam_shake");
  self endon("stop_cam_shake");
  self.interactivecombat = 1;
  val::reset_all("combat_start");
  self setdemeanorviewmodel("normal");
  self lerpfovbypreset("default_2seconds");

  while(true) {
    self playrumbleonpositionforclient("mig_rumble", self.origin);
    wait randomfloatrange(0.15, 0.5);
  }
}

function combat_end() {
  self notify("stop_cam_shake");
  self.interactivecombat = 0;
  updateshakeonplayer(0.06, 0.075, 2, self.origin, 8000, "mig_rumble", 0.05, 0.1);
  val::set("combat_start", "fire", 0);
  val::set("combat_start", "ads", 0);
  val::set("combat_start", "reload", 0);
  setrecoilscale();
}

function blima_commander_play_sound_func(alias, notification, var_9a0afe8ff3d2508f) {
  foreach(player in self.infil.players) {
    player playsoundtoplayer(alias, player);
  }
}

function vehiclethinkpath(team, scene_node, scene_name) {
  gameflagwait("infil_started");
  self.linktoent setscriptablepartstate("engine", "on", 0);
  self.linktoent.unload_hover_offset = 300;
  self.linktoent.unload_time = 10;
  self.linktoent thread vehicle_paths_helicopter(self.path);
  thread heli_path(self.linktoent);
  self.linktoent waittill("reached_dynamic_path_end");
  self.linktoent delete();
  self.linktoent = undefined;
}

function giveinteractiveinfilweapon() {
  weapon = makeweapon("iw8_lm_kilo121infil_mp", ["acog_west01"]);
  _giveweapon(weapon, undefined, undefined, 1);
  val::reset_all("infil_weapon");
  success = domonitoredweaponswitch(weapon, 0);

  if(success) {
    self.infilweapon = weapon;
    val::set("infil_weapon", "weapon_switch", 0);
    setrecoilscale(0, 50);
  } else {
    _takeweapon(weapon);
    forcevalidweapon();
  }

  return success;
}

function updatehighinfilscore(var_5936722eda95901a) {
  level.highestinfilname = var_5936722eda95901a.name;
  level.highestinfilscore = var_5936722eda95901a.infilscore;

  foreach(player in level.players) {
    if(player.team == "allies") {
      player iprintlnbold(level.highestinfilname + " is in the lead with" + level.highestinfilscore + " kills");
    }
  }
}

function announceinfilwinner() {
  level waittill("interactive_infil_complete");

  if(!isDefined(level.highestinfilname)) {
    return;
  }

  foreach(player in level.players) {
    if(player.team == "allies") {
      player iprintlnbold(level.highestinfilname + " won with" + level.highestinfilscore + " kills");
    }
  }
}

function dummychopper() {
  var_b5232bdc3ef7ef0b = (1325, -1200, 30);
  var_9b47c9dc2d2c79b9 = (0, 90, 0);
  alpha = spawnVehicle("veh8_mil_air_blima", "alpha", "blima_hackney_infil_mp", var_b5232bdc3ef7ef0b, var_9b47c9dc2d2c79b9);
  alpha setvehicleteam("allies");
  alpha setCanDamage(0);
  alpha.animname = "blima";
  alpha setscriptablepartstate("engine", "on", 0);
  light = spawn("script_model", alpha.origin);
  light.angles = alpha.angles;
  light setModel("cop_marker_scriptable");
  light setscriptablepartstate("marker", "heliLight");
  light linkTo(alpha, "tag_origin", (0, 0, -60), (-90, 0, 0));
  alpha thread anim_single_solo(alpha, "rappel_hackney_infil_" + "alpha");
  var_2defaefa4c5fb2eb = (525, -1460, 30);
  var_fad4cfa35bbe199 = (0, 180, 0);
  bravo = spawnVehicle("veh8_mil_air_blima", "bravo", "blima_hackney_infil_mp", var_2defaefa4c5fb2eb, var_fad4cfa35bbe199);
  bravo setvehicleteam("allies");
  bravo setCanDamage(0);
  bravo.animname = "blima";
  bravo setscriptablepartstate("engine", "on", 0);
  light = spawn("script_model", bravo.origin);
  light.angles = bravo.angles;
  light setModel("cop_marker_scriptable");
  light setscriptablepartstate("marker", "heliLight");
  light linkTo(bravo, "tag_origin", (0, 0, -60), (-90, 0, 0));
  bravo thread anim_single_solo(bravo, "rappel_hackney_infil_" + "bravo");
}

function applymapvisionset() {
  switch (level.mapname) {
    case #"hash_be52fbd3b8746bc":
      self visionsetnakedforplayer("infil_spear_pm", 0);
      break;
    default:
      return;
  }
}

function removemapvisionset() {
  self endon("player_free_spot");
  wait 1.5;
  self visionsetnakedforplayer("", 1);
}

function getcommanderassets(team) {
  data = spawnStruct();

  if(team == "axis") {
    data.body = "body_russian_helicopter_pilot";
    data.head = "head_russian_helicopter_pilot_opaque";
  } else {
    data.body = "body_mp_helicopter_crew";
    data.head = "head_mp_helicopter_crew";
  }

  return data;
}

function outsideheli(guy) {
  if(!isDefined(guy)) {
    return;
  }

  if(isDefined(guy.player)) {
    player = guy.player;
  } else {
    player = guy;
  }

  player thread clear_infil_ambient_zone();
  player thread removemapvisionset();
}

function function_aa9c0268656debfc(subtype) {
  var_addd3217bc59a7b8 = spawnStruct();
  var_5e0676140eecdf2d = "rappel_hackney_" + subtype + "_probe";
  light_name = "rappel_hackney_" + subtype + "_light";
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

function function_40ab1094757333e0(var_addd3217bc59a7b8) {
  if(!isDefined(var_addd3217bc59a7b8)) {
    return;
  }

  var_addd3217bc59a7b8.probe show();
  var_addd3217bc59a7b8.probe linkTo(self, "tag_origin", (16, 0, -80), (0, 0, 0));

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