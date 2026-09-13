/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\infilexfil\blima_infil.gsc
*************************************************/

_id_6CB969A7647DC10F(subtype) {
  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("blima_infil");
  thread scripts\mp\infilexfil\infilexfil::infil_add("infil_blima", subtype, 6, 4, undefined, ::_id_41496C26B8D3660C, ::_id_807B3E73F0750918, ::_id_00807C8F0E4F5AD6);
}

_id_41496C26B8D3660C(team, target, subtype, originalsubtype) {
  initanims(subtype, team, originalsubtype);
  scene_node = scripts\engine\utility::getStruct(target, "targetname");
  postlaunchscenenodecorrection(scene_node, team, subtype, originalsubtype);
  infil = spawn("script_origin", scene_node.origin);
  infil.angles = scene_node.angles;
  infil.scene_node = scene_node;

  if(isDefined(scene_node.target)) {
    infil._id_AC1EA7394A9A1A08 = getanimlength(level.scr_anim["blima"]["blima_infil_" + subtype]);
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
    case "mp_downtown_gw":
      switch (originalsubtype) {
        case "alpha":
          if(team == "axis")
            scene_node.angles = scene_node.angles + (0, 8, 0);
          else {
            scene_node.angles = scene_node.angles + (0, 23, 0);
            scene_node.origin = scene_node.origin + anglesToForward(scene_node.angles) * 100;
          }

          break;
        case "alpha1":
          if(team == "axis")
            scene_node.angles = scene_node.angles + (0, -8, 0);
          else
            scene_node.angles = scene_node.angles + (0, -3, 0);

          break;
        case "alpha2":
          if(team == "axis") {
            scene_node.angles = scene_node.angles + (0, -3, 0);
            scene_node.origin = scene_node.origin + anglesToForward(scene_node.angles) * 200;
          } else
            scene_node.angles = scene_node.angles + (0, 12, 0);

          break;
      }

      break;
    case "mp_farms2_gw":
      switch (originalsubtype) {
        case "bravo":
          if(team == "allies")
            scene_node.origin = scene_node.origin - (0, 0, 86);
      }
    case "mp_promenade_gw":
      switch (originalsubtype) {
        case "alpha":
          if(team == "allies")
            scene_node.angles = scene_node.angles - (0, 30, 0);
      }

      break;
  }
}

_id_807B3E73F0750918(subtype) {
  animlength = getanimlength(level.scr_anim["slot_0"]["blima_infil"]);
  return animlength;
}

_id_00807C8F0E4F5AD6(infil, _id_E4B9CD561C7C0DE6) {
  self endon("player_free_spot");

  if(isPlayer(self))
    self setclienttriggeraudiozone("blima_preinfil_mix", 1);

  thread infil_radio_idle(infil);
  thread player_infil_end();
  spawnpos = infil.linktoent gettagorigin("body_animate_jnt");
  _id_B7850001037AA074 = infil.linktoent gettagangles("body_animate_jnt");
  thread scripts\mp\utility\infilexfil::infil_player_rig_updated("slot_" + _id_E4B9CD561C7C0DE6, spawnpos, _id_B7850001037AA074);
  self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe_heli");
  self lerpfovbypreset("80_instant");
  self lerpfovscalefactor(0, 0);
  self visionsetnakedforplayer("mp_core_infil", 0.0);
  thread player_disconnect();
  scripts\mp\flags::gameflagwait("infil_started");
  infil.linktoent scripts\common\anim::anim_first_frame_solo(self.player_rig, "blima_infil", "body_animate_jnt");
  self.player_rig linkTo(infil.linktoent, "body_animate_jnt");
  thread scripts\mp\music_and_dialog::_id_03AA69E0E6827CE5();

  if(isDefined(self.animname) && !isai(self))
    thread _id_6E440E13675E7A78();

  self setcinematicmotionoverride("disabled");
  self lerpviewangleclamp(1, 0.25, 0.25, 60, 60, 5, 5);
  thread scripts\mp\infilexfil\infilexfil::_id_D41CBA513A03D958(1.0);
  infil.linktoent scripts\mp\anim::anim_player_solo(self, self.player_rig, "blima_infil");
  thread scripts\mp\class::unblockclasschange();
  self lerpfovscalefactor(1, 2);

  if(isDefined(self.player_rig) && self.player_rig islinked())
    self.player_rig unlink();

  self visionsetnakedforplayer("", 0.75);
  self setdemeanorviewmodel("normal");
  thread clear_infil_ambient_zone();
  self clearcinematicmotionoverride();
  self disablephysicaldepthoffieldscripting();
}

