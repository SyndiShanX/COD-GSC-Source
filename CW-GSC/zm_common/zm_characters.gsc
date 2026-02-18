/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\zm_characters.gsc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\player\player_role;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_maptable;
#using scripts\zm_common\zm_utility;
#namespace zm_characters;

function private autoexec __init__system__() {
  system::register(#"zm_characters", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!isDefined(level.var_e52a681)) {
    level.var_e52a681 = 0;
  }

  level.var_e824f826 = 1;
  level.precachecustomcharacters = &precachecustomcharacters;
  initcharacterstartindex();

  zm_devgui::add_custom_devgui_callback(&function_9436b105);
}

function private zombie_force_char(n_char) {
  assert(isDefined(self));
  assert(isPlayer(self));
  assert(isalive(self));
  set_character(n_char);
}

function private function_9436b105(cmd) {
  if(issubstr(cmd, "<dev string:x38>")) {
    tokens = strtok(cmd, "<dev string:x48>");
    player = int(getsubstr(tokens[0], "<dev string:x4d>".size));
    character = int(tokens[tokens.size - 1]);
    players = getplayers();
    players[player - 1] thread zombie_force_char(character);
  }
}

function precachecustomcharacters() {}

function initcharacterstartindex() {
  level.characterstartindex = randomint(4);
}

function selectcharacterindextouse() {
  if(level.characterstartindex >= 4) {
    level.characterstartindex = 0;
  }

  self.characterindex = level.characterstartindex;
  level.characterstartindex++;
  return self.characterindex;
}

function function_b04c6f1f() {
  playerroletemplatecount = getplayerroletemplatecount(currentsessionmode());
  var_36918d27 = [];
  var_e7d30c12 = undefined;

  for(i = 0; i < playerroletemplatecount; i++) {
    if(isbot(self)) {
      if(function_f4bf7e3f(i, currentsessionmode())) {
        if(!isDefined(var_36918d27)) {
          var_36918d27 = [];
        } else if(!isarray(var_36918d27)) {
          var_36918d27 = array(var_36918d27);
        }

        var_36918d27[var_36918d27.size] = i;
      }

      continue;
    }

    rf = getplayerrolefields(i, currentsessionmode());

    if(isDefined(rf) && is_true(rf.isdefaultcharacter)) {
      if(!isDefined(var_36918d27)) {
        var_36918d27 = [];
      } else if(!isarray(var_36918d27)) {
        var_36918d27 = array(var_36918d27);
      }

      var_36918d27[var_36918d27.size] = i;
    }

    if(isDefined(rf)) {
      if(!isDefined(var_e7d30c12)) {
        var_e7d30c12 = i;
      }
    }
  }

  var_72964a59 = isDefined(array::random(var_36918d27)) ? array::random(var_36918d27) : 0;

  if(var_72964a59 == 0) {
    return var_e7d30c12;
  }

  return var_72964a59;
}

