/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\rappel_hackney_infil.gsc
**********************************************************/

rappel_hackney_init(subtype) {
  initanims(subtype);
  _id_453E4FC2C649FEA4 = [];
  _id_453E4FC2C649FEA4[0] = [0, 1];
  _id_453E4FC2C649FEA4[1] = [2];
  thread scripts\mp\infilexfil\infilexfil::infil_add("infil_rappel_hackney", subtype, 3, 2, _id_453E4FC2C649FEA4, ::rappel_hackney_spawn, ::rappel_hackney_get_length, ::player_rappel_hackney_infil_think);
}

rappel_hackney_spawn(team, target, subtype, originalsubtype) {
  scene_node = scripts\engine\utility::getStruct(target, "targetname");
  infil = spawn("script_origin", scene_node.origin);
  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;
  infil thread infilthink(team, subtype);
  return infil;
}

rappel_hackney_get_length(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["rappel_hackney_infil_" + subtype]);
  return animlength;
}

player_rappel_hackney_infil_think(infil, _id_E4B9CD561C7C0DE6) {
  self endon("player_free_spot");

  if(isPlayer(self))
    self setclienttriggeraudiozone("hackney_infil_heli_intro", 1);

  applymapvisionset();
  thread player_infil_end();
  thread heli_infil_radio_idle();
  spawnpos = infil.linktoent gettagorigin("origin_animate_jnt");
  _id_B7850001037AA074 = infil.linktoent gettagangles("origin_animate_jnt");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + _id_E4B9CD561C7C0DE6, spawnpos, _id_B7850001037AA074);
  self.player_rig linkTo(infil.linktoent, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  infil.linktoent scripts\common\anim::anim_first_frame_solo(self.player_rig, "rappel_hackney_infil_" + infil.subtype);
  thread player_rappel_disconnect();
  self.manualoverridewindmaterial = 1;
  self setscriptablepartstate("wind", "100", 0);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  scripts\mp\flags::gameflagwait("infil_started");
  self lerpfovscalefactor(0, 0);

  if(_id_E4B9CD561C7C0DE6 == 0)
    self lerpfovbypreset("80_instant");

  thread scripts\mp\music_and_dialog::_id_03AA69E0E6827CE5();

  if(isDefined(self.animname) && isPlayer(self)) {
    soundalias = "scn_infil_hackney_heli_plr1";

    if(isDefined(infil.subtype)) {
      if(infil.subtype == "alpha") {
        switch (self.animname) {
          case "slot_0":
            soundalias = "scn_infil_hackney_heli_plr1";
            break;
          case "slot_1":
            soundalias = "scn_infil_hackney_heli_plr2";
            break;
          case "slot_2":
            soundalias = "scn_infil_hackney_heli_plr3";
            break;
          default:
            soundalias = "scn_infil_hackney_heli_plr1";
            break;
        }
      } else {
        switch (self.animname) {
          case "slot_0":
            soundalias = "scn_infil_hackney_heli_plr4";
            break;
          case "slot_1":
            soundalias = "scn_infil_hackney_heli_plr5";
            break;
          case "slot_2":
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

player_normal_think(infil) {
  self endon("player_free_spot");
  self lerpviewangleclamp(1, 0.25, 0.25, 30, 30, 30, 10);
  infil.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "rappel_hackney_infil_" + infil.subtype);

  if(isDefined(self.player_rig) && self.player_rig islinked())
    self.player_rig unlink();

  if(self isnightvisionon())
    self visionsetnakedforplayer("", 0.75);

  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
  self setscriptablepartstate("wind", "0", 0);
  self.manualoverridewindmaterial = 0;
}

clear_infil_ambient_zone() {
  self endon("death_or_disconnect");
  wait 1;

  if(isDefined(self._id_5B097BDE4417D7AD))
    self clearsoundsubmix(self._id_5B097BDE4417D7AD, 2);

  self clearclienttriggeraudiozone(2);
}

heli_infil_radio_idle() {
  if(isPlayer(self)) {
    _id_E014D2BCF2D12FAC = spawn("script_origin", (0, 0, 0));
    _id_E014D2BCF2D12FAC showonlytoplayer(self);
    _id_E014D2BCF2D12FAC playLoopSound("dx_mpo_ukop_radio_chatter");
    scripts\mp\flags::gameflagwait("infil_started");
    wait 2;
    _id_E014D2BCF2D12FAC stoploopsound("dx_mpo_ukop_radio_chatter");
    _id_E014D2BCF2D12FAC delete();
  }
}

player_interactive_think(infil) {
  self endon("player_free_spot");
  self.player_rig linkTo(infil.linktoent, "origin_animate_jnt", (0, 0, 0), (0, 0, 0));
  self lerpviewangleclamp(1, 0.25, 0.25, 80, 80, 30, 70);
  infil scripts\mp\anim::anim_player_solo(self, self.player_rig, "rappel_hackney_infil_" + infil.subtype + "_interactive_intro");
  thread combat_start();
  wait 15.0;
  thread combat_end();

  if(!isai(self))
    scripts\cp_mp\utility\inventory_utility::_id_FC6A5B145563BE33();

  self lerpviewangleclamp(1, 0.25, 0.25, 0, 0, 0, 0);
  infil.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "rappel_hackney_infil_" + infil.subtype + "_interactive_exit");

  if(isDefined(self.player_rig) && self.player_rig islinked())
    self.player_rig unlink();

  if(self isnightvisionon())
    self visionsetnakedforplayer("", 0.75);

  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
}

player_infil_end() {
  self endon("disconnect");
  level waittill("prematch_over");
  self notify("remove_rig");

  if(isDefined(self._id_5B097BDE4417D7AD))
    self clearsoundsubmix(self._id_5B097BDE4417D7AD, 2);

  self clearclienttriggeraudiozone(1.0);
  scripts\mp\utility\player::setdof_default();
}

player_rappel_disconnect() {
  level endon("prematch_over");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    self visionsetnakedforplayer("");

    if(isDefined(self._id_5B097BDE4417D7AD))
      self clearsoundsubmix(self._id_5B097BDE4417D7AD, 2);

    self clearclienttriggeraudiozone(0.0);
    self lerpfovbypreset("default");
    self setviewmodeldepthoffield(0, 0, 18);
    scripts\mp\utility\player::setdof_default();
  }
}

spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  if(!isDefined(self.actors))
    self.actors = [];

  _id_46959F58CBABA3AC = getcommanderassets(team);
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("commander", "origin_animate_jnt", _id_46959F58CBABA3AC.body, _id_46959F58CBABA3AC.head);
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("pilot", "origin_animate_jnt", "body_pilot_helicopter_british", "head_pilot_helicopter_british");
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("copilot", "origin_animate_jnt", "body_pilot_helicopter_british", "head_mp_helicopter_crew");

  foreach(actor in self.actors)
  actor.infil = self;

  scripts\mp\flags::gameflagwait("infil_started");
  self.actors[0].anim_playsound_func = ::blima_commander_play_sound_func;
}

infilthink(team, _id_CA85A0DE365C6A63) {
  _id_E026A614F7467557 = getdvarfloat("r_mbVelocityScale", 0.2);

  foreach(ent in getEntArray("infil_delete", "script_noteworthy"))
  ent delete();

  thread helithink(team, self.scene_node, _id_CA85A0DE365C6A63);
  thread actorthink(team, self.scene_node, _id_CA85A0DE365C6A63);
  scripts\mp\flags::gameflagwait("infil_started");
  setDvar("r_spotLightEntityShadows", 1);
  setDvar("r_mbVelocityScale", 1.0);

  if(level.prematchperiodend > self.infillength)
    wait(level.prematchperiodend - self.infillength);

  level waittill("prematch_over");
  setDvar("r_spotLightEntityShadows", 0);
  setDvar("r_mbVelocityScale", _id_E026A614F7467557);
}

helithink(team, scene_node, _id_CA85A0DE365C6A63) {
  spawnheli(scene_node, team, _id_CA85A0DE365C6A63);
  scripts\common\anim::anim_first_frame_solo(self.linktoent, "rappel_hackney_infil_" + _id_CA85A0DE365C6A63);
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent setscriptablepartstate("engine", "on", 0);
  self.linktoent setscriptablepartstate("running_lights", "on", 0);
  self.linktoent setscriptablepartstate("infil_lights", "on", 0);
  self._id_ADDD3217BC59A7B8 = _id_AA9C0268656DEBFC(_id_CA85A0DE365C6A63);
  self.linktoent _id_40AB1094757333E0(self._id_ADDD3217BC59A7B8);
  thread heli_normal_think(team, scene_node, _id_CA85A0DE365C6A63);
  thread heli_interior_sfx(_id_CA85A0DE365C6A63);
}

heli_interior_sfx(_id_CA85A0DE365C6A63) {
  _id_4237DFC2448D7BC8 = spawn("script_model", self.linktoent.origin);
  _id_060876D0F32D5396 = spawn("script_model", self.linktoent.origin);
  _id_060876D0F32D5396 linkTo(self.linktoent, "tag_light_cockpit01");
  wait 0.1;

  if(_id_CA85A0DE365C6A63 == "alpha") {
    self.linktoent playsoundonmovingent("scn_mp_hackney_heli1_lr");
    _id_4237DFC2448D7BC8 linkTo(self.linktoent, "j_tied_cable_02");
    wait 0.1;
    _id_4237DFC2448D7BC8 playsoundonmovingent("scn_infil_hackney_heli1_ceiling_rattles");
    _id_060876D0F32D5396 playsoundonmovingent("scn_infil_hackney_heli1_cockpit_rattles");
  } else {
    self.linktoent playsoundonmovingent("scn_mp_hackney_heli2_lr");
    _id_4237DFC2448D7BC8 linkTo(self.linktoent, "j_ceiling_cable_02");
    wait 0.1;
    _id_4237DFC2448D7BC8 playsoundonmovingent("scn_infil_hackney_heli2_ceiling_rattles");
    _id_060876D0F32D5396 playsoundonmovingent("scn_infil_hackney_heli2_cockpit_rattles");
  }

  level waittill("prematch_over");
  _id_4237DFC2448D7BC8 delete();
  _id_060876D0F32D5396 delete();
}

heli_interactive_think(team, scene_node, _id_CA85A0DE365C6A63) {
  thread scripts\common\anim::anim_single_solo(self.linktoent, "rappel_hackney_infil_" + _id_CA85A0DE365C6A63 + "_interactive");
  wait(level.interactivecombatduration - 15.0);
  thread ropethink(_id_CA85A0DE365C6A63);
  wait 15.0;
  cleanup();
}

heli_normal_think(team, scene_node, _id_CA85A0DE365C6A63) {
  thread ropethink(_id_CA85A0DE365C6A63);

  if(isDefined(self.path)) {
    thread scripts\common\anim::anim_single_solo(self.linktoent, "rappel_hackney_infil_" + _id_CA85A0DE365C6A63);
    vehiclethinkpath(team, scene_node, _id_CA85A0DE365C6A63);
  } else {
    thread scripts\common\anim::anim_single_solo(self.linktoent, "rappel_hackney_infil_" + _id_CA85A0DE365C6A63);
    duration = getanimlength(level.scr_anim[self.linktoent.animname]["rappel_hackney_infil_" + _id_CA85A0DE365C6A63]);
    wait(duration);
  }

  cleanup();
}

ropethink(_id_CA85A0DE365C6A63) {
  self.linktoent thread scripts\common\anim::anim_single_solo(self.linktoent.rope, "rappel_hackney_infil_" + _id_CA85A0DE365C6A63, "origin_animate_jnt");
  duration = getanimlength(level.scr_anim[self.linktoent.rope.animname]["rappel_hackney_infil_" + _id_CA85A0DE365C6A63]);
  wait(duration);
  self.linktoent.rope unlink();
  thread scripts\common\anim::anim_single_solo(self.linktoent.rope, "rappel_hackney_infil_" + _id_CA85A0DE365C6A63 + "_fall");
}

sfx_infil_hackney_heli1_rope(guy) {
  guy playsoundonmovingent("scn_infil_hackney_heli1_rope");
}

sfx_infil_hackney_heli2_rope(guy) {
  guy playsoundonmovingent("scn_infil_hackney_heli2_rope");
}

actorthink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  thread spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  actor_normal_think(team, scene_node, _id_CA85A0DE365C6A63);
}

