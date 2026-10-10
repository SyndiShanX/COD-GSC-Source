/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_67055b3ff4918256.gsc
*************************************************/

#using script_3455e18e022b7abc;
#using script_5d8202968463a21d;
#using script_6df6604a74a7a9c7;
#using script_71eca06c29041e9e;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\currency;
#using scripts\cp_mp\interaction;
#using scripts\engine\utility;
#namespace namespace_740a076c3d0a164d;

function function_7c6822271ce8a12() {}

function init(manager) {
  self.manager = manager;
  self.current_code = "";
  self.digits = [];
  self.var_232a9bd68a2afb2d = [];
  self.active = 0;
  self.linked = 0;
  self.portal_open = 0;
  self.var_6612ebb7de7a2933 = 0;
  self.door_object = spawnscriptable("ob_combo_lock_door", self.origin - (0, 0, -52), self.angles);
  self.interact_position = self.door_object.origin + anglestoup(self.door_object.angles) * 30;
  linked_digit = getStruct(self.target, "targetname");
  linked_digit namespace_26e60c953dc40f2c::init(self);
  self.digits = array_randomize(self.digits);
}

function function_2cade2c182251141(digit) {
  self.digits = array_add(self.digits, digit);
}

function function_3edb9b978dca8642(scriptable, value) {
  self.current_code += value;
  result = self.manager namespace_a07f20e9740e52::function_cb7a8125ea9acdce(self.current_code);

  switch (result) {
    case #"hash_f43afb7b1b11f010":
      self.current_code = "";
      self.var_232a9bd68a2afb2d = array_add(self.var_232a9bd68a2afb2d, scriptable.digit_struct);
      zip_door_link(0);
      self.var_232a9bd68a2afb2d = [];
      self.door_object setscriptablepartstate("sfx", "unlinked");
      break;
    case #"hash_4fca7d9b3c60a9b0":
      zip_door_link(1, self.manager namespace_a07f20e9740e52::function_198a38d3011ec3bc(self.current_code));
      self.var_232a9bd68a2afb2d = array_add(self.var_232a9bd68a2afb2d, scriptable.digit_struct);
      scriptable setscriptablepartstate("vfx", scriptable getscriptablepartstate("model", 0));
      scriptable setscriptablepartstate("model", "inactive");
      self.door_object setscriptablepartstate("sfx", string(self.current_code.size));
      self.current_code = "";
      break;
    case #"hash_e2450218207b1651":
      self.var_232a9bd68a2afb2d = array_add(self.var_232a9bd68a2afb2d, scriptable.digit_struct);
      scriptable setscriptablepartstate("vfx", scriptable getscriptablepartstate("model", 0));
      scriptable setscriptablepartstate("model", "inactive");
      self.door_object setscriptablepartstate("sfx", string(self.current_code.size));
      break;
  }
}

function function_a69dbc79d8e0c7c(var_d6bfa53c531546d6) {
  entered_zone = var_d6bfa53c531546d6.enteredzone;
  zone_name = var_d6bfa53c531546d6.zonename;

  if(!entered_zone) {
    return;
  }

  self.players_in_range = var_d6bfa53c531546d6.var_9f2dab34edc7e257;

  if(!self.active) {
    self notify("ZIP_TRANSITION_SINGLETON");
    self endon("ZIP_TRANSITION_SINGLETON");

    iprintln("<dev string:x1c>");

    self.active = 1;
    self.door_object setscriptablepartstate("door", "spawned");

    for(idx = 0; idx < self.digits.size; idx++) {
      if(istrue(self.digits[idx].spawned)) {
        continue;
      }

      self.digits[idx] namespace_26e60c953dc40f2c::digit_activate(1, idx);
      wait 0.15;
    }

    return;
  }

  if(self.portal_open || self.var_6612ebb7de7a2933) {
    self notify("ZIP_TRANSITION_SINGLETON");
  }
}

function function_4dc883726bbcee81(var_d6bfa53c531546d6) {
  entered_zone = var_d6bfa53c531546d6.enteredzone;
  zone_name = var_d6bfa53c531546d6.zonename;

  if(entered_zone) {
    return;
  }

  if(self.active && var_d6bfa53c531546d6.var_9f2dab34edc7e257.size == 0) {
    iprintln("<dev string:x2d>");

    thread function_b62de3e2fa216219();
    return;
  }

  return;
}

