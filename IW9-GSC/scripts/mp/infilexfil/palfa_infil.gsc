/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\palfa_infil.gsc
*************************************************/

_id_3EF5F926204CBD9E(subtype) {
  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("palfa_infil");
  _id_453E4FC2C649FEA4 = [];
  _id_453E4FC2C649FEA4[0] = [0, 1];
  _id_453E4FC2C649FEA4[1] = [2, 3];
  _id_453E4FC2C649FEA4[2] = [4, 5];
  _id_453E4FC2C649FEA4[3] = [6, 7];
  _id_453E4FC2C649FEA4[4] = [8, 9];
  _id_453E4FC2C649FEA4[5] = [10, 11];
  _id_453E4FC2C649FEA4[6] = [12, 13];
  _id_453E4FC2C649FEA4[7] = [14, 15];
  _id_453E4FC2C649FEA4[8] = [16, 17];
  _id_453E4FC2C649FEA4[9] = [18, 19];
  thread scripts\mp\infilexfil\infilexfil::infil_add("infil_palfa", subtype, 20, 4, _id_453E4FC2C649FEA4, ::_id_4420CB72B132E463, ::_id_97BBCB5E314A57D5, ::_id_8154362D8A73C991);
}

_id_4420CB72B132E463(team, target, subtype, originalsubtype) {
  initanims(subtype, team, originalsubtype);
  scene_node = scripts\engine\utility::getStruct(target, "targetname");
  postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype);
  infil = spawn("script_origin", scene_node.origin);
  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;

  if(isDefined(scene_node.target)) {
    _id_8539ADBF8F73E390 = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 19; _id_AC0E594AC96AA3A8++) {
      _id_D4400603D79F0CF4 = getanimlength(level.scr_anim["slot_" + _id_AC0E594AC96AA3A8]["palfa_infil_intro"]);

      if(_id_D4400603D79F0CF4 > _id_8539ADBF8F73E390)
        _id_8539ADBF8F73E390 = _id_D4400603D79F0CF4;
    }

    infil._id_AC1EA7394A9A1A08 = _id_8539ADBF8F73E390;
    infil.path = scene_node;
  }

  infil.subtype = subtype;
  infil.originalsubtype = originalsubtype;
  infil thread infilthink(team, subtype);
  return infil;
}

postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype) {
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  switch (mapname) {
    case "mp_wartorn_gw":
      if(team == "axis")
        scene_node.origin = scene_node.origin - (0, 0, 22.5);
      else
        scene_node.origin = scene_node.origin - (0, 200, 22.5);

      break;
    default:
      break;
  }
}

_id_97BBCB5E314A57D5(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["palfa_infil_intro"]) + getanimlength(level.scr_anim["slot_0"]["palfa_infil_exit"]);
  return animlength;
}

_id_8154362D8A73C991(infil, _id_E4B9CD561C7C0DE6) {
  self endon("player_free_spot");

  if(isPlayer(self))
    self setclienttriggeraudiozone("palfa_preinfil_mix", 1);

  thread infil_radio_idle(infil);
  thread player_infil_end();
  spawnpos = infil.linktoent gettagorigin("tag_origin_animate");
  _id_B7850001037AA074 = infil.linktoent gettagangles("tag_origin_animate");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + _id_E4B9CD561C7C0DE6, spawnpos, _id_B7850001037AA074);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  self lerpfovbypreset("80_instant");
  self lerpfovscalefactor(0, 0);
  self visionsetnakedforplayer("mp_core_infil", 0.0);
  thread player_disconnect();
  scripts\mp\flags::gameflagwait("infil_started");
  infil.linktoent scripts\common\anim::anim_first_frame_solo(self.player_rig, "palfa_infil_intro", "tag_origin_animate");
  self.player_rig linkTo(infil.linktoent, "tag_origin_animate");
  thread scripts\mp\music_and_dialog::_id_03AA69E0E6827CE5();

  if(isDefined(self.animname) && !isai(self)) {
    self setclienttriggeraudiozone("iw9_gen_infil_mix", 2);

    if(soundexists("amb_infil_palfa_lr"))
      self playlocalsound("amb_infil_palfa_lr");
  }

  self setcinematicmotionoverride("disabled");
  self lerpviewangleclamp(1, 0.25, 0.25, 40, 40, 15, 5);
  thread clear_infil_ambient_zone();
  thread scripts\mp\infilexfil\infilexfil::_id_D41CBA513A03D958(4.0);
  infil.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "palfa_infil_intro", "tag_origin_animate");
  self.player_rig unlink();
  thread scripts\mp\class::unblockclasschange();
  infil scripts\mp\anim::anim_player_solo(self, self.player_rig, "palfa_infil_exit");
  self lerpfovscalefactor(1, 2);
  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
}

