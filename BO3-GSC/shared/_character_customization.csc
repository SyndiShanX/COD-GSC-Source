/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\_character_customization.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\core\_multi_extracam;
#using scripts\shared\abilities\gadgets\_gadget_camo_render;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\end_game_taunts;
#using scripts\shared\filter_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using_animtree("all_player");
#using_animtree("generic");
#namespace character_customization;

function autoexec __init__sytem__() {
  system::register("character_customization", & __init__, undefined, undefined);
}

function __init__() {
  level.extra_cam_render_hero_func_callback = & process_character_extracam_request;
  level.extra_cam_render_lobby_client_hero_func_callback = & process_lobby_client_character_extracam_request;
  level.extra_cam_render_current_hero_headshot_func_callback = & process_current_hero_headshot_extracam_request;
  level.extra_cam_render_outfit_preview_func_callback = & process_outfit_preview_extracam_request;
  level.extra_cam_render_character_body_item_func_callback = & process_character_body_item_extracam_request;
  level.extra_cam_render_character_helmet_item_func_callback = & process_character_helmet_item_extracam_request;
  level.extra_cam_render_character_head_item_func_callback = & process_character_head_item_extracam_request;
  level.intercom_dialog = associativearray("helmet", "", "head", "");
  if(!isdefined(level.liveccdata)) {
    level.liveccdata = [];
  }
  if(!isdefined(level.custom_characters)) {
    level.custom_characters = [];
  }
  if(!isdefined(level.extra_cam_hero_data)) {
    level.extra_cam_hero_data = [];
  }
  if(!isdefined(level.extra_cam_lobby_client_hero_data)) {
    level.extra_cam_lobby_client_hero_data = [];
  }
  if(!isdefined(level.extra_cam_headshot_hero_data)) {
    level.extra_cam_headshot_hero_data = [];
  }
  if(!isdefined(level.extra_cam_outfit_preview_data)) {
    level.extra_cam_outfit_preview_data = [];
  }
  level.charactercustomizationsetup = & localclientconnect;
}

function localclientconnect(localclientnum) {
  level.liveccdata[localclientnum] = setup_live_character_customization_target(localclientnum);
  if(isdefined(level.liveccdata[localclientnum])) {
    setup_character_streaming(level.liveccdata[localclientnum]);
  }
  level.staticccdata = setup_static_character_customization_target(localclientnum);
}

function create_character_data_struct(charactermodel, localclientnum, alt_render_mode = 1) {
  if(!isdefined(charactermodel)) {
    return undefined;
  }
  if(!isdefined(level.custom_characters[localclientnum])) {
    level.custom_characters[localclientnum] = [];
  }
  if(isdefined(level.custom_characters[localclientnum][charactermodel.targetname])) {
    return level.custom_characters[localclientnum][charactermodel.targetname];
  }
  data_struct = spawnstruct();
  level.custom_characters[localclientnum][charactermodel.targetname] = data_struct;
  data_struct.charactermodel = charactermodel;
  data_struct.attached_model_anims = array();
  data_struct.attached_models = array();
  data_struct.attached_entities = array();
  data_struct.origin = charactermodel.origin;
  data_struct.angles = charactermodel.angles;
  data_struct.characterindex = 0;
  data_struct.charactermode = 3;
  data_struct.splitscreenclient = undefined;
  data_struct.bodyindex = 0;
  data_struct.bodycolors = array(0, 0, 0);
  data_struct.helmetindex = 0;
  data_struct.helmetcolors = array(0, 0, 0);
  data_struct.headindex = 0;
  data_struct.align_target = undefined;
  data_struct.currentanimation = undefined;
  data_struct.currentscene = undefined;
  data_struct.body_render_options = getcharacterbodyrenderoptions(0, 0, 0, 0, 0);
  data_struct.helmet_render_options = getcharacterhelmetrenderoptions(0, 0, 0, 0, 0);
  data_struct.head_render_options = getcharacterheadrenderoptions(0);
  data_struct.mode_render_options = getcharactermoderenderoptions(0);
  data_struct.alt_render_mode = alt_render_mode;
  data_struct.usefrozenmomentanim = 0;
  data_struct.frozenmomentstyle = "weapon";
  data_struct.show_helmets = 1;
  data_struct.allow_showcase_weapons = 0;
  data_struct.force_prologue_body = 0;
  if(sessionmodeiscampaigngame()) {
    highestmapreached = getdstat(localclientnum, "highestMapReached");
    data_struct.force_prologue_body = !isdefined(highestmapreached) || highestmapreached == 0 && getdvarstring("mapname") == "core_frontend";
  }
  charactermodel sethighdetail(1, data_struct.alt_render_mode);
  return data_struct;
}

function handle_forced_streaming(game_mode) {}

function loadequippedcharacteronmodel(localclientnum, data_struct, characterindex, params) {
  assert(isdefined(data_struct));
  data_lcn = (isdefined(data_struct.splitscreenclient) ? data_struct.splitscreenclient : localclientnum);
  if(!isdefined(characterindex)) {
    characterindex = getequippedheroindex(data_lcn, params.sessionmode);
  }
  defaultindex = undefined;
  if(isdefined(params.isdefaulthero) && params.isdefaulthero) {
    defaultindex = 0;
  }
  set_character(data_struct, characterindex);
  charactermode = params.sessionmode;
  set_character_mode(data_struct, charactermode);
  body = get_character_body(data_lcn, charactermode, characterindex, params.extracam_data);
  bodycolors = get_character_body_colors(data_lcn, charactermode, characterindex, body, params.extracam_data);
  set_body(data_struct, charactermode, characterindex, body, bodycolors);
  head = get_character_head(data_lcn, charactermode, params.extracam_data);
  set_head(data_struct, charactermode, head);
  helmet = get_character_helmet(data_lcn, charactermode, characterindex, params.extracam_data);
  helmetcolors = get_character_helmet_colors(data_lcn, charactermode, data_struct.characterindex, helmet, params.extracam_data);
  set_helmet(data_struct, charactermode, characterindex, helmet, helmetcolors);
  if(isdefined(data_struct.allow_showcase_weapons) && data_struct.allow_showcase_weapons) {
    showcaseweapon = get_character_showcase_weapon(data_lcn, charactermode, characterindex, params.extracam_data);
    set_showcase_weapon(data_struct, charactermode, data_lcn, undefined, characterindex, showcaseweapon.weaponname, showcaseweapon.attachmentinfo, showcaseweapon.weaponrenderoptions, 0, 1);
  }
  return update(localclientnum, data_struct, params);
}

