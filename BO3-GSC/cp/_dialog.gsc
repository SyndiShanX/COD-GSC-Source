/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_dialog.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\systems\face;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace dialog;

function autoexec __init__sytem__() {
  system::register("dialog", &__init__, undefined, undefined);
}

function __init__() {
  level.vo = spawnStruct();
  level.vo.nag_groups = [];
  callback::on_spawned(&dialog_onplayerspawned);
}

function dialog_onplayerspawned() {
  self luinotifyevent(&"offsite_comms_complete");
}

function add(str_dialog_name, str_vox_file) {
  assert(isDefined(str_dialog_name), "");
  assert(isDefined(str_vox_file), "");
  if(!isDefined(level.scr_sound)) {
    level.scr_sound = [];
  }
  if(!isDefined(level.scr_sound["generic"])) {
    level.scr_sound["generic"] = [];
  }
  level.scr_sound["generic"][str_dialog_name] = str_vox_file;
  animation::add_global_notetrack_handler("vox#" + str_dialog_name, &notetrack_say, 0, str_dialog_name);
}

function notetrack_say(str_vo_line) {
  if(isplayer(self)) {
    if(self flagsys::get("shared_igc")) {
      player_say(str_vo_line);
    } else {
      say(str_vo_line);
    }
  } else {
    if(is_player_dialog(str_vo_line)) {
      level player_say(str_vo_line);
    } else {
      say(str_vo_line);
    }
  }
}

function is_player_dialog(str_script_id) {
  str_alias = undefined;
  if(isDefined(level.scr_sound) && isDefined(level.scr_sound["generic"])) {
    str_alias = level.scr_sound["generic"][str_script_id];
  }
  if(!isDefined(str_alias)) {
    return 0;
  }
  return strendswith(str_alias, "plyr");
}

function say(str_vo_line, n_delay, b_fake_ent = 0, e_to_player, var_43937b21) {
  ent = self;
  if(self == level) {
    if(isDefined(var_43937b21) && var_43937b21) {
      ent = spawn("script_model", (0, 0, 0));
      level.e_speaker = ent;
    } else {
      ent = spawn("script_origin", (0, 0, 0));
    }
    waittillframeend();
    level notify("hash_120cde7f", ent);
    b_fake_ent = 1;
  }
  ent endon("death");
  ent thread _say(str_vo_line, n_delay, b_fake_ent, e_to_player);
  ent waittillmatch("hash_90f83311");
  if(self == level) {
    ent delete();
    if(isDefined(level.e_speaker)) {
      level.e_speaker delete();
    }
  }
}

function private _say(str_vo_line, n_delay, b_fake_ent = 0, e_to_player) {
  self endon("death");
  self.is_about_to_talk = 1;
  self thread _on_kill_pending_dialog(str_vo_line);
  level endon("kill_pending_dialog");
  self endon("kill_pending_dialog");
  if(isDefined(n_delay) && n_delay > 0) {
    wait(n_delay);
  }
  if(self.classname === "script_origin") {
    b_fake_ent = 1;
  }
  if(!b_fake_ent) {
    if(!isDefined(self.health) || self.health <= 0) {
      if(!isplayer(self) || (!(isDefined(self.laststand) && self.laststand))) {
        assertmsg("");
        self.is_about_to_talk = undefined;
        self notify("hash_90f83311", str_vo_line);
        return;
      }
    }
  }
  self.is_talking = 1;
  if(isDefined(self.archetype) && (self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || self.archetype == "civilian")) {
    self clientfield::set("facial_dial", 1);
  }
  self face::sayspecificdialogue(0, str_vo_line, 1, undefined, undefined, undefined, e_to_player);
  self waittillmatch("hash_90f83311");
  if(isDefined(self.archetype) && (self.archetype == "human" || self.archetype == "human_riotshield" || self.archetype == "human_rpg" || self.archetype == "civilian")) {
    self clientfield::set("facial_dial", 0);
  }
  self.is_talking = undefined;
  self.is_about_to_talk = undefined;
}

function _on_kill_pending_dialog(str_vo_line) {
  self endon("death");
  self notify("_on_kill_pending_dialog_end");
  self endon("_on_kill_pending_dialog_end");
  util::waittill_any_ents_two(level, "kill_pending_dialog", self, "kill_pending_dialog");
  self.is_about_to_talk = undefined;
}

function player_say(str_vo_line, n_delay) {
  if(self == level) {
    foreach(player in level.activeplayers) {
      player thread player_say(str_vo_line, n_delay);
    }
    array::wait_till_match(level.activeplayers, "done speaking", str_vo_line);
  } else {
    say(str_vo_line, n_delay, 0, self);
  }
}

function remote(str_vo_line, n_delay, str_type = "dni", e_to_player, var_43937b21) {
  if(str_type === "dni") {
    a_script_id = strtok(level.scr_sound["generic"][str_vo_line], "_");
    str_who = undefined;
    switch (a_script_id[a_script_id.size - 1]) {
      case "diaz": {
        str_who = &"CPUI_DIAZ_SEBASTIAN";
        break;
      }
      case "ecmd": {
        str_who = &"CPUI_EGYPTIAN_COMMAND";
        break;
      }
      case "xiul": {
        str_who = &"CPUI_GOH_XIULAN";
        break;
      }
      case "hend": {
        str_who = &"CPUI_HENDRICKS_JACOB";
        break;
      }
      case "khal": {
        str_who = &"CPUI_KHALIL_ZEYAD";
        break;
      }
      case "mare": {
        str_who = &"CPUI_MARETTI_PETER";
        break;
      }
      case "kane": {
        str_who = &"CPUI_KANE_RACHEL";
        break;
      }
      case "hall": {
        str_who = &"CPUI_HALL_SARAH";
        break;
      }
      case "tayr": {
        str_who = &"CPUI_TAYLOR_JOHN";
        break;
      }
      case "vtpl":
      case "wapl": {
        str_who = &"CPUI_VTOL_PILOT";
        break;
      }
      default: {
        str_who = undefined;
        break;
      }
    }
    if(isDefined(str_who) && !sessionmodeiscampaignzombiesgame()) {
      foreach(player in level.players) {
        if(!isDefined(e_to_player) || e_to_player == player) {
          player luinotifyevent(&"offsite_comms_message", 1, str_who);
        }
      }
    }
  }
  level say(str_vo_line, n_delay, 1, e_to_player, var_43937b21);
  if(!sessionmodeiscampaignzombiesgame()) {
    if(str_type === "dni") {
      foreach(player in level.players) {
        if(!isDefined(e_to_player) || e_to_player == player) {
          player luinotifyevent(&"offsite_comms_complete");
        }
      }
    }
  }
}