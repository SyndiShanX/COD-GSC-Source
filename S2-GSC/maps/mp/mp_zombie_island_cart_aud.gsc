/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_island_cart_aud.gsc
*************************************************/

cart_begin_leave(param_00) {}

cart_finish_leave(param_00) {}

cart_begin_roundabout(param_00) {}

cart_finish_roundabout(param_00) {}

cart_begin_arrival(param_00) {}

cart_finish_arrival(param_00) {}

gate_closing(param_00) {}

gate_closed(param_00) {}

gate_opening(param_00) {}

gate_opened(param_00) {}

lever_toggle_start(param_00, param_01) {}

lever_toggle_end(param_00, param_01) {}

play_transport_aud(param_00, param_01) {
  switch (param_00) {
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

  wait(param_01);
  switch (param_00) {
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