function update_model_attachment(localclientnum, data_struct, attached_model, slot, model_anim, model_intro_anim, force_update) {
  assert(isdefined(data_struct.attached_models));
  assert(isdefined(data_struct.attached_model_anims));
  assert(isdefined(level.intercom_dialog));
  if(force_update || attached_model !== data_struct.attached_models[slot] || model_anim !== data_struct.attached_model_anims[slot]) {
    bone = slot;
    if(isdefined(level.intercom_dialog[slot])) {
      bone = level.intercom_dialog[slot];
    }
    assert(isdefined(bone));
    if(isdefined(data_struct.attached_models[slot])) {
      if(isdefined(data_struct.attached_entities[slot])) {
        data_struct.attached_entities[slot] unlink();
        data_struct.attached_entities[slot] delete();
        data_struct.attached_entities[slot] = undefined;
      } else if(data_struct.charactermodel isattached(data_struct.attached_models[slot], bone)) {
        data_struct.charactermodel detach(data_struct.attached_models[slot], bone);
      }
      data_struct.attached_models[slot] = undefined;
    }
    data_struct.attached_models[slot] = attached_model;
    if(isdefined(data_struct.attached_models[slot])) {
      if(isdefined(model_anim)) {
        ent = spawn(localclientnum, data_struct.charactermodel.origin, "script_model");
        ent sethighdetail(1, data_struct.alt_render_mode);
        data_struct.attached_entities[slot] = ent;
        ent setmodel(data_struct.attached_models[slot]);
        if(!ent hasanimtree()) {
          ent useanimtree($generic);
        }
        ent.origin = data_struct.charactermodel.origin;
        ent.angles = data_struct.charactermodel.angles;
        ent.chosenorigin = ent.origin;
        ent.chosenangles = ent.angles;
        ent thread play_intro_and_animation(model_intro_anim, model_anim, 1);
      } else if(!data_struct.charactermodel isattached(data_struct.attached_models[slot], bone)) {
        data_struct.charactermodel attach(data_struct.attached_models[slot], bone);
      }
      data_struct.attached_model_anims[slot] = model_anim;
    }
  }
  if(isdefined(data_struct.attached_entities[slot])) {
    data_struct.attached_entities[slot] setbodyrenderoptions(data_struct.mode_render_options, data_struct.body_render_options, data_struct.helmet_render_options, data_struct.head_render_options);
  }
}

function set_character(data_struct, characterindex) {
  data_struct.characterindex = characterindex;
}

function set_character_mode(data_struct, charactermode) {
  assert(isdefined(charactermode));
  data_struct.charactermode = charactermode;
  data_struct.mode_render_options = getcharactermoderenderoptions(charactermode);
}

function set_body(data_struct, mode, characterindex, bodyindex, bodycolors) {
  assert(isdefined(mode));
  assert(mode != 3);
  if(mode == 2 && (isdefined(data_struct.force_prologue_body) && data_struct.force_prologue_body)) {
    bodyindex = 1;
  }
  data_struct.bodyindex = bodyindex;
  data_struct.bodymodel = getcharacterbodymodel(characterindex, bodyindex, mode);
  if(isdefined(data_struct.bodymodel)) {
    data_struct.charactermodel setmodel(data_struct.bodymodel);
  }
  if(isdefined(bodycolors)) {
    set_body_colors(data_struct, mode, bodycolors);
  }
  render_options = getcharacterbodyrenderoptions(data_struct.characterindex, data_struct.bodyindex, data_struct.bodycolors[0], data_struct.bodycolors[1], data_struct.bodycolors[2]);
  data_struct.body_render_options = render_options;
}

function set_body_colors(data_struct, mode, bodycolors) {
  for (i = 0; i < bodycolors.size && i < bodycolors.size; i++) {
    set_body_color(data_struct, i, bodycolors[i]);
  }
}

function set_body_color(data_struct, colorslot, colorindex) {
  data_struct.bodycolors[colorslot] = colorindex;
  render_options = getcharacterbodyrenderoptions(data_struct.characterindex, data_struct.bodyindex, data_struct.bodycolors[0], data_struct.bodycolors[1], data_struct.bodycolors[2]);
  data_struct.body_render_options = render_options;
}

function set_head(data_struct, mode, headindex) {
  data_struct.headindex = headindex;
  data_struct.headmodel = getcharacterheadmodel(headindex, mode);
  render_options = getcharacterheadrenderoptions(headindex);
  data_struct.head_render_options = render_options;
}

function set_helmet(data_struct, mode, characterindex, helmetindex, helmetcolors) {
  data_struct.helmetindex = helmetindex;
  data_struct.helmetmodel = getcharacterhelmetmodel(characterindex, helmetindex, mode);
  set_helmet_colors(data_struct, helmetcolors);
}