_id_6E440E13675E7A78() {
  self endon("death_or_disconnect");
  self setclienttriggeraudiozone("iw9_gen_infil_mix", 2);
  soundalias = "scn_infil_blima_plr1";
  waittime = 3.3;

  switch (self.animname) {
    case "slot_0":
      soundalias = "scn_infil_blima_plr1";
      waittime = 3.3;
      break;
    case "slot_1":
      soundalias = "scn_infil_blima_plr2";
      waittime = 3.45;
      break;
    case "slot_2":
      soundalias = "scn_infil_blima_plr3";
      waittime = 5.05;
      break;
    case "slot_3":
      soundalias = "scn_infil_blima_plr4";
      waittime = 5.65;
      break;
    case "slot_4":
      soundalias = "scn_infil_blima_plr5";
      waittime = 6.6;
      break;
    case "slot_5":
      soundalias = "scn_infil_blima_plr6";
      waittime = 6.9;
      break;
    default:
      soundalias = "scn_infil_blima_plr1";
      waittime = 3.3;
      break;
  }

  self setclienttriggeraudiozone("iw9_gen_infil_mix", 2);
  wait(waittime);

  if(soundexists(soundalias))
    self playlocalsound(soundalias);
}

clear_infil_ambient_zone() {
  self endon("death_or_disconnect");
  wait 1;

  if(isDefined(self._id_5B097BDE4417D7AD))
    self clearsoundsubmix(self._id_5B097BDE4417D7AD, 2);

  self clearclienttriggeraudiozone(2);
}

player_infil_end() {
  self endon("disconnect");
  level waittill("prematch_over");
  self notify("remove_rig");
  self lerpfovbypreset("default_2seconds");
  self clearclienttriggeraudiozone(1.0);
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
    scripts\mp\flags::gameflagwait("infil_started");
    wait 1;
    _id_E014D2BCF2D12FAC stoploopsound("dx_mpo_ukop_radio_chatter");
    _id_E014D2BCF2D12FAC stoploopsound("amb_infil_blima_pre");
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

  self.actors[self.actors.size] = self.linktoent spawn_anim_model("crew1", "body_animate_jnt", "fullbody_sp_ally_helicopter_crew_chief");
  self.actors[self.actors.size] = self.linktoent spawn_anim_model("crew2", "body_animate_jnt", "fullbody_sp_ally_helicopter_crew_chief");

  foreach(actor in self.actors)
  actor.infil = self;
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
  self.linktoent._id_7D1A90814C8500FF = self.linktoent spawn_anim_model("rope_l", "origin_animate_jnt", "equipment_fast_rope_wm_01_infil_heli_l");
  self.linktoent._id_7D1AA6814C853161 = self.linktoent spawn_anim_model("rope_r", "origin_animate_jnt", "equipment_fast_rope_wm_01_infil_heli_l");
  self.linktoent._id_7D1A90814C8500FF scripts\common\anim::anim_first_frame_solo(self.linktoent._id_7D1A90814C8500FF, "blima_infil");
  self.linktoent._id_7D1AA6814C853161 scripts\common\anim::anim_first_frame_solo(self.linktoent._id_7D1AA6814C853161, "blima_infil");
  self.linktoent thread scripts\common\anim::anim_single_solo(self.linktoent._id_7D1A90814C8500FF, "blima_infil", "origin_animate_jnt");
  self.linktoent thread scripts\common\anim::anim_single_solo(self.linktoent._id_7D1AA6814C853161, "blima_infil", "origin_animate_jnt");
  duration = getanimlength(level.scr_anim[self.linktoent._id_7D1A90814C8500FF.animname]["blima_infil"]);
  wait(duration);
  self.linktoent notify("rope_drop");
  self.linktoent._id_7D1A90814C8500FF unlink();
  self.linktoent._id_7D1AA6814C853161 unlink();
}

