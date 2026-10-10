/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_57614a088fb41089.gsc
*************************************************/

#using script_72ef6b9f0cf1f55a;
#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace namespace_e06040b33bcef19;

function player_init(player, widget_ref, widget_type, pos_x, pos_y) {
  assert(isDefined(player));

  if(!player namespace_373fee410d5055ba::function_ada0825249682644(widget_ref)) {
    player.objective_tracker = spawnStruct();
    player.objective_tracker.objectives = [];
    player.objective_tracker.widget_ref = widget_ref;
    player.objective_tracker.init_complete = 0;
    player namespace_373fee410d5055ba::function_90de31b2cbef19f9(widget_ref, widget_type);
  }

  player thread function_2fe4757104986d63(widget_ref);
  player thread function_efca2517e81e2996(widget_ref, pos_x, pos_y);
  player thread function_372a8c2173c66c11();
}

function function_2fe4757104986d63(widget_ref) {
  self endon("disconnect");
  player = self;

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  player namespace_373fee410d5055ba::function_af4f62f0f944a8f1(widget_ref, "INIT");
  wait 1;

  if(isDefined(player) && isDefined(player.objective_tracker)) {
    player.objective_tracker.init_complete = 1;
  }
}

function function_efca2517e81e2996(widget_ref, pos_x, pos_y) {
  self endon("disconnect");

  if(!scripts\mp\flags::gameflag("prematch_done")) {
    scripts\mp\flags::gameflagwait("prematch_done");
  }

  wait 1;
  namespace_373fee410d5055ba::function_f4c37324750dc183(widget_ref, pos_x, pos_y, 0, 0);
}

function add_objective(uid, owner, owner_type, ui_key, is_completed, var_4f1c7c8ad5d5b9e4) {
  assert(isDefined(self));
  assert(isDefined(ui_key));
  assert(isDefined(self.objective_tracker) && isDefined(self.objective_tracker.objectives));

  if(isDefined(self.objective_tracker.objectives[uid])) {
    println("<dev string:x1c>" + uid + "<dev string:x4f>");
    return;
  }

  objective = spawnStruct();
  objective.uid = uid;
  objective.owner = owner;
  objective.owner_type = owner_type;
  objective.ui_key = ui_key;
  objective.is_completed = is_completed;
  objective.var_a1bb69f4fd589029 = 0;
  objective.var_4f1c7c8ad5d5b9e4 = var_4f1c7c8ad5d5b9e4;
  self.objective_tracker.objectives[uid] = objective;
  queue_objective(uid);
}

function remove_objective(uid) {
  assert(isDefined(self));
  assert(isDefined(uid));

  if(!isDefined(self.objective_tracker) || !isDefined(self.objective_tracker.objectives)) {
    return;
  }

  var_35eb8e862aa328c5 = self.objective_tracker.objectives[uid];

  if(!isDefined(var_35eb8e862aa328c5)) {
    return;
  }

  self.objective_tracker.objectives[uid] = undefined;
}

function function_c0257db3a941f1b6(uid, is_successful) {
  assert(isDefined(self));
  assert(isDefined(uid));

  if(!isDefined(self.objective_tracker) || !isDefined(self.objective_tracker.objectives)) {
    return;
  }

  var_1d242f4c62100b9a = self.objective_tracker.objectives[uid];

  if(!isDefined(var_1d242f4c62100b9a)) {
    return;
  }

  self.objective_tracker.objectives[uid].is_completed = 1;
  self.objective_tracker.objectives[uid].is_successful = is_successful;
}

function generate_uid(prefix) {
  if(!isDefined(level.objective_tracker)) {
    level.objective_tracker = spawnStruct();
    level.objective_tracker.var_f42eade64ac30200 = 0;
  }

  uid = prefix + level.objective_tracker.var_f42eade64ac30200;
  level.objective_tracker.var_f42eade64ac30200++;
  return uid;
}

function function_4c43cb3c8fcb9b87() {
  assert(isDefined(self));

  if(isDefined(self.objective_tracker) && isDefined(self.objective_tracker.widget_ref)) {
    namespace_373fee410d5055ba::function_d28fa5295a04d555(self.objective_tracker.widget_ref, "FADE_OUT");
    self.objective_tracker.active_uid = undefined;
    self.objective_tracker.active_completed = undefined;
    self.objective_tracker.var_1710c224de197b0a = 0.5;
  }
}