function set_showcase_weapon(data_struct, mode, localclientnum, xuid, characterindex, showcaseweaponname, showcaseweaponattachmentinfo, weaponrenderoptions, useshowcasepaintjob, uselocalpaintshop) {
  if(isdefined(xuid)) {
    setshowcaseweaponpaintshopxuid(localclientnum, xuid);
  } else {
    setshowcaseweaponpaintshopxuid(localclientnum);
  }
  data_struct.showcaseweaponname = showcaseweaponname;
  data_struct.showcaseweaponmodel = getweaponwithattachments(showcaseweaponname);
  if(data_struct.showcaseweaponmodel == getweapon("none")) {
    data_struct.showcaseweaponmodel = getweapon("ar_standard");
    data_struct.showcaseweaponname = data_struct.showcaseweaponmodel.name;
  }
  attachmentnames = [];
  attachmentindices = [];
  tokenizedattachmentinfo = strtok(showcaseweaponattachmentinfo, ",");
  index = 0;
  while ((index + 1) < tokenizedattachmentinfo.size) {
    attachmentnames[attachmentnames.size] = tokenizedattachmentinfo[index];
    attachmentindices[attachmentindices.size] = int(tokenizedattachmentinfo[index + 1]);
    index = index + 2;
  }
  index = tokenizedattachmentinfo.size;
  while ((index + 1) < 16) {
    attachmentnames[attachmentnames.size] = "none";
    attachmentindices[attachmentindices.size] = 0;
    index = index + 2;
  }
  data_struct.acvi = getattachmentcosmeticvariantindexes(data_struct.showcaseweaponmodel, attachmentnames[0], attachmentindices[0], attachmentnames[1], attachmentindices[1], attachmentnames[2], attachmentindices[2], attachmentnames[3], attachmentindices[3], attachmentnames[4], attachmentindices[4], attachmentnames[5], attachmentindices[5], attachmentnames[6], attachmentindices[6], attachmentnames[7], attachmentindices[7]);
  camoindex = 0;
  paintjobslot = 15;
  paintjobindex = 15;
  showpaintshop = 0;
  tokenizedweaponrenderoptions = strtok(weaponrenderoptions, ",");
  if(tokenizedweaponrenderoptions.size > 2) {
    camoindex = int(tokenizedweaponrenderoptions[0]);
    paintjobslot = int(tokenizedweaponrenderoptions[1]);
    paintjobindex = int(tokenizedweaponrenderoptions[2]);
    showpaintshop = paintjobslot != 15 && paintjobindex != 15;
  }
  paintshopclasstype = 0;
  if(useshowcasepaintjob) {
    paintshopclasstype = 1;
  } else if(uselocalpaintshop) {
    paintshopclasstype = 2;
  }
  data_struct.weaponrenderoptions = calcweaponoptions(localclientnum, camoindex, 0, 0, 0, 0, showpaintshop, paintshopclasstype);
  weapon_root_name = data_struct.showcaseweaponmodel.rootweapon.name;
  weapon_is_dual_wield = data_struct.showcaseweaponmodel.isdualwield;
  weapon_group = getitemgroupforweaponname(weapon_root_name);
  if(weapon_group == "weapon_launcher") {
    if(weapon_root_name == "launcher_lockonly" || weapon_root_name == "launcher_multi") {
      weapon_group = "weapon_launcher_alt";
    } else if(weapon_root_name == "launcher_ex41") {
      weapon_group = "weapon_smg_ppsh";
    }
  } else {
    if(weapon_group == "weapon_assault") {
      if(weapon_root_name == "ar_m14") {
        weapon_group = "weapon_shotgun_olympia";
      }
    } else {
      if(weapon_group == "weapon_pistol" && weapon_is_dual_wield) {
        weapon_group = "weapon_pistol_dw";
      } else {
        if(weapon_group == "weapon_smg") {
          if(weapon_root_name == "smg_ppsh") {
            weapon_group = "weapon_smg_ppsh";
          } else if(weapon_root_name == "smg_sten2") {
            weapon_group = "weapon_knuckles";
          }
        } else {
          if(weapon_group == "weapon_cqb") {
            if(weapon_root_name == "shotgun_olympia") {
              weapon_group = "weapon_shotgun_olympia";
            }
          } else {
            if(weapon_group == "weapon_special") {
              if(weapon_root_name == "special_crossbow" || weapon_root_name == "special_discgun") {
                weapon_group = "weapon_smg";
              } else {
                if(weapon_root_name == "special_crossbow_dw") {
                  weapon_group = "weapon_pistol_dw";
                } else if(weapon_root_name == "knife_ballistic") {
                  weapon_group = "weapon_knife_ballistic";
                }
              }
            } else {
              if(weapon_group == "weapon_knife") {
                if(weapon_root_name == "melee_knuckles" || weapon_root_name == "melee_boxing") {
                  weapon_group = "weapon_knuckles";
                } else {
                  if(weapon_root_name == "melee_chainsaw" || weapon_root_name == "melee_boneglass" || weapon_root_name == "melee_crescent") {
                    weapon_group = "weapon_chainsaw";
                  } else {
                    if(weapon_root_name == "melee_improvise" || weapon_root_name == "melee_shovel") {
                      weapon_group = "weapon_improvise";
                    } else {
                      if(weapon_root_name == "melee_wrench" || weapon_root_name == "melee_crowbar" || weapon_root_name == "melee_shockbaton") {
                        weapon_group = "weapon_wrench";
                      } else {
                        if(weapon_root_name == "melee_nunchuks") {
                          weapon_group = "weapon_nunchucks";
                        } else {
                          if(weapon_root_name == "melee_sword" || weapon_root_name == "melee_bat" || weapon_root_name == "melee_fireaxe" || weapon_root_name == "melee_mace" || weapon_root_name == "melee_katana") {
                            weapon_group = "weapon_sword";
                          } else if(weapon_root_name == "melee_prosthetic") {
                            weapon_group = "weapon_prosthetic";
                          }
                        }
                      }
                    }
                  }
                }
              } else if(weapon_group == "miscweapon") {
                if(weapon_root_name == "blackjack_coin") {
                  weapon_group = "brawler";
                } else if(weapon_root_name == "blackjack_cards") {
                  weapon_group = "brawler";
                }
              }
            }
          }
        }
      }
    }
  }
  if(data_struct.charactermode === 0) {
    data_struct.anim_name = "pb_cac_rifle_showcase_cp";
  } else if(isdefined(associativearray("weapon_smg", "pb_cac_smg_showcase", "weapon_assault", "pb_cac_rifle_showcase", "weapon_cqb", "pb_cac_rifle_showcase", "weapon_lmg", "pb_cac_rifle_showcase", "weapon_sniper", "pb_cac_sniper_showcase", "weapon_pistol", "pb_cac_pistol_showcase", "weapon_pistol_dw", "pb_cac_pistol_dw_showcase", "weapon_launcher", "pb_cac_launcher_showcase", "weapon_launcher_alt", "pb_cac_launcher_alt_showcase", "weapon_knife", "pb_cac_knife_showcase", "weapon_knuckles", "pb_cac_brass_knuckles_showcase", "weapon_wrench", "pb_cac_wrench_showcase", "weapon_improvise", "pb_cac_improvise_showcase", "weapon_sword", "pb_cac_sword_showcase", "weapon_nunchucks", "pb_cac_nunchucks_showcase", "weapon_mace", "pb_cac_sword_showcase", "brawler", "pb_cac_brawler_showcase", "weapon_prosthetic", "pb_cac_prosthetic_arm_showcase", "weapon_chainsaw", "pb_cac_chainsaw_showcase", "weapon_smg_ppsh", "pb_cac_smg_ppsh_showcase", "weapon_knife_ballistic", "pb_cac_b_knife_showcase", "weapon_shotgun_olympia", "pb_cac_shotgun_olympia_showcase")[weapon_group])) {
    data_struct.anim_name = associativearray("weapon_smg", "pb_cac_smg_showcase", "weapon_assault", "pb_cac_rifle_showcase", "weapon_cqb", "pb_cac_rifle_showcase", "weapon_lmg", "pb_cac_rifle_showcase", "weapon_sniper", "pb_cac_sniper_showcase", "weapon_pistol", "pb_cac_pistol_showcase", "weapon_pistol_dw", "pb_cac_pistol_dw_showcase", "weapon_launcher", "pb_cac_launcher_showcase", "weapon_launcher_alt", "pb_cac_launcher_alt_showcase", "weapon_knife", "pb_cac_knife_showcase", "weapon_knuckles", "pb_cac_brass_knuckles_showcase", "weapon_wrench", "pb_cac_wrench_showcase", "weapon_improvise", "pb_cac_improvise_showcase", "weapon_sword", "pb_cac_sword_showcase", "weapon_nunchucks", "pb_cac_nunchucks_showcase", "weapon_mace", "pb_cac_sword_showcase", "brawler", "pb_cac_brawler_showcase", "weapon_prosthetic", "pb_cac_prosthetic_arm_showcase", "weapon_chainsaw", "pb_cac_chainsaw_showcase", "weapon_smg_ppsh", "pb_cac_smg_ppsh_showcase", "weapon_knife_ballistic", "pb_cac_b_knife_showcase", "weapon_shotgun_olympia", "pb_cac_shotgun_olympia_showcase")[weapon_group];
  }
}

function set_helmet_colors(data_struct, colors) {
  for (i = 0; i < colors.size && i < data_struct.helmetcolors.size; i++) {
    set_helmet_color(data_struct, i, colors[i]);
  }
  render_options = getcharacterhelmetrenderoptions(data_struct.characterindex, data_struct.helmetindex, data_struct.helmetcolors[0], data_struct.helmetcolors[1], data_struct.helmetcolors[2]);
  data_struct.helmet_render_options = render_options;
}