vehiclethink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  self.linktoent = spawninfilvehicle(scene_node, team, _id_CA85A0DE365C6A63);
  self._id_ADDD3217BC59A7B8 = _id_8C1C6F0A556C30E9(_id_CA85A0DE365C6A63);
  self.linktoent vehicle_turnengineoff();

  if(self.originalsubtype != self.subtype && (getDvar("g_mapname") == "mp_downtown_gw" || getDvar("g_mapname") == "mp_port2_gw"))
    _id_CA85A0DE365C6A63 = self.originalsubtype;

  scripts\common\anim::anim_first_frame_solo(self.linktoent, "blima_infil_" + _id_CA85A0DE365C6A63);
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent _id_7E05C22E552B8EED(self._id_ADDD3217BC59A7B8);
  thread ropethink(_id_CA85A0DE365C6A63);
  thread scripts\common\anim::anim_single_solo(self.linktoent, "blima_infil_" + _id_CA85A0DE365C6A63);
  animlength = getanimlength(level.scr_anim["blima"]["blima_infil_" + _id_CA85A0DE365C6A63]);
  self.linktoent thread _id_08D92FB386A75E9F();

  if(isDefined(self.path)) {
    self.linktoent waittill("rope_drop");
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
    wait(animlength);
    thread scripts\common\anim::anim_single_solo(self.linktoent, "blima_infil_" + _id_CA85A0DE365C6A63 + "exit");
    _id_C925C1AA50C8EE10 = getanimlength(level.scr_anim["blima"]["blima_infil_" + _id_CA85A0DE365C6A63 + "exit"]);
    wait(_id_C925C1AA50C8EE10);
  }

  _id_89A2405953B84136(self._id_ADDD3217BC59A7B8, 0);
  self.linktoent delete();
  self.linktoent = undefined;
  thread _id_F764364C2AC0250D();
}

_id_08D92FB386A75E9F() {
  wait 2;
  self playsoundonmovingent("scn_infil_blima_heli_ext_lr");
}

actorthink(team, scene_node, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73) {
  thread spawnactors(team, _id_CA85A0DE365C6A63, _id_16E334D22D37BE73);
  self.linktoent scripts\common\anim::anim_first_frame(self.actors, "blima_infil", "body_animate_jnt");
  scripts\mp\flags::gameflagwait("infil_started");
  self.linktoent scripts\common\anim::anim_single(self.actors, "blima_infil", "body_animate_jnt");
  duration = getanimlength(level.scr_anim["crew1"]["blima_infil"]);
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
  vehicles_alpha_anims(subtype, team, originalsubtype);
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
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_6", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_7", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_8", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_9", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_10", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_11", "shake_running", scripts\mp\utility\infilexfil::cam_shake_running, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "shake_off", ::customground, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "shake_off", ::customground, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "shake_off", ::customground, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "shake_off", ::customground, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "shake_off", ::customground, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "shake_off", ::customground, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_6", "shake_off", ::customground, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_7", "shake_off", ::customground, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_8", "shake_off", ::customground, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_9", "shake_off", ::customground, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_10", "shake_off", ::customground, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_11", "shake_off", ::customground, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_1", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_2", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_3", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_4", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_5", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_6", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_7", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_8", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_9", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_10", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_11", "equip_nvg", scripts\mp\utility\infilexfil::player_equip_nvg, "blima_infil");
  scripts\common\anim::addnotetrack_customfunction("slot_0", "scn_infil_blima_npc1", ::_id_8A8894FF587A8195);
  scripts\common\anim::addnotetrack_customfunction("slot_1", "scn_infil_blima_npc2", ::_id_8A8891FF587A7AFC);
  scripts\common\anim::addnotetrack_customfunction("slot_2", "scn_infil_blima_npc3", ::_id_8A8892FF587A7D2F);
  scripts\common\anim::addnotetrack_customfunction("slot_3", "scn_infil_blima_npc4", ::_id_8A888FFF587A7696);
  scripts\common\anim::addnotetrack_customfunction("slot_4", "scn_infil_blima_npc5", ::_id_8A8890FF587A78C9);
  scripts\common\anim::addnotetrack_customfunction("slot_5", "scn_infil_blima_npc6", ::_id_8A888DFF587A7230);
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
  scripts\common\anim::addnotetrack_customfunction("rope_l", "sfx_infil_blima_rope_01", ::_id_1E98BF9F4D0D86A0);
  scripts\common\anim::addnotetrack_customfunction("rope_l", "sfx_infil_blima_rope_02", ::_id_1E98C29F4D0D8D39);
  scripts\common\anim::addnotetrack_customfunction("rope_r", "sfx_infil_blima_rope_01", ::_id_1E98BF9F4D0D86A0);
  scripts\common\anim::addnotetrack_customfunction("rope_r", "sfx_infil_blima_rope_02", ::_id_1E98C29F4D0D8D39);
}

#using_animtree("script_model");

