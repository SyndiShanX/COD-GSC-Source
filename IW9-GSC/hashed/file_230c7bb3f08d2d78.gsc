/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_230c7bb3f08d2d78.gsc
***********************************************/

#using_animtree("script_model");

_id_C773479E45DC40A8() {
  level.scr_animtree["cutter_player"] = #animtree;
  level.scr_anim["cutter_player"]["pullout"] = % sdr_cp_hostage_cutout_blima_dst_pullout_player;
  level.scr_animname["cutter_player"]["pullout"] = "sdr_cp_hostage_cutout_blima_dst_pullout_player";
  level.scr_eventanim["cutter_player"]["pullout"] = "pullout_saw";
  level.scr_anim["cutter_player"]["putaway"] = % sdr_cp_hostage_cutout_blima_dst_putaway_player;
  level.scr_animname["cutter_player"]["putaway"] = "sdr_cp_hostage_cutout_blima_dst_putaway_player";
  level.scr_eventanim["cutter_player"]["putaway"] = "putaway_saw";
  level.scr_anim["cutter_player"]["cut"] = % sdr_cp_hostage_cutout_blima_dst_2_player;
  level.scr_animname["cutter_player"]["cut"] = "sdr_cp_hostage_cutout_blima_dst_2_player";
  level.scr_eventanim["cutter_player"]["cut"] = "player_cut_2";
  level.scr_anim["cutter_player"]["cut_loop"][0] = % sdr_cp_hostage_cutout_blima_dst_2_player;
  level.scr_animname["cutter_player"]["cut_loop"][0] = "sdr_cp_hostage_cutout_blima_dst_2_player";
  level.scr_eventanim["cutter_player"]["cut_loop"][0] = "player_cut_2";
  level.scr_animtree["saw"] = #animtree;
  level.scr_anim["saw"]["pullout"] = % sdr_cp_hostage_cutout_blima_dst_pullout_saw;
  level.scr_animname["saw"]["pullout"] = "sdr_cp_hostage_cutout_blima_dst_pullout_saw";
  level.scr_anim["saw"]["putaway"] = % sdr_cp_hostage_cutout_blima_dst_putaway_saw;
  level.scr_animname["saw"]["putaway"] = "sdr_cp_hostage_cutout_blima_dst_putaway_saw";
  level.scr_anim["saw"]["cut"] = % sdr_cp_hostage_cutout_blima_dst_2_saw;
  level.scr_animname["saw"]["cut"] = "sdr_cp_hostage_cutout_blima_dst_2_saw";
  level.scr_anim["saw"]["cut_loop"][0] = % sdr_cp_hostage_cutout_blima_dst_2_saw;
  level.scr_animname["saw"]["cut_loop"][0] = "sdr_cp_hostage_cutout_blima_dst_2_saw";
}

_id_32862600B800E3D1(_id_25CF9354B0A83D75, name, objindex) {
  level._id_04D373847E98E347[name] = spawnStruct();
  level._id_04D373847E98E347[name]._id_25CF9354B0A83D75 = _id_25CF9354B0A83D75;
  level._id_04D373847E98E347[name].objindex = objindex;
}

_id_51D3194276CFD0A5(player, _id_AF1158AD2B60FFA8, objectiveindex, _id_A137E502148A0CBC) {
  player.usingobject = 1;
  gunless = makeweapon("iw9_fists_cqc_mp");
  player scripts\cp\utility::_giveweapon(gunless, undefined, undefined, 1);
  success = player switchtoweaponimmediate(gunless);
  player _id_3B64EB40368C1450::set("cut_vault_gate", "weapon_switch", 0);
  player _id_3B64EB40368C1450::set("cut_vault_gate", "weapon_pickup", 0);
  _id_D5685B7BAEE6505E = getstartorigin(self.origin, self.angles, level.scr_anim["cutter_player"][_id_AF1158AD2B60FFA8]);
  start_angles = getstartangles(self.origin, self.angles, level.scr_anim["cutter_player"][_id_AF1158AD2B60FFA8]);
  player setOrigin(_id_D5685B7BAEE6505E, 1);
  player setplayerangles(start_angles);
  player setstance("stand");
  player cameraset("camera_custom_orbit_2_cp");
  _id_BE31E8030AEAE176 = spawn("script_model", self.origin);

  if(getdvarint("dvar_5F30937FD1AFD2AA", 1) > 0)
    _id_BE31E8030AEAE176 setModel("misc_vm_buzzsaw");
  else
    _id_BE31E8030AEAE176 setModel("tool_portable_gas_cutter_01_cp");

  _id_BE31E8030AEAE176.angles = self.angles;
  _id_BE31E8030AEAE176.animname = "saw";
  _id_BE31E8030AEAE176 hide();
  objective_pinforclient(objectiveindex, player);
  _func_D1B64C3D055CEEB0(2, player);
  _func_8B71EB96E1636EDC(&"CP_RAID1_BOSS1/SAW_CUT", player);
  _id_BE31E8030AEAE176 useanimtree(level.scr_animtree["saw"]);
  player thread _id_982AB262D1985B13(player, "cutter_player");
  success = _id_59EE7E6E5C100827(player, _id_BE31E8030AEAE176, _id_AF1158AD2B60FFA8, objectiveindex, _id_A137E502148A0CBC);
  player cameradefault();
  player forceusehintoff();
  objective_unpinforclient(objectiveindex, player);
  wait 0.1;
  _id_BE31E8030AEAE176 delete();
  _id_46D07C75D6302F1F(player);
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("cut_vault_gate");
  player scripts\cp_mp\utility\inventory_utility::_takeweapon(gunless);
  player scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
  player setstance("stand");
  player.usingobject = undefined;

  if(istrue(success))
    return 1;

  return 0;
}