function private function_b62de3e2fa216219() {
  self notify("ZIP_TRANSITION_SINGLETON");
  self endon("ZIP_TRANSITION_SINGLETON");

  while(self.portal_open || self.linked) {
    waitframe();
  }

  if(self.var_232a9bd68a2afb2d.size > 0) {
    self.var_6612ebb7de7a2933 = 1;
    wait 60;
    self.var_6612ebb7de7a2933 = 0;
  }

  self.active = 0;
  self.door_object setscriptablepartstate("door", "disappear");

  for(idx = 0; idx < self.digits.size; idx++) {
    self.digits[idx] namespace_26e60c953dc40f2c::digit_activate(0);
    wait 0.1;
  }

  self.current_code = "";
}

function private zip_door_link(should_link, destination) {
  foreach(dig in self.var_232a9bd68a2afb2d) {
    dig namespace_26e60c953dc40f2c::digit_link(should_link);
  }

  if(istrue(should_link)) {
    self.linked = 1;
    thread function_f4ce626fde09f7e2(destination);
    return;
  }

  self.var_232a9bd68a2afb2d = [];
  self.linked = 0;
  self.portal_open = 0;
}

function private function_f4ce626fde09f7e2(destination) {
  if(getDvar(@ "hash_7130c1f3ad21f0ad", "0") != "1") {
    thread function_afc90ff2c54fd85c(destination.origin);
  }

  function_c0e0e7ff7351a670(1);
  self.door_object setscriptablepartstate("door", "purchase");
  self.interact = scripts\cp_mp\interaction::register_interact(self.interact_position, 128, &function_3684a2eb8cb2f9d7, &"SHARED_HINTSTRINGS/ZIP_DOOR_USE");
  self.interact sethintstringparams(1000);
  self.interact.door = self;
  self.interact.destination = destination;
  thread function_9efa238094778a76();
}

function private function_c0e0e7ff7351a670(should_lock) {
  foreach(dig in self.digits) {
    dig namespace_26e60c953dc40f2c::digit_lock(should_lock);
  }
}

function private function_4e26281a62cb2825(destination) {
  self.door_object setscriptablepartstate("door", "opened");
  self.portal_open = 1;
  self.current_trigger = function_f0a3a8ccf8f52412(self, (0, 0, 10), (20, 20, 20));
  thread function_43233144917da206();

  while(isDefined(self.current_trigger)) {
    self.current_trigger waittill("trigger", data);

    if(isPlayer(data) && !istrue(data.teleporting)) {
      data.teleporting = 1;
      data thread function_dc8998400a3eb807(destination, self.door_object);
    }
  }
}

function private function_dc8998400a3eb807(destination, door_object) {
  playfxontagforclients(level._effect["vfx_player_screen_distortion"], self, "j_head", self);
  val::set("fasttravel", "allow_movement", 0);
  val::set("fasttravel_ignoreme", "ignoreme", 1);
  val::set("fasttravel", "weapon", 0);
  val::set("fasttravel", "freezecontrols", 1);
  val::set("fasttravel_hud", "show_hud", 0);
  val::set("fasttravel", "interactions", 0);
  val::set("fasttravel", "vehicle_use", 0);
  playFXOnTag(level._effect["vfx_zip_player_teleport"], self, "tag_origin");
  playFXOnTag(level._effect["vfx_zip_portal_teleport"], self, "tag_origin");
  wait 0.5;
  self playsoundevent("sndevent_zipdoor_teleport_out_2d");
  wait 0.5;
  thread function_4dfb8a88030327b();
  door_object setscriptablepartstate("sfx", "teleport_out_3p");
  wait 0.25;
  self setOrigin(destination.origin);
  self setplayerangles(destination.angles);
  val::reset_all("fasttravel");
  playfxontagforclients(level._effect["vfx_player_screen_distortion_end"], self, "j_head", self);
  waitframe();
  self playsoundevent("sndevent_zipdoor_teleport_in");
  playFXOnTag(level._effect["vfx_zip_player_arrive"], self, "tag_origin");
  level callback::callback("zip_teleport_player", destination);
  wait 1;
  val::reset_all("fasttravel_ignoreme");
  self.teleporting = undefined;
  stopfxontagforclients(level._effect["vfx_player_screen_distortion"], self, "j_head", self);
}

