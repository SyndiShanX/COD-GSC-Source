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

function should_drop_intel_piece(var0) {
  if(isDefined(level.should_drop_intel_func)) {
    return [[level.should_drop_intel_func]](var0);
  }

  if(istrue(level.no_intel_drops)) {
    return 0;
  }

  if(istrue(self.force_intel_drop)) {
    return 1;
  }

  var1 = randomint(100);

  if(var1 > 20) {
    return 0;
  }

  return 1;
}

function drop_intel_piece(var0) {
  self notify("dropping_intel");
  var1 = init_first_button();
  level.intel_drops = scripts\engine\utility::array_add(level.intel_drops, var1);

  if(isDefined(self.traincar_wait_until_shown)) {
    var1.traincar_wait_until_shown = self.traincar_wait_until_shown;
  }

  waitframe();
  ref_11a88(var1);
  tag_intel_with_head_icon(var1);

  if(isDefined(var1.traincar_wait_until_shown)) {
    level notify("ml_p1_intel_dropped", var1);
    return;
  }

  level notify("ml_p1_intel_dropped");
}

function init_first_button() {
  var0 = spawn("script_model", self.origin + (0, 0, 5));
  var0 setModel("offhand_wm_cellphone_old");
  return var0;
}

function ref_11a88(var0) {
  var1 = &"CP_BR/INTEL_DROP";
  var0 setHintString(var1);
  var0 setCursorHint("HINT_BUTTON");
  var0 sethintdisplayrange(500);
  var0 sethintdisplayfov(65);
  var0 setuserange(72);
  var0 setusefov(65);
  var0 sethintonobstruction("show");
  var0 setuseholdduration("duration_none");
  var0 makeusable();
  thread use_think();
  return var0;
}