_id_59EE7E6E5C100827(player, _id_BE31E8030AEAE176, _id_AF1158AD2B60FFA8, objectiveindex, _id_A137E502148A0CBC) {
  while(player useButtonPressed()) {
    _id_F7D79C7C83E5DF5B = getanimlength(level.scr_anim["cutter_player"]["pullout"]);
    _id_621528A23A9B2007 = getanimlength(level.scr_anim["cutter_player"][_id_AF1158AD2B60FFA8]);
    _id_950C749B2EAB4F0A = getanimlength(level.scr_anim["cutter_player"]["putaway"]);

    if(getdvarfloat("dvar_A034A2FF64229D4E") > 0)
      _id_621528A23A9B2007 = getdvarfloat("dvar_A034A2FF64229D4E");

    thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "pullout");
    thread scripts\common\anim::anim_single_solo(_id_BE31E8030AEAE176, "pullout");
    wait 0.25;
    wait 0.25;
    _id_BE31E8030AEAE176 show();
    _id_BE31E8030AEAE176 playLoopSound("saw_spinup");
    wait(_id_F7D79C7C83E5DF5B - 0.6);
    _id_46F432042B3473D8 = _id_621528A23A9B2007 - 0.25;
    thread _id_5E2730F8A277B70C(player, _id_BE31E8030AEAE176, _id_AF1158AD2B60FFA8);
    player forceusehintoff();
    result = _id_42312B16E58974E7(player, _id_46F432042B3473D8, objectiveindex, _id_A137E502148A0CBC);
    _id_BE31E8030AEAE176 stoploopsound();
    playsoundatpos(_id_BE31E8030AEAE176.origin, "saw_spinup_stop");

    if(!isDefined(result) || !result)
      player notify("cut_failed");

    if(!_id_0AFB7E332AEE4BF2::player_in_laststand(player)) {
      thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, "putaway");
      thread scripts\common\anim::anim_single_solo(_id_BE31E8030AEAE176, "putaway");
    }

    _id_BE31E8030AEAE176 hide();
    return result;
  }
}

_id_42312B16E58974E7(player, _id_46F432042B3473D8, objectiveindex, _id_A137E502148A0CBC) {
  player endon("last_stand");
  player endon("disconnect");

  if(!isDefined(self.cut_progress))
    self.cut_progress = 0;

  if(!isDefined(level.total_cut_progress) || !isDefined(level.total_cut_progress[_id_A137E502148A0CBC]))
    level.total_cut_progress[_id_A137E502148A0CBC] = 0;

  for(_id_25CF9354B0A83D75 = level._id_04D373847E98E347[_id_A137E502148A0CBC]._id_25CF9354B0A83D75; self.cut_progress <= _id_46F432042B3473D8 && player useButtonPressed(); level.total_cut_progress[_id_A137E502148A0CBC] = level.total_cut_progress[_id_A137E502148A0CBC] + 0.05) {
    objective_setprogress(objectiveindex, level.total_cut_progress[_id_A137E502148A0CBC] / (_id_46F432042B3473D8 * _id_25CF9354B0A83D75));
    wait 0.05;
    self.cut_progress = self.cut_progress + 0.05;
  }

  return self.cut_progress >= _id_46F432042B3473D8;
}