script_model_alpha_anims(subtype) {
  level.scr_animtree["slot_0"] = #animtree;
  level.scr_anim["slot_0"]["blima_infil"] = % iw9_mp_infil_blima_seat_0;
  level.scr_animname["slot_0"]["blima_infil"] = "iw9_mp_infil_blima_seat_0";
  level.scr_eventanim["slot_0"]["blima_infil"] = "infil_blima_1";
  level.scr_animtree["slot_1"] = #animtree;
  level.scr_anim["slot_1"]["blima_infil"] = % iw9_mp_infil_blima_seat_1;
  level.scr_animname["slot_1"]["blima_infil"] = "iw9_mp_infil_blima_seat_1";
  level.scr_eventanim["slot_1"]["blima_infil"] = "infil_blima_2";
  level.scr_animtree["slot_2"] = #animtree;
  level.scr_anim["slot_2"]["blima_infil"] = % iw9_mp_infil_blima_seat_2;
  level.scr_animname["slot_2"]["blima_infil"] = "iw9_mp_infil_blima_seat_2";
  level.scr_eventanim["slot_2"]["blima_infil"] = "infil_blima_3";
  level.scr_animtree["slot_3"] = #animtree;
  level.scr_anim["slot_3"]["blima_infil"] = % iw9_mp_infil_blima_seat_3;
  level.scr_animname["slot_3"]["blima_infil"] = "iw9_mp_infil_blima_seat_3";
  level.scr_eventanim["slot_3"]["blima_infil"] = "infil_blima_4";
  level.scr_animtree["slot_4"] = #animtree;
  level.scr_anim["slot_4"]["blima_infil"] = % iw9_mp_infil_blima_seat_4;
  level.scr_animname["slot_4"]["blima_infil"] = "iw9_mp_infil_blima_seat_4";
  level.scr_eventanim["slot_4"]["blima_infil"] = "infil_blima_5";
  level.scr_animtree["slot_5"] = #animtree;
  level.scr_anim["slot_5"]["blima_infil"] = % iw9_mp_infil_blima_seat_5;
  level.scr_animname["slot_5"]["blima_infil"] = "iw9_mp_infil_blima_seat_5";
  level.scr_eventanim["slot_5"]["blima_infil"] = "infil_blima_6";
  level.scr_animtree["crew1"] = #animtree;
  level.scr_anim["crew1"]["blima_infil"] = % iw9_mp_infil_blima_crew_1;
  level.scr_animname["crew1"]["blima_infil"] = "iw9_mp_infil_blima_crew_1";
  level.scr_eventanim["crew1"]["blima_infil"] = "infil_blima_crew";
  level.scr_animtree["crew2"] = #animtree;
  level.scr_anim["crew2"]["blima_infil"] = % iw9_mp_infil_blima_crew_2;
  level.scr_animname["crew2"]["blima_infil"] = "iw9_mp_infil_blima_crew_2";
  level.scr_eventanim["crew2"]["blima_infil"] = "infil_blima_crew";
  level.scr_animtree["rope_l"] = #animtree;
  level.scr_anim["rope_l"]["blima_infil"] = % iw9_mp_infil_blima_rope_l;
  level.scr_animname["rope_l"]["blima_infil"] = "iw9_mp_infil_blima_rope_l";
  level.scr_animtree["rope_r"] = #animtree;
  level.scr_anim["rope_r"]["blima_infil"] = % iw9_mp_infil_blima_rope_r;
  level.scr_animname["rope_r"]["blima_infil"] = "iw9_mp_infil_blima_rope_r";
}

_id_1E98BF9F4D0D86A0(rope) {
  _id_D56049B8E2D7E9C5 = spawn("script_model", (0, 0, 0));
  _id_D56049B8E2D7E9C5 linkTo(self, "j_rope_1");
  _id_D56049B8E2D7E9C5 playsoundonmovingent("scn_infil_blima_rope_01");
  wait 5;
  _id_D56049B8E2D7E9C5 delete();
}

_id_1E98C29F4D0D8D39(rope) {
  _id_D56049B8E2D7E9C5 = spawn("script_model", (0, 0, 0));
  _id_D56049B8E2D7E9C5 linkTo(self, "j_rope_165");
  _id_D56049B8E2D7E9C5 playsoundonmovingent("scn_infil_blima_rope_02");
  wait 2;
  _id_D56049B8E2D7E9C5 delete();
}

_id_8A8894FF587A8195(guy) {
  guy playsoundonmovingent("scn_infil_blima_npc1");
}