actor_interactive_think(team, scene_node, _id_CA85A0DE365C6A63) {
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "rappel_hackney_infil_" + _id_CA85A0DE365C6A63 + "_interactive", "origin_animate_jnt");
  scripts\mp\utility\infilexfil::hideactors();
  level waittill("infil_started");
  scripts\mp\utility\infilexfil::showactors();
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "rappel_hackney_infil_" + _id_CA85A0DE365C6A63 + "_interactive", "origin_animate_jnt");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["rappel_hackney_infil_" + _id_CA85A0DE365C6A63 + "_interactive"]);
}

actor_normal_think(team, scene_node, _id_CA85A0DE365C6A63) {
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "rappel_hackney_infil_" + _id_CA85A0DE365C6A63, "origin_animate_jnt");
  scripts\mp\utility\infilexfil::hideactors();
  scripts\mp\flags::gameflagwait("infil_started");
  scripts\mp\utility\infilexfil::showactors();
  self.linktoent thread scripts\common\anim::anim_single(self.actors, "rappel_hackney_infil_" + _id_CA85A0DE365C6A63, "origin_animate_jnt");
  self.actors[0].head scriptmodelplayanim(level.scr_anim[self.actors[0].animname]["rappel_hackney_infil_" + _id_CA85A0DE365C6A63]);
}