clear_infil_ambient_zone() {
  self endon("death_or_disconnect");
  wait 4;
  self setclienttriggeraudiozonepartialwithfade("mindia_infil_mix", 4, "mix");
  wait 4;
  self clearallsoundsubmixes();
  self clearclienttriggeraudiozone(2);
}

player_infil_end() {
  self endon("disconnect");
  level waittill("prematch_over");
  self notify("remove_rig");
  self clearclienttriggeraudiozone(1.0);
  self lerpfovbypreset("default_2seconds");
  scripts\mp\utility\player::setdof_default();
}

infil_radio_idle(infil) {
  if(isPlayer(self)) {
    if(!isDefined(self)) {
      return;
    }
    _id_E014D2BCF2D12FAC = spawn("script_origin", (0, 0, 0));
    _id_E014D2BCF2D12FAC showonlytoplayer(self);
    _id_E014D2BCF2D12FAC playLoopSound("dx_mpo_ukop_radio_chatter");
    _id_E014D2BCF2D12FAC playLoopSound("amb_infil_palfa_pre");
    scripts\mp\flags::gameflagwait("infil_started");
    wait 1;
    _id_E014D2BCF2D12FAC stoploopsound("dx_mpo_ukop_radio_chatter");
    _id_E014D2BCF2D12FAC stoploopsound("amb_infil_palfa_pre");
    _id_E014D2BCF2D12FAC delete();
  }
}

player_disconnect() {
  level endon("prematch_over");
  self waittill("death_or_disconnect");

  if(isDefined(self)) {
    self visionsetnakedforplayer("");
    self clearclienttriggeraudiozone(0.0);
    self lerpfovbypreset("default");
    self setviewmodeldepthoffield(0, 0, 18);
    scripts\mp\utility\player::setdof_default();
  }
}

spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  if(!isDefined(self.actors))
    self.actors = [];

  self.actors[self.actors.size] = self.linktoent spawn_anim_model("crew1", "tag_origin_animate", "fullbody_sp_ally_helicopter_crew_chief");
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("crew2", "tag_origin_animate", "fullbody_sp_ally_helicopter_crew_chief");

  switch (team) {
    case "axis":
      self.actors[self.actors.size] = self.linktoent spawn_anim_model("crew3", "tag_origin_animate", "body_russian_helicopter_pilot", "head_russian_helicopter_pilot_opaque");
      break;
    case "allies":
      self.actors[self.actors.size] = self.linktoent spawn_anim_model("crew3", "tag_origin_animate", "body_pilot_helicopter_british", "head_pilot_helicopter_british");
      break;
    default:
      self.actors[self.actors.size] = self.linktoent spawn_anim_model("crew3", "tag_origin_animate", "fullbody_sp_ally_helicopter_crew_chief");
      break;
  }

  foreach(actor in self.actors)
  actor.infil = self;
}

_id_E9EE7133BD5841CF(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  foreach(player in self._id_B389B85C70DC3C9B.players)
  player playsoundtoplayer(alias, player);
}

infilthink(team, _id_CA85A0DE365C6A63) {
  _id_E026A614F7467557 = getdvarfloat("r_mbVelocityScale", 0.2);

  foreach(ent in getEntArray("infil_delete", "script_noteworthy"))
  ent delete();

  thread vehiclethink(team, self.scene_node, _id_CA85A0DE365C6A63);
  thread actorthink(team, self.scene_node, _id_CA85A0DE365C6A63);
  scripts\mp\flags::gameflagwait("infil_started");
  setDvar("r_spotLightEntityShadows", 1);
  setDvar("r_mbVelocityScale", 1.0);
  level notify("start_scene");
  level waittill("prematch_over");
  setDvar("r_spotLightEntityShadows", 0);
  setDvar("r_mbVelocityScale", _id_E026A614F7467557);

  while(isDefined(self.linktoent) || isDefined(self.actors))
    waitframe();

  level.infilsactive--;
  self delete();
}