function function_3b4b24bbf0814ee6(uid, ui_key, is_completed, is_successful) {
  assert(isDefined(self));
  assert(isDefined(ui_key));
  assert(isDefined(is_completed));

  if(isDefined(self.objective_tracker) && isDefined(self.objective_tracker.widget_ref)) {
    function_d6b2ade17408586f(self);
    namespace_373fee410d5055ba::function_af4f62f0f944a8f1(self.objective_tracker.widget_ref, ui_key);
    new_state = "FADE_IN_INCOMPLETE";

    if(istrue(is_completed) && isDefined(is_successful)) {
      new_state = ter_op(istrue(is_successful), "FADE_IN_SUCCESSFUL", "FADE_IN_FAILURE");
    }

    namespace_373fee410d5055ba::function_d28fa5295a04d555(self.objective_tracker.widget_ref, new_state);
    function_8374758ea95f4353(self, uid);
    self.objective_tracker.active_uid = uid;
    self.objective_tracker.active_completed = is_completed;
    self.objective_tracker.var_1710c224de197b0a = 0.5;
  }
}

function function_7fcc6994dd0b0374(uid, ui_key) {
  assert(isDefined(uid));
  assert(isDefined(ui_key));

  if(isDefined(self.objective_tracker) && isDefined(self.objective_tracker.widget_ref)) {
    function_d6b2ade17408586f(self);
    namespace_373fee410d5055ba::function_af4f62f0f944a8f1(self.objective_tracker.widget_ref, ui_key);
    namespace_373fee410d5055ba::function_d28fa5295a04d555(self.objective_tracker.widget_ref, "SUB_OBJECTIVE_UPDATE");
    function_8374758ea95f4353(self, uid);
    self.objective_tracker.active_uid = uid;
    self.objective_tracker.active_completed = 0;
    self.objective_tracker.var_1710c224de197b0a = level.framedurationseconds;
  }
}

function function_d463ec55daebbd66(is_successful) {
  assert(isDefined(self));

  if(isDefined(self.objective_tracker) && isDefined(self.objective_tracker.widget_ref)) {
    new_state = ter_op(istrue(is_successful), "INCOMPLETE_TO_SUCCESSFUL", "INCOMPLETE_TO_FAILURE");
    namespace_373fee410d5055ba::function_d28fa5295a04d555(self.objective_tracker.widget_ref, new_state);
  }

  if(isDefined(self.objective_tracker.active_uid)) {
    uid = self.objective_tracker.active_uid;
    thread function_fbc454b8a9e01274(uid, 2);
  }
}

function function_fbc454b8a9e01274(uid, var_76bb91adcc07335f) {
  transition_length = 0.5 * var_76bb91adcc07335f;
  wait transition_length;

  if(isDefined(self.objective_tracker) && isDefined(self.objective_tracker.objectives)) {
    obj = self.objective_tracker.objectives[uid];

    if(isDefined(obj)) {
      obj.var_a1bb69f4fd589029 = 1;
    }
  }
}

function function_41e69df7eeb5c17b(player, uid, totalcount) {
  if(isDefined(player.objective_tracker) && isDefined(player.objective_tracker.objectives)) {
    if(isDefined(player.objective_tracker.active_uid) && player.objective_tracker.active_uid == uid) {
      function_9c9dc0bc7ea4a64e(player, totalcount);
      return;
    }

    objective = player.objective_tracker.objectives[uid];
    objective.counter_total = totalcount;
    objective.var_9c9dc0bc7ea4a64e = 1;
  }
}

function private function_9c9dc0bc7ea4a64e(player, totalcount) {
  player setclientomnvar("obj_tracker_counter_set", totalcount);
}

function function_a92e843c02dc6414(player, uid, progresscount) {
  if(isDefined(player.objective_tracker) && isDefined(player.objective_tracker.objectives)) {
    objective = player.objective_tracker.objectives[uid];
    objective.counter_progress = progresscount;

    if(isDefined(player.objective_tracker.active_uid) && player.objective_tracker.active_uid == uid) {
      function_b768c68c436ee397(player, progresscount);
      return;
    }

    objective.var_b768c68c436ee397 = 1;
  }
}

function private function_b768c68c436ee397(player, progresscount) {
  player setclientomnvar("obj_tracker_counter_update", progresscount);
}

function function_15010f27afb2d1e7(player) {
  player setclientomnvar("obj_tracker_counter_set", -1);
  player setclientomnvar("obj_tracker_counter_update", -1);
}

