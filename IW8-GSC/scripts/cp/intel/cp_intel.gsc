/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\intel\cp_intel.gsc
***********************************************/

function intel_init() {
  level.intel_drops = [];
  level.intel_drop_num = 0;
  level.intel_level = 0;
  level.transientname = [];
  level.no_intel_drops = 1;
  level.intel_drop_func = &drop_intel_piece;
  level.should_intel_drop_func = &should_drop_intel_piece;
  level.playerclearstreamhintorigin = &spawn_another_group_and_run_regular_death;
  scripts\engine\utility::flag_init("intel_pieces_init_done");

  if(scripts\engine\utility::flag_exist("init_interaction_done")) {
    scripts\engine\utility::flag_wait("init_interaction_done");
  }

  scripts\cp\cp_agent_damage::register_drop_func("intel", &drop_intel_piece, &should_drop_intel_piece, 15);
  thread test_intel_pickup();
}

function should_drop_intel_piece(var_0) {
  if(isDefined(level.should_drop_intel_func)) {
    return [[level.should_drop_intel_func]](var_0);
  }

  if(istrue(level.no_intel_drops)) {
    return 0;
  }

  if(istrue(self.force_intel_drop)) {
    return 1;
  }

  var_1 = randomint(100);

  if(var_1 > 20) {
    return 0;
  }

  return 1;
}

function drop_intel_piece(var_0) {
  self notify("dropping_intel");
  var_1 = init_first_button();
  level.intel_drops = scripts\engine\utility::array_add(level.intel_drops, var_1);

  if(isDefined(self.traincar_wait_until_shown)) {
    var_1.traincar_wait_until_shown = self.traincar_wait_until_shown;
  }

  waitframe();
  ref_11a88(var_1);
  tag_intel_with_head_icon(var_1);

  if(isDefined(var_1.traincar_wait_until_shown)) {
    level notify("ml_p1_intel_dropped", var_1);
    return;
  }

  level notify("ml_p1_intel_dropped");
}

function init_first_button() {
  var_0 = spawn("script_model", self.origin + (0, 0, 5));
  var_0 setModel("offhand_wm_cellphone_old");
  return var_0;
}

function ref_11a88(var_0) {
  var_1 = &"CP_BR/INTEL_DROP";
  var_0 setHintString(var_1);
  var_0 setCursorHint("HINT_BUTTON");
  var_0 sethintdisplayrange(500);
  var_0 sethintdisplayfov(65);
  var_0 setuserange(72);
  var_0 setusefov(65);
  var_0 sethintonobstruction("show");
  var_0 setuseholdduration("duration_none");
  var_0 makeusable();
  thread use_think();
  return var_0;
}

function use_think() {
  self endon("death");
  level endon("ml_p1_intel_timed_out");
  level endon("ml_p1_intel_prox_remove");

  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(var_0)) {
      if(!var_0 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      var_1 = undefined;

      if(isDefined(self.traincar_wait_until_shown)) {
        var_1 = self.traincar_wait_until_shown;
      }

      thread collect_intel(level, var_0);
      remove_intel_piece();
    }
  }
}

function tag_intel_with_head_icon(var_0) {
  if(!isDefined(level.intel_headicons)) {
    level.intel_headicons = [];
  }

  var_0.head_icon = deleteheadicon(var_0);
  setheadiconfriendlyimage(var_0.head_icon, "hud_icon_hardpoint_diamond");
  setheadiconsnaptoedges(var_0.head_icon, 0);
  level.intel_headicons[level.intel_headicons.size] = var_0.head_icon;
}

function collect_intel(var_0, var_1) {
  thread ref_123f5();
  give_intel_weapon(var_0);
  level.intel_level++;

  if(isDefined(var_1)) {
    level notify("ml_p1_intel_found", var_1);
    return;
  }

  level notify("ml_p1_intel_found");
}

function ref_123f5() {
  if(isDefined(level.train_delay_handler)) {
    [[level.train_delay_handler]](self);
    return;
  }

  scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "inform_collect_generic");
}