spawn_anim_model(animname, _id_0609C1B125A13456, body, head, weapon) {
  _id_C920DC0E8DFA0EF4 = 1;

  if(scripts\engine\utility::cointoss())
    _id_C920DC0E8DFA0EF4 = 0;

  if(body == "random") {
    if(_id_C920DC0E8DFA0EF4) {
      index = randomint(3);

      if(index == 0)
        body = "c_civ_pic_male_2_brown";
      else if(index == 1)
        body = "body_opforce_london_civ_1_1";
      else if(index == 2)
        body = "civ_london_male_2_5";
    } else if(scripts\engine\utility::cointoss())
      body = "civ_london_female_1_4";
    else
      body = "c_civ_pic_female_5_6";
  }

  guy = spawn("script_model", (0, 0, 0));
  guy setModel(body);

  if(isDefined(head)) {
    if(head == "random") {
      if(_id_C920DC0E8DFA0EF4) {
        if(scripts\engine\utility::cointoss())
          head = "head_bg_var_head_bg_male_09_head_sc_male_14";
        else
          head = "head_bg_var_head_male_bc_01_head_hero_gator";
      } else if(scripts\engine\utility::cointoss())
        head = "head_bg_var_head_female_bc_01_head_sc_female_10";
      else
        head = "head_bg_var_head_sc_female_04_head_female_bc_02";
    }

    _id_F4246828592F1C0F = spawn("script_model", (0, 0, 0));
    _id_F4246828592F1C0F setModel(head);
    _id_F4246828592F1C0F linkTo(guy, "j_spine4", (0, 0, 0), (0, 0, 0));
    guy.head = _id_F4246828592F1C0F;
    guy thread scripts\engine\utility::delete_on_death(_id_F4246828592F1C0F);
  }

  if(isDefined(weapon)) {
    _id_E71CCB5E6023BCDD = spawn("script_model", (0, 0, 0));
    _id_E71CCB5E6023BCDD setModel(weapon);
    _id_E71CCB5E6023BCDD linkTo(guy, "j_gun", (0, 0, 0), (0, 0, 0));
    guy thread scripts\engine\utility::delete_on_death(_id_E71CCB5E6023BCDD);
    guy.weapon = _id_E71CCB5E6023BCDD;
  }

  guy.animname = animname;
  guy scripts\common\anim::setanimtree();

  if(isDefined(_id_0609C1B125A13456)) {
    thread scripts\engine\utility::delete_on_death(guy);
    guy linkTo(self, _id_0609C1B125A13456, (0, 0, 0), (0, 0, 0));
  }

  return guy;
}

initanims(subtype) {
  script_model_alpha_anims(subtype);
  vehicles_alpha_anims(subtype);

  if(!isDefined(level.scr_notetrack) || !isDefined(level.scr_notetrack["commander"])) {
    scripts\common\anim::addnotetrack_customfunction("commander", "door_slam", ::blima_door_slam);
    scripts\common\anim::addnotetrack_customfunction("commander", "shake_low", ::blima_cam_shake_low);
    scripts\common\anim::addnotetrack_customfunction("commander", "shake_bump", ::blima_cam_shake_bump);
    scripts\common\anim::addnotetrack_customfunction("commander", "door_open_sfx", ::heli_door_open_sfx);
    scripts\common\anim::addnotetrack_customfunction("commander", "sfx_infil_hackney_heli_commander", ::heli_commander_sfx);
    scripts\common\anim::addnotetrack_customfunction("commander", "scn_infil_hackney_heli1_rope", ::sfx_infil_hackney_heli1_rope);
    scripts\common\anim::addnotetrack_customfunction("commander", "scn_infil_hackney_heli2_rope", ::sfx_infil_hackney_heli2_rope);
  }

  switch (subtype) {
    case "alpha":
      scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "outside_heli", ::outsideheli, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "rumble_rope", ::blima_rumble_rope, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "rumble_ground", ::blima_rumble_ground, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", scripts\mp\utility\infilexfil::player_free_look, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "outside_heli", ::outsideheli, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "rumble_rope", ::blima_rumble_rope, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "rumble_ground", ::blima_rumble_ground, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", scripts\mp\utility\infilexfil::player_free_look, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "outside_heli", ::outsideheli, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "rumble_rope", ::blima_rumble_rope, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "rumble_ground", ::blima_rumble_ground, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", scripts\mp\utility\infilexfil::player_free_look, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2, "rappel_hackney_infil_alpha");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "rappel_hackney_infil_alpha");
      break;
    case "bravo":
      scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "outside_heli", ::outsideheli, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "rumble_rope", ::blima_rumble_rope, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "rumble_ground", ::blima_rumble_ground, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", scripts\mp\utility\infilexfil::player_free_look, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_0", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "outside_heli", ::outsideheli, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "rumble_rope", ::blima_rumble_rope, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "rumble_ground", ::blima_rumble_ground, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", scripts\mp\utility\infilexfil::player_free_look, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_1", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "outside_heli", ::outsideheli, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "rumble_rope", ::blima_rumble_rope, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "rumble_ground", ::blima_rumble_ground, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", scripts\mp\utility\infilexfil::player_free_look, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2, "rappel_hackney_infil_bravo");
      scripts\common\anim::addnotetrack_customfunction("slot_2", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "rappel_hackney_infil_bravo");
      break;
  }
}