function set_helmet_color(data_struct, colorslot, colorindex) {
  data_struct.helmetcolors[colorslot] = colorindex;
  render_options = getcharacterhelmetrenderoptions(data_struct.characterindex, data_struct.helmetindex, data_struct.helmetcolors[0], data_struct.helmetcolors[1], data_struct.helmetcolors[2]);
  data_struct.helmet_render_options = render_options;
}

function update(localclientnum, data_struct, params) {
  data_struct.charactermodel setbodyrenderoptions(data_struct.mode_render_options, data_struct.body_render_options, data_struct.helmet_render_options, data_struct.head_render_options);
  helmet_model = "tag_origin";
  show_helmet = data_struct.show_helmets && (!isdefined(params) || (!(isdefined(params.hide_helmet) && params.hide_helmet)));
  if(show_helmet) {
    helmet_model = data_struct.helmetmodel;
  }
  update_model_attachment(localclientnum, data_struct, helmet_model, "helmet", undefined, undefined, 1);
  head_model = data_struct.headmodel;
  if(show_helmet && isdefined(params) && getcharacterhelmethideshead(data_struct.characterindex, data_struct.helmetindex, (isdefined(params.sessionmode) ? params.sessionmode : data_struct.charactermode))) {
    assert(helmet_model != "");
    head_model = "tag_origin";
  }
  update_model_attachment(localclientnum, data_struct, head_model, "head", undefined, undefined, 1);
  changed = update_character_animation_and_attachments(localclientnum, data_struct, params);
  data_struct.charactermodel.bodymodel = data_struct.bodymodel;
  data_struct.charactermodel.helmetmodel = data_struct.helmetmodel;
  data_struct.charactermodel.moderenderoptions = data_struct.mode_render_options;
  data_struct.charactermodel.bodyrenderoptions = data_struct.body_render_options;
  data_struct.charactermodel.helmetrenderoptions = data_struct.helmet_render_options;
  data_struct.charactermodel.headrenderoptions = data_struct.head_render_options;
  return changed;
}

function is_character_streamed(data_struct) {
  if(isdefined(data_struct.charactermodel)) {
    if(!data_struct.charactermodel isstreamed()) {
      return false;
    }
  }
  foreach(ent in data_struct.attached_entities) {
    if(isdefined(ent)) {
      if(!ent isstreamed()) {
        return false;
      }
    }
  }
  return true;
}

function setup_character_streaming(data_struct) {
  if(isdefined(data_struct.charactermodel)) {
    data_struct.charactermodel sethighdetail(1, data_struct.alt_render_mode);
  }
  foreach(ent in data_struct.attached_entities) {
    if(isdefined(ent)) {
      ent sethighdetail(1, data_struct.alt_render_mode);
    }
  }
}

function get_character_mode(localclientnum) {
  return getequippedheromode(localclientnum);
}

function get_character_body(localclientnum, charactermode, characterindex, extracamdata) {
  assert(isdefined(characterindex));
  if(charactermode === 2 && sessionmodeiscampaigngame() && getdvarstring("mapname") == "core_frontend") {
    mapindex = getdstat(localclientnum, "highestMapReached");
    if(isdefined(mapindex) && mapindex < 1) {
      str_gender = getherogender(getequippedheroindex(localclientnum, 2), "cp");
      n_body_id = getcharacterbodystyleindex(str_gender == "female", "CPUI_OUTFIT_PROLOGUE");
      return n_body_id;
    }
  }
  if(isdefined(extracamdata) && (isdefined(extracamdata.isdefaulthero) && extracamdata.isdefaulthero)) {
    return 0;
  }
  if(isdefined(extracamdata) && extracamdata.uselobbyplayers) {
    return getequippedbodyindexforhero(localclientnum, charactermode, extracamdata.jobindex, 1);
  }
  if(isdefined(extracamdata) && isdefined(extracamdata.usebodyindex)) {
    return extracamdata.usebodyindex;
  }
  if(isdefined(extracamdata) && (isdefined(extracamdata.defaultimagerender) && extracamdata.defaultimagerender)) {
    return 0;
  }
  return getequippedbodyindexforhero(localclientnum, charactermode, characterindex);
}

function get_character_body_color(localclientnum, charactermode, characterindex, bodyindex, colorslot, extracamdata) {
  if(isdefined(extracamdata) && (isdefined(extracamdata.isdefaulthero) && extracamdata.isdefaulthero)) {
    return 0;
  }
  if(isdefined(extracamdata) && extracamdata.uselobbyplayers) {
    return getequippedbodyaccentcolorforhero(localclientnum, charactermode, extracamdata.jobindex, bodyindex, colorslot, 1);
  }
  if(isdefined(extracamdata) && (isdefined(extracamdata.defaultimagerender) && extracamdata.defaultimagerender)) {
    return 0;
  }
  return getequippedbodyaccentcolorforhero(localclientnum, charactermode, characterindex, bodyindex, colorslot);
}

function get_character_body_colors(localclientnum, charactermode, characterindex, bodyindex, extracamdata) {
  bodyaccentcolorcount = getbodyaccentcolorcountforhero(localclientnum, charactermode, characterindex, bodyindex);
  colors = [];
  for (i = 0; i < 3; i++) {
    colors[i] = 0;
  }
  for (i = 0; i < bodyaccentcolorcount; i++) {
    colors[i] = get_character_body_color(localclientnum, charactermode, characterindex, bodyindex, i, extracamdata);
  }
  return colors;
}

function get_character_head(localclientnum, charactermode, extracamdata) {
  if(isdefined(extracamdata) && (isdefined(extracamdata.isdefaulthero) && extracamdata.isdefaulthero)) {
    return 0;
  }
  if(isdefined(extracamdata) && extracamdata.uselobbyplayers) {
    return getequippedheadindexforhero(localclientnum, charactermode, extracamdata.jobindex);
  }
  if(isdefined(extracamdata) && isdefined(extracamdata.useheadindex)) {
    return extracamdata.useheadindex;
  }
  if(isdefined(extracamdata) && (isdefined(extracamdata.defaultimagerender) && extracamdata.defaultimagerender)) {
    return 0;
  }
  return getequippedheadindexforhero(localclientnum, charactermode);
}

function get_character_helmet(localclientnum, charactermode, characterindex, extracamdata) {
  if(isdefined(extracamdata) && (isdefined(extracamdata.isdefaulthero) && extracamdata.isdefaulthero)) {
    return 0;
  }
  if(isdefined(extracamdata) && extracamdata.uselobbyplayers) {
    return getequippedhelmetindexforhero(localclientnum, charactermode, extracamdata.jobindex, 1);
  }
  if(isdefined(extracamdata) && isdefined(extracamdata.usehelmetindex)) {
    return extracamdata.usehelmetindex;
  }
  if(isdefined(extracamdata) && (isdefined(extracamdata.defaultimagerender) && extracamdata.defaultimagerender)) {
    return 0;
  }
  return getequippedhelmetindexforhero(localclientnum, charactermode, characterindex);
}