ropethink(_id_CA85A0DE365C6A63) {
  self.linktoent._id_A6985B5B48B0A0E3 = self.linktoent spawn_anim_model("rope_fl", "tag_origin_animate", "equipment_fast_rope_wm_01_infil_heli_l");
  self.linktoent._id_A698595B48B09C7D = self.linktoent spawn_anim_model("rope_fr", "tag_origin_animate", "equipment_fast_rope_wm_01_infil_heli_l");
  self.linktoent._id_A6875B5B489E9687 = self.linktoent spawn_anim_model("rope_bl", "tag_origin_animate", "equipment_fast_rope_wm_01_infil_heli_l");
  self.linktoent._id_A687415B489E5D59 = self.linktoent spawn_anim_model("rope_br", "tag_origin_animate", "equipment_fast_rope_wm_01_infil_heli_l");
  self.linktoent._id_A6985B5B48B0A0E3 scripts\common\anim::anim_first_frame_solo(self.linktoent._id_A6985B5B48B0A0E3, "palfa_infil");
  self.linktoent._id_A698595B48B09C7D scripts\common\anim::anim_first_frame_solo(self.linktoent._id_A698595B48B09C7D, "palfa_infil");
  self.linktoent._id_A6875B5B489E9687 scripts\common\anim::anim_first_frame_solo(self.linktoent._id_A6875B5B489E9687, "palfa_infil");
  self.linktoent._id_A687415B489E5D59 scripts\common\anim::anim_first_frame_solo(self.linktoent._id_A687415B489E5D59, "palfa_infil");
  self.linktoent thread scripts\common\anim::anim_single_solo(self.linktoent._id_A6985B5B48B0A0E3, "palfa_infil", "tag_origin_animate");
  self.linktoent thread scripts\common\anim::anim_single_solo(self.linktoent._id_A698595B48B09C7D, "palfa_infil", "tag_origin_animate");
  self.linktoent thread scripts\common\anim::anim_single_solo(self.linktoent._id_A6875B5B489E9687, "palfa_infil", "tag_origin_animate");
  self.linktoent thread scripts\common\anim::anim_single_solo(self.linktoent._id_A687415B489E5D59, "palfa_infil", "tag_origin_animate");
  duration = getanimlength(level.scr_anim[self.linktoent._id_A6985B5B48B0A0E3.animname]["palfa_infil"]);
  wait(duration);

  if(!isDefined(self.linktoent)) {
    return;
  }
  self.linktoent._id_A6985B5B48B0A0E3 unlink();
  self.linktoent._id_A698595B48B09C7D unlink();
  self.linktoent._id_A6875B5B489E9687 unlink();
  self.linktoent._id_A687415B489E5D59 unlink();
}

vehiclethink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  self.linktoent = spawninfilvehicle(scene_node, team, _id_CA85A0DE365C6A63);
  self._id_ADDD3217BC59A7B8 = _id_7D7E095D01F0873C(_id_CA85A0DE365C6A63);
  scripts\common\anim::anim_first_frame_solo(self.linktoent, "palfa_infil");
  self.linktoent _id_66A58C7E02607034(self._id_ADDD3217BC59A7B8);
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent setscriptablepartstate("infil_lights", "on", 0);
  self.linktoent playsoundonmovingent("scn_infil_palfa_heli_ext_lr");
  thread ropethink(_id_CA85A0DE365C6A63);
  thread scripts\common\anim::anim_single_solo(self.linktoent, "palfa_infil");

  if(isDefined(self.path)) {
    animlength = getanimlength(level.scr_anim["palfa"]["palfa_infil"]);
    wait(animlength);
    self.linktoent stopanimScripted();

    if(self.linktoent vehicle_isphysveh())
      self.linktoent vehphys_setdefaultmotion();

    startstruct = spawnStruct();
    startstruct.origin = self.linktoent.origin;
    startstruct.angles = self.linktoent.angles;
    startstruct.radius = 500;
    startstruct.speed = 30;
    startstruct.target = self.path.target;
    self.linktoent scripts\common\vehicle_paths::vehicle_paths_helicopter(startstruct);
  } else {
    animlength = getanimlength(level.scr_anim["palfa"]["palfa_infil"]);
    wait(animlength);
  }

  thread _id_393CBD8435FCB5C0();

  if(isDefined(self.linktoent)) {
    self.linktoent delete();
    self.linktoent = undefined;
  }
}