_id_5E2730F8A277B70C(player, _id_BE31E8030AEAE176, animname) {
  player endon("cut_failed");
  _id_F7D79C7C83E5DF5B = getanimlength(level.scr_anim["cutter_player"]["pullout"]);
  _id_621528A23A9B2007 = getanimlength(level.scr_anim["cutter_player"][animname]);

  if(getdvarfloat("dvar_A034A2FF64229D4E") > 0)
    _id_621528A23A9B2007 = getdvarfloat("dvar_A034A2FF64229D4E");

  _id_950C749B2EAB4F0A = getanimlength(level.scr_anim["cutter_player"]["putaway"]);
  thread scripts\cp\cp_anim::anim_player_solo(player, player.player_rig, animname);
  thread scripts\common\anim::anim_single_solo(_id_BE31E8030AEAE176, animname);
  wait 0.5;

  if(getdvarint("dvar_5F30937FD1AFD2AA", 1) < 1)
    _id_BE31E8030AEAE176 setscriptablepartstate("sparks", "on");

  wait(_id_621528A23A9B2007 - 0.6);
}

_id_F9AC07E5A43E0E50() {
  self endon("disconnect");

  if(!randomint(100) > 80) {
    return;
  }
  wait(randomintrange(7, 10));
  magicgrenademanual("frag_grenade_mp", self.origin + (0, 0, 90), (0, 0, -50), 5);

  if(randomint(100) > 80) {
    wait(randomfloatrange(0.25, 2));
    magicgrenademanual("frag_grenade_mp", self.origin + (0, 0, 90), (0, 0, -50), 5);
  }
}

_id_B0CA36875BE60C39(_id_BE31E8030AEAE176, _id_DAE9042556DF9437, headicon, _id_8CFAAC8F213315C2) {
  weapon = _id_66122A002AFF5D57::createspawnweaponatpos(_id_BE31E8030AEAE176.origin, _id_BE31E8030AEAE176.angles, "iw9_me_buzzsaw_mp", 1);
  weapon _id_66122A002AFF5D57::_id_86321FC8F45C2A9B(0);
  weapon _id_66122A002AFF5D57::_id_B10EE40ED82D45C9(1);
  weapon thread _id_61486E594827B479();

  if(isDefined(_id_8CFAAC8F213315C2))
    weapon thread _id_A37D51ED362EF4C5(_id_8CFAAC8F213315C2);

  level thread _id_F80B42BE57790416(weapon, _id_BE31E8030AEAE176, _id_DAE9042556DF9437, headicon, _id_8CFAAC8F213315C2);
  _id_BE31E8030AEAE176 hide();
}

_id_A37D51ED362EF4C5(_id_C8D97D68F249F53F) {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(!isPlayer(player)) {
      continue;
    }
    level notify(_id_C8D97D68F249F53F, player);
  }
}

_id_F80B42BE57790416(weapon, _id_BE31E8030AEAE176, _id_DAE9042556DF9437, headicon, _id_8CFAAC8F213315C2) {
  level endon("game_ended");
  level endon("silo_end");

  for(;;) {
    weapon waittill("trigger", ent);
    wait 5;

    while(_id_CFF97426ED0F8CF3())
      wait 1;

    break;
  }

  wait 15;

  if(isDefined(weapon))
    weapon delete();

  level thread _id_B0CA36875BE60C39(_id_BE31E8030AEAE176, _id_DAE9042556DF9437, headicon, _id_8CFAAC8F213315C2);
}

_id_CFF97426ED0F8CF3(_id_E84136BA3D0BA016) {
  _id_E84136BA3D0BA016 = scripts\engine\utility::_id_53C4C53197386572(_id_E84136BA3D0BA016, 1);

  foreach(player in level.players) {
    if(!_id_E84136BA3D0BA016 && (!isalive(player) || !player scripts\cp\utility::is_valid_player(1, 1))) {
      continue;
    }
    if(player hasweapon("iw9_me_buzzsaw_mp"))
      return 1;
  }

  return 0;
}