function get_character_showcase_weapon(localclientnum, charactermode, characterindex, extracamdata) {
  if(isdefined(extracamdata) && (isdefined(extracamdata.isdefaulthero) && extracamdata.isdefaulthero)) {
    return undefined;
  }
  if(isdefined(extracamdata) && extracamdata.uselobbyplayers) {
    return getequippedshowcaseweaponforhero(localclientnum, charactermode, extracamdata.jobindex, 1);
  }
  if(isdefined(extracamdata) && isdefined(extracamdata.useshowcaseweapon)) {
    return extracamdata.useshowcaseweapon;
  }
  return getequippedshowcaseweaponforhero(localclientnum, charactermode, characterindex);
}

function get_character_helmet_color(localclientnum, charactermode, characterindex, helmetindex, colorslot, extracamdata) {
  if(isdefined(extracamdata) && (isdefined(extracamdata.isdefaulthero) && extracamdata.isdefaulthero)) {
    return 0;
  }
  if(isdefined(extracamdata) && extracamdata.uselobbyplayers) {
    return getequippedhelmetaccentcolorforhero(localclientnum, charactermode, extracamdata.jobindex, helmetindex, colorslot, 1);
  }
  if(isdefined(extracamdata) && (isdefined(extracamdata.defaultimagerender) && extracamdata.defaultimagerender)) {
    return 0;
  }
  return getequippedhelmetaccentcolorforhero(localclientnum, charactermode, characterindex, helmetindex, colorslot);
}

function get_character_helmet_colors(localclientnum, charactermode, characterindex, helmetindex, extracamdata) {
  helmetcolorcount = gethelmetaccentcolorcountforhero(localclientnum, charactermode, characterindex, helmetindex);
  colors = [];
  for (i = 0; i < 3; i++) {
    colors[i] = 0;
  }
  for (i = 0; i < helmetcolorcount; i++) {
    colors[i] = get_character_helmet_color(localclientnum, charactermode, characterindex, helmetindex, i, extracamdata);
  }
  return colors;
}

function update_character_animation_tree_for_scene(charactermodel) {
  if(!charactermodel hasanimtree()) {
    charactermodel useanimtree($all_player);
  }
}

function reaper_body3_hack(params) {
  if(isdefined(params.weapon_right) && params.weapon_right == "wpn_t7_hero_reaper_minigun_prop" && isdefined(level.mp_lobby_data_struct.charactermodel) && issubstr(level.mp_lobby_data_struct.charactermodel.model, "body3")) {
    params.weapon_right = "wpn_t7_loot_hero_reaper3_minigun_prop";
    params.weapon = getweapon("hero_minigun_body3");
    return true;
  }
  return false;
}

function get_current_frozen_moment_params(localclientnum, data_struct, params) {
  fields = getcharacterfields(data_struct.characterindex, data_struct.charactermode);
  if(data_struct.frozenmomentstyle == "weapon") {
    if(isdefined(fields.weaponfrontendfrozenmomentxanim)) {
      params.anim_name = fields.weaponfrontendfrozenmomentxanim;
    }
    params.scene = undefined;
    if(isdefined(fields.weaponfrontendfrozenmomentweaponleftmodel)) {
      params.weapon_left = fields.weaponfrontendfrozenmomentweaponleftmodel;
    }
    if(isdefined(fields.weaponfrontendfrozenmomentweaponleftanim)) {
      params.weapon_left_anim = fields.weaponfrontendfrozenmomentweaponleftanim;
    }
    if(isdefined(fields.weaponfrontendfrozenmomentweaponrightmodel)) {
      params.weapon_right = fields.weaponfrontendfrozenmomentweaponrightmodel;
    }
    if(isdefined(fields.weaponfrontendfrozenmomentweaponrightanim)) {
      params.weapon_right_anim = fields.weaponfrontendfrozenmomentweaponrightanim;
    }
    if(isdefined(fields.weaponfrontendfrozenmomentexploder)) {
      params.exploder_id = fields.weaponfrontendfrozenmomentexploder;
    }
    if(isdefined(struct::get(fields.weaponfrontendfrozenmomentaligntarget))) {
      params.align_struct = struct::get(fields.weaponfrontendfrozenmomentaligntarget);
    }
    if(isdefined(fields.weaponfrontendfrozenmomentxcam)) {
      params.xcam = fields.weaponfrontendfrozenmomentxcam;
    }
    if(isdefined(fields.weaponfrontendfrozenmomentxcamsubxcam)) {
      params.subxcam = fields.weaponfrontendfrozenmomentxcamsubxcam;
    }
    if(isdefined(fields.weaponfrontendfrozenmomentxcamframe)) {
      params.xcamframe = fields.weaponfrontendfrozenmomentxcamframe;
    }
  } else if(data_struct.frozenmomentstyle == "ability") {
    if(isdefined(fields.abilityfrontendfrozenmomentxanim)) {
      params.anim_name = fields.abilityfrontendfrozenmomentxanim;
    }
    params.scene = undefined;
    if(isdefined(fields.abilityfrontendfrozenmomentweaponleftmodel)) {
      params.weapon_left = fields.abilityfrontendfrozenmomentweaponleftmodel;
    }
    if(isdefined(fields.abilityfrontendfrozenmomentweaponleftanim)) {
      params.weapon_left_anim = fields.abilityfrontendfrozenmomentweaponleftanim;
    }
    if(isdefined(fields.abilityfrontendfrozenmomentweaponrightmodel)) {
      params.weapon_right = fields.abilityfrontendfrozenmomentweaponrightmodel;
    }
    if(isdefined(fields.abilityfrontendfrozenmomentweaponrightanim)) {
      params.weapon_right_anim = fields.abilityfrontendfrozenmomentweaponrightanim;
    }
    if(isdefined(fields.abilityfrontendfrozenmomentexploder)) {
      params.exploder_id = fields.abilityfrontendfrozenmomentexploder;
    }
    if(isdefined(struct::get(fields.abilityfrontendfrozenmomentaligntarget))) {
      params.align_struct = struct::get(fields.abilityfrontendfrozenmomentaligntarget);
    }
    if(isdefined(fields.abilityfrontendfrozenmomentxcam)) {
      params.xcam = fields.abilityfrontendfrozenmomentxcam;
    }
    if(isdefined(fields.abilityfrontendfrozenmomentxcamsubxcam)) {
      params.subxcam = fields.abilityfrontendfrozenmomentxcamsubxcam;
    }
    if(isdefined(fields.abilityfrontendfrozenmomentxcamframe)) {
      params.xcamframe = fields.abilityfrontendfrozenmomentxcamframe;
    }
  }
  reaper_body3_hack(params);
  if(!isdefined(params.align_struct)) {
    params.align_struct = data_struct;
  }
}

function play_intro_and_animation(intro_anim_name, anim_name, b_keep_link) {
  self notify("stop_vignette_animation");
  self endon("stop_vignette_animation");
  if(isdefined(intro_anim_name)) {
    self animation::play(intro_anim_name, self.chosenorigin, self.chosenangles, 1, 0, 0, 0, b_keep_link);
  }
  self animation::play(anim_name, self.chosenorigin, self.chosenangles, 1, 0, 0, 0, b_keep_link);
}