actorthink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  thread spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "palfa_infil", "tag_origin_animate");
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent scripts\common\anim::anim_single(self.actors, "palfa_infil", "tag_origin_animate");
  duration = getanimlength(level.scr_anim["crew1"]["palfa_infil"]);
  wait(duration);

  foreach(actor in self.actors) {
    if(isDefined(actor))
      actor delete();
  }

  self.actors = undefined;
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

initanims(subtype, team, originalsubtype) {
  script_model_alpha_anims(subtype);
  _id_068AAB9F69431CE1(subtype, team, originalsubtype);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_6", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_7", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_8", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_9", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_10", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_11", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_12", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_13", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_14", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_15", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_16", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_17", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_18", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_19", "fov_63_2", scripts\mp\utility\infilexfil::player_fov_default_2);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_6", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_7", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_8", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_9", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_10", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_11", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_12", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_13", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_14", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_15", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_16", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_17", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_18", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_19", "player_lock_look_1_second", scripts\mp\utility\infilexfil::player_lock_look_1_second);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_6", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_7", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_8", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_9", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_10", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_11", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_12", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_13", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_14", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_15", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_16", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_17", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_18", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_19", "free_look", scripts\mp\utility\infilexfil::player_free_look);
  scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_6", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_7", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_8", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_9", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_10", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_11", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_12", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_13", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_14", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_15", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_16", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_17", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_18", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
  scripts\common\anim::addnotetrack_customfunction("slot_19", "scn_infil_palfa_rope_foley", ::_id_EFDD068B11C62F56);
}

#using_animtree("script_model");

