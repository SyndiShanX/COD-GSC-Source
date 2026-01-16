/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bgbs\zm_bgb_board_games.gsc
*************************************************/

#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_blockers;
#include scripts\zm_common\zm_score;
#include scripts\zm_common\zm_utility;

#namespace zm_bgb_board_games;

autoexec __init__system__() {
  system::register(#"zm_bgb_board_games", &__init__, undefined, #"bgb");
}

__init__() {
  if(!(isDefined(level.bgb_in_use) && level.bgb_in_use)) {
    return;
  }

  bgb::register(#"zm_bgb_board_games", "time", 300, &enable, &disable, undefined);
}

enable() {
  self thread function_202a3d22();
}

disable() {}

function_202a3d22() {
  self endon(#"disconnect", #"bled_out", #"bgb_update");

  while(true) {
    waitresult = self waittill(#"boarding_window");
    s_window = waitresult;
    self bgb::do_one_shot_use();
    self thread function_c2342058(s_window);
  }
}

function_c2342058(s_window) {
  carp_ent = spawn("script_origin", (0, 0, 0));
  carp_ent playLoopSound(#"evt_carpenter");
  num_chunks_checked = 0;

  while(true) {
    if(zm_utility::all_chunks_intact(s_window, s_window.barrier_chunks)) {
      break;
    }

    chunk = zm_utility::get_random_destroyed_chunk(s_window, s_window.barrier_chunks);

    if(!isDefined(chunk)) {
      break;
    }

    s_window thread zm_blockers::replace_chunk(s_window, chunk, undefined, 1);
    self.rebuild_barrier_reward += 10;

    if(self.rebuild_barrier_reward < zombie_utility::get_zombie_var(#"rebuild_barrier_cap_per_round")) {
      self zm_score::player_add_points("rebuild_board", 10);
      self zm_utility::play_sound_on_ent("purchase");
    }

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
        waitframe(1);
      }

      if(isDefined(s_window._post_carpenter_callback)) {
        s_window[[s_window._post_carpenter_callback]]();
      }
    }
  } else {
    while(isDefined(last_repaired_chunk) && last_repaired_chunk.state == "mid_repair") {
      waitframe(1);
    }
  }

  carp_ent stoploopsound(1);
  carp_ent playsoundwithnotify("evt_carpenter_end", "sound_done");
  carp_ent waittill(#"sound_done");
  carp_ent delete();
}