function update_character_animation_based_on_showcase_weapon(data_struct, params) {
  if(!isdefined(params.weapon_right) && !isdefined(params.weapon_left)) {
    if(isdefined(data_struct.anim_name)) {
      params.anim_name = data_struct.anim_name;
    }
  }
}

function update_character_animation_and_attachments(localclientnum, data_struct, params) {
  changed = 0;
  if(!isdefined(params)) {
    params = spawnstruct();
  }
  if(data_struct.usefrozenmomentanim && isdefined(data_struct.frozenmomentstyle)) {
    get_current_frozen_moment_params(localclientnum, data_struct, params);
  }
  if(!isdefined(params.exploder_id)) {
    params.exploder_id = data_struct.default_exploder;
  }
  align_changed = 0;
  if(!isdefined(params.align_struct)) {
    params.align_struct = struct::get(data_struct.align_target);
  }
  if(!isdefined(params.align_struct)) {
    params.align_struct = data_struct;
  }
  if(isdefined(params.align_struct) && (params.align_struct.origin !== data_struct.charactermodel.chosenorigin || params.align_struct.angles !== data_struct.charactermodel.chosenangles)) {
    data_struct.charactermodel.chosenorigin = params.align_struct.origin;
    data_struct.charactermodel.chosenangles = params.align_struct.angles;
    params.anim_name = (isdefined(params.anim_name) ? params.anim_name : data_struct.currentanimation);
    align_changed = 1;
  }
  if(isdefined(data_struct.allow_showcase_weapons) && data_struct.allow_showcase_weapons) {
    update_character_animation_based_on_showcase_weapon(data_struct, params);
  }
  if(reaper_body3_hack(params)) {
    align_changed = 1;
    changed = 1;
  }
  if(isdefined(params.weapon_right) && params.weapon_right !== data_struct.weapon_right) {
    align_changed = 1;
  }
  if(isdefined(params.anim_name) && (params.anim_name !== data_struct.currentanimation || align_changed)) {
    changed = 1;
    end_game_taunts::canceltaunt(localclientnum, data_struct.charactermodel);
    end_game_taunts::cancelgesture(data_struct.charactermodel);
    data_struct.currentanimation = params.anim_name;
    data_struct.weapon_right = params.weapon_right;
    if(!data_struct.charactermodel hasanimtree()) {
      data_struct.charactermodel useanimtree($all_player);
    }
    data_struct.charactermodel thread play_intro_and_animation(params.anim_intro_name, params.anim_name, 0);
  } else if(isdefined(params.scene) && params.scene !== data_struct.currentscene) {
    if(isdefined(data_struct.currentscene)) {
      level scene::stop(data_struct.currentscene, 0);
    }
    update_character_animation_tree_for_scene(data_struct.charactermodel);
    data_struct.currentscene = params.scene;
    level thread scene::play(params.scene);
  }
  if(data_struct.exploder_id !== params.exploder_id) {
    if(isdefined(data_struct.exploder_id)) {
      killradiantexploder(localclientnum, data_struct.exploder_id);
    }
    if(isdefined(params.exploder_id)) {
      playradiantexploder(localclientnum, params.exploder_id);
    }
    data_struct.exploder_id = params.exploder_id;
  }
  if(isdefined(params.weapon_right) || isdefined(params.weapon_left)) {
    update_model_attachment(localclientnum, data_struct, params.weapon_right, "tag_weapon_right", params.weapon_right_anim, params.weapon_right_anim_intro, align_changed);
    update_model_attachment(localclientnum, data_struct, params.weapon_left, "tag_weapon_left", params.weapon_left_anim, params.weapon_left_anim_intro, align_changed);
  } else if(isdefined(data_struct.showcaseweaponmodel)) {
    if(isdefined(data_struct.attached_models["tag_weapon_right"]) && data_struct.charactermodel isattached(data_struct.attached_models["tag_weapon_right"], "tag_weapon_right")) {
      data_struct.charactermodel detach(data_struct.attached_models["tag_weapon_right"], "tag_weapon_right");
    }
    if(isdefined(data_struct.attached_models["tag_weapon_left"]) && data_struct.charactermodel isattached(data_struct.attached_models["tag_weapon_left"], "tag_weapon_left")) {
      data_struct.charactermodel detach(data_struct.attached_models["tag_weapon_left"], "tag_weapon_left");
    }
    data_struct.charactermodel attachweapon(data_struct.showcaseweaponmodel, data_struct.weaponrenderoptions, data_struct.acvi);
    data_struct.charactermodel useweaponhidetags(data_struct.showcaseweaponmodel);
    data_struct.charactermodel.showcaseweapon = data_struct.showcaseweaponmodel;
    data_struct.charactermodel.showcaseweaponrenderoptions = data_struct.weaponrenderoptions;
    data_struct.charactermodel.showcaseweaponacvi = data_struct.acvi;
  }
  return changed;
}

function update_use_frozen_moments(localclientnum, data_struct, usefrozenmoments) {
  if(data_struct.usefrozenmomentanim != usefrozenmoments) {
    data_struct.usefrozenmomentanim = usefrozenmoments;
    params = spawnstruct();
    if(!data_struct.usefrozenmomentanim) {
      params.align_struct = struct::get("character_customization");
      params.anim_name = "pb_cac_main_lobby_idle";
    }
    markasdirty(data_struct.charactermodel);
    update_character_animation_and_attachments(localclientnum, data_struct, params);
    if(data_struct.usefrozenmomentanim) {
      level notify("frozenMomentChanged" + localclientnum);
    }
  }
}

function update_show_helmets(localclientnum, data_struct, show_helmets) {
  if(data_struct.show_helmets != show_helmets) {
    data_struct.show_helmets = show_helmets;
    params = spawnstruct();
    params.weapon_right = data_struct.attached_models["tag_weapon_right"];
    params.weapon_left = data_struct.attached_models["tag_weapon_left"];
    update(localclientnum, data_struct, params);
  }
}

function set_character_align(localclientnum, data_struct, align_target) {
  if(data_struct.align_target !== align_target) {
    data_struct.align_target = align_target;
    params = spawnstruct();
    params.weapon_right = data_struct.attached_models["tag_weapon_right"];
    params.weapon_left = data_struct.attached_models["tag_weapon_left"];
    update(localclientnum, data_struct, params);
  }
}

function setup_live_character_customization_target(localclientnum) {
  characterent = getent(localclientnum, "character_customization", "targetname");
  if(isdefined(characterent)) {
    customization_data_struct = create_character_data_struct(characterent, localclientnum, 1);
    customization_data_struct.default_exploder = "char_customization";
    customization_data_struct.allow_showcase_weapons = 1;
    level thread updateeventthread(localclientnum, customization_data_struct);
    return customization_data_struct;
  }
  return undefined;
}