#using_animtree("script_model");

script_model_alpha_anims(subtype) {
  switch (subtype) {
    case "alpha":
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["rappel_hackney_infil_alpha"] = % mp_faridah_infill_bird_a_pilot_idle;
      level.scr_animname["pilot"]["rappel_hackney_infil_alpha"] = "mp_faridah_infill_bird_a_pilot_idle";
      level.scr_anim["pilot"]["rappel_hackney_infil_alpha_interactive"] = % mp_faridah_infill_bird_a_pilot_idle;
      level.scr_animname["pilot"]["rappel_hackney_infil_alpha_interactive"] = "mp_faridah_infill_bird_a_pilot_idle";
      level.scr_animtree["copilot"] = #animtree;
      level.scr_anim["copilot"]["rappel_hackney_infil_alpha"] = % mp_faridah_infill_bird_a_copilot_idle;
      level.scr_animname["copilot"]["rappel_hackney_infil_alpha"] = "mp_faridah_infill_bird_a_copilot_idle";
      level.scr_anim["copilot"]["rappel_hackney_infil_alpha_interactive"] = % mp_faridah_infill_bird_a_copilot_idle;
      level.scr_animname["copilot"]["rappel_hackney_infil_alpha_interactive"] = "mp_faridah_infill_bird_a_copilot_idle";
      level.scr_animtree["commander"] = #animtree;
      level.scr_anim["commander"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_chief;
      level.scr_animname["commander"]["rappel_hackney_infil_alpha"] = "mp_infil_blima_chief";
      level.scr_anim["commander"]["rappel_hackney_infil_alpha_interactive"] = % mp_infil_act_blima_chief;
      level.scr_animname["commander"]["rappel_hackney_infil_alpha_interactive"] = "mp_infil_act_blima_chief";
      level.scr_animtree["rope"] = #animtree;
      level.scr_anim["rope"]["rappel_hackney_infil_alpha"] = % equipment_fast_rope_wm_01_infil_heli_l;
      level.scr_animname["rope"]["rappel_hackney_infil_alpha"] = "equipment_fast_rope_wm_01_infil_heli_l";
      level.scr_anim["rope"]["rappel_hackney_infil_alpha_fall"] = % equipment_fast_rope_wm_01_infil_heli_l_fall;
      level.scr_animname["rope"]["rappel_hackney_infil_alpha_fall"] = "equipment_fast_rope_wm_01_infil_heli_l_fall";
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_guy01;
      level.scr_animname["slot_0"]["rappel_hackney_infil_alpha"] = "mp_infil_blima_guy01";
      level.scr_eventanim["slot_0"]["rappel_hackney_infil_alpha"] = "infil_rappel_hackney_alpha_ally_1";
      scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_hackney_heli_npc1", ::scn_infil_hackney_heli_npc1);
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_guy02;
      level.scr_animname["slot_1"]["rappel_hackney_infil_alpha"] = "mp_infil_blima_guy02";
      level.scr_eventanim["slot_1"]["rappel_hackney_infil_alpha"] = "infil_rappel_hackney_alpha_ally_2";
      scripts\common\anim::addnotetrack_customfunction("slot_1", "scn_infil_hackney_heli_npc2", ::scn_infil_hackney_heli_npc2);
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_guy03;
      level.scr_animname["slot_2"]["rappel_hackney_infil_alpha"] = "mp_infil_blima_guy03";
      level.scr_eventanim["slot_2"]["rappel_hackney_infil_alpha"] = "infil_rappel_hackney_alpha_ally_3";
      scripts\common\anim::addnotetrack_customfunction("slot_2", "scn_infil_hackney_heli_npc3", ::scn_infil_hackney_heli_npc3);
      break;
    case "bravo":
      level.scr_animtree["pilot"] = #animtree;
      level.scr_anim["pilot"]["rappel_hackney_infil_bravo"] = % mp_faridah_infill_bird_a_pilot_idle;
      level.scr_animname["pilot"]["rappel_hackney_infil_bravo"] = "mp_faridah_infill_bird_a_pilot_idle";
      level.scr_anim["pilot"]["rappel_hackney_infil_bravo_interactive"] = % mp_faridah_infill_bird_a_pilot_idle;
      level.scr_animname["pilot"]["rappel_hackney_infil_bravo_interactive"] = "mp_faridah_infill_bird_a_pilot_idle";
      level.scr_animtree["copilot"] = #animtree;
      level.scr_anim["copilot"]["rappel_hackney_infil_bravo"] = % mp_faridah_infill_bird_a_copilot_idle;
      level.scr_animname["copilot"]["rappel_hackney_infil_bravo"] = "mp_faridah_infill_bird_a_copilot_idle";
      level.scr_anim["copilot"]["rappel_hackney_infil_bravo_interactive"] = % mp_faridah_infill_bird_a_copilot_idle;
      level.scr_animname["copilot"]["rappel_hackney_infil_bravo_interactive"] = "mp_faridah_infill_bird_a_copilot_idle";
      level.scr_animtree["commander"] = #animtree;
      level.scr_anim["commander"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_r_chief;
      level.scr_animname["commander"]["rappel_hackney_infil_bravo"] = "mp_infil_blima_r_chief";
      level.scr_anim["commander"]["rappel_hackney_infil_bravo_interactive"] = % mp_infil_act_blima_b_chief;
      level.scr_animname["commander"]["rappel_hackney_infil_bravo_interactive"] = "mp_infil_act_blima_b_chief";
      level.scr_animtree["rope"] = #animtree;
      level.scr_anim["rope"]["rappel_hackney_infil_bravo"] = % equipment_fast_rope_wm_01_infil_heli_r;
      level.scr_animname["rope"]["rappel_hackney_infil_bravo"] = "equipment_fast_rope_wm_01_infil_heli_r";
      level.scr_anim["rope"]["rappel_hackney_infil_bravo_fall"] = % equipment_fast_rope_wm_01_infil_heli_r_fall;
      level.scr_animname["rope"]["rappel_hackney_infil_bravo_fall"] = "equipment_fast_rope_wm_01_infil_heli_r_fall";
      level.scr_animtree["slot_0"] = #animtree;
      level.scr_anim["slot_0"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_r_guy01;
      level.scr_animname["slot_0"]["rappel_hackney_infil_bravo"] = "mp_infil_blima_r_guy01";
      level.scr_eventanim["slot_0"]["rappel_hackney_infil_bravo"] = "infil_rappel_hackney_bravo_ally_1";
      scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_hackney_heli_npc4", ::scn_infil_hackney_heli_npc4);
      level.scr_animtree["slot_1"] = #animtree;
      level.scr_anim["slot_1"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_r_guy02;
      level.scr_animname["slot_1"]["rappel_hackney_infil_bravo"] = "mp_infil_blima_r_guy02";
      level.scr_eventanim["slot_1"]["rappel_hackney_infil_bravo"] = "infil_rappel_hackney_bravo_ally_2";
      scripts\common\anim::addnotetrack_customfunction("slot_1", "scn_infil_hackney_heli_npc5", ::scn_infil_hackney_heli_npc5);
      level.scr_animtree["slot_2"] = #animtree;
      level.scr_anim["slot_2"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_r_guy03;
      level.scr_animname["slot_2"]["rappel_hackney_infil_bravo"] = "mp_infil_blima_r_guy03";
      level.scr_eventanim["slot_2"]["rappel_hackney_infil_bravo"] = "infil_rappel_hackney_bravo_ally_3";
      scripts\common\anim::addnotetrack_customfunction("slot_2", "scn_infil_hackney_heli_npc6", ::scn_infil_hackney_heli_npc6);
      break;
  }
}

#using_animtree("mp_vehicles_always_loaded");

vehicles_alpha_anims(subtype) {
  switch (subtype) {
    case "alpha":
      level.scr_animtree["blima"] = #animtree;

      switch (getDvar("g_mapname")) {
        case "mp_spear":
        case "mp_spear_pm":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mpspear_alpha;
          break;
        case "mp_cave":
        case "mp_cave_am":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mpcave_alpha;
          break;
        case "mp_crash2":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mpcrash_alpha;
          break;
        case "mp_aniyah_tac":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mpaniyah_tactical_alpha;
          break;
        case "mp_oilrig":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mp_oilrig_alpha;
          break;
        case "mp_harbor":
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli_mpharbor_alpha;
          break;
        default:
          level.scr_anim["blima"]["rappel_hackney_infil_alpha"] = % mp_infil_blima_heli;
          break;
      }

      level.scr_anim["blima"]["rappel_hackney_infil_alpha_interactive"] = % mp_infil_act_blima_heli;
      break;
    case "bravo":
      level.scr_animtree["blima"] = #animtree;

      switch (getDvar("g_mapname")) {
        case "mp_spear":
        case "mp_spear_pm":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mpspear_bravo;
          break;
        case "mp_cave":
        case "mp_cave_am":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mpcave_bravo;
          break;
        case "mp_crash2":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mpcrash_bravo;
          break;
        case "mp_aniyah_tac":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mpaniyah_tactical_bravo;
          break;
        case "mp_oilrig":
          level.scr_anim["blima"]["rappel_hackney_infil_bravo"] = % mp_infil_blima_heli_mp_oilrig_bravo;
          break;
        case "mp_harbor":
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

spawnheli(scene_node, team, _id_CA85A0DE365C6A63) {
  vehicle = "blima_desert_day_infil_mp";

  if(level.mapname == "mp_hackney_yard")
    vehicle = "blima_hackney_infil_mp";

  blima = spawnVehicle("veh8_mil_air_blima_infils", _id_CA85A0DE365C6A63, vehicle, scene_node.origin, scene_node.angles);
  blima setvehicleteam(team);
  blima setCanDamage(0);
  blima.animname = "blima";
  self.linktoent = blima;
  blima.infil = self;
  self.linktoent.rope = self.linktoent spawn_anim_model("rope", "origin_animate_jnt", "equipment_fast_rope_wm_01_infil_heli_l");
  self.linktoent.rope scripts\common\anim::anim_first_frame_solo(self.linktoent.rope, "rappel_hackney_infil_" + _id_CA85A0DE365C6A63);
  return blima;
}

helifollowpath(_id_BA4C16AD30A65991) {
  if(!isDefined(_id_BA4C16AD30A65991)) {
    return;
  }
  currentnode = scripts\engine\utility::getStruct(_id_BA4C16AD30A65991, "targetname");

  if(!isDefined(currentnode)) {
    return;
  }
  nextnode = scripts\engine\utility::getStruct(currentnode.target, "targetname");
  self.speed = 500;
  self.accel = 175;
  self.combatmode = "guard_location";
  self notify(self.combatmode);

  while(isDefined(currentnode.target)) {
    thread scripts\mp\killstreaks\jackal::guardpositionescort(nextnode.origin, undefined, 800);

    for(;;) {
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
    nextnode = scripts\engine\utility::getStruct(currentnode.target, "targetname");
  }
}

cleanup() {
  foreach(actor in self.actors)
  actor delete();

  self.linktoent.rope delete();
  _id_89A2405953B84136(self._id_ADDD3217BC59A7B8, 0);
  self.linktoent delete();
  level.infilsactive--;
  self delete();
}

spawn_infil_axis_ai(lane, _id_E0CBA2B0A5510D09, _id_0FD901B0C91A0D1F, _id_017F7F54AA3EF276) {
  level.gameskill = 0;
  agent = scripts\mp\mp_agent::spawnnewagent("soldier_agent", "axis", _id_E0CBA2B0A5510D09, _id_0FD901B0C91A0D1F, scripts\engine\utility::ter_op(isDefined(_id_017F7F54AA3EF276), _id_017F7F54AA3EF276, "iw8_ar_mike4_mp"));

  if(!isDefined(agent))
    return undefined;

  agent.desiredmovetype = "combat";
  agent clearpath();
  agent.goalradius = 999;
  agent.fixednode = 0;
  agent scripts\mp\agents\agent_common::set_agent_health(50);
  return agent;
}

spawninteractiveinfilai() {
  level thread alphaai();
  level thread bravoai();
}

alphaai() {
  level endon("interactive_infil_complete");
  level endon("prematch_over");
  level endon("infil_done");
  level.alphaagents = [];
  _id_B2C3325AA4F3FCB9 = scripts\engine\utility::getStructArray("ai_alpha_start", "targetname");
  _id_BDC35E9715DB3CDA = scripts\engine\utility::getStructArray("ai_alpha_respawn", "targetname");

  foreach(start in _id_B2C3325AA4F3FCB9) {
    agent = spawn_infil_axis_ai("alpha", start.origin, start.angles);

    if(isDefined(agent))
      level thread alpha_ai_array_handler(agent);

    if(level.alphaagents.size == 5) {
      break;
    }
  }

  for(;;) {
    if(level.alphaagents.size < 5) {
      _id_AC0E594AC96AA3A8 = randomint(_id_BDC35E9715DB3CDA.size);

      if(randomint(100) > 75)
        weaponoverride = "iw8_la_rpapa7_mp";
      else
        weaponoverride = undefined;

      agent = spawn_infil_axis_ai("alpha", _id_BDC35E9715DB3CDA[_id_AC0E594AC96AA3A8].origin, _id_BDC35E9715DB3CDA[_id_AC0E594AC96AA3A8].angles, weaponoverride);

      if(isDefined(agent))
        level thread alpha_ai_array_handler(agent, weaponoverride);
    }

    waitframe();
  }
}

alpha_ai_array_handler(agent, _id_CB5616A26C79121F) {
  level.alphaagents = scripts\engine\utility::array_add(level.alphaagents, agent);
  outlineid = scripts\mp\utility\outline::outlineenableforteam(agent, "allies", scripts\engine\utility::ter_op(isDefined(_id_CB5616A26C79121F), "outline_depth_red", "outline_depth_orange"), "level_script");
  agent waittill("death");
  scripts\mp\utility\outline::outlinedisable(outlineid, agent);
  level.alphaagents = scripts\engine\utility::array_remove(level.alphaagents, agent);
}

bravoai() {
  level endon("interactive_infil_complete");
  level endon("prematch_over");
  level endon("infil_done");
  level.bravoagents = [];
  _id_177E57346ABD5299 = scripts\engine\utility::getStructArray("ai_bravo_start", "targetname");
  _id_19A57B9C0F61E73A = scripts\engine\utility::getStructArray("ai_bravo_respawn", "targetname");

  foreach(start in _id_177E57346ABD5299) {
    agent = spawn_infil_axis_ai("bravo", start.origin, start.angles);

    if(isDefined(agent))
      level thread bravo_ai_array_handler(agent);

    if(level.bravoagents.size == 5) {
      break;
    }
  }

  for(;;) {
    if(level.bravoagents.size < 5) {
      _id_AC0E594AC96AA3A8 = randomint(_id_19A57B9C0F61E73A.size);

      if(randomint(100) > 75)
        weaponoverride = "iw8_la_rpapa7_mp";
      else
        weaponoverride = undefined;

      agent = spawn_infil_axis_ai("bravo", _id_19A57B9C0F61E73A[_id_AC0E594AC96AA3A8].origin, _id_19A57B9C0F61E73A[_id_AC0E594AC96AA3A8].angles, weaponoverride);

      if(isDefined(agent))
        level thread bravo_ai_array_handler(agent, weaponoverride);
    }

    waitframe();
  }
}

bravo_ai_array_handler(agent, _id_CB5616A26C79121F) {
  level.bravoagents = scripts\engine\utility::array_add(level.bravoagents, agent);
  outlineid = scripts\mp\utility\outline::outlineenableforteam(agent, "allies", scripts\engine\utility::ter_op(isDefined(_id_CB5616A26C79121F), "outline_depth_red", "outline_depth_orange"), "level_script");
  agent waittill("death");
  scripts\mp\utility\outline::outlinedisable(outlineid, agent);
  level.bravoagents = scripts\engine\utility::array_remove(level.bravoagents, agent);
}

cleanupinteractiveinfilai() {
  animlength = getanimlength(level.scr_anim["slot_0"]["rappel_hackney_infil_alpha_interactive_intro"]);
  animlength = animlength + 15.0;
  wait(animlength);

  foreach(agent in level.alphaagents) {
    if(isalive(agent))
      agent kill();
  }

  foreach(agent in level.bravoagents) {
    if(isalive(agent))
      agent kill();
  }
}

agent_handledamagefeedback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname) {
  if(isDefined(eattacker) && eattacker.team != "axis") {
    eattacker _id_5762AC2F22202BA2::updatedamagefeedback("", idamage >= self.health);

    if(idamage >= self.health) {
      if(!isDefined(eattacker.infilscore))
        eattacker.infilscore = 1;
      else
        eattacker.infilscore++;

      if(eattacker.infilscore > level.highestinfilscore)
        level updatehighinfilscore(eattacker);
    }
  }
}

blima_door_slam(guy) {
  foreach(player in guy.infil.players) {
    player earthquakeforplayer(randomfloatrange(0.135, 0.15), 2, self.origin, 8000);
    player playrumbleonpositionforclient("ground_pound_land", player.origin);
  }
}

blima_cam_shake_low(guy) {
  foreach(player in guy.infil.players)
  player scripts\mp\utility\infilexfil::updateshakeonplayer(0.06, 0.075, 2, player.origin, 8000, "mig_rumble", 0.05, 0.1);
}

blima_cam_shake_bump(guy) {
  foreach(player in guy.infil.players)
  player scripts\mp\utility\infilexfil::updateshakeonplayer(0.145, 0.16, 2, player.origin, 8000, "pistol_fire", 0.05, 0.15);
}

heli_door_open_sfx(guy) {
  if(guy.infil.subtype == "alpha") {
    _id_15DF0F22135EC326 = spawn("script_origin", guy.infil.linktoent.origin);
    _id_15DF0F22135EC326 linkTo(guy.infil.linktoent, "side_door_l_jnt");
    _id_15DF0F22135EC326 playSound("scn_infil_hackney_heli1_door_open");
    wait 3;
    _id_15DF0F22135EC326 delete();
  } else {
    _id_15DF0F22135EC326 = spawn("script_origin", guy.infil.linktoent.origin);
    _id_15DF0F22135EC326 linkTo(guy.infil.linktoent, "side_door_r_jnt");
    _id_15DF0F22135EC326 playSound("scn_infil_hackney_heli2_door_open");
    wait 3;
    _id_15DF0F22135EC326 delete();
  }
}

heli_commander_sfx(guy) {
  if(guy.infil.subtype == "alpha")
    alias = "scn_infil_hackney_heli1_commander";
  else
    alias = "scn_infil_hackney_heli1_commander";

  if(soundexists(alias))
    guy playsoundonmovingent(alias);
}

scn_infil_hackney_heli_npc1(guy) {
  if(soundexists("scn_infil_hackney_heli_npc1"))
    guy playsoundonmovingent("scn_infil_hackney_heli_npc1");
}

scn_infil_hackney_heli_npc2(guy) {
  if(soundexists("scn_infil_hackney_heli_npc2"))
    guy playsoundonmovingent("scn_infil_hackney_heli_npc2");
}

scn_infil_hackney_heli_npc3(guy) {
  if(soundexists("scn_infil_hackney_heli_npc3"))
    guy playsoundonmovingent("scn_infil_hackney_heli_npc3");
}

scn_infil_hackney_heli_npc4(guy) {
  if(soundexists("scn_infil_hackney_heli_npc4"))
    guy playsoundonmovingent("scn_infil_hackney_heli_npc4");
}

scn_infil_hackney_heli_npc5(guy) {
  if(soundexists("scn_infil_hackney_heli_npc5"))
    guy playsoundonmovingent("scn_infil_hackney_heli_npc5");
}

scn_infil_hackney_heli_npc6(guy) {
  if(soundexists("scn_infil_hackney_heli_npc6"))
    guy playsoundonmovingent("scn_infil_hackney_heli_npc6");
}

blima_rumble_rope(guy) {
  level endon("prematch_over");
  level endon("infil_done");
  player = guy.player;
  player notify("stop_cam_shake");
  player endon("stop_cam_shake");
  player endon("death_or_disconnect");

  for(;;) {
    player playrumbleonpositionforclient("pistol_fire", player.origin);
    wait(randomfloatrange(0.05, 0.15));
  }
}

blima_rumble_ground(guy) {
  player = guy.player;
  player notify("stop_cam_shake");
  player playRumbleOnEntity("ground_pound_land");
  player lerpfovscalefactor(1, 0.5);
}

combat_start() {
  self notify("stop_cam_shake");
  self endon("stop_cam_shake");
  self.interactivecombat = 1;
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("combat_start");
  self setdemeanorviewmodel("normal");
  self lerpfovbypreset("default_2seconds");

  for(;;) {
    self playrumbleonpositionforclient("mig_rumble", self.origin);
    wait(randomfloatrange(0.15, 0.5));
  }
}

combat_end() {
  self notify("stop_cam_shake");
  self.interactivecombat = 0;
  scripts\mp\utility\infilexfil::updateshakeonplayer(0.06, 0.075, 2, self.origin, 8000, "mig_rumble", 0.05, 0.1);
  _id_3B64EB40368C1450::set("combat_start", "fire", 0);
  _id_3B64EB40368C1450::set("combat_start", "ads", 0);
  _id_3B64EB40368C1450::set("combat_start", "reload", 0);
  scripts\mp\utility\weapon::setrecoilscale();
}

blima_commander_play_sound_func(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  foreach(player in self.infil.players)
  player playsoundtoplayer(alias, player);
}

vehiclethinkpath(team, scene_node, _id_CA85A0DE365C6A63) {
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent setscriptablepartstate("engine", "on", 0);
  self.linktoent.unload_hover_offset = 300;
  self.linktoent.unload_time = 10;
  self.linktoent thread scripts\mp\infilexfil\infilexfil::vehicle_paths_helicopter(self.path);
  thread scripts\mp\infilexfil\infilexfil::heli_path(self.linktoent);
  self.linktoent waittill("reached_dynamic_path_end");
  self.linktoent delete();
  self.linktoent = undefined;
}

giveinteractiveinfilweapon() {
  weapon = makeweapon("iw8_lm_kilo121infil_mp", ["acog_west01"]);
  scripts\cp_mp\utility\inventory_utility::_giveweapon(weapon, undefined, undefined, 1);
  _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("infil_weapon");
  success = scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(weapon, 0);

  if(success) {
    self.infilweapon = weapon;
    _id_3B64EB40368C1450::set("infil_weapon", "weapon_switch", 0);
    scripts\mp\utility\weapon::setrecoilscale(0.0, 50);
  } else {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);
    scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  }

  return success;
}

updatehighinfilscore(_id_5936722EDA95901A) {
  level.highestinfilname = _id_5936722EDA95901A.name;
  level.highestinfilscore = _id_5936722EDA95901A.infilscore;

  foreach(player in level.players) {
    if(player.team == "allies")
      player iprintlnbold(level.highestinfilname + " is in the lead with" + level.highestinfilscore + " kills");
  }
}

announceinfilwinner() {
  level waittill("interactive_infil_complete");

  if(!isDefined(level.highestinfilname)) {
    return;
  }
  foreach(player in level.players) {
    if(player.team == "allies")
      player iprintlnbold(level.highestinfilname + " won with" + level.highestinfilscore + " kills");
  }
}

dummychopper() {
  _id_B5232BDC3EF7EF0B = (1325, -1200, 30);
  _id_9B47C9DC2D2C79B9 = (0, 90, 0);
  alpha = spawnVehicle("veh8_mil_air_blima", "alpha", "blima_hackney_infil_mp", _id_B5232BDC3EF7EF0B, _id_9B47C9DC2D2C79B9);
  alpha setvehicleteam("allies");
  alpha setCanDamage(0);
  alpha.animname = "blima";
  alpha setscriptablepartstate("engine", "on", 0);
  light = spawn("script_model", alpha.origin);
  light.angles = alpha.angles;
  light setModel("cop_marker_scriptable");
  light setscriptablepartstate("marker", "heliLight");
  light linkTo(alpha, "tag_origin", (0, 0, -60), (-90, 0, 0));
  alpha thread scripts\common\anim::anim_single_solo(alpha, "rappel_hackney_infil_alpha");
  _id_2DEFAEFA4C5FB2EB = (525, -1460, 30);
  _id_0FAD4CFA35BBE199 = (0, 180, 0);
  _id_66CDDB4195E97777 = spawnVehicle("veh8_mil_air_blima", "bravo", "blima_hackney_infil_mp", _id_2DEFAEFA4C5FB2EB, _id_0FAD4CFA35BBE199);
  _id_66CDDB4195E97777 setvehicleteam("allies");
  _id_66CDDB4195E97777 setCanDamage(0);
  _id_66CDDB4195E97777.animname = "blima";
  _id_66CDDB4195E97777 setscriptablepartstate("engine", "on", 0);
  light = spawn("script_model", _id_66CDDB4195E97777.origin);
  light.angles = _id_66CDDB4195E97777.angles;
  light setModel("cop_marker_scriptable");
  light setscriptablepartstate("marker", "heliLight");
  light linkTo(_id_66CDDB4195E97777, "tag_origin", (0, 0, -60), (-90, 0, 0));
  _id_66CDDB4195E97777 thread scripts\common\anim::anim_single_solo(_id_66CDDB4195E97777, "rappel_hackney_infil_bravo");
}

applymapvisionset() {
  switch (level.mapname) {
    case "mp_spear_pm":
      self visionsetnakedforplayer("infil_spear_pm", 0);
      break;
    default:
      return;
  }
}

removemapvisionset() {
  self endon("player_free_spot");
  wait 1.5;
  self visionsetnakedforplayer("", 1.0);
}

getcommanderassets(team) {
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

outsideheli(guy) {
  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;

  player thread clear_infil_ambient_zone();
  player thread removemapvisionset();
}

_id_AA9C0268656DEBFC(subtype) {
  _id_ADDD3217BC59A7B8 = spawnStruct();
  _id_5E0676140EECDF2D = "rappel_hackney_" + subtype + "_probe";
  _id_4AE45078DF12C7A7 = "rappel_hackney_" + subtype + "_light";
  probe = getEnt(_id_5E0676140EECDF2D, "script_noteworthy");
  lights = getEntArray(_id_4AE45078DF12C7A7, "targetname");

  if(!isDefined(probe))
    return undefined;

  foreach(_id_AC0E5E4AC96AAEA7 in lights) {
    if(!isDefined(_id_AC0E5E4AC96AAEA7))
      return undefined;
  }

  _id_ADDD3217BC59A7B8.probe = probe;
  _id_ADDD3217BC59A7B8.lights = lights;
  _id_89A2405953B84136(_id_ADDD3217BC59A7B8, 1);
  return _id_ADDD3217BC59A7B8;
}

_id_40AB1094757333E0(_id_ADDD3217BC59A7B8) {
  if(!isDefined(_id_ADDD3217BC59A7B8)) {
    return;
  }
  _id_ADDD3217BC59A7B8.probe show();
  _id_ADDD3217BC59A7B8.probe linkTo(self, "tag_origin", (16, 0, -80), (0, 0, 0));

  foreach(_id_AC0E5E4AC96AAEA7 in _id_ADDD3217BC59A7B8.lights) {
    if(isDefined(_id_AC0E5E4AC96AAEA7.original_intensity))
      _id_AC0E5E4AC96AAEA7 setlightintensity(_id_AC0E5E4AC96AAEA7.original_intensity);

    _id_AC0E5E4AC96AAEA7 linkTo(self);
  }
}

_id_89A2405953B84136(_id_ADDD3217BC59A7B8, _id_AC17789997E5B858) {
  if(!isDefined(_id_ADDD3217BC59A7B8)) {
    return;
  }
  _id_ADDD3217BC59A7B8.probe hide();

  foreach(_id_AC0E5E4AC96AAEA7 in _id_ADDD3217BC59A7B8.lights) {
    if(_id_AC17789997E5B858)
      _id_AC0E5E4AC96AAEA7.original_intensity = _id_AC0E5E4AC96AAEA7 getlightintensity();

    _id_AC0E5E4AC96AAEA7 setlightintensity(0.0);
  }
}