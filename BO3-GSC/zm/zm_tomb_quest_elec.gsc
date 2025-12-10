/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_tomb_quest_elec.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\zm_tomb_chamber;
#using scripts\zm\zm_tomb_utility;
#using scripts\zm\zm_tomb_vo;
#namespace zm_tomb_quest_elec;

function main() {
  callback::on_connect(&onplayerconnect);
  level flag::init("electric_puzzle_1_complete");
  level flag::init("electric_puzzle_2_complete");
  level flag::init("electric_upgrade_available");
  zm_tomb_vo::add_puzzle_completion_line(3, "vox_sam_lightning_puz_solve_0");
  zm_tomb_vo::add_puzzle_completion_line(3, "vox_sam_lightning_puz_solve_1");
  zm_tomb_vo::add_puzzle_completion_line(3, "vox_sam_lightning_puz_solve_2");
  level thread zm_tomb_vo::watch_one_shot_line("puzzle", "try_puzzle", "vo_try_puzzle_lightning1");
  level thread zm_tomb_vo::watch_one_shot_line("puzzle", "try_puzzle", "vo_try_puzzle_lightning2");
  electric_puzzle_1_init();
  electric_puzzle_2_init();
  level thread electric_puzzle_1_run();
  level flag::wait_till("electric_puzzle_1_complete");
  playsoundatposition("zmb_squest_step1_finished", (0, 0, 0));
  level thread zm_tomb_utility::rumble_players_in_chamber(5, 3);
  level thread electric_puzzle_2_run();
  level flag::wait_till("electric_puzzle_2_complete");
  level thread electric_puzzle_2_cleanup();
}

function onplayerconnect() {
  self thread electric_puzzle_watch_staff();
}

function electric_puzzle_watch_staff() {
  self endon("disconnect");
  a_piano_keys = struct::get_array("piano_key", "script_noteworthy");
  var_dc8ace48 = level.a_elemental_staffs["staff_lightning"].w_weapon;
  while(true) {
    self waittill("projectile_impact", w_weapon, v_explode_point, n_radius, e_projectile, n_impact);
    if(w_weapon == var_dc8ace48) {
      if(!level flag::get("electric_puzzle_1_complete") && zm_tomb_chamber::is_chamber_occupied()) {
        n_index = zm_utility::get_closest_index(v_explode_point, a_piano_keys, 20);
        if(isDefined(n_index)) {
          a_piano_keys[n_index] notify("piano_key_shot");
          a_players = getplayers();
          foreach(e_player in a_players) {
            if(e_player hasweapon(var_dc8ace48)) {
              level notify("vo_try_puzzle_lightning1", e_player);
            }
          }
        }
      }
    }
  }
}

function electric_puzzle_1_init() {
  level flag::init("piano_chord_ringing");
}

function electric_puzzle_1_run() {
  a_piano_keys = struct::get_array("piano_key", "script_noteworthy");
  level.a_piano_keys_playing = [];
  array::thread_all(a_piano_keys, &piano_key_run);
  level thread piano_run_chords();
}

function piano_keys_stop() {
  level notify("piano_keys_stop");
  level.a_piano_keys_playing = [];
}

function show_chord_debug(a_chord_notes) {
  if(!isDefined(a_chord_notes)) {
    a_chord_notes = [];
  }
  a_piano_keys = struct::get_array("", "");
  foreach(e_key in a_piano_keys) {
    e_key notify("stop_debug_position");
    foreach(note in a_chord_notes) {
      if(note == e_key.script_string) {
        e_key thread zm_tomb_utility::puzzle_debug_position();
        break;
      }
    }
  }
}