function update_locked_shader(localclientnum, params) {
  if(isdefined(params.isitemunlocked) && params.isitemunlocked != 1) {
    enablefrontendlockedweaponoverlay(localclientnum, 1);
  } else {
    enablefrontendlockedweaponoverlay(localclientnum, 0);
  }
}

function updateeventthread(localclientnum, data_struct) {
  while (true) {
    level waittill("updateHero" + localclientnum, eventtype, param1, param2, param3, param4);
    switch (eventtype) {
      case "update_lcn": {
        data_struct.splitscreenclient = param1;
        break;
      }
      case "refresh": {
        data_struct.splitscreenclient = param1;
        params = spawnstruct();
        params.anim_name = "pb_cac_main_lobby_idle";
        params.sessionmode = param2;
        loadequippedcharacteronmodel(localclientnum, data_struct, undefined, params);
        if(isdefined(param3) && param3 != "") {
          level.mp_lobby_data_struct.playsound = param3;
        }
        break;
      }
      case "changeHero": {
        params = spawnstruct();
        params.anim_name = "pb_cac_main_lobby_idle";
        params.sessionmode = param2;
        loadequippedcharacteronmodel(localclientnum, data_struct, param1, params);
        break;
      }
      case "changeBody": {
        params = spawnstruct();
        params.sessionmode = param2;
        params.isitemunlocked = param3;
        set_body(data_struct, param2, data_struct.characterindex, param1, get_character_body_colors(localclientnum, param2, data_struct.characterindex, param1));
        update(localclientnum, data_struct, params);
        update_locked_shader(localclientnum, params);
        break;
      }
      case "changeHelmet": {
        params = spawnstruct();
        params.sessionmode = param2;
        params.isitemunlocked = param3;
        set_helmet(data_struct, param2, data_struct.characterindex, param1, get_character_helmet_colors(localclientnum, param2, data_struct.characterindex, param1));
        update(localclientnum, data_struct, params);
        update_locked_shader(localclientnum, params);
        break;
      }
      case "changeShowcaseWeapon": {
        params = spawnstruct();
        params.sessionmode = param4;
        set_showcase_weapon(data_struct, param4, localclientnum, undefined, data_struct.characterindex, param1, param2, param3, 0, 1);
        update(localclientnum, data_struct, params);
        break;
      }
      case "changeHead": {
        params = spawnstruct();
        params.sessionmode = param2;
        set_head(data_struct, param2, param1);
        update(localclientnum, data_struct, params);
        break;
      }
      case "changeBodyAccentColor": {
        params = spawnstruct();
        params.sessionmode = param3;
        set_body_color(data_struct, param1, param2);
        update(localclientnum, data_struct, params);
        break;
      }
      case "changeHelmetAccentColor": {
        params = spawnstruct();
        params.sessionmode = param3;
        set_helmet_color(data_struct, param1, param2);
        update(localclientnum, data_struct, params);
        break;
      }
      case "changeFrozenMoment": {
        data_struct.frozenmomentstyle = param1;
        if(data_struct.usefrozenmomentanim) {
          markasdirty(data_struct.charactermodel);
          update_character_animation_and_attachments(localclientnum, data_struct, undefined);
        }
        level notify("frozenMomentChanged" + localclientnum);
        break;
      }
      case "previewGesture": {
        data_struct.currentanimation = param1;
        thread end_game_taunts::previewgesture(localclientnum, data_struct.charactermodel, data_struct.anim_name, param1);
        break;
      }
      case "previewTaunt": {
        if(is_character_streamed(data_struct)) {
          data_struct.currentanimation = param1;
          thread end_game_taunts::previewtaunt(localclientnum, data_struct.charactermodel, data_struct.anim_name, param1);
        }
        break;
      }
    }
  }
}

function rotation_thread_spawner(localclientnum, data_struct, endonevent) {
  if(!isdefined(endonevent)) {
    return;
  }
  assert(isdefined(data_struct.charactermodel));
  model = data_struct.charactermodel;
  baseangles = model.angles;
  level thread update_model_rotation_for_right_stick(localclientnum, data_struct, endonevent);
  level waittill(endonevent);
  if(!(isdefined(data_struct.charactermodel.anglesoverride) && data_struct.charactermodel.anglesoverride)) {
    model.angles = baseangles;
  }
}

function update_model_rotation_for_right_stick(localclientnum, data_struct, endonevent) {
  level endon(endonevent);
  assert(isdefined(data_struct.charactermodel));
  model = data_struct.charactermodel;
  while (true) {
    data_lcn = (isdefined(data_struct.splitscreenclient) ? data_struct.splitscreenclient : localclientnum);
    if(localclientactive(data_lcn) && (!(isdefined(data_struct.charactermodel.anglesoverride) && data_struct.charactermodel.anglesoverride))) {
      pos = getcontrollerposition(data_lcn);
      if(isdefined(pos["rightStick"])) {
        model.angles = (model.angles[0], absangleclamp360(model.angles[1] + (pos["rightStick"][0] * 3)), model.angles[2]);
      } else {
        model.angles = (model.angles[0], absangleclamp360(model.angles[1] + (pos["look"][0] * 3)), model.angles[2]);
      }
      if(ispc()) {
        pos = getxcammousecontrol(data_lcn);
        model.angles = (model.angles[0], absangleclamp360(model.angles[1] - (pos["yaw"] * 3)), model.angles[2]);
      }
    }
    wait(0.016);
  }
}