function set_character(character) {
  self detachall();

  if(isDefined(character)) {
    if(isarray(character)) {
      self.characterindex = get_character_index(character);
    } else {
      self.characterindex = character;
    }
  }

  if(!isDefined(self.characterindex) || !player_role::is_valid(self.characterindex)) {
    self.characterindex = self player_role::function_2a911680();

    if(self ishost() && getdvarstring(#"force_char") != "<dev string:x57>") {
      self.characterindex = getdvarint(#"force_char", 0);
    }

    if(self.characterindex == 0) {
      self.characterindex = function_b04c6f1f();
    }

    self.pers[# "characterindex"] = self.characterindex;
  }

  player_role::set(self.characterindex);
  self.favorite_wall_weapons_list = [];
  self.talks_in_danger = 0;

  if(!isDefined(level.var_6f14e9e1)) {
    level.var_6f14e9e1 = [];
  } else if(!isarray(level.var_6f14e9e1)) {
    level.var_6f14e9e1 = array(level.var_6f14e9e1);
  }

  if(!isinarray(level.var_6f14e9e1, self)) {
    level.var_6f14e9e1[level.var_6f14e9e1.size] = self;
  }

  characterindex = function_dc232a80();

  if(isDefined(characterindex)) {
    zm_audio::setexertvoice(characterindex);
  }
}

function setup_personality_character_exerts() {
  level.exert_sounds[1][# "burp"][0] = "vox_plr_0_exert_burp_0";
  level.exert_sounds[1][# "burp"][1] = "vox_plr_0_exert_burp_1";
  level.exert_sounds[1][# "burp"][2] = "vox_plr_0_exert_burp_2";
  level.exert_sounds[1][# "burp"][3] = "vox_plr_0_exert_burp_3";
  level.exert_sounds[1][# "burp"][4] = "vox_plr_0_exert_burp_4";
  level.exert_sounds[1][# "burp"][5] = "vox_plr_0_exert_burp_5";
  level.exert_sounds[1][# "burp"][6] = "vox_plr_0_exert_burp_6";
  level.exert_sounds[2][# "burp"][0] = "vox_plr_1_exert_burp_0";
  level.exert_sounds[2][# "burp"][1] = "vox_plr_1_exert_burp_1";
  level.exert_sounds[2][# "burp"][2] = "vox_plr_1_exert_burp_2";
  level.exert_sounds[2][# "burp"][3] = "vox_plr_1_exert_burp_3";
  level.exert_sounds[3][# "burp"][0] = "vox_plr_2_exert_burp_0";
  level.exert_sounds[3][# "burp"][1] = "vox_plr_2_exert_burp_1";
  level.exert_sounds[3][# "burp"][2] = "vox_plr_2_exert_burp_2";
  level.exert_sounds[3][# "burp"][3] = "vox_plr_2_exert_burp_3";
  level.exert_sounds[3][# "burp"][4] = "vox_plr_2_exert_burp_4";
  level.exert_sounds[3][# "burp"][5] = "vox_plr_2_exert_burp_5";
  level.exert_sounds[3][# "burp"][6] = "vox_plr_2_exert_burp_6";
  level.exert_sounds[4][# "burp"][0] = "vox_plr_3_exert_burp_0";
  level.exert_sounds[4][# "burp"][1] = "vox_plr_3_exert_burp_1";
  level.exert_sounds[4][# "burp"][2] = "vox_plr_3_exert_burp_2";
  level.exert_sounds[4][# "burp"][3] = "vox_plr_3_exert_burp_3";
  level.exert_sounds[4][# "burp"][4] = "vox_plr_3_exert_burp_4";
  level.exert_sounds[4][# "burp"][5] = "vox_plr_3_exert_burp_5";
  level.exert_sounds[4][# "burp"][6] = "vox_plr_3_exert_burp_6";
  level.exert_sounds[1][# "hitmed"][0] = "vox_plr_0_exert_pain_medium_0";
  level.exert_sounds[1][# "hitmed"][1] = "vox_plr_0_exert_pain_medium_1";
  level.exert_sounds[1][# "hitmed"][2] = "vox_plr_0_exert_pain_medium_2";
  level.exert_sounds[1][# "hitmed"][3] = "vox_plr_0_exert_pain_medium_3";
  level.exert_sounds[2][# "hitmed"][0] = "vox_plr_1_exert_pain_medium_0";
  level.exert_sounds[2][# "hitmed"][1] = "vox_plr_1_exert_pain_medium_1";
  level.exert_sounds[2][# "hitmed"][2] = "vox_plr_1_exert_pain_medium_2";
  level.exert_sounds[2][# "hitmed"][3] = "vox_plr_1_exert_pain_medium_3";
  level.exert_sounds[3][# "hitmed"][0] = "vox_plr_2_exert_pain_medium_0";
  level.exert_sounds[3][# "hitmed"][1] = "vox_plr_2_exert_pain_medium_1";
  level.exert_sounds[3][# "hitmed"][2] = "vox_plr_2_exert_pain_medium_2";
  level.exert_sounds[3][# "hitmed"][3] = "vox_plr_2_exert_pain_medium_3";
  level.exert_sounds[4][# "hitmed"][0] = "vox_plr_3_exert_pain_medium_0";
  level.exert_sounds[4][# "hitmed"][1] = "vox_plr_3_exert_pain_medium_1";
  level.exert_sounds[4][# "hitmed"][2] = "vox_plr_3_exert_pain_medium_2";
  level.exert_sounds[4][# "hitmed"][3] = "vox_plr_3_exert_pain_medium_3";
  level.exert_sounds[1][# "hitlrg"][0] = "vox_plr_0_exert_pain_high_0";
  level.exert_sounds[1][# "hitlrg"][1] = "vox_plr_0_exert_pain_high_1";
  level.exert_sounds[1][# "hitlrg"][2] = "vox_plr_0_exert_pain_high_2";
  level.exert_sounds[1][# "hitlrg"][3] = "vox_plr_0_exert_pain_high_3";
  level.exert_sounds[2][# "hitlrg"][0] = "vox_plr_1_exert_pain_high_0";
  level.exert_sounds[2][# "hitlrg"][1] = "vox_plr_1_exert_pain_high_1";
  level.exert_sounds[2][# "hitlrg"][2] = "vox_plr_1_exert_pain_high_2";
  level.exert_sounds[2][# "hitlrg"][3] = "vox_plr_1_exert_pain_high_3";
  level.exert_sounds[3][# "hitlrg"][0] = "vox_plr_2_exert_pain_high_0";
  level.exert_sounds[3][# "hitlrg"][1] = "vox_plr_2_exert_pain_high_1";
  level.exert_sounds[3][# "hitlrg"][2] = "vox_plr_2_exert_pain_high_2";
  level.exert_sounds[3][# "hitlrg"][3] = "vox_plr_2_exert_pain_high_3";
  level.exert_sounds[4][# "hitlrg"][0] = "vox_plr_3_exert_pain_high_0";
  level.exert_sounds[4][# "hitlrg"][1] = "vox_plr_3_exert_pain_high_1";
  level.exert_sounds[4][# "hitlrg"][2] = "vox_plr_3_exert_pain_high_2";
  level.exert_sounds[4][# "hitlrg"][3] = "vox_plr_3_exert_pain_high_3";
}

function get_character_index(character) {
  var_ba015ed = getplayerroletemplatecount(currentsessionmode());

  for(i = 0; i < var_ba015ed; i++) {
    name = function_ac0419ac(i, currentsessionmode());

    if(isinarray(character, name)) {
      return i;
    }
  }

  assertmsg("<dev string:x5b>");
  return 0;
}

function function_d35e4c92(characterindex, var_fdf0f13d = 0) {
  if(isDefined(characterindex)) {
    if(var_fdf0f13d || player_role::is_valid(characterindex)) {
      fields = getplayerrolefields(characterindex, currentsessionmode());

      if(isDefined(fields)) {
        return fields.var_2a42c5e0;
      }
    }
  } else if(isDefined(self) && isPlayer(self)) {
    characterindex = player_role::get();

    if(player_role::is_valid(characterindex)) {
      fields = getplayerrolefields(player_role::get(), currentsessionmode());

      if(isDefined(fields)) {
        return fields.var_2a42c5e0;
      }
    }
  }

  return 0;
}

function function_dc232a80(character) {
  if(isDefined(self) && isPlayer(self)) {
    characterindex = player_role::get();
  } else if(isarray(character)) {
    characterindex = get_character_index(character);
  }

  if(isDefined(characterindex)) {
    if(player_role::is_valid(characterindex)) {
      fields = getplayerrolefields(player_role::get(), currentsessionmode());

      if(isDefined(fields.var_3e570307)) {
        return fields.var_3e570307;
      } else {
        return 0;
      }
    }

    assertmsg("<dev string:x7f>" + characterindex);
  }

  return 0;
}

function is_character(character) {
  assert(isPlayer(self));

  if(isDefined(self) && isPlayer(self)) {
    characterindex = player_role::get();

    if(player_role::is_valid(characterindex)) {
      name = function_b14806c6(player_role::get(), currentsessionmode());
      return isinarray(character, name);
    }
  }

  return 0;
}