function give_intel_weapon(var_0) {
  self endon("death");
  var_1 = "intel_pickup_phone";

  if(isDefined(var_0)) {
    var_1 = var_0;
  }

  if(getDvar("scr_test_intel_pickup") != "") {
    var_1 = getDvar("scr_test_intel_pickup");
  }

  var_2 = get_intel_omnvar(var_1);
  self disableweaponswitch();
  scripts\common\utility::allow_mantle(0);
  scripts\common\utility::allow_prone(0);
  scripts\common\utility::allow_melee(0);
  scripts\common\utility::allow_offhand_weapons(0);
  scripts\common\utility::allow_weapon_pickup(0);
  vehicle_allowplayeruse(self, 0);
  var_3 = scripts\cp\utility::getvalidtakeweapon();
  var_4 = getcompleteweaponname(var_1);
  scripts\cp\utility::_giveweapon(var_4);
  self switchtoweapon(var_4);
  self setclientomnvar("ui_tablet_usb", var_2);
  var_5 = get_intel_weapon_hold_time(var_1);
  wait var_5;
  self takeweapon(var_4);
  self switchtoweapon(var_3);
  self enableweaponswitch();
  scripts\common\utility::allow_mantle(1);
  scripts\common\utility::allow_prone(1);
  scripts\common\utility::allow_melee(1);
  scripts\common\utility::allow_offhand_weapons(1);
  vehicle_allowplayeruse(self, 1);
  scripts\common\utility::allow_weapon_pickup(1);
  self setclientomnvar("ui_tablet_usb", 0);
}

function get_intel_weapon_hold_time(var_0) {
  switch (var_0) {
    case "intel_pickup_phone":
      return 4;
    case "intel_call_phone":
      return 3;
    case "intel_put_usb_in_tablet":
      return 4;
    case "intel_found_usb":
      return 4;
  }

  return 5;
}

function get_intel_omnvar(var_0) {
  switch (var_0) {
    case "intel_pickup_phone":
      return 1;
    case "intel_call_phone":
      return 2;
    case "intel_put_usb_in_tablet":
      return 3;
    case "intel_found_usb":
      return 8;
  }

  return 0;
}

function test_intel_pickup() {
  while(!isDefined(level.players) || level.players.size < 1) {
    wait 0.1;
  }

  if(getDvar("scr_test_intel_pickup") != "") {
    wait 5;
    var_0 = anglesToForward(level.players[0] getplayerangles());
    var_0 = vectorNormalize(var_0);
    var_0 *= 30;
    var_1 = level.players[0].origin;
    var_2 = (0, 0, 0);
    var_3 = scripts\engine\utility::spawn_script_origin(var_1 + var_0, var_2);
    var_3 linkTo(level.players[0]);

    for(;;) {
      drop_intel_piece(var_3);
      level waittill("ml_p1_intel_found");
      wait 3;
    }

    return;
  }
}

function remove_intel_piece() {
  playFX(level._effect["equipment_smoke"], self.origin);
  level.intel_drops = scripts\engine\utility::array_remove(level.intel_drops, self);

  if(isDefined(self.head_icon)) {
    if(scripts\engine\utility::array_contains(level.intel_headicons, self.head_icon)) {
      if(isDefined(self.head_icon)) {
        level.intel_headicons = scripts\engine\utility::array_remove(level.intel_headicons, self.head_icon);
        setheadiconimage(self.head_icon);
      }
    }
  }

  self delete();
}

function timeout_remove_intel(var_0) {
  self endon("death");
  wait var_0;
  level notify("ml_p1_intel_timed_out");
  remove_intel_piece();
}

function remove_when_no_one_around() {
  self endon("death");
  var_0 = 4000;
  var_1 = var_0 * var_0;

  for(;;) {
    var_2 = 0;

    foreach(var_4 in level.players) {
      if(var_2) {
        continue;
      }

      if(distance2dsquared(var_4.origin, self.origin) < var_1) {
        var_2 = 1;
      }
    }

    if(!var_2) {
      break;
    }

    wait 1;
  }

  level notify("ml_p1_intel_prox_remove");
  remove_intel_piece();
}