function piano_run_chords() {
  a_chords = struct::get_array("piano_chord", "targetname");
  foreach(s_chord in a_chords) {
    s_chord.notes = strtok(s_chord.script_string, " ");
    assert(s_chord.notes.size == 3);
  }
  var_dc8ace48 = level.a_elemental_staffs["staff_lightning"].w_weapon;
  a_chord_order = array("a_minor", "e_minor", "d_minor");
  foreach(chord_name in a_chord_order) {
    s_chord = struct::get("piano_chord_" + chord_name, "script_noteworthy");
    show_chord_debug(s_chord.notes);
    chord_solved = 0;
    while(!chord_solved) {
      level waittill("piano_key_played");
      if(level.a_piano_keys_playing.size == 3) {
        correct_notes_playing = 0;
        foreach(played_note in level.a_piano_keys_playing) {
          foreach(requested_note in s_chord.notes) {
            if(requested_note == played_note) {
              correct_notes_playing++;
            }
          }
        }
        if(correct_notes_playing == 3) {
          chord_solved = 1;
        } else {
          a_players = getplayers();
          foreach(e_player in a_players) {
            if(e_player hasweapon(var_dc8ace48)) {
              level notify("vo_puzzle_bad", e_player);
            }
          }
        }
      }
    }
    a_players = getplayers();
    foreach(e_player in a_players) {
      if(e_player hasweapon(var_dc8ace48)) {
        level notify("vo_puzzle_good", e_player);
      }
    }
    level flag::set("piano_chord_ringing");
    zm_tomb_utility::rumble_nearby_players(a_chords[0].origin, 1500, 2);
    wait(4);
    level flag::clear("piano_chord_ringing");
    piano_keys_stop();
    show_chord_debug();
  }
  e_player = zm_utility::get_closest_player(a_chords[0].origin);
  e_player thread zm_tomb_vo::say_puzzle_completion_line(3);
  level flag::set("electric_puzzle_1_complete");
}

function piano_key_run() {
  piano_key_note = self.script_string;
  while(true) {
    self waittill("piano_key_shot");
    if(!level flag::get("piano_chord_ringing")) {
      if(level.a_piano_keys_playing.size >= 3) {
        piano_keys_stop();
      }
      self.e_fx = spawn("script_model", self.origin);
      self.e_fx playLoopSound("zmb_kbd_" + piano_key_note);
      self.e_fx.angles = self.angles;
      self.e_fx setModel("tag_origin");
      playFXOnTag(level._effect["elec_piano_glow"], self.e_fx, "tag_origin");
      level.a_piano_keys_playing[level.a_piano_keys_playing.size] = piano_key_note;
      level notify("piano_key_played", self, piano_key_note);
      level waittill("piano_keys_stop");
      self.e_fx delete();
    }
  }
}

function electric_puzzle_2_init() {
  level.electric_relays = [];
  level.electric_relays["bunker"] = spawnStruct();
  level.electric_relays["tank_platform"] = spawnStruct();
  level.electric_relays["start"] = spawnStruct();
  level.electric_relays["elec"] = spawnStruct();
  level.electric_relays["ruins"] = spawnStruct();
  level.electric_relays["air"] = spawnStruct();
  level.electric_relays["ice"] = spawnStruct();
  level.electric_relays["village"] = spawnStruct();
  foreach(s_relay in level.electric_relays) {
    s_relay.connections = [];
  }
  level.electric_relays["tank_platform"].connections[0] = "ruins";
  level.electric_relays["start"].connections[1] = "tank_platform";
  level.electric_relays["elec"].connections[0] = "ice";
  level.electric_relays["ruins"].connections[2] = "chamber";
  level.electric_relays["air"].connections[2] = "start";
  level.electric_relays["ice"].connections[3] = "village";
  level.electric_relays["village"].connections[2] = "air";
  level.electric_relays["bunker"].position = 2;
  level.electric_relays["tank_platform"].position = 1;
  level.electric_relays["start"].position = 3;
  level.electric_relays["elec"].position = 1;
  level.electric_relays["ruins"].position = 3;
  level.electric_relays["air"].position = 0;
  level.electric_relays["ice"].position = 1;
  level.electric_relays["village"].position = 1;
  a_switches = getEntArray("puzzle_relay_switch", "script_noteworthy");
  foreach(e_switch in a_switches) {
    level.electric_relays[e_switch.script_string].e_switch = e_switch;
  }
  array::thread_all(level.electric_relays, &relay_switch_run);
}

function electric_puzzle_2_run() {
  update_relays();
}

function electric_puzzle_2_cleanup() {
  foreach(s_relay in level.electric_relays) {
    if(isDefined(s_relay.trigger_stub)) {
      zm_unitrigger::register_unitrigger(s_relay.trigger_stub);
    }
    if(isDefined(s_relay.e_switch)) {
      s_relay.e_switch stoploopsound(0.5);
    }
    if(isDefined(s_relay.e_fx)) {
      s_relay.e_fx delete();
    }
  }
}

