/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_island_cart_aud.gsc
*********************************************************/

cart_begin_leave(var_0) {}

cart_finish_leave(var_0) {}

cart_begin_roundabout(var_0) {}

cart_finish_roundabout(var_0) {}

cart_begin_arrival(var_0) {}

cart_finish_arrival(var_0) {}

gate_closing(var_0) {}

gate_closed(var_0) {}

gate_opening(var_0) {}

gate_opened(var_0) {}

lever_toggle_start(var_0, var_1) {}

lever_toggle_end(var_0, var_1) {}

play_transport_aud(var_0, var_1) {
  switch (var_0) {
    case 0:
      thread cart_begin_leave(self);
      break;
    case 1:
      thread cart_begin_roundabout(self);
      break;
    case 2:
      thread cart_begin_arrival(self);
      break;
  }

  wait(var_1);

  switch (var_0) {
    case 0:
      thread cart_finish_leave(self);
      break;
    case 1:
      thread cart_finish_roundabout(self);
      break;
    case 2:
      thread cart_finish_arrival(self);
      break;
  }
}