function publiceventsmanager(var_0) {
  [var_2] = strtok(var_0, "_");
  var_3 = int(var_1[1]);
  var_4 = 0;

  switch (var_2) {
    case "dealer":
      break;
    case "dealer2":
      var_4 = 5;
      break;
    case "landlord":
      var_4 = 10;
      break;
    case "landlord2":
      var_4 = 15;
      break;
    case "launderer":
      var_4 = 20;
      break;
    case "launderer2":
      var_4 = 25;
      break;
    case "smuggler":
      var_4 = 30;
      break;
    case "smuggler2":
      var_4 = 35;
      break;
    default:
      break;
  }

  var_5 = var_4 + var_3;
  return var_5;
}

function shared_interaction_structs(var_0, var_1) {
  var_2 = 1;
  var_2 = publiceventsmanager(var_0);
  var_3 = 0;
  var_3 = self getplayerdata("cp", "cpIntel", var_2);
  return var_3;
}

function unlock_player_intel(var_0, var_1) {
  var_2 = 1;
  var_2 = publiceventsmanager(var_0);
  self setplayerdata("cp", "cpIntel", var_2, 1);
  self setplayerdata("cp", "cpIntelNew", var_2, 1);
  thread scripts\cp\cp_hud_message::showsplash("cp_intel_hack_found", undefined, self);
}

function piece_use() {
  self endon("death");
  var_0 = &"CP_BR/INTEL_DROP";
  self setHintString(var_0);
  self setCursorHint("HINT_BUTTON");
  var_1 = 500;

  if(self.script_noteworthy == "dealer2_2") {
    var_1 = 130;
  }

  self sethintdisplayrange(var_1);
  self sethintdisplayfov(65);
  self setuserange(72);
  self setusefov(65);
  self sethintonobstruction("hide");
  self setuseholdduration("duration_none");
  self makeusable();
  level.transientname[level.transientname.size] = self;

  for(;;) {
    self waittill("trigger", var_2);

    if(isDefined(var_2)) {
      if(!var_2 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(!shared_interaction_structs(var_2, self.script_noteworthy)) {
        thread helis_assault3_check_size(var_2);
      }
    }
  }
}

function helis_assault3_check_size(var_0) {
  switch (self.model) {
    case "electronics_usb_thumb_drive":
      self hidefromplayer(var_0);
      self disableplayeruse(var_0);
      give_intel_weapon(var_0, "intel_found_usb");
      thread scramblebink(var_0);
      break;
    case "offhand_wm_cellphone_old":
      self hidefromplayer(var_0);
      self disableplayeruse(var_0);
      give_intel_weapon(var_0, "intel_pickup_phone");
      thread scramblebink(var_0);
      break;
    case "ee_book_office_folder_02":
    case "un_office_paper_01":
      var_0 scripts\cp\utility::playerplaytakephotoanim();
      self hidefromplayer(var_0);
      self disableplayeruse(var_0);
      thread scramblebink(var_0);
      break;
    default:
      break;
  }
}

function scramblebink(var_0) {
  unlock_player_intel(var_0, self.script_noteworthy);
}

function init_intel_pieces(var_0, var_1) {
  level.tracktimeringingfrenzy = 1;
  var_3 = "cp_donetsk_intel_cs";

  if(isDefined(var_1)) {
    var_3 = var_1;
  }

  if(!scripts\engine\utility::flag_exist(var_3 + "_completed")) {
    scripts\engine\utility::flag_init(var_3 + "_completed");
  }

  scripts\engine\utility::flag_wait(var_3 + "_completed");

  if(!level.tracktimeringingfrenzy) {
    var_0 = "no_intel";
  }

  var_4 = getEntArray("intel_piece", "targetname");

  foreach(var_6 in var_4) {
    [var_8] = strtok(var_6.script_noteworthy, "_");

    if(var_8 == var_0) {
      thread piece_use();
      continue;
    }

    var_6 delete();
  }

  wait 1;
  scripts\engine\utility::flag_set("intel_pieces_init_done");
}

function spawn_another_group_and_run_regular_death() {
  self endon("disconnect");
  scripts\engine\utility::flag_wait("intel_pieces_init_done");

  if(!isDefined(self)) {
    return;
  }

  foreach(var_2 in level.transientname) {
    if(shared_interaction_structs(var_2.script_noteworthy)) {
      var_2 hidefromplayer(self);
      var_2 disableplayeruse(self);
    }
  }
}