function function_3e38fac7ccd01903(player, uid, progress) {
  if(isDefined(player.objective_tracker) && isDefined(player.objective_tracker.objectives)) {
    if(isDefined(player.objective_tracker.active_uid) && player.objective_tracker.active_uid == uid) {
      function_6101ef6fc344c2ec(player, progress);
      return;
    }

    objective = player.objective_tracker.objectives[uid];
    objective.progress_bar = progress;
    objective.var_6101ef6fc344c2ec = 1;
  }
}

function private function_6101ef6fc344c2ec(player, progress) {
  player setclientomnvar("obj_tracker_progress_bar_update", progress);
}

function function_c718b293158313c9(player, uid, state) {
  if(isDefined(player.objective_tracker) && isDefined(player.objective_tracker.objectives)) {
    if(isDefined(player.objective_tracker.active_uid) && player.objective_tracker.active_uid == uid) {
      function_2f329f5bf42743ea(player, state);
      return;
    }

    objective = player.objective_tracker.objectives[uid];
    objective.progress_bar_state = state;
    objective.var_2f329f5bf42743ea = 1;
  }
}

function private function_2f329f5bf42743ea(player, state) {
  player setclientomnvar("obj_tracker_progress_bar_state", state);
}

function function_c1edc8a24a424e72(player, uid, show_bar) {
  if(isDefined(player.objective_tracker) && isDefined(player.objective_tracker.objectives)) {
    if(isDefined(player.objective_tracker.active_uid) && player.objective_tracker.active_uid == uid) {
      function_29e38432836c3014(player, show_bar);
      return;
    }

    objective = player.objective_tracker.objectives[uid];
    objective.progress_bar_show = show_bar;
    objective.var_fa5876e527b19b0d = 1;
  }
}

function private function_29e38432836c3014(player, show_bar) {
  player setclientomnvar("obj_tracker_progress_bar_show", show_bar);
}

function function_c69e50fb723f0078(player) {
  player setclientomnvar("obj_tracker_progress_bar_update", 0);
  player setclientomnvar("obj_tracker_progress_bar_show", 0);
  player setclientomnvar("obj_tracker_progress_bar_state", 0);
}

function function_5d2c66d2ea6e4267(player, uid, endtime) {
  if(isDefined(player.objective_tracker) && isDefined(player.objective_tracker.objectives)) {
    if(isDefined(player.objective_tracker.active_uid) && player.objective_tracker.active_uid == uid) {
      function_8024da9ac487036a(player, endtime);
      return;
    }

    objective = player.objective_tracker.objectives[uid];
    objective.timer_end_time = endtime;
    objective.update_timer = 1;
  }
}

function function_8024da9ac487036a(player, endtime) {
  player setclientomnvar("obj_tracker_timer_end_time", endtime);
}

function function_f43cc336eb444616(player) {
  player setclientomnvar("obj_tracker_timer_end_time", 0);
}

function function_8733c2caee45c023(player, uid, icon) {
  if(isDefined(player.objective_tracker) && isDefined(player.objective_tracker.objectives)) {
    if(isDefined(player.objective_tracker.active_uid) && player.objective_tracker.active_uid == uid) {
      update_icon(player, icon);
      return;
    }

    objective = player.objective_tracker.objectives[uid];
    objective.new_icon = icon;
    objective.update_icon = 1;
  }
}

function private update_icon(player, icon) {
  player setclientomnvar("obj_tracker_icon_update", icon);
}

function reset_icon(player) {
  player setclientomnvar("obj_tracker_icon_update", -1);
}