function use_think() {
  self endon("death");
  level endon("ml_p1_intel_timed_out");
  level endon("ml_p1_intel_prox_remove");

  for(;;) {
    self waittill("trigger", var0);

    if(isDefined(var0)) {
      if(!var0 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      var1 = undefined;

      if(isDefined(self.traincar_wait_until_shown)) {
        var1 = self.traincar_wait_until_shown;
      }

      thread collect_intel(level, var0);
      remove_intel_piece();
    }
  }
}

function tag_intel_with_head_icon(var0) {
  if(!isDefined(level.intel_headicons)) {
    level.intel_headicons = [];
  }

  var0.head_icon = deleteheadicon(var0);
  setheadiconfriendlyimage(var0.head_icon, "hud_icon_hardpoint_diamond");
  setheadiconsnaptoedges(var0.head_icon, 0);
  level.intel_headicons[level.intel_headicons.size] = var0.head_icon;
}

function collect_intel(var0, var1) {
  thread ref_123f5();
  give_intel_weapon(var0);
  level.intel_level++;

  if(isDefined(var1)) {
    level notify("ml_p1_intel_found", var1);
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

function give_intel_weapon(var0) {
  self endon("death");
  var1 = "intel_pickup_phone";

  if(isDefined(var0)) {
    var1 = var0;
  }

  if(getDvar("scr_test_intel_pickup") != "") {
    var1 = getDvar("scr_test_intel_pickup");
  }

  var2 = get_intel_omnvar(var1);
  self disableweaponswitch();
  scripts\common\utility::allow_mantle(0);
  scripts\common\utility::allow_prone(0);
  scripts\common\utility::allow_melee(0);
  scripts\common\utility::allow_offhand_weapons(0);
  scripts\common\utility::allow_weapon_pickup(0);
  vehicle_allowplayeruse(self, 0);
  var3 = scripts\cp\utility::getvalidtakeweapon();
  var4 = getcompleteweaponname(var1);
  scripts\cp\utility::_giveweapon(var4);
  self switchtoweapon(var4);
  self setclientomnvar("ui_tablet_usb", var2);
  var5 = get_intel_weapon_hold_time(var1);
  wait var5;
  self takeweapon(var4);
  self switchtoweapon(var3);
  self enableweaponswitch();
  scripts\common\utility::allow_mantle(1);
  scripts\common\utility::allow_prone(1);
  scripts\common\utility::allow_melee(1);
  scripts\common\utility::allow_offhand_weapons(1);
  vehicle_allowplayeruse(self, 1);
  scripts\common\utility::allow_weapon_pickup(1);
  self setclientomnvar("ui_tablet_usb", 0);
}

function get_intel_weapon_hold_time(var0) {
  switch (var0) {
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

function get_intel_omnvar(var0) {
  switch (var0) {
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
    var0 = anglesToForward(level.players[0] getplayerangles());
    var0 = vectorNormalize(var0);
    var0 *= 30;
    var1 = level.players[0].origin;
    var2 = (0, 0, 0);
    var3 = scripts\engine\utility::spawn_script_origin(var1 + var0, var2);
    var3 linkTo(level.players[0]);

    for(;;) {
      drop_intel_piece(var3);
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

function timeout_remove_intel(var0) {
  self endon("death");
  wait var0;
  level notify("ml_p1_intel_timed_out");
  remove_intel_piece();
}

function remove_when_no_one_around() {
  self endon("death");
  var0 = 4000;
  var1 = var0 * var0;

  for(;;) {
    var2 = 0;

    foreach(var4 in level.players) {
      if(var2) {
        continue;
      }

      if(distance2dsquared(var4.origin, self.origin) < var1) {
        var2 = 1;
      }
    }

    if(!var2) {
      break;
    }

    wait 1;
  }

  level notify("ml_p1_intel_prox_remove");
  remove_intel_piece();
}

function publiceventsmanager(var0) {
  [var2] = strtok(var0, "_");
  var3 = int(var1[1]);
  var4 = 0;

  switch (var2) {
    case "dealer":
      break;
    case "dealer2":
      var4 = 5;
      break;
    case "landlord":
      var4 = 10;
      break;
    case "landlord2":
      var4 = 15;
      break;
    case "launderer":
      var4 = 20;
      break;
    case "launderer2":
      var4 = 25;
      break;
    case "smuggler":
      var4 = 30;
      break;
    case "smuggler2":
      var4 = 35;
      break;
    default:
      break;
  }

  var5 = var4 + var3;
  return var5;
}

function shared_interaction_structs(var0, var1) {
  var2 = 1;
  var2 = publiceventsmanager(var0);
  var3 = 0;
  var3 = self getplayerdata("cp", "cpIntel", var2);
  return var3;
}

function unlock_player_intel(var0, var1) {
  var2 = 1;
  var2 = publiceventsmanager(var0);
  self setplayerdata("cp", "cpIntel", var2, 1);
  self setplayerdata("cp", "cpIntelNew", var2, 1);
  thread scripts\cp\cp_hud_message::showsplash("cp_intel_hack_found", undefined, self);
}

function piece_use() {
  self endon("death");
  var0 = &"CP_BR/INTEL_DROP";
  self setHintString(var0);
  self setCursorHint("HINT_BUTTON");
  var1 = 500;

  if(self.script_noteworthy == "dealer2_2") {
    var1 = 130;
  }

  self sethintdisplayrange(var1);
  self sethintdisplayfov(65);
  self setuserange(72);
  self setusefov(65);
  self sethintonobstruction("hide");
  self setuseholdduration("duration_none");
  self makeusable();
  level.transientname[level.transientname.size] = self;

  for(;;) {
    self waittill("trigger", var2);

    if(isDefined(var2)) {
      if(!var2 scripts\cp\utility::is_valid_player()) {
        continue;
      }

      if(!shared_interaction_structs(var2, self.script_noteworthy)) {
        thread helis_assault3_check_size(var2);
      }
    }
  }
}

function helis_assault3_check_size(var0) {
  switch (self.model) {
    case "electronics_usb_thumb_drive":
      self hidefromplayer(var0);
      self disableplayeruse(var0);
      give_intel_weapon(var0, "intel_found_usb");
      thread scramblebink(var0);
      break;
    case "offhand_wm_cellphone_old":
      self hidefromplayer(var0);
      self disableplayeruse(var0);
      give_intel_weapon(var0, "intel_pickup_phone");
      thread scramblebink(var0);
      break;
    case "ee_book_office_folder_02":
    case "un_office_paper_01":
      var0 scripts\cp\utility::playerplaytakephotoanim();
      self hidefromplayer(var0);
      self disableplayeruse(var0);
      thread scramblebink(var0);
      break;
    default:
      break;
  }
}

function scramblebink(var0) {
  unlock_player_intel(var0, self.script_noteworthy);
}

function init_intel_pieces(var0, var1) {
  level.tracktimeringingfrenzy = 1;
  var3 = "cp_donetsk_intel_cs";

  if(isDefined(var1)) {
    var3 = var1;
  }

  if(!scripts\engine\utility::flag_exist(var3 + "_completed")) {
    scripts\engine\utility::flag_init(var3 + "_completed");
  }

  scripts\engine\utility::flag_wait(var3 + "_completed");

  if(!level.tracktimeringingfrenzy) {
    var0 = "no_intel";
  }

  var4 = getEntArray("intel_piece", "targetname");

  foreach(var6 in var4) {
    [var8] = strtok(var6.script_noteworthy, "_");

    if(var8 == var0) {
      thread piece_use();
      continue;
    }

    var6 delete();
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

  foreach(var2 in level.transientname) {
    if(shared_interaction_structs(var2.script_noteworthy)) {
      var2 hidefromplayer(self);
      var2 disableplayeruse(self);
    }
  }
}