function kill_all_relay_power() {
  foreach(s_relay in level.electric_relays) {
    s_relay.receiving_power = 0;
    s_relay.sending_power = 0;
  }
}

function relay_give_power(s_relay) {
  if(!level flag::get("electric_puzzle_1_complete")) {
    return;
  }
  if(!isDefined(s_relay)) {
    kill_all_relay_power();
    s_relay = level.electric_relays["elec"];
  }
  s_relay.receiving_power = 1;
  str_target_relay = s_relay.connections[s_relay.position];
  if(isDefined(str_target_relay)) {
    if(str_target_relay == "chamber") {
      s_relay.e_switch thread zm_tomb_vo::say_puzzle_completion_line(3);
      level thread zm_tomb_utility::play_puzzle_stinger_on_all_players();
      level flag::set("electric_puzzle_2_complete");
    } else {
      s_relay.sending_power = 1;
      s_target_relay = level.electric_relays[str_target_relay];
      relay_give_power(s_target_relay);
    }
  }
}

function update_relay_fx_and_sound() {
  if(!level flag::get("electric_puzzle_1_complete")) {
    return;
  }
  foreach(s_relay in level.electric_relays) {
    if(s_relay.sending_power) {
      if(isDefined(s_relay.e_fx)) {
        s_relay.e_fx delete();
      }
      s_relay.e_switch playLoopSound("zmb_squest_elec_switch_hum", 1);
      continue;
    }
    if(s_relay.receiving_power) {
      if(!isDefined(s_relay.e_fx)) {
        v_offset = anglestoright(s_relay.e_switch.angles) * 1;
        s_relay.e_fx = spawn("script_model", s_relay.e_switch.origin + v_offset);
        s_relay.e_fx.angles = s_relay.e_switch.angles + (vectorscale((0, 0, -1), 90));
        s_relay.e_fx setModel("tag_origin");
        playFXOnTag(level._effect["fx_tomb_sparks_sm"], s_relay.e_fx, "tag_origin");
      }
      s_relay.e_switch playLoopSound("zmb_squest_elec_switch_spark", 1);
      continue;
    }
    if(isDefined(s_relay.e_fx)) {
      s_relay.e_fx delete();
    }
    s_relay.e_switch stoploopsound(1);
  }
}

function update_relay_rotation() {
  self.e_switch rotateto((self.position * 90, self.e_switch.angles[1], self.e_switch.angles[2]), 0.1, 0, 0);
  self.e_switch playSound("zmb_squest_elec_switch");
  self.e_switch waittill("rotatedone");
}

function update_relays() {
  relay_give_power();
  update_relay_fx_and_sound();
}

function relay_switch_run() {
  assert(isDefined(self.e_switch));
  self.trigger_stub = spawnStruct();
  self.trigger_stub.origin = self.e_switch.origin;
  self.trigger_stub.radius = 50;
  self.trigger_stub.cursor_hint = "HINT_NOICON";
  self.trigger_stub.hint_string = "";
  self.trigger_stub.script_unitrigger_type = "unitrigger_radius_use";
  self.trigger_stub.require_look_at = 1;
  zm_unitrigger::register_unitrigger(self.trigger_stub, &relay_unitrigger_think);
  level endon("electric_puzzle_2_complete");
  self thread update_relay_rotation();
  n_tries = 0;
  while(true) {
    self.trigger_stub waittill("trigger", e_user);
    n_tries++;
    level notify("vo_try_puzzle_lightning2", e_user);
    self.position = (self.position + 1) % 4;
    str_target_relay = self.connections[self.position];
    if(isDefined(str_target_relay)) {
      if(str_target_relay == "village" || str_target_relay == "ruins") {
        level notify("vo_puzzle_good", e_user);
      }
    } else {
      if((n_tries % 8) == 0) {
        level notify("vo_puzzle_confused", e_user);
      } else if((n_tries % 4) == 0) {
        level notify("vo_puzzle_bad", e_user);
      }
    }
    self update_relay_rotation();
    update_relays();
  }
}

function relay_unitrigger_think() {
  self endon("kill_trigger");
  while(true) {
    self waittill("trigger", player);
    self.stub notify("trigger", player);
  }
}