_id_B73725DB6A202A37(_id_E035FDEF423A5164, _id_83382C55CCAB2C6D, objectiveindex, _id_A137E502148A0CBC) {
  _id_7D03D2D2566E7AB6 = spawnStruct();
  _id_7D03D2D2566E7AB6.origin = _id_E035FDEF423A5164.origin + anglesToForward(_id_E035FDEF423A5164.angles) * 75 + anglestoright(_id_E035FDEF423A5164.angles) * 120 + anglestoup(_id_E035FDEF423A5164.angles) * -41;
  _id_7D03D2D2566E7AB6.angles = _id_E035FDEF423A5164.angles + (0, 90, 0);
  hintstring = &"CP_BR_SYRK_OBJECTIVES/CUT_PILOT_OBJ";

  if(isDefined(_id_83382C55CCAB2C6D))
    hintstring = _id_83382C55CCAB2C6D;

  interaction = scripts\cp\utility::createhintobject(_id_E035FDEF423A5164.origin, "HINT_BUTTON", "cp_tac_waypoint_buzzsaw", hintstring, undefined, "duration_none", "show", 200, 65, 72, 65);
  interaction thread _id_7B3F10A4DD2446D1("cut", _id_7D03D2D2566E7AB6, objectiveindex, _id_A137E502148A0CBC);
  return interaction;
}

_id_08CEC0172731DAD4(ent) {
  if(!isDefined(level.saw_headicons))
    level.saw_headicons = [];

  ent.head_icon = createheadicon(ent);
  setheadiconimage(ent.head_icon, "cp_tac_waypoint_buzzsaw");
  setheadiconmaxdistance(ent.head_icon, 0);
  setheadiconsnaptoedges(ent.head_icon, 1);
  setheadiconzoffset(ent.head_icon, 10);
  setheadicondrawinmap(ent.head_icon, 1);
  level.saw_headicons[level.saw_headicons.size] = ent.head_icon;
}

_id_4DBAEB78ABF964B8() {
  if(isDefined(self.head_icon)) {
    if(scripts\engine\utility::array_contains(level.saw_headicons, self.head_icon)) {
      if(isDefined(self.head_icon)) {
        level.saw_headicons = scripts\engine\utility::array_remove(level.saw_headicons, self.head_icon);
        deleteheadicon(self.head_icon);
      }
    }
  }
}

_id_B4CDDDFB34A0472C() {
  level endon("game_ended");
  self endon("trigger");
  scripts\engine\utility::flag_wait("saws_have_been_used");
  _id_4DBAEB78ABF964B8();
  self makeunusable();
}

_id_7B3F10A4DD2446D1(flagname, _id_0CB8AFF0C74283BA, objectiveindex, _id_A137E502148A0CBC) {
  self endon("death");

  for(;;) {
    self _meth_DFB78B3E724AD620(1);
    self waittill("trigger", player);

    if(!player scripts\cp\utility::is_valid_player()) {
      continue;
    }
    if(!player hasweapon("iw9_me_buzzsaw_mp")) {
      player scripts\cp\utility::setlowermessage("havesaw", &"CP_DWN_TWN_OBJECTIVES/NEED_SAW", 5);
      continue;
    }

    level notify("saw_used", objectiveindex, player);
    level notify("saw_door_started", flagname);
    objective_state(objectiveindex, "current");
    self _meth_DFB78B3E724AD620(0);

    if(!_id_0CB8AFF0C74283BA _id_51D3194276CFD0A5(player, flagname, objectiveindex, _id_A137E502148A0CBC)) {
      level notify("saw_released_early", objectiveindex, player);
      wait 1;
      continue;
    }

    level notify("saw_finished", objectiveindex, player);
    self delete();
  }
}

_id_6D10B2E59026C58F(_id_800054CA1A89DACE) {
  objectiveindex = scripts\cp\cp_objectives::requestworldid("doorcut");
  objective_position(objectiveindex, _id_800054CA1A89DACE);
  objective_setplayintro(objectiveindex, 1);
  objective_setshowprogress(objectiveindex, 1);
  objective_setprogressteam(objectiveindex, "allies");
  objective_icon(objectiveindex, "icon_waypoint_objective_general");
  objective_setlabel(objectiveindex, &"CP_BR_SYRK_OBJECTIVES/CUT_HINT");
  objective_state(objectiveindex, "done");
  return objectiveindex;
}

_id_3CFEB446CB63D459(interactions, _id_30BFB3138218E061, objectiveindex, _id_A137E502148A0CBC) {
  scripts\engine\utility::flag_init(_id_30BFB3138218E061);

  foreach(interaction in interactions) {
    interact = _id_B73725DB6A202A37(interaction, undefined, objectiveindex, _id_A137E502148A0CBC);
    interaction.interact = interact;
  }

  level thread _id_ACCE72D960F1541F(_id_30BFB3138218E061, interactions, objectiveindex);
}

