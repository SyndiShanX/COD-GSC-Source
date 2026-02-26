/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_utility.csc
***********************************************/

#using scripts\core_common\activecamo_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm_common\zm_customgame;
#using scripts\zm_common\zm_maptable;
#using scripts\zm_common\zm_wallbuy;
#namespace zm_utility;

function private autoexec __init__system__() {
  system::register(#"zm_utility", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  level._effect[#"zm_zone_edge_marker"] = # "hash_3002526b7ff53cbf";
  clientfield::register_clientuimodel("hudItems.armorType", #"hud_items", #"armortype", 1, 2, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.armorPercent", #"hud_items", #"armorpercent", 1, 7, "float", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.scrap", #"hud_items", #"scrap", 1, 16, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("hudItems.rareScrap", #"hud_items", #"rarescrap", 1, 16, "int", undefined, 0, 0);
  clientfield::register_clientuimodel("pap_current", #"zm_hud", #"hash_64f2ff2ddddbe9c7", 1, 2, "int", undefined, 0, 0);
  clientfield::register("toplayer", "zm_zone_out_of_bounds", 1, 1, "int", &zm_zone_out_of_bounds, 0, 0);
  clientfield::register("actor", "flame_corpse_fx", 1, 1, "int", &flame_corpse_fx, 0, 0);
  clientfield::register("scriptmover", "model_rarity_rob", 1, 3, "int", &model_rarity_rob, 0, 0);
  clientfield::register("scriptmover", "set_compass_icon", 1, 1, "int", &set_compass_icon, 0, 0);
  clientfield::register("scriptmover", "force_stream", 1, 1, "int", &force_stream_changed, 0, 0);
  callback::on_localclient_connect(&on_localclient_connect);

  for(i = 0; i < 5; i++) {
    clientfield::function_5b7d846d("PlayerList.client" + i + ".playerIsDowned", #"hash_97df1852304b867", [hash(isDefined(i) ? "" + i : ""), #"playerisdowned"], 1, 1, "int", undefined, 0, 0);
    clientfield::function_5b7d846d("PlayerList.client" + i + ".self_revives", #"hash_97df1852304b867", [hash(isDefined(i) ? "" + i : ""), #"self_revives"], 1, 8, "int", undefined, 0, 0);
  }
}

function on_localclient_connect(localclientnum) {
  level thread function_725e99fb(localclientnum);
}

function private postinit() {}

function ignore_triggers(timer) {
  if(!isDefined(self)) {
    return;
  }

  self endon(#"death");
  self.ignoretriggers = 1;

  if(isDefined(timer)) {
    wait timer;
  } else {
    wait 0.5;
  }

  self.ignoretriggers = 0;
}

function is_encounter() {
  return false;
}

function round_up_to_ten(score) {
  new_score = score - score % 10;

  if(new_score < score) {
    new_score += 10;
  }

  return new_score;
}

function round_up_score(score, value) {
  score = int(score);
  new_score = score - score % value;

  if(new_score < score) {
    new_score += value;
  }

  return new_score;
}

function halve_score(n_score) {
  n_score /= 2;
  n_score = round_up_score(n_score, 10);
  return n_score;
}

function spawn_weapon_model(localclientnum, weapon, model = weapon.worldmodel, origin, angles, renderoptionsweapon, var_fd90b0bb) {
  weapon_model = spawn(localclientnum, origin, "script_model");

  if(isDefined(angles)) {
    weapon_model.angles = angles;
  }

  if(isDefined(renderoptionsweapon) || isDefined(var_fd90b0bb)) {
    weapon_model useweaponmodel(weapon, model, renderoptionsweapon, var_fd90b0bb);
  } else {
    weapon_model useweaponmodel(weapon, model);
  }

  return weapon_model;
}

function spawn_buildkit_weapon_model(localclientnum, weapon, camo, origin, angles) {
  weapon_model = spawn(localclientnum, origin, "script_model");

  if(isDefined(angles)) {
    weapon_model.angles = angles;
  }

  weapon_model usebuildkitweaponmodel(localclientnum, weapon, camo);
  weapon_model activecamo::function_e40c785a(localclientnum);
  return weapon_model;
}

function is_classic() {
  str_gametype = util::get_game_type();

  if(str_gametype == # "zclassic") {
    return true;
  }

  return false;
}

function is_survival() {
  str_gametype = util::get_game_type();

  if(str_gametype == # "zsurvival") {
    return true;
  }

  return false;
}

function is_standard() {
  str_gametype = util::get_game_type();

  if(str_gametype == # "zstandard") {
    return true;
  }

  return false;
}

function is_trials() {
  str_gametype = util::get_game_type();

  if(str_gametype == # "ztrials" || level flag::exists(#"ztrial")) {
    return true;
  }

  return false;
}

function is_tutorial() {
  str_gametype = util::get_game_type();

  if(str_gametype == # "ztutorial") {
    return true;
  }

  return false;
}

function is_grief() {
  str_gametype = util::get_game_type();

  if(str_gametype == # "zgrief") {
    return true;
  }

  return false;
}

function is_gametype_active(a_gametypes) {
  b_is_gametype_active = 0;

  if(!isarray(a_gametypes)) {
    a_gametypes = array(a_gametypes);
  }

  for(i = 0; i < a_gametypes.size; i++) {
    if(util::get_game_type() == a_gametypes[i]) {
      b_is_gametype_active = 1;
    }
  }

  return b_is_gametype_active;
}

function is_ee_enabled() {
  if(!getdvarint(#"zm_ee_enabled", 0)) {
    return false;
  }

  if(!zm_custom::function_901b751c(#"hash_3c5363541b97ca3e")) {
    return false;
  }

  if(level.gamedifficulty == 0) {
    return false;
  }

  return true;
}

function function_36e7b4a2() {
  if(is_true(getgametypesetting(#"hash_5d6471cd7038852e")) && !is_true(getgametypesetting(#"hash_1e1a5ebefe2772ba"))) {
    return true;
  }

  return false;
}

function setinventoryuimodels(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(function_65b9eb0f(binitialsnap)) {
    return;
  }

  setuimodelvalue(createuimodel(function_1df4c3b0(binitialsnap, #"zm_inventory"), bwastimejump), fieldname);
}

function setsharedinventoryuimodels(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setuimodelvalue(createuimodel(function_1df4c3b0(binitialsnap, #"zm_inventory"), bwastimejump), fieldname);
}

function zm_ui_infotext(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(fieldname) {
    setuimodelvalue(createuimodel(function_1df4c3b0(binitialsnap, #"zm_inventory"), "infoText"), bwastimejump);
    return;
  }

  setuimodelvalue(createuimodel(function_1df4c3b0(binitialsnap, #"zm_inventory"), "infoText"), "");
}

function drawcylinder(pos, rad, height, color) {
  currad = rad;
  curheight = height;
  debugstar(pos, 1, color);

  for(r = 0; r < 20; r++) {
    theta = r / 20 * 360;
    theta2 = (r + 1) / 20 * 360;
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta2) * currad, sin(theta2) * currad, 0), color, 1, 1, 100);
    line(pos + (cos(theta) * currad, sin(theta) * currad, curheight), pos + (cos(theta2) * currad, sin(theta2) * currad, curheight), color, 1, 1, 100);
    line(pos + (cos(theta) * currad, sin(theta) * currad, 0), pos + (cos(theta) * currad, sin(theta) * currad, curheight), color, 1, 1, 100);
  }
}

function function_f8796df3(localclientnum) {
  b_first = 0;

  if(isPlayer(self) && self function_21c0fa55() && !isdemoplaying()) {
    var_27cd9fcb = self getlocalclientnumber();

    if((!isDefined(var_27cd9fcb) || localclientnum == var_27cd9fcb) && !isthirdperson(localclientnum)) {
      b_first = 1;
    }
  }

  return b_first;
}

function function_467efa7b(var_9f3fb329 = 0) {
  if(!isDefined(self.archetype)) {
    return "tag_origin";
  }

  switch (self.archetype) {
    case # "stoker":
    case # "catalyst":
    case # "gladiator":
    case # "nova_crawler":
    case # "zombie":
    case # "ghost":
    case # "brutus":
      if(var_9f3fb329) {
        str_tag = "j_spine4";
      } else {
        str_tag = "j_spineupper";
      }

      break;
    case # "blight_father":
    case # "tiger":
    case # "elephant":
      str_tag = "j_head";
      break;
    default:
      str_tag = "tag_origin";
      break;
  }

  return str_tag;
}

function function_bb54a31f(localclientnum, var_20804e3b, var_3ab46b9) {
  self endon(var_3ab46b9);
  s_result = level waittill(#"respawn");
  a_e_players = getlocalplayers();

  foreach(e_player in a_e_players) {
    if(e_player postfx::function_556665f2(var_20804e3b)) {
      e_player postfx::exitpostfxbundle(var_20804e3b);
    }
  }
}

function function_ae3780f1(localclientnum, n_fx_id, var_3ab46b9) {
  self endon(var_3ab46b9);
  s_result = level waittill(#"respawn");
  a_e_players = getlocalplayers();

  foreach(e_player in a_e_players) {
    if(isDefined(n_fx_id)) {
      deletefx(localclientnum, n_fx_id);
      n_fx_id = undefined;
    }
  }
}

function get_cast() {
  return zm_maptable::get_cast();
}

function get_story() {
  return zm_maptable::get_story();
}

function zm_zone_out_of_bounds(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_20861007)) {
    level.var_20861007 = [];
  }

  if(!isDefined(level.var_20861007[fieldname])) {
    level.var_20861007[fieldname] = util::spawn_model(fieldname, "tag_origin");
  }

  if(bwastimejump) {
    level.var_20861007[fieldname] playLoopSound(#"hash_6da7ae12f538ef5e", 0.5);
    self postfx::playpostfxbundle(#"hash_798237aa1bad3d7d");
    return;
  }

  level.var_20861007[fieldname] stopallloopsounds(0.5);
  self postfx::exitpostfxbundle(#"hash_798237aa1bad3d7d");
}

function flame_corpse_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump == 1) {
    if(isDefined(self.var_71a7fc1c)) {
      stopfx(fieldname, self.var_71a7fc1c);
    }

    str_tag = "j_spineupper";

    if(!isDefined(self gettagorigin(str_tag))) {
      str_tag = "tag_origin";
    }

    if(isDefined(level._effect) && isDefined(level._effect[#"character_fire_death_torso"])) {
      self.var_71a7fc1c = util::playFXOnTag(fieldname, level._effect[#"character_fire_death_torso"], self, str_tag);
    }

    return;
  }

  if(isDefined(self.var_71a7fc1c)) {
    stopfx(fieldname, self.var_71a7fc1c);
    self.var_71a7fc1c = undefined;
  }
}

function model_rarity_rob(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  switch (bwasdemojump) {
    case 1:
      self.var_d9e5ccb2 = # "hash_6f1ab68ac78ac2ea";
      break;
    case 2:
      self.var_d9e5ccb2 = # "hash_312ceb838675b80";
      break;
    case 3:
      self.var_d9e5ccb2 = # "hash_70c807782a37573e";
      break;
    case 4:
      self.var_d9e5ccb2 = # "hash_5b08235c0b55a003";
      break;
    case 5:
      self.var_d9e5ccb2 = # "rob_sr_item_purple";
      break;
    case 6:
      self.var_d9e5ccb2 = # "hash_64261dabb4df88cd";
      break;
    case 7:
      self.var_d9e5ccb2 = # "rob_sr_item_gold";
      break;
    case 0:
    default:
      if(isDefined(self.var_d9e5ccb2)) {
        self stoprenderoverridebundle(self.var_d9e5ccb2);
        self.var_d9e5ccb2 = undefined;
      }

      break;
  }

  if(isDefined(self.var_d9e5ccb2)) {
    self playrenderoverridebundle(self.var_d9e5ccb2);
  }
}

function set_compass_icon(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    switch (self.model) {
      case # "p9_zm_platinum_radio_call_boxes_on":
        str_objective = # "hash_4542aa212012068";
        break;
      case # "p8_wz_ep_fishing_pole":
        str_objective = # "hash_249d888e2d3c6aed";
        break;
      case # "hash_94b3a8b935248d0":
        str_objective = # "hash_669c000075d7222";
        break;
      case # "p9_fxanim_zm_gold_control_point_collector_mod":
        str_objective = # "hash_1da886c89c2e4073";
        break;
      case # "p9_fxanim_zm_gold_control_point_crystal_mod":
        str_objective = # "hash_73705646f7ccc79c";
        break;
      case # "hash_3d3aeedc296addd":
        str_objective = # "hash_5ae3492cc261d9c9";
        break;
      case # "p9_zm_gold_teleporter_b":
        str_objective = # "hash_48c296f58e75bbc7";
        break;
      case # "p9_zm_gold_jumppads_machine_mod":
        str_objective = # "hash_7ccf11b4a680682a";
        break;
      case # "p9_zm_gold_jumppads_machine_sub":
        str_objective = # "hash_7f5d2d61a6f36e5d";
        break;
      case # "p8_zm_off_trap_switch_box":
        str_objective = # "hash_6906420c98a0ea37";
        break;
      default:
        str_objective = # "hash_7ec87a35af8f03b0";
        self zm_wallbuy::function_8f12abec(fieldname);
        break;
    }

    self thread function_a1290dca(fieldname, str_objective);
    return;
  }

  self notify(#"hash_1c25e0d8228a5516");
}

function function_a1290dca(localclientnum, str_objective, n_range = 1500) {
  self notify("7a62b33c6cdca143");
  self endon("7a62b33c6cdca143");
  self endoncallback(&function_2b04855, #"death", #"hash_1c25e0d8228a5516");

  if(!isDefined(level.var_cef2e607[#"hash_2aeea3ff25adc082"])) {
    level.var_cef2e607[#"hash_2aeea3ff25adc082"] = -1;
  }

  level.var_cef2e607[#"hash_2aeea3ff25adc082"]++;
  wait 0.016 * (level.var_cef2e607[#"hash_2aeea3ff25adc082"] % int(0.5 / 0.016) + 1);

  while(true) {
    var_30300360 = 0;
    player = function_5c10bd79(localclientnum);

    if(isDefined(player) && function_9023da2d(player, self, n_range)) {
      var_30300360 = 1;
    }

    if(var_30300360 && !isDefined(self.n_obj_id)) {
      self.n_obj_id = util::getnextobjid(localclientnum);
      objective_add(localclientnum, self.n_obj_id, "active", str_objective, self.origin);
      objective_onentity(localclientnum, self.n_obj_id, self, 0, 1, 0);
    } else if(!var_30300360 && isDefined(self.n_obj_id)) {
      util::releaseobjid(localclientnum, self.n_obj_id);
      objective_delete(localclientnum, self.n_obj_id);
      self.n_obj_id = undefined;
    }

    wait 0.5;
  }
}

function function_2b04855(str_notify) {
  if(isDefined(self.n_obj_id)) {
    foreach(localclientnum in function_41bfa501()) {
      util::releaseobjid(localclientnum, self.n_obj_id);
      objective_delete(localclientnum, self.n_obj_id);
    }

    self.n_obj_id = undefined;
  }
}

function function_9023da2d(player, entity, n_range) {
  if(is_survival()) {
    n_range = 3000;
  }

  n_range = isDefined(entity.var_c1ec47be) ? entity.var_c1ec47be : n_range;

  if(distance(player.origin, entity.origin) > n_range) {
    return false;
  }

  if(is_survival()) {
    return true;
  }

  var_27e54ab2 = isDefined(level.var_c2964bec) ? level.var_c2964bec : 160;
  var_27e54ab2 = isDefined(entity.var_c2964bec) ? entity.var_c2964bec : var_27e54ab2;

  if(abs(player.origin[2] - entity.origin[2]) > var_27e54ab2) {
    return false;
  }

  return true;
}

function force_stream_changed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(!isDefined(level.var_c427e93b)) {
      level.var_c427e93b = [];
    } else if(!isarray(level.var_c427e93b)) {
      level.var_c427e93b = array(level.var_c427e93b);
    }

    if(!isinarray(level.var_c427e93b, self)) {
      level.var_c427e93b[level.var_c427e93b.size] = self;
    }

    if(self.model == # "p9_fxanim_zm_gp_dac_xmodel") {
      self.var_35f71e38 = array(#"p9_sur_machine_computer_side_screen_on_seq_01", #"p9_sur_machine_computer_side_screen_on_seq_02");
    } else if(self.model == # "p9_zm_ndu_trial_terminal_01") {
      player = function_5c10bd79(fieldname);
      n_ent_num = player getentitynumber();

      switch (n_ent_num) {
        case 0:
        default:
          self.var_35f71e38 = array(#"p9_zm_ndu_trial_terminal_01_screen_face_purple", #"p9_zm_ndu_trial_terminal_01_screen_face_static_purple");
          break;
        case 1:
          self.var_35f71e38 = array(#"p9_zm_ndu_trial_terminal_01_screen_face_orange", #"p9_zm_ndu_trial_terminal_01_screen_face_static_orange");
          break;
        case 2:
          self.var_35f71e38 = array(#"p9_zm_ndu_trial_terminal_01_screen_face_green", #"p9_zm_ndu_trial_terminal_01_screen_face_static_green");
          break;
        case 3:
          self.var_35f71e38 = array(#"p9_zm_ndu_trial_terminal_01_screen_face_blue", #"p9_zm_ndu_trial_terminal_01_screen_face_static_blue");
          break;
      }
    }

    self callback::add_entity_callback(#"on_entity_shutdown", &function_1b43e8f6);
    return;
  }

  arrayremovevalue(level.var_c427e93b, self);

  if(isDefined(self.model) && self.model != "") {
    util::unlock_model(self.model);
    self callback::function_52ac9652(#"on_entity_shutdown", &function_1b43e8f6);
  }
}

function function_1b43e8f6(params) {
  if(self.model != "") {
    util::unlock_model(self.model);
    self callback::function_52ac9652(#"on_entity_shutdown", &function_1b43e8f6);
  }
}

function function_ca960904(machine) {
  if(!isDefined(level.var_c427e93b)) {
    level.var_c427e93b = [];
  } else if(!isarray(level.var_c427e93b)) {
    level.var_c427e93b = array(level.var_c427e93b);
  }

  if(!isinarray(level.var_c427e93b, machine)) {
    level.var_c427e93b[level.var_c427e93b.size] = machine;
  }
}

function function_725e99fb(localclientnum) {
  self notify("1d5a2d5d1c016b65");
  self endon("1d5a2d5d1c016b65");
  level endon(#"end_game");

  if(!isDefined(level.var_c427e93b)) {
    level.var_c427e93b = [];
  }

  util::init_dvar(#"hash_416069220b5b56e3", 0, &function_3a919d3f);

  while(true) {
    arrayremovevalue(level.var_c427e93b, undefined);

    if(!getdvarint(#"hash_2769a6109d9d7b4d", 1)) {
      foreach(machine in level.var_c427e93b) {
        if(is_true(machine.var_c02c4d66)) {
          util::unlock_model(machine.model);
          machine.var_c02c4d66 = undefined;

          if(isarray(machine.var_35f71e38)) {
            foreach(var_61794186 in machine.var_35f71e38) {
              util::unlock_model(var_61794186);
            }
          }
        }
      }

      wait 1;
      continue;
    }

    foreach(machine in level.var_c427e93b) {
      if(!isDefined(machine)) {
        continue;
      }

      var_30300360 = 0;
      player = function_5c10bd79(localclientnum);

      if(isDefined(player) && function_7757350c(player, machine)) {
        var_30300360 = 1;
      }

      if(isDefined(machine)) {
        if(var_30300360 && !is_true(machine.var_c02c4d66)) {
          util::lock_model(machine.model);
          machine.var_c02c4d66 = 1;

          if(isarray(machine.var_35f71e38)) {
            foreach(var_61794186 in machine.var_35f71e38) {
              util::lock_model(var_61794186);
            }
          }
        } else if(!var_30300360 && is_true(machine.var_c02c4d66)) {
          util::unlock_model(machine.model);
          machine.var_c02c4d66 = undefined;

          if(isarray(machine.var_35f71e38)) {
            foreach(var_61794186 in machine.var_35f71e38) {
              util::unlock_model(var_61794186);
            }
          }
        }
      }

      waitframe(1);
    }

    waitframe(10);
  }
}

function function_7757350c(player, machine) {
  var_2cdb84bb = machine function_2cfe56d8();
  v_eye = player getEye();
  n_height_diff = abs(v_eye[2] - var_2cdb84bb[2]);

  if(n_height_diff < 140 && distance2dsquared(v_eye, var_2cdb84bb) < 360000) {
    return true;
  }

  if(util::within_fov(v_eye, player.angles, var_2cdb84bb, 0.75) && bullettracepassed(v_eye, var_2cdb84bb, 0, machine, player)) {
    return true;
  }

  return false;
}

function private function_2cfe56d8() {
  var_2cdb84bb = self.origin + (0, 0, 24) + anglesToForward(self.angles) * 24;
  return var_2cdb84bb;
}

function function_3a919d3f(params) {
  if(int(params.value)) {
    level thread function_538799c4();
    return;
  }

  level notify(#"hash_a8ed1dd0750e229");
}

function private function_538799c4() {
  level notify(#"hash_a8ed1dd0750e229");
  level endon(#"hash_a8ed1dd0750e229");

  while(true) {
    if(getdvarint(#"hash_416069220b5b56e3", 0)) {
      i = 0;
      debug2dtext((325, 200, 0) + (0, 20, 0) * (i + 1), "<dev string:x38>", (0, 1, 0));

      foreach(e_machine in level.var_c427e93b) {
        if(isDefined(e_machine)) {
          var_2cdb84bb = e_machine function_2cfe56d8();
          i++;

          if(is_true(e_machine.var_c02c4d66)) {
            debug2dtext((325, 200, 0) + (0, 20, 0) * (i + 1), function_9e72a96(e_machine.model), (0, 1, 0));
            circle(var_2cdb84bb, 64, (0, 1, 0));
            continue;
          }

          debug2dtext((325, 200, 0) + (0, 20, 0) * (i + 1), function_9e72a96(e_machine.model), (1, 0, 0));
          circle(var_2cdb84bb, 64, (1, 0, 0));
        }
      }
    }

    waitframe(1);
  }
}

function function_88c3a609() {
  if(isarray(self.var_8dbbd2d8)) {
    arrayremovevalue(self.var_8dbbd2d8, undefined);

    foreach(var_ee6bcd51 in self.var_8dbbd2d8) {
      if(self function_d2503806(var_ee6bcd51)) {
        self function_f6e99a8d(var_ee6bcd51);
      }
    }
  }

  if(isPlayer(self)) {
    self.var_699347d1 = 1;
  }
}

function function_6c91d22b() {
  if(isarray(self.var_8dbbd2d8)) {
    arrayremovevalue(self.var_8dbbd2d8, undefined);

    foreach(var_ee6bcd51 in self.var_8dbbd2d8) {
      if(!self function_d2503806(var_ee6bcd51)) {
        self playrenderoverridebundle(var_ee6bcd51);
      }
    }
  }

  if(isPlayer(self)) {
    self.var_699347d1 = undefined;
  }
}

function function_8065ace2(var_ee6bcd51) {
  if(isPlayer(self)) {
    if(!isDefined(self.var_8dbbd2d8)) {
      self.var_8dbbd2d8 = [];
    } else if(!isarray(self.var_8dbbd2d8)) {
      self.var_8dbbd2d8 = array(self.var_8dbbd2d8);
    }

    if(!isinarray(self.var_8dbbd2d8, var_ee6bcd51)) {
      self.var_8dbbd2d8[self.var_8dbbd2d8.size] = var_ee6bcd51;
    }
  }
}

function function_f933b697(var_ee6bcd51) {
  if(isPlayer(self) && isarray(self.var_8dbbd2d8)) {
    arrayremovevalue(self.var_8dbbd2d8, var_ee6bcd51);
  }
}

function function_10df0b9c(var_ee6bcd51) {
  if(is_true(self.var_699347d1)) {
    return false;
  }

  return true;
}