function function_8374758ea95f4353(player, uid) {
  if(!isDefined(player.objective_tracker.objectives)) {
    return;
  }

  objective = player.objective_tracker.objectives[uid];

  if(isDefined(objective)) {
    if(istrue(objective.update_icon)) {
      update_icon(player, objective.new_icon);
      objective.update_icon = 0;
    }

    if(istrue(objective.var_9c9dc0bc7ea4a64e) && isDefined(objective.counter_total)) {
      function_9c9dc0bc7ea4a64e(player, objective.counter_total);
      objective.var_9c9dc0bc7ea4a64e = 0;
    }

    if(istrue(objective.var_b768c68c436ee397) && isDefined(objective.counter_progress)) {
      function_b768c68c436ee397(player, objective.counter_progress);
      objective.var_b768c68c436ee397 = 0;
    }

    if(istrue(objective.var_6101ef6fc344c2ec) && isDefined(objective.progress_bar)) {
      function_6101ef6fc344c2ec(player, objective.progress_bar);
      objective.var_6101ef6fc344c2ec = 0;
    }

    if(istrue(objective.var_2f329f5bf42743ea) && isDefined(objective.progress_bar_state)) {
      function_2f329f5bf42743ea(player, objective.progress_bar_state);
      objective.var_2f329f5bf42743ea = 0;
    }

    if(istrue(objective.var_fa5876e527b19b0d)) {
      function_29e38432836c3014(player, objective.progress_bar_show);
      objective.var_fa5876e527b19b0d = 0;
    }

    if(istrue(objective.update_timer) && isDefined(objective.timer_end_time)) {
      function_8024da9ac487036a(player, objective.timer_end_time);
    }
  }
}

function function_d6b2ade17408586f(player) {
  reset_icon(player);
  function_c69e50fb723f0078(player);
}

function queue_objective(uid) {
  if(!isDefined(self.objective_tracker)) {
    return;
  }

  new_obj = spawnStruct();
  new_obj.uid = uid;

  if(!isDefined(self.objective_tracker.var_2a31279df671975)) {
    self.objective_tracker.var_2a31279df671975 = new_obj;
    self.objective_tracker.var_2b9d584de2e49065 = new_obj;
    thread function_f61660544e4b572b();
    return;
  }

  old_tail = self.objective_tracker.var_2b9d584de2e49065;
  old_tail.next_obj = new_obj;
  self.objective_tracker.var_2b9d584de2e49065 = new_obj;
}

function function_f61660544e4b572b() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("clear_obj_queue");
  var_d0ed7628500fde62 = level.framedurationseconds;

  while(isDefined(self.objective_tracker.var_2a31279df671975)) {
    if(istrue(self.objective_tracker.init_complete)) {
      if(isDefined(self.objective_tracker.active_uid)) {
        active_uid = self.objective_tracker.active_uid;
        active_obj = self.objective_tracker.objectives[active_uid];

        if(istrue(active_obj.is_completed) && istrue(active_obj.var_a1bb69f4fd589029)) {
          wait 3;
          function_7c1e7dd73e60601c();
        }
      } else {
        function_7c1e7dd73e60601c();
      }
    }

    wait var_d0ed7628500fde62;
  }

  self.objective_tracker.var_2b9d584de2e49065 = undefined;
}

function function_7c1e7dd73e60601c() {
  obj = self.objective_tracker.var_2a31279df671975;
  self.objective_tracker.next_uid = obj.uid;
  self.objective_tracker.var_2a31279df671975 = obj.next_obj;
}

function clear_obj_queue() {
  self notify("clear_obj_queue");
  next_obj = self.objective_tracker.var_2a31279df671975;

  while(isDefined(next_obj)) {
    current_obj = next_obj;
    next_obj = current_obj.next_obj;
    current_obj.next_obj = undefined;
  }

  self.objective_tracker.var_2a31279df671975 = undefined;
  self.objective_tracker.var_2b9d584de2e49065 = undefined;
}

function private function_372a8c2173c66c11() {
  level endon("game_ended");
  self endon("disconnect");
  player = self;

  while(true) {
    if(!isDefined(player)) {
      break;
    }

    if(isDefined(level.var_ee1c5b2643a1c2f9)) {
      player[[level.var_ee1c5b2643a1c2f9]]();
    }

    var_d0ed7628500fde62 = level.framedurationseconds;

    if(isDefined(player.objective_tracker) && isDefined(player.objective_tracker.var_1710c224de197b0a)) {
      var_d0ed7628500fde62 = player.objective_tracker.var_1710c224de197b0a;
    }

    wait var_d0ed7628500fde62;
  }

  function_f979eb22c4cee76d(player);
}

function function_f979eb22c4cee76d(player) {
  if(isDefined(player) && isDefined(player.objective_tracker) && isDefined(player.objective_tracker.widget_ref)) {
    if(player namespace_373fee410d5055ba::function_ada0825249682644(player.objective_tracker.widget_ref)) {
      player namespace_373fee410d5055ba::function_fb3c9a259f146781(player.objective_tracker.widget_ref);
    }

    player clear_obj_queue();
    player.objective_tracker = undefined;
  }
}