function setup_static_character_customization_target(localclientnum) {
  characterent = getent(localclientnum, "character_customization_staging", "targetname");
  level.extra_cam_hero_data[localclientnum] = setup_character_extracam_struct("ui_cam_character_customization", "cam_menu_unfocus", "pb_cac_main_lobby_idle", 0);
  level.extra_cam_lobby_client_hero_data[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", "pb_cac_vs_screen_idle_1", 1);
  level.extra_cam_headshot_hero_data[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", "pb_cac_vs_screen_idle_1", 0);
  level.extra_cam_outfit_preview_data[localclientnum] = setup_character_extracam_struct("ui_cam_char_identity", "cam_bust", "pb_cac_main_lobby_idle", 0);
  if(isdefined(characterent)) {
    customization_data_struct = create_character_data_struct(characterent, localclientnum, 0);
    level thread update_character_extracam(localclientnum, customization_data_struct);
    return customization_data_struct;
  }
  return undefined;
}

function setup_character_extracam_struct(xcam, subxcam, model_animation, uselobbyplayers) {
  newstruct = spawnstruct();
  newstruct.xcam = xcam;
  newstruct.subxcam = subxcam;
  newstruct.anim_name = model_animation;
  newstruct.uselobbyplayers = uselobbyplayers;
  return newstruct;
}

function wait_for_extracam_close(localclientnum, camera_ent, extracamindex) {
  level waittill((("render_complete_" + localclientnum) + "_") + extracamindex);
  multi_extracam::extracam_reset_index(localclientnum, extracamindex);
}

function setup_character_extracam_settings(localclientnum, data_struct, extracam_data_struct) {
  assert(isdefined(extracam_data_struct.jobindex));
  if(!isdefined(level.camera_ents)) {
    level.camera_ents = [];
  }
  initializedextracam = 0;
  camera_ent = (isdefined(level.camera_ents[localclientnum]) ? level.camera_ents[localclientnum][extracam_data_struct.extracamindex] : undefined);
  if(!isdefined(camera_ent)) {
    initializedextracam = 1;
    multi_extracam::extracam_init_index(localclientnum, "character_staging_extracam" + (extracam_data_struct.extracamindex + 1), extracam_data_struct.extracamindex);
    camera_ent = level.camera_ents[localclientnum][extracam_data_struct.extracamindex];
  }
  assert(isdefined(camera_ent));
  camera_ent playextracamxcam(extracam_data_struct.xcam, 0, extracam_data_struct.subxcam);
  params = spawnstruct();
  params.anim_name = extracam_data_struct.anim_name;
  params.extracam_data = extracam_data_struct;
  params.isdefaulthero = extracam_data_struct.isdefaulthero;
  params.sessionmode = extracam_data_struct.sessionmode;
  params.hide_helmet = isdefined(extracam_data_struct.hidehelmet) && extracam_data_struct.hidehelmet;
  data_struct.alt_render_mode = 0;
  loadequippedcharacteronmodel(localclientnum, data_struct, extracam_data_struct.characterindex, params);
  while (!is_character_streamed(data_struct)) {
    wait(0.016);
  }
  if(isdefined(extracam_data_struct.defaultimagerender) && extracam_data_struct.defaultimagerender) {
    wait(0.5);
  } else {
    wait(0.1);
  }
  setextracamrenderready(extracam_data_struct.jobindex);
  extracam_data_struct.jobindex = undefined;
  if(initializedextracam) {
    level thread wait_for_extracam_close(localclientnum, camera_ent, extracam_data_struct.extracamindex);
  }
}

function update_character_extracam(localclientnum, data_struct) {
  level endon("disconnect");
  while (true) {
    level waittill("process_character_extracam" + localclientnum, extracam_data_struct);
    setup_character_extracam_settings(localclientnum, data_struct, extracam_data_struct);
  }
}

function process_character_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, characterindex) {
  level.extra_cam_hero_data[localclientnum].jobindex = jobindex;
  level.extra_cam_hero_data[localclientnum].extracamindex = extracamindex;
  level.extra_cam_hero_data[localclientnum].characterindex = characterindex;
  level.extra_cam_hero_data[localclientnum].sessionmode = sessionmode;
  level notify("process_character_extracam" + localclientnum, level.extra_cam_hero_data[localclientnum]);
}

function process_lobby_client_character_extracam_request(localclientnum, jobindex, extracamindex, sessionmode) {
  level.extra_cam_lobby_client_hero_data[localclientnum].jobindex = jobindex;
  level.extra_cam_lobby_client_hero_data[localclientnum].extracamindex = extracamindex;
  level.extra_cam_lobby_client_hero_data[localclientnum].characterindex = getequippedcharacterindexforlobbyclienthero(localclientnum, jobindex);
  level.extra_cam_lobby_client_hero_data[localclientnum].sessionmode = sessionmode;
  level notify("process_character_extracam" + localclientnum, level.extra_cam_lobby_client_hero_data[localclientnum]);
}

function process_current_hero_headshot_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, characterindex, isdefaulthero) {
  level.extra_cam_headshot_hero_data[localclientnum].jobindex = jobindex;
  level.extra_cam_headshot_hero_data[localclientnum].extracamindex = extracamindex;
  level.extra_cam_headshot_hero_data[localclientnum].characterindex = characterindex;
  level.extra_cam_headshot_hero_data[localclientnum].isdefaulthero = isdefaulthero;
  level.extra_cam_headshot_hero_data[localclientnum].sessionmode = sessionmode;
  level notify("process_character_extracam" + localclientnum, level.extra_cam_headshot_hero_data[localclientnum]);
}

function process_outfit_preview_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, outfitindex) {
  level.extra_cam_outfit_preview_data[localclientnum].jobindex = jobindex;
  level.extra_cam_outfit_preview_data[localclientnum].extracamindex = extracamindex;
  level.extra_cam_outfit_preview_data[localclientnum].characterindex = outfitindex;
  level.extra_cam_outfit_preview_data[localclientnum].sessionmode = sessionmode;
  level notify("process_character_extracam" + localclientnum, level.extra_cam_outfit_preview_data[localclientnum]);
}

function process_character_body_item_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, characterindex, itemindex, defaultimagerender) {
  extracam_data = undefined;
  if(defaultimagerender) {
    extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons_render", "loot_body", "pb_cac_vs_screen_idle_1", 0);
    extracam_data.useheadindex = getfirstheadofgender(getherogender(characterindex, sessionmode), sessionmode);
  } else {
    extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons", "cam_body", "pb_cac_vs_screen_idle_1", 0);
  }
  extracam_data.jobindex = jobindex;
  extracam_data.extracamindex = extracamindex;
  extracam_data.sessionmode = sessionmode;
  extracam_data.characterindex = characterindex;
  extracam_data.usebodyindex = itemindex;
  extracam_data.defaultimagerender = defaultimagerender;
  level notify("process_character_extracam" + localclientnum, extracam_data);
}

function process_character_helmet_item_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, characterindex, itemindex, defaultimagerender) {
  extracam_data = undefined;
  if(defaultimagerender) {
    extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons_render", "loot_helmet", "pb_cac_vs_screen_idle_1", 0);
    extracam_data.useheadindex = getfirstheadofgender(getherogender(characterindex, sessionmode), sessionmode);
  } else {
    extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons", "cam_helmet", "pb_cac_vs_screen_idle_1", 0);
  }
  extracam_data.jobindex = jobindex;
  extracam_data.extracamindex = extracamindex;
  extracam_data.sessionmode = sessionmode;
  extracam_data.characterindex = characterindex;
  extracam_data.usehelmetindex = itemindex;
  extracam_data.defaultimagerender = defaultimagerender;
  level notify("process_character_extracam" + localclientnum, extracam_data);
}

function process_character_head_item_extracam_request(localclientnum, jobindex, extracamindex, sessionmode, headindex, defaultimagerender) {
  extracam_data = undefined;
  if(defaultimagerender) {
    extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons_render", "cam_head", "pb_cac_vs_screen_idle_1", 0);
    extracam_data.characterindex = getfirstheroofgender(getheadgender(headindex, sessionmode), sessionmode);
  } else {
    extracam_data = setup_character_extracam_struct("ui_cam_char_customization_icons", "cam_head", "pb_cac_vs_screen_idle_1", 0);
  }
  extracam_data.jobindex = jobindex;
  extracam_data.extracamindex = extracamindex;
  extracam_data.sessionmode = sessionmode;
  extracam_data.useheadindex = headindex;
  extracam_data.hidehelmet = 1;
  extracam_data.defaultimagerender = defaultimagerender;
  level notify("process_character_extracam" + localclientnum, extracam_data);
}