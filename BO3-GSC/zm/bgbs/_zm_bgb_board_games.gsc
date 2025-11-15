/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\bgbs\_zm_bgb_board_games.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_blockers;
#using scripts\zm\_zm_powerups;
#using scripts\zm\_zm_utility;
#namespace zm_bgb_board_games;

function autoexec __init__sytem__() {
  system::register("zm_bgb_board_games", & __init__, undefined, "bgb");
}

function __init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }
  bgb::register("zm_bgb_board_games", "rounds", 5, & enable, & disable, undefined);
}

function enable() {
  self thread function_7b627622();
}

function disable() {}

function function_7b627622() {
  self endon("disconnect");
  self endon("bled_out");
  self endon("bgb_update");
  while(true) {
    self waittill("boarding_window", s_window);
    self bgb::do_one_shot_use();
    self thread function_d5ed5165(s_window);
  }
}

function function_d5ed5165(s_window) {
  carp_ent = spawn("script_origin", (0, 0, 0));
  carp_ent playLoopSound("evt_carpenter");
  num_chunks_checked = 0;
  while(true) {
    if(zm_utility::all_chunks_intact(s_window, s_window.barrier_chunks)) {
      break;
    }
    chunk = zm_utility::get_random_destroyed_chunk(s_window, s_window.barrier_chunks);
    if(!isDefined(chunk)) {
      break;
    }
    s_window thread zm_blockers::replace_chunk(s_window, chunk, undefined, 0, 1);
    last_repaired_chunk = chunk;
    if(isDefined(s_window.clip)) {
      s_window.clip triggerenable(1);
      s_window.clip disconnectpaths();
    } else {
      zm_blockers::blocker_disconnect_paths(s_window.neg_start, s_window.neg_end);
    }
    util::wait_network_frame();
    num_chunks_checked++;
    if(num_chunks_checked >= 20) {
      break;
    }
  }
  if(isDefined(s_window.zbarrier)) {
    if(isDefined(last_repaired_chunk)) {
      while(s_window.zbarrier getzbarrierpiecestate(last_repaired_chunk) == "closing") {
        wait(0.05);
      }
      if(isDefined(s_window._post_carpenter_callback)) {
        s_window[[s_window._post_carpenter_callback]]();
      }
    }
  } else {
    while(isDefined(last_repaired_chunk) && last_repaired_chunk.state == "mid_repair") {
      wait(0.05);
    }
  }
  carp_ent stoploopsound(1);
  carp_ent playsoundwithnotify("evt_carpenter_end", "sound_done");
  carp_ent waittill("sound_done");
  carp_ent delete();
}