script_model_alpha_anims(subtype) {
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_0_intro;
  level.scr_animname["slot_0"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_0_intro";
  level.scr_eventanim["slot_0"]["palfa_infil_intro"] = "palfa_infil_intro_0";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_1_intro;
  level.scr_animname["slot_1"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_1_intro";
  level.scr_eventanim["slot_1"]["palfa_infil_intro"] = "palfa_infil_intro_1";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_2_intro;
  level.scr_animname["slot_2"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_2_intro";
  level.scr_eventanim["slot_2"]["palfa_infil_intro"] = "palfa_infil_intro_2";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_3_intro;
  level.scr_animname["slot_3"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_3_intro";
  level.scr_eventanim["slot_3"]["palfa_infil_intro"] = "palfa_infil_intro_3";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_4_intro;
  level.scr_animname["slot_4"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_4_intro";
  level.scr_eventanim["slot_4"]["palfa_infil_intro"] = "palfa_infil_intro_4";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_5_intro;
  level.scr_animname["slot_5"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_5_intro";
  level.scr_eventanim["slot_5"]["palfa_infil_intro"] = "palfa_infil_intro_5";
  level.scr_animtree["slot_6"] = #animtree;
  level.scr_anim["slot_6"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_6_intro;
  level.scr_animname["slot_6"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_6_intro";
  level.scr_eventanim["slot_6"]["palfa_infil_intro"] = "palfa_infil_intro_6";
  level.scr_animtree["slot_7"] = #animtree;
  level.scr_anim["slot_7"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_7_intro;
  level.scr_animname["slot_7"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_7_intro";
  level.scr_eventanim["slot_7"]["palfa_infil_intro"] = "palfa_infil_intro_7";
  level.scr_animtree["slot_8"] = #animtree;
  level.scr_anim["slot_8"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_8_intro;
  level.scr_animname["slot_8"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_8_intro";
  level.scr_eventanim["slot_8"]["palfa_infil_intro"] = "palfa_infil_intro_8";
  level.scr_animtree["slot_9"] = #animtree;
  level.scr_anim["slot_9"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_9_intro;
  level.scr_animname["slot_9"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_9_intro";
  level.scr_eventanim["slot_9"]["palfa_infil_intro"] = "palfa_infil_intro_9";
  level.scr_animtree["slot_10"] = #animtree;
  level.scr_anim["slot_10"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_10_intro;
  level.scr_animname["slot_10"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_10_intro";
  level.scr_eventanim["slot_10"]["palfa_infil_intro"] = "palfa_infil_intro_10";
  level.scr_animtree["slot_11"] = #animtree;
  level.scr_anim["slot_11"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_11_intro;
  level.scr_animname["slot_11"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_11_intro";
  level.scr_eventanim["slot_11"]["palfa_infil_intro"] = "palfa_infil_intro_11";
  level.scr_animtree["slot_12"] = #animtree;
  level.scr_anim["slot_12"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_12_intro;
  level.scr_animname["slot_12"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_12_intro";
  level.scr_eventanim["slot_12"]["palfa_infil_intro"] = "palfa_infil_intro_12";
  level.scr_animtree["slot_13"] = #animtree;
  level.scr_anim["slot_13"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_13_intro;
  level.scr_animname["slot_13"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_13_intro";
  level.scr_eventanim["slot_13"]["palfa_infil_intro"] = "palfa_infil_intro_13";
  level.scr_animtree["slot_14"] = #animtree;
  level.scr_anim["slot_14"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_14_intro;
  level.scr_animname["slot_14"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_14_intro";
  level.scr_eventanim["slot_14"]["palfa_infil_intro"] = "palfa_infil_intro_14";
  level.scr_animtree["slot_15"] = #animtree;
  level.scr_anim["slot_15"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_15_intro;
  level.scr_animname["slot_15"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_15_intro";
  level.scr_eventanim["slot_15"]["palfa_infil_intro"] = "palfa_infil_intro_15";
  level.scr_animtree["slot_16"] = #animtree;
  level.scr_anim["slot_16"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_16_intro;
  level.scr_animname["slot_16"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_16_intro";
  level.scr_eventanim["slot_16"]["palfa_infil_intro"] = "palfa_infil_intro_16";
  level.scr_animtree["slot_17"] = #animtree;
  level.scr_anim["slot_17"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_17_intro;
  level.scr_animname["slot_17"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_17_intro";
  level.scr_eventanim["slot_17"]["palfa_infil_intro"] = "palfa_infil_intro_17";
  level.scr_animtree["slot_18"] = #animtree;
  level.scr_anim["slot_18"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_18_intro;
  level.scr_animname["slot_18"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_18_intro";
  level.scr_eventanim["slot_18"]["palfa_infil_intro"] = "palfa_infil_intro_18";
  level.scr_animtree["slot_19"] = #animtree;
  level.scr_anim["slot_19"]["palfa_infil_intro"] = % iw9_mp_infil_palfa_seat_19_intro;
  level.scr_animname["slot_19"]["palfa_infil_intro"] = "iw9_mp_infil_palfa_seat_19_intro";
  level.scr_eventanim["slot_19"]["palfa_infil_intro"] = "palfa_infil_intro_19";
  level.scr_anim["slot_0"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_0_exit;
  level.scr_animname["slot_0"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_0_exit";
  level.scr_eventanim["slot_0"]["palfa_infil_exit"] = "palfa_infil_exit_0";
  level.scr_anim["slot_1"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_1_exit;
  level.scr_animname["slot_1"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_1_exit";
  level.scr_eventanim["slot_1"]["palfa_infil_exit"] = "palfa_infil_exit_1";
  level.scr_anim["slot_2"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_2_exit;
  level.scr_animname["slot_2"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_2_exit";
  level.scr_eventanim["slot_2"]["palfa_infil_exit"] = "palfa_infil_exit_2";
  level.scr_anim["slot_3"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_3_exit;
  level.scr_animname["slot_3"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_3_exit";
  level.scr_eventanim["slot_3"]["palfa_infil_exit"] = "palfa_infil_exit_3";
  level.scr_anim["slot_4"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_4_exit;
  level.scr_animname["slot_4"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_4_exit";
  level.scr_eventanim["slot_4"]["palfa_infil_exit"] = "palfa_infil_exit_4";
  level.scr_anim["slot_5"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_5_exit;
  level.scr_animname["slot_5"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_5_exit";
  level.scr_eventanim["slot_5"]["palfa_infil_exit"] = "palfa_infil_exit_5";
  level.scr_anim["slot_6"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_6_exit;
  level.scr_animname["slot_6"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_6_exit";
  level.scr_eventanim["slot_6"]["palfa_infil_exit"] = "palfa_infil_exit_6";
  level.scr_anim["slot_7"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_7_exit;
  level.scr_animname["slot_7"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_7_exit";
  level.scr_eventanim["slot_7"]["palfa_infil_exit"] = "palfa_infil_exit_7";
  level.scr_anim["slot_8"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_8_exit;
  level.scr_animname["slot_8"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_8_exit";
  level.scr_eventanim["slot_8"]["palfa_infil_exit"] = "palfa_infil_exit_8";
  level.scr_anim["slot_9"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_9_exit;
  level.scr_animname["slot_9"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_9_exit";
  level.scr_eventanim["slot_9"]["palfa_infil_exit"] = "palfa_infil_exit_9";
  level.scr_anim["slot_10"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_10_exit;
  level.scr_animname["slot_10"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_10_exit";
  level.scr_eventanim["slot_10"]["palfa_infil_exit"] = "palfa_infil_exit_10";
  level.scr_anim["slot_11"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_11_exit;
  level.scr_animname["slot_11"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_11_exit";
  level.scr_eventanim["slot_11"]["palfa_infil_exit"] = "palfa_infil_exit_11";
  level.scr_anim["slot_12"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_12_exit;
  level.scr_animname["slot_12"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_12_exit";
  level.scr_eventanim["slot_12"]["palfa_infil_exit"] = "palfa_infil_exit_12";
  level.scr_anim["slot_13"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_13_exit;
  level.scr_animname["slot_13"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_13_exit";
  level.scr_eventanim["slot_13"]["palfa_infil_exit"] = "palfa_infil_exit_13";
  level.scr_anim["slot_14"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_14_exit;
  level.scr_animname["slot_14"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_14_exit";
  level.scr_eventanim["slot_14"]["palfa_infil_exit"] = "palfa_infil_exit_14";
  level.scr_anim["slot_15"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_15_exit;
  level.scr_animname["slot_15"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_15_exit";
  level.scr_eventanim["slot_15"]["palfa_infil_exit"] = "palfa_infil_exit_15";
  level.scr_anim["slot_16"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_16_exit;
  level.scr_animname["slot_16"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_16_exit";
  level.scr_eventanim["slot_16"]["palfa_infil_exit"] = "palfa_infil_exit_16";
  level.scr_anim["slot_17"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_17_exit;
  level.scr_animname["slot_17"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_17_exit";
  level.scr_eventanim["slot_17"]["palfa_infil_exit"] = "palfa_infil_exit_17";
  level.scr_anim["slot_18"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_18_exit;
  level.scr_animname["slot_18"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_18_exit";
  level.scr_eventanim["slot_18"]["palfa_infil_exit"] = "palfa_infil_exit_18";
  level.scr_anim["slot_19"]["palfa_infil_exit"] = % iw9_mp_infil_palfa_seat_19_exit;
  level.scr_animname["slot_19"]["palfa_infil_exit"] = "iw9_mp_infil_palfa_seat_19_exit";
  level.scr_eventanim["slot_19"]["palfa_infil_exit"] = "palfa_infil_exit_19";
  level.scr_animtree["crew1"] = #animtree;
  level.scr_anim["crew1"]["palfa_infil"] = % iw9_mp_infil_palfa_crew_1;
  level.scr_animname["crew1"]["palfa_infil"] = "iw9_mp_infil_palfa_crew_1";
  level.scr_eventanim["crew1"]["palfa_infil"] = "palfa_infil_crew_1";
  level.scr_animtree["crew2"] = #animtree;
  level.scr_anim["crew2"]["palfa_infil"] = % iw9_mp_infil_palfa_crew_2;
  level.scr_animname["crew2"]["palfa_infil"] = "iw9_mp_infil_palfa_crew_2";
  level.scr_eventanim["crew2"]["palfa_infil"] = "palfa_infil_crew_2";
  level.scr_animtree["crew3"] = #animtree;
  level.scr_anim["crew3"]["palfa_infil"] = % iw9_mp_infil_palfa_crew_3;
  level.scr_animname["crew3"]["palfa_infil"] = "iw9_mp_infil_palfa_crew_3";
  level.scr_eventanim["crew3"]["palfa_infil"] = "palfa_infil_crew_3";
  level.scr_animtree["rope_fl"] = #animtree;
  level.scr_anim["rope_fl"]["palfa_infil"] = % iw9_mp_infil_palfa_rope_fl;
  level.scr_animname["rope_fl"]["palfa_infil"] = "iw9_mp_infil_palfa_rope_fl";
  level.scr_animtree["rope_fr"] = #animtree;
  level.scr_anim["rope_fr"]["palfa_infil"] = % iw9_mp_infil_palfa_rope_fr;
  level.scr_animname["rope_fr"]["palfa_infil"] = "iw9_mp_infil_palfa_rope_fr";
  level.scr_animtree["rope_bl"] = #animtree;
  level.scr_anim["rope_bl"]["palfa_infil"] = % iw9_mp_infil_palfa_rope_bl;
  level.scr_animname["rope_bl"]["palfa_infil"] = "iw9_mp_infil_palfa_rope_bl";
  level.scr_animtree["rope_br"] = #animtree;
  level.scr_anim["rope_br"]["palfa_infil"] = % iw9_mp_infil_palfa_rope_br;
  level.scr_animname["rope_br"]["palfa_infil"] = "iw9_mp_infil_palfa_rope_br";
}

#using_animtree("mp_vehicles_always_loaded");

_id_068AAB9F69431CE1(subtype, team, originalsubtype) {
  level.scr_anim["palfa"]["palfa_infil"] = % iw9_mp_infil_palfa_vehicle;
}

spawninfilvehicle(scene_node, team, _id_CA85A0DE365C6A63) {
  spawnpos = scene_node.origin;
  _id_B7850001037AA074 = scene_node.angles;
  model = "veh9_mil_air_heli_palfa_doors_open_vehphys_mp";
  _id_AB5CD311F5DC80A6 = "veh9_mil_air_heli_palfa_physics_mp";
  vehicle = spawnVehicle(model, _id_CA85A0DE365C6A63, _id_AB5CD311F5DC80A6, spawnpos, _id_B7850001037AA074);
  vehicle setvehicleteam(team);
  vehicle.animname = "palfa";
  vehicle setCanDamage(0);

  if(vehicle vehicle_isphysveh()) {
    vehicle _meth_247AD6A91F6A4FFE(1);
    vehicle vehphys_forcekeyframedmotion();
  } else
    vehicle notsolid();

  vehicle hidepart("tag_main_rotor_blade_01");
  vehicle hidepart("tag_main_rotor_blade_02");
  vehicle hidepart("tag_main_rotor_blade_03");
  vehicle hidepart("tag_main_rotor_blade_04");
  vehicle hidepart("tag_main_rotor_blade_05");
  vehicle hidepart("tag_main_rotor_blade_06");
  vehicle hidepart("tag_tail_rotor_blade_01");
  vehicle hidepart("tag_tail_rotor_blade_02");
  vehicle hidepart("tag_tail_rotor_blade_03");
  vehicle hidepart("tag_tail_rotor_blade_04");
  vehicle.infil = self;
  vehicle vehicle_turnengineoff();
  return vehicle;
}

_id_7D7E095D01F0873C(subtype) {
  _id_ADDD3217BC59A7B8 = spawnStruct();
  _id_5E0676140EECDF2D = "palfa_" + subtype + "_probe";
  _id_83D076584339CBE2 = getEntArray(_id_5E0676140EECDF2D, "script_noteworthy");
  probe = undefined;

  foreach(ent in _id_83D076584339CBE2) {
    if(!isDefined(ent) || istrue(ent.claimed)) {
      continue;
    }
    probe = ent;
    break;
  }

  if(!isDefined(probe))
    return undefined;

  probe.claimed = 1;
  _id_ADDD3217BC59A7B8.probe = probe;
  _id_89A2405953B84136(_id_ADDD3217BC59A7B8, 1);
  return _id_ADDD3217BC59A7B8;
}

_id_66A58C7E02607034(_id_ADDD3217BC59A7B8) {
  if(!isDefined(_id_ADDD3217BC59A7B8)) {
    return;
  }
  _id_ADDD3217BC59A7B8.probe show();
  _id_ADDD3217BC59A7B8.probe linkTo(self, "tag_origin", (-51, 0, -164), (0, 0, 0));
}

_id_89A2405953B84136(_id_ADDD3217BC59A7B8, _id_AC17789997E5B858) {
  if(!isDefined(_id_ADDD3217BC59A7B8)) {
    return;
  }
  _id_ADDD3217BC59A7B8.probe hide();
}

_id_EFDD068B11C62F56(guy) {
  if(!isDefined(guy._id_8655D6F4C9340DB1))
    guy playsoundonmovingent("scn_infil_palfa_rope_foley");

  guy._id_8655D6F4C9340DB1 = 1;
}

_id_393CBD8435FCB5C0() {
  wait 5;
  _id_7AB5B649FA408138::_id_F4E0FF5CB899686D("palfa_infil");
}