_id_8A8891FF587A7AFC(guy) {
  guy playsoundonmovingent("scn_infil_blima_npc2");
}

_id_8A8892FF587A7D2F(guy) {
  guy playsoundonmovingent("scn_infil_blima_npc3");
}

_id_8A888FFF587A7696(guy) {
  guy playsoundonmovingent("scn_infil_blima_npc4");
}

_id_8A8890FF587A78C9(guy) {
  guy playsoundonmovingent("scn_infil_blima_npc5");
}

_id_8A888DFF587A7230(guy) {
  guy playsoundonmovingent("scn_infil_blima_npc6");
}

#using_animtree("mp_vehicles_always_loaded");

vehicles_alpha_anims(subtype, team, originalsubtype) {
  level.scr_anim["blima"]["blima_infil_" + subtype] = % iw9_mp_infil_blima_heli;

  switch (level.mapname) {
    case "mp_grandprix":
    default:
      level.scr_anim["blima"]["blima_infil_" + subtype + "exit"] = % iw9_mp_infil_blima_heli_exit_grandprix;
      break;
  }
}

spawninfilvehicle(scene_node, team, _id_CA85A0DE365C6A63) {
  spawnpos = scene_node.origin;
  _id_B7850001037AA074 = scene_node.angles;
  model = "veh9_mil_air_heli_blima_mp";

  if(team == "allies")
    model = "veh9_mil_air_heli_blima_mp";

  _id_AB5CD311F5DC80A6 = "blima_cp";
  _id_E29C89AE4C29E698 = getdvarint("dvar_3F9319692595C13A", 1);

  if(_id_E29C89AE4C29E698 > 0)
    _id_AB5CD311F5DC80A6 = "veh9_mil_air_heli_blima_physics_mp";

  vehicle = spawnVehicle(model, _id_CA85A0DE365C6A63, _id_AB5CD311F5DC80A6, spawnpos, _id_B7850001037AA074);
  vehicle setvehicleteam(team);
  vehicle.animname = "blima";
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
  vehicle hidepart("tag_tail_rotor_blade_01");
  vehicle hidepart("tag_tail_rotor_blade_02");
  vehicle hidepart("tag_tail_rotor_blade_03");
  vehicle hidepart("tag_tail_rotor_blade_04");
  vehicle.infil = self;
  return vehicle;
}

commander_play_sound_func(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  foreach(player in self.infil.players)
  self playsoundtoplayer(alias, player);
}

driver_play_sound_func(alias, _id_EA3E3B2121E6713A, _id_9A0AFE8FF3D2508F) {
  foreach(player in self.infil.players)
  self playsoundtoplayer(alias, player);
}

getcommanderassets(team) {
  data = spawnStruct();
  data.body = "body_pilot_helicopter_british";
  data.head = "head_pilot_helicopter_british";
  return data;
}

customground(guy) {
  scripts\mp\utility\infilexfil::cam_shake_off(guy);

  if(!isDefined(guy)) {
    return;
  }
  if(isDefined(guy.player))
    player = guy.player;
  else
    player = guy;
}

_id_8C1C6F0A556C30E9(subtype) {
  _id_ADDD3217BC59A7B8 = spawnStruct();
  _id_5E0676140EECDF2D = "blima_" + subtype + "_probe";
  _id_4AE45078DF12C7A7 = "blima_" + subtype + "_light";
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

_id_7E05C22E552B8EED(_id_ADDD3217BC59A7B8) {
  if(!isDefined(_id_ADDD3217BC59A7B8)) {
    return;
  }
  _id_ADDD3217BC59A7B8.probe show();
  _id_ADDD3217BC59A7B8.probe linkTo(self, "tag_origin", (0, 0, -48), (0, 0, 0));

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

modifyscenenode(infil, team, subtype) {
  switch (level.mapname) {
    case "mp_quarry2":
      switch (team) {
        case "allies":
          switch (subtype) {
            case "alpha":
              break;
            case "bravo":
              infil.origin = infil.origin + anglesToForward(infil.angles) * 200;
              break;
          }

          break;
        case "axis":
          switch (subtype) {
            case "alpha":
              break;
            case "bravo":
              infil.origin = infil.origin + anglestoup(infil.angles) * 281.907;
              break;
          }

          break;
      }

      break;
  }
}

_id_F764364C2AC0250D() {
  wait 5;
  _id_7AB5B649FA408138::_id_F4E0FF5CB899686D("blima_infil");
}