function private function_4dfb8a88030327b() {
  self notify("play_nuke_screen_flash");
  self endon("death_or_disconnect");
  self endon("play_nuke_screen_flash");

  if(!isDefined(self.var_ad173ac833a970d4)) {
    self.var_ad173ac833a970d4 = newclienthudelem(self);
    self.var_ad173ac833a970d4.x = 0;
    self.var_ad173ac833a970d4.y = 0;
    self.var_ad173ac833a970d4 setshader("white", 640, 480);
    self.var_ad173ac833a970d4.alignx = "left";
    self.var_ad173ac833a970d4.aligny = "top";
    self.var_ad173ac833a970d4.sort = 1;
    self.var_ad173ac833a970d4.horzalign = "fullscreen";
    self.var_ad173ac833a970d4.vertalign = "fullscreen";
    self.var_ad173ac833a970d4.alpha = 0;
    self.var_ad173ac833a970d4.foreground = 1;
    self.var_ad173ac833a970d4.archived = 0;
    self.var_ad173ac833a970d4.scramblerdisabled = 1;
  }

  var_52bee65a8171b558 = 0.15;
  n_target_alpha = 1;
  self.var_ad173ac833a970d4 fadeovertime(var_52bee65a8171b558);
  self.var_ad173ac833a970d4.alpha = n_target_alpha;
  wait 0.7;
  var_52bee65a8171b558 = 0.7;
  self.var_ad173ac833a970d4 fadeovertime(var_52bee65a8171b558);
  self.var_ad173ac833a970d4.alpha = 0;
  wait var_52bee65a8171b558;
  val::reset_all("fasttravel_hud");

  if(isDefined(self.var_ad173ac833a970d4)) {
    self.var_ad173ac833a970d4 destroy();
  }
}

function private function_43233144917da206() {
  wait 57;
  wait 3;
  self.current_trigger delete();
  self.door_object setscriptablepartstate("door", "closed");
  wait 2;
  function_c0e0e7ff7351a670(0);
  zip_door_link(0);
}

function private function_9efa238094778a76() {
  self endon("ZIP_DOOR_LINKED");
  wait 20;
  self.door_object setscriptablepartstate("door", "linkfail");
  self.interact delete();
  function_c0e0e7ff7351a670(0);
  zip_door_link(0);
}

function private function_afc90ff2c54fd85c(location) {
  self.var_caa0834845100f69 = [];

  while(self.linked) {
    foreach(player in self.players_in_range) {
      if(isDefined(player) && !array_contains(self.var_caa0834845100f69, player)) {
        self.var_caa0834845100f69 = array_add(self.var_caa0834845100f69, player);
        player function_bc667001f9dd3808(location);
      }
    }

    var_8e5822fd681823ce = self.var_caa0834845100f69;

    foreach(player in self.var_caa0834845100f69) {
      if(!array_contains(self.players_in_range, player)) {
        var_8e5822fd681823ce = array_remove(var_8e5822fd681823ce, player);

        if(isDefined(player)) {
          player clearpredictedstreampos();
        }
      }
    }

    self.var_caa0834845100f69 = var_8e5822fd681823ce;
    waitframe();
  }

  foreach(player in self.var_caa0834845100f69) {
    if(isDefined(player)) {
      player clearpredictedstreampos();
    }
  }
}

function private function_3684a2eb8cb2f9d7(player) {
  if(isDefined(player)) {
    if(!player scripts\cp_mp\currency::attempt_purchase("essence", 1000, 1, 0, #"zip_door")) {
      return;
    }

    self.door notify("ZIP_DOOR_LINKED");
    self.door thread function_4e26281a62cb2825(self.destination);
    self delete();
  }
}

function private function_f0a3a8ccf8f52412(trigger_struct, offset, size) {
  assertex(isDefined(trigger_struct), "<dev string:x3a>");
  offset = default_to(offset, (0, 0, 0));
  size = default_to(size, (100, 100, 100)) / 2;
  trigger_box = spawn("trigger_box", trigger_struct.origin + offset, 0, size, size + (1, 1, 1));

  if(isDefined(trigger_struct.angles)) {
    trigger_box.angles = trigger_struct.angles;
  }

  thread function_ca53007eead9ab91(trigger_box, size);

  return trigger_box;
}

function private function_ca53007eead9ab91(trigger_box, size) {
  while(isDefined(trigger_box)) {
    if(getdvarint(@ "hash_99616e34386263aa", 0)) {
      orientedbox(trigger_box.origin, size * 2, trigger_box.angles, (0, 0, 1), 0, 1);
    }

    waitframe();
  }
}