_id_614B7E8246F0A475() {
  scripts\engine\utility::flag_init("cut_objective_finished");
  interactions = scripts\engine\utility::getStructArray("buzzsaw_interact", "targetname");

  foreach(interaction in interactions) {
    interact = _id_B73725DB6A202A37(interaction);
    interaction.interact = interact;
  }

  level thread _id_ACCE72D960F1541F();
}

_id_982AB262D1985B13(player, animname, _id_486DB5FA512A3B6B, _id_CE4AF45F8FFF86B7) {
  if(!isDefined(player) || isDefined(player.player_rig)) {
    return;
  }
  player.animname = animname;

  if(!isDefined(_id_486DB5FA512A3B6B))
    _id_486DB5FA512A3B6B = "viewhands_base_iw8";

  player _meth_B88C89BB7CD1AB8E(player.origin);
  player_rig = spawn("script_arms", player.origin, 0, 0, player);
  player_rig.player = player;
  player.player_rig = player_rig;
  player.player_rig hide();
  player.player_rig.animname = animname;
  player.player_rig useanimtree(#animtree);
  player _id_3B64EB40368C1450::set("anim", "fire", 0);
  player _id_3B64EB40368C1450::set("anim", "ads", 0);

  if(isDefined(animname) && animname == "planter")
    player playerlinktodelta(player.player_rig, "tag_player", 0, 0, 0, 0, 0, 0, 0);
  else
    player playerlinktodelta(player.player_rig, "tag_player", 1, 0, 0, 0, 0, 0, 0);

  player _id_1AE1C05387E012F9();
  _id_46D07C75D6302F1F(player);
}

_id_46D07C75D6302F1F(player) {
  if(!isDefined(player) || !isDefined(player.player_rig) || !isDefined(player.origin)) {
    return;
  }
  player unlink();

  if(isDefined(player getdroptofloorposition(player.origin)))
    player setOrigin(player getdroptofloorposition(player.origin));

  player.player_rig delete();
  player.player_rig = undefined;
  player _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("anim");
  player notify("remove_rig");
}

_id_1AE1C05387E012F9(struct) {
  scripts\engine\utility::waittill_any_3("remove_rig", "death", "disconnect");
}

_id_ACCE72D960F1541F(_id_F9788B8E98C2AA1E, interactions, objectiveindex) {
  if(!isDefined(interactions))
    interactions = scripts\engine\utility::getStructArray("buzzsaw_interact", "targetname");

  for(;;) {
    wait 1;
    _id_0F5E6316C2383F5F = 1;

    foreach(interaction in interactions) {
      if(isDefined(interaction.interact))
        _id_0F5E6316C2383F5F = 0;
    }

    if(_id_0F5E6316C2383F5F) {
      break;
    }
  }

  scripts\engine\utility::flag_set("cut_objective_finished");

  if(isDefined(_id_F9788B8E98C2AA1E))
    scripts\engine\utility::flag_set(_id_F9788B8E98C2AA1E);

  if(isDefined(objectiveindex))
    objective_delete(objectiveindex);
}

_id_1B49A35C2483B328() {
  if(isDefined(level._id_1226A83CD0ECB060)) {
    return;
  }
  level._id_1226A83CD0ECB060 = 1;
  _id_66122A002AFF5D57::registerpickupcreatedcallback("brloot_weapon_me_buzzsaw", ::_id_ACDED3C0B4010D06);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("brloot_weapon_me_buzzsaw", ::_id_43F61B67BD93F1AF);
}

_id_61486E594827B479() {
  level endon("game_ended");
  self endon("death");
  _id_1B49A35C2483B328();

  for(;;) {
    level scripts\engine\utility::waittill_any_timeout_2(10, "saw_pickup_created", "saw_pickup_interact");

    foreach(player in level.players) {
      if(!player scripts\cp\utility::is_valid_player()) {
        continue;
      }
      if(!player hasweapon("iw9_me_buzzsaw_mp")) {
        if(isDefined(player._id_69F32076C953761D)) {
          player scripts\cp\utility::_id_98F7CA3781DAC77C(player, player._id_69F32076C953761D.carry_ref);
          player._id_69F32076C953761D = undefined;
        }

        continue;
      }

      if(isDefined(player._id_69F32076C953761D)) {
        continue;
      }
      player._id_69F32076C953761D = scripts\cp\utility::set_carry_item(player, "buzzsaw");
    }
  }
}

_id_ACDED3C0B4010D06() {
  level notify("saw_pickup_created");
}

_id_43F61B67BD93F1AF(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level notify("saw_pickup_interact");
}