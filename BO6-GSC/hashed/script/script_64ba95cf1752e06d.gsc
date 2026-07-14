/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_64ba95cf1752e06d.gsc
*****************************************************/

#using script_153326c39c6d37eb;
#using script_1c5659cf71abc214;
#using script_25bf71578e00560d;
#using script_64ba95cf1752e06d;
#using scripts\anim\dialogue;
#using scripts\common\system;
#using scripts\engine\utility;
#using scripts\sp\loot;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\save;
#namespace radio_safe;

function private autoexec __init__system__() {
  system::register(#"radio_safe", #"t10_system", undefined, &post_main);
}

function autoexec init() {
  level._effect["\xe5\x1by~x\xef\xe7\x1c\x88\xb5\\Fh`\x15\xb9\xf8\xd0\x9e\xa3O\xbc\x7fv\x1e\x06\xdf\x1d\xbeF1\x7f\xfe"] = loadfxasset("\xe5\x1by~x\xef\xe7\x1c\x88\xb5\\Fh`\x15\xb9\xf8\xd0\x9e\xa3O\xbc\x7fv\x1e\x06\xdf\x1d\xbeF1\x7f\xfe");
  level._effect["%\xa0R\x9f9l<`82o\xdaV\xd9\x88!\t\xc8\xd0\x89\xd9X\x8a\x14f\xaaC\x1a\xb5\xc3\xe8-+\x18"] = loadfxasset("%\xa0R\x9f9l<`82o\xdaV\xd9\x88!\t\xc8\xd0\x89\xd9X\x8a\x14f\xaaC\x1a\xb5\xc3\xe8-+\x18");
}

function private post_main() {
  utility::flag_wait("78\x8f ?\xdf\x9b\xda\x7f\x15c=\xc0A\xf3'\xe4\xe9\xfc\x9f\x95\xa1");
  safe_setups = getEntArray("\\6\xc9\x14\xf8,\xd3\xf4g\x80", "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

  while(!isDefined(level.mapname)) {
    waitframe();
  }

  foreach(setup in safe_setups) {
    setup register_safe();
    setup.var_6366d552fc2ac751 = setup.identifier + "\xd7\x0f\xdfwh!$v\xf4f@";
    setup.var_fc9dad3808912017 = setup.identifier + "v\xae\xa2\x99\xa6\xe5\xa9\x8fKh~";
    setup.opened_flag = setup.identifier + "\xb9X\xcc\xb2\xf5{\x0e\xac\xcd\x952";
    target_ents = getEntArray(setup.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

    foreach(ent in target_ents) {
      switch (ent.script_noteworthy) {
        case #"hash_4576dc059727cc09":
          setup.door = ent;
          break;
        case #"hash_793674feaea8cfb3":
          setup.handle = ent;
          break;
        case #"hash_6cbc49a9241853f7":
          setup.trigger = ent;
          break;
        case #"hash_584ae7cabd7c9f4":
          setup.door_clip = ent;
          break;
      }
    }

    if(isDefined(setup.door) && isDefined(setup.door_clip)) {
      setup.door_clip linkTo(setup.door);
      setup.door_clip notsolid();
    }

    target_structs = utility::getStructArray(setup.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");

    foreach(struct in target_structs) {
      switch (struct.script_noteworthy) {
        case #"hash_38198f071b42b5af":
          setup.safe_interact = struct;
          break;
        case #"hash_c9b4ce3580e88197":
          setup.loot_spawn = struct;
          break;
      }
    }

    if(function_44157436e2f05660(setup.identifier)) {
      setup thread safe_open();
      continue;
    }

    setup thread safe_radio();
    setup thread function_416b7ba3d2ace8cd();
    setup thread safe_logic();
  }
}

function register_safe(manualprefix = undefined) {
  if(isstring(manualprefix)) {
    self.identifier = manualprefix + "\xfe\xa1'\xb7\xa5Q\xfe\x81U{";
  } else {
    if(!isDefined(level.mapsafes)) {
      level.mapsafes = [];
    }

    var_fcfd2e56263cbce5 = level.mapsafes.size;
    level.mapsafes[level.mapsafes.size] = self;
    self.identifier = level.mapname + "\xe6\x7f\xbd\xc2\xcd\xe0\xca\b\"c\xe5" + var_fcfd2e56263cbce5;
  }

  var_58d6fc354a3f6ca7 = save::function_1d3508467f5df46d("d'H>\xc9\r\xd7Eu6\f\x8a", []);

  if(!isDefined(var_58d6fc354a3f6ca7[self.identifier])) {
    var_58d6fc354a3f6ca7[self.identifier] = var_58d6fc354a3f6ca7.size;
  }

  save::function_2be49230a9e6f761("d'H>\xc9\r\xd7Eu6\f\x8a", var_58d6fc354a3f6ca7);

  index = function_1122a03857fe0be4(self.identifier);
}

function function_1122a03857fe0be4(identifier) {
  var_58d6fc354a3f6ca7 = save::function_1d3508467f5df46d("d'H>\xc9\r\xd7Eu6\f\x8a", []);
  ddlindex = var_58d6fc354a3f6ca7[identifier];
  assert(isint(ddlindex));
  assert(ddlindex >= 0);
  assert(ddlindex < 32);
  ddlindex = int(clamp(ddlindex, 0, 31));
  return ddlindex;
}

function function_44157436e2f05660(identifier) {
  ddlindex = function_1122a03857fe0be4(identifier);
  return level.player getplayerprogression("\xcb\x03a\x9d\xe4E\xed\x9fC\xe1", ddlindex);
}

function function_e3ac19213a21061c(identifier) {
  ddlindex = function_1122a03857fe0be4(identifier);
  level.player setplayerprogression("\xcb\x03a\x9d\xe4E\xed\x9fC\xe1", ddlindex, 1);
  totalopened = 0;

  for(i = 0; i < 32; i++) {
    if(level.player getplayerprogression("\xcb\x03a\x9d\xe4E\xed\x9fC\xe1", i)) {
      totalopened += 1;
    }
  }

  level.player player_sp::challengeprogressset("\x87UF\xf0\xb5\x98x\xc3\xab)x", totalopened);
}

function safe_radio() {
  level thread function_d02bfb9310f9dbcc(self);

  while(!utility::flag(self.var_6366d552fc2ac751)) {
    cursor_hint::create_cursor_hint(undefined, undefined, &"hash_8f76e9bd9b0d6bf", undefined, 100, 64, 0);
    self waittill("\x91`\xb1\xe7T\x97>");

    if(!utility::flag(self.var_fc9dad3808912017)) {
      utility::flag_set(self.var_fc9dad3808912017);
    }

    var_5378d361bc6906af = level.player frequency_matching_puzzle::function_64ac42fdbfcb2110();

    if(var_5378d361bc6906af) {
      level.player waittill("\x1c6\xbak\xda\xcdVY:`\xd2\x18\xcb\x1a\xf5<\xdfWy2\xb9\xcfPY\x98f\x0fY\xc1");
      continue;
    }

    waitframe();
  }
}

function function_416b7ba3d2ace8cd() {
  level.player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self.trigger endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");

  while(!utility::flag(self.var_fc9dad3808912017)) {
    self.trigger waittill("\x91`\xb1\xe7T\x97>");
    level.player thread signal_detected::function_f9fb8e4168989e5c(self.trigger, self);

    while(level.player istouching(self.trigger)) {
      waitframe();
    }
  }
}

function function_d02bfb9310f9dbcc(radio) {
  level.player waittill("\x96\xdf\n\xef\xc7\xd1\xa8vh\xf5\x80]\xe9\xd7\b\x9d\xec\xf8& 7\x9d\xb0\x1e\xbbY?\x04w\x0f\xf6");
  utility::flag_set(radio.var_6366d552fc2ac751);
  level.player frequency_matching_puzzle::frequency_match_puzzle_close();
  radio thread function_5ca514ffe1b362c6();
}

function function_5ca514ffe1b362c6() {
  words = self.safe_combo;
  sfxoffset = anglesToForward(self.angles);
  sfxoffset = sfxoffset * -5 + (0, 0, 5);

  if(!isDefined(self.sfxloop)) {
    self.sfxloop = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", self.origin + sfxoffset);
  }

  while(!utility::flag(self.opened_flag)) {
    foreach(vo in words) {
      self.sfxloop dialogue::say(vo);
      wait 0.25;
    }

    wait 7.25;
  }
}

function safe_logic() {
  function_b5f00d22d3ff18eb();

  while(!utility::flag(self.opened_flag)) {
    self.safe_interact cursor_hint::create_cursor_hint(undefined, undefined, &"hash_27c9d5968bf8a1c6", undefined, 200, 64, 0);
    self.safe_interact waittill("\x91`\xb1\xe7T\x97>");
    self.safe_interact cursor_hint::remove_cursor_hint();
    level.player.current_safe = self;
    level.player combination_puzzle::combination_open(self.safe_code, &function_f6152154671db04d, undefined, &safe_combo_closed);
    level utility::waittill_any(self.opened_flag, "!D\xf8\x81\xec\xa8\x80\x82\x9aE[\xa1\x13\xcbxP3");
  }
}

function safe_combo_closed() {
  level notify("!D\xf8\x81\xec\xa8\x80\x82\x9aE[\xa1\x13\xcbxP3");
}

function function_f6152154671db04d() {
  utility::flag_set(self.current_safe.opened_flag);
  self.current_safe thread function_995bec0dd8165025();
  level.player combination_puzzle::combination_close();
  level.player.current_safe = undefined;
}

function function_995bec0dd8165025() {
  self.loot = loot::spawnlootitem("\xf2s3\xdaP\xd6\xb1\xc4a\x14", self.loot_spawn.origin, self.loot_spawn.angles, 1, 1, 1, 0);
  self.loot thread spin_coin();
  self.loot thread coin_vfx();
  thread safe_open();
  thread function_854077aeda4fcb92(self.identifier);
}

function safe_open() {
  rotate_amt = -110;

  if(isDefined(self.door.script_parameters) && isnumber(self.door.script_parameters)) {
    rotate_amt = self.door.script_parameters;
  }

  self.handle linkTo(self.door);
  self.door rotateYaw(rotate_amt, 0.5);
  self.door playSound("\x02/\x88_\xd1\xb8\xf8\x85L\xa45a\xd4");
  level.player playRumbleOnEntity("\xf6 \xc1\x13\x119\x0f\xf5C&E\x97");
  wait 0.5;
  self.door_clip solid();
  self.door notsolid();
  self.handle notsolid();
}

function coin_vfx() {
  playFXOnTag(utility::getfx("\xe5\x1by~x\xef\xe7\x1c\x88\xb5\\Fh`\x15\xb9\xf8\xd0\x9e\xa3O\xbc\x7fv\x1e\x06\xdf\x1d\xbeF1\x7f\xfe"), self, "\xec\xbfK|\au\xcd\xc2\x19<");
  self waittill("U(\x8c@r\x8c5E`");
  killfxontag(utility::getfx("\xe5\x1by~x\xef\xe7\x1c\x88\xb5\\Fh`\x15\xb9\xf8\xd0\x9e\xa3O\xbc\x7fv\x1e\x06\xdf\x1d\xbeF1\x7f\xfe"), self, "\xec\xbfK|\au\xcd\xc2\x19<");
  playFX(utility::getfx("%\xa0R\x9f9l<`82o\xdaV\xd9\x88!\t\xc8\xd0\x89\xd9X\x8a\x14f\xaaC\x1a\xb5\xc3\xe8-+\x18"), self.origin);
}

function function_854077aeda4fcb92(identifier) {
  self.loot waittill("U(\x8c@r\x8c5E`");
  utility::flag_set("ny\xc8\x14\xc0*\b\xbb\xf3\x98\xad\xdcDw");
  function_e3ac19213a21061c(identifier);
}

function spin_coin() {
  tag = utility::function_94c66bbed3da2a18(self.origin, self.angles);
  self linkTo(tag);
  rotationtime = 4;

  while(isDefined(tag)) {
    if(!utility::flag("ny\xc8\x14\xc0*\b\xbb\xf3\x98\xad\xdcDw")) {
      tag rotateby((0, 360, 0), rotationtime, 0, 0);
      wait rotationtime;
      continue;
    }

    tag delete();
  }
}

function function_b5f00d22d3ff18eb() {
  combos = [["\xcc9\xdb\x85\x11\xed\xec$#,\xd4M\xd7\xc8x\a\x1f\x9fV\x1c\x92\x1b\xc8I\xdf|", "\xde\x7f\x9dF\xe4P\x1c\x9d\x05\xec\x1b\xf1\xd0\xa2wCo\"\x12\xeb60\x90\x94w", "\xa1t\x01\xa9\x9e8C\xdc\xec31\xcf\x9cRe\x93Q%2\xd8M*\xab\x8c|", "\xde\x7f\x9dF\xe4P\x1c\x9d\x05\xec\x1b\xf1\xd0\xa2wCo\"\x12\xeb60\x90\x94w"]];
  combos = utility::array_add(combos, ["\xa1t\x01\xa9\x9e8C\xdc\xec31\xcf\x9cRe\x93Q%2\xd8M*\xab\x8c|", "\xde\x7f\x9dF\xe4P\x1c\x9d\x05\xec\x1b\xf1\xd0\xa2wCo\"\x12\xeb60\x90\x94w", "\x01\xef\xe4W\x83kR\x86\x9b\x1e\xd0\x01j=\xe7x\xdc\x128\xf2\x1f\x8f\anis", "\xcc9\xdb\x85\x11\xed\xec$#,\xd4M\xd7\xc8x\a\x1f\x9fV\x1c\x92\x1b\xc8I\xdf|"]);
  combos = utility::array_add(combos, ["\xed\xd0\xda\xfcm0\x87\x8a\xab;\xfe\xb6\\\xa8\xff8\x9dp\x81r\xfb\x901\x7f", "\xed\xd0\xda\xfcm0\x87\x8a\xab;\xfe\xb6\\\xa8\xff8\x9dp\x81r\xfb\x901\x7f", "\xde\x7f\x9dF\xe4P\x1c\x9d\x05\xec\x1b\xf1\xd0\xa2wCo\"\x12\xeb60\x90\x94w", "\x05\x95\x1a\xc1-\xa4qd\xf0\xd4\b\xb5\xbc,\x81\x9c\xf6.\x17\x8bP0\x13\x82"]);
  combos = utility::array_add(combos, ["\xbf\x9e\x9ex\x11,\xc1w\xeb\x80\xce\x86\x15\xb0\xf2\x1b\xaa\xcdU\xf5\x9f\xbb\x81\xdb\xf8@", "\xa1t\x01\xa9\x9e8C\xdc\xec31\xcf\x9cRe\x93Q%2\xd8M*\xab\x8c|", "\x05\x95\x1a\xc1-\xa4qd\xf0\xd4\b\xb5\xbc,\x81\x9c\xf6.\x17\x8bP0\x13\x82", "\xf1\xb1\xde\x91\x1c\xf9\x1f\xf2\xbaT[\xc7\xa6h\x1c\xb9\xe9s\xae\v\x86\xdb\xe3\x05\x82"]);
  combos = utility::array_add(combos, ["&\x02\xe6\xbf\\/\x90\x16\xeb\xd3\x0e~c\x88\x18\xf0\xf8\x04<\xa4\r\xa5\xbc,\xfd", "\xcc9\xdb\x85\x11\xed\xec$#,\xd4M\xd7\xc8x\a\x1f\x9fV\x1c\x92\x1b\xc8I\xdf|", "\xf1\xb1\xde\x91\x1c\xf9\x1f\xf2\xbaT[\xc7\xa6h\x1c\xb9\xe9s\xae\v\x86\xdb\xe3\x05\x82", "&\x02\xe6\xbf\\/\x90\x16\xeb\xd3\x0e~c\x88\x18\xf0\xf8\x04<\xa4\r\xa5\xbc,\xfd"]);
  combos = utility::array_add(combos, ["&\x02\xe6\xbf\\/\x90\x16\xeb\xd3\x0e~c\x88\x18\xf0\xf8\x04<\xa4\r\xa5\xbc,\xfd", "\xa1t\x01\xa9\x9e8C\xdc\xec31\xcf\x9cRe\x93Q%2\xd8M*\xab\x8c|", "\xed\xd0\xda\xfcm0\x87\x8a\xab;\xfe\xb6\\\xa8\xff8\x9dp\x81r\xfb\x901\x7f", "\xcc9\xdb\x85\x11\xed\xec$#,\xd4M\xd7\xc8x\a\x1f\x9fV\x1c\x92\x1b\xc8I\xdf|"]);
  combos = utility::array_add(combos, ["\x8e\x7fzM\x82\xdd\xfe\xe2\x86\xed\xe1\x06\xf5B\xb8\x97\xd1\xcd\x15V\x11\xed\xb1\x03", "\xbf\x9e\x9ex\x11,\xc1w\xeb\x80\xce\x86\x15\xb0\xf2\x1b\xaa\xcdU\xf5\x9f\xbb\x81\xdb\xf8@", "\xbf\x9e\x9ex\x11,\xc1w\xeb\x80\xce\x86\x15\xb0\xf2\x1b\xaa\xcdU\xf5\x9f\xbb\x81\xdb\xf8@", "\xde\x7f\x9dF\xe4P\x1c\x9d\x05\xec\x1b\xf1\xd0\xa2wCo\"\x12\xeb60\x90\x94w"]);
  combos = utility::array_add(combos, ["\xde\x7f\x9dF\xe4P\x1c\x9d\x05\xec\x1b\xf1\xd0\xa2wCo\"\x12\xeb60\x90\x94w", "\x8e\x7fzM\x82\xdd\xfe\xe2\x86\xed\xe1\x06\xf5B\xb8\x97\xd1\xcd\x15V\x11\xed\xb1\x03", "\xcc9\xdb\x85\x11\xed\xec$#,\xd4M\xd7\xc8x\a\x1f\x9fV\x1c\x92\x1b\xc8I\xdf|", "\xbf\x9e\x9ex\x11,\xc1w\xeb\x80\xce\x86\x15\xb0\xf2\x1b\xaa\xcdU\xf5\x9f\xbb\x81\xdb\xf8@"]);
  combos = utility::array_add(combos, ["\xcc9\xdb\x85\x11\xed\xec$#,\xd4M\xd7\xc8x\a\x1f\x9fV\x1c\x92\x1b\xc8I\xdf|", "\xf1\xb1\xde\x91\x1c\xf9\x1f\xf2\xbaT[\xc7\xa6h\x1c\xb9\xe9s\xae\v\x86\xdb\xe3\x05\x82", "&\x02\xe6\xbf\\/\x90\x16\xeb\xd3\x0e~c\x88\x18\xf0\xf8\x04<\xa4\r\xa5\xbc,\xfd", "\xbf\x9e\x9ex\x11,\xc1w\xeb\x80\xce\x86\x15\xb0\xf2\x1b\xaa\xcdU\xf5\x9f\xbb\x81\xdb\xf8@"]);
  combos = utility::array_add(combos, ["\x01\xef\xe4W\x83kR\x86\x9b\x1e\xd0\x01j=\xe7x\xdc\x128\xf2\x1f\x8f\anis", "&\x02\xe6\xbf\\/\x90\x16\xeb\xd3\x0e~c\x88\x18\xf0\xf8\x04<\xa4\r\xa5\xbc,\xfd", "\xde\x7f\x9dF\xe4P\x1c\x9d\x05\xec\x1b\xf1\xd0\xa2wCo\"\x12\xeb60\x90\x94w", "\x05\x95\x1a\xc1-\xa4qd\xf0\xd4\b\xb5\xbc,\x81\x9c\xf6.\x17\x8bP0\x13\x82"]);
  combos = utility::array_add(combos, ["\x01\xef\xe4W\x83kR\x86\x9b\x1e\xd0\x01j=\xe7x\xdc\x128\xf2\x1f\x8f\anis", "\x05\x95\x1a\xc1-\xa4qd\xf0\xd4\b\xb5\xbc,\x81\x9c\xf6.\x17\x8bP0\x13\x82", "\x8e\x7fzM\x82\xdd\xfe\xe2\x86\xed\xe1\x06\xf5B\xb8\x97\xd1\xcd\x15V\x11\xed\xb1\x03", "\x8e\x7fzM\x82\xdd\xfe\xe2\x86\xed\xe1\x06\xf5B\xb8\x97\xd1\xcd\x15V\x11\xed\xb1\x03"]);
  combos = utility::array_add(combos, ["\xed\xd0\xda\xfcm0\x87\x8a\xab;\xfe\xb6\\\xa8\xff8\x9dp\x81r\xfb\x901\x7f", "\xcc9\xdb\x85\x11\xed\xec$#,\xd4M\xd7\xc8x\a\x1f\x9fV\x1c\x92\x1b\xc8I\xdf|", "\xcc9\xdb\x85\x11\xed\xec$#,\xd4M\xd7\xc8x\a\x1f\x9fV\x1c\x92\x1b\xc8I\xdf|", "\x01\xef\xe4W\x83kR\x86\x9b\x1e\xd0\x01j=\xe7x\xdc\x128\xf2\x1f\x8f\anis"]);
  combos = utility::array_add(combos, ["\x05\x95\x1a\xc1-\xa4qd\xf0\xd4\b\xb5\xbc,\x81\x9c\xf6.\x17\x8bP0\x13\x82", "\x05\x95\x1a\xc1-\xa4qd\xf0\xd4\b\xb5\xbc,\x81\x9c\xf6.\x17\x8bP0\x13\x82", "\xa1t\x01\xa9\x9e8C\xdc\xec31\xcf\x9cRe\x93Q%2\xd8M*\xab\x8c|", "\xed\xd0\xda\xfcm0\x87\x8a\xab;\xfe\xb6\\\xa8\xff8\x9dp\x81r\xfb\x901\x7f"]);
  combos = utility::array_add(combos, ["\xbf\x9e\x9ex\x11,\xc1w\xeb\x80\xce\x86\x15\xb0\xf2\x1b\xaa\xcdU\xf5\x9f\xbb\x81\xdb\xf8@", "\xed\xd0\xda\xfcm0\x87\x8a\xab;\xfe\xb6\\\xa8\xff8\x9dp\x81r\xfb\x901\x7f", "\xed\xd0\xda\xfcm0\x87\x8a\xab;\xfe\xb6\\\xa8\xff8\x9dp\x81r\xfb\x901\x7f", "&\x02\xe6\xbf\\/\x90\x16\xeb\xd3\x0e~c\x88\x18\xf0\xf8\x04<\xa4\r\xa5\xbc,\xfd"]);
  combos = utility::array_add(combos, ["\xde\x7f\x9dF\xe4P\x1c\x9d\x05\xec\x1b\xf1\xd0\xa2wCo\"\x12\xeb60\x90\x94w", "\x8e\x7fzM\x82\xdd\xfe\xe2\x86\xed\xe1\x06\xf5B\xb8\x97\xd1\xcd\x15V\x11\xed\xb1\x03", "\x01\xef\xe4W\x83kR\x86\x9b\x1e\xd0\x01j=\xe7x\xdc\x128\xf2\x1f\x8f\anis", "\xa1t\x01\xa9\x9e8C\xdc\xec31\xcf\x9cRe\x93Q%2\xd8M*\xab\x8c|"]);
  combos = utility::array_add(combos, ["\x8e\x7fzM\x82\xdd\xfe\xe2\x86\xed\xe1\x06\xf5B\xb8\x97\xd1\xcd\x15V\x11\xed\xb1\x03", "\xf1\xb1\xde\x91\x1c\xf9\x1f\xf2\xbaT[\xc7\xa6h\x1c\xb9\xe9s\xae\v\x86\xdb\xe3\x05\x82", "\x8e\x7fzM\x82\xdd\xfe\xe2\x86\xed\xe1\x06\xf5B\xb8\x97\xd1\xcd\x15V\x11\xed\xb1\x03", "\x01\xef\xe4W\x83kR\x86\x9b\x1e\xd0\x01j=\xe7x\xdc\x128\xf2\x1f\x8f\anis"]);
  combos = utility::array_add(combos, ["\xf1\xb1\xde\x91\x1c\xf9\x1f\xf2\xbaT[\xc7\xa6h\x1c\xb9\xe9s\xae\v\x86\xdb\xe3\x05\x82", "\x01\xef\xe4W\x83kR\x86\x9b\x1e\xd0\x01j=\xe7x\xdc\x128\xf2\x1f\x8f\anis", "\xbf\x9e\x9ex\x11,\xc1w\xeb\x80\xce\x86\x15\xb0\xf2\x1b\xaa\xcdU\xf5\x9f\xbb\x81\xdb\xf8@", "\xed\xd0\xda\xfcm0\x87\x8a\xab;\xfe\xb6\\\xa8\xff8\x9dp\x81r\xfb\x901\x7f"]);
  combos = utility::array_add(combos, ["\x05\x95\x1a\xc1-\xa4qd\xf0\xd4\b\xb5\xbc,\x81\x9c\xf6.\x17\x8bP0\x13\x82", "\x01\xef\xe4W\x83kR\x86\x9b\x1e\xd0\x01j=\xe7x\xdc\x128\xf2\x1f\x8f\anis", "&\x02\xe6\xbf\\/\x90\x16\xeb\xd3\x0e~c\x88\x18\xf0\xf8\x04<\xa4\r\xa5\xbc,\xfd", "\xa1t\x01\xa9\x9e8C\xdc\xec31\xcf\x9cRe\x93Q%2\xd8M*\xab\x8c|"]);
  combos = utility::array_add(combos, ["\xf1\xb1\xde\x91\x1c\xf9\x1f\xf2\xbaT[\xc7\xa6h\x1c\xb9\xe9s\xae\v\x86\xdb\xe3\x05\x82", "\xbf\x9e\x9ex\x11,\xc1w\xeb\x80\xce\x86\x15\xb0\xf2\x1b\xaa\xcdU\xf5\x9f\xbb\x81\xdb\xf8@", "\x05\x95\x1a\xc1-\xa4qd\xf0\xd4\b\xb5\xbc,\x81\x9c\xf6.\x17\x8bP0\x13\x82", "\x8e\x7fzM\x82\xdd\xfe\xe2\x86\xed\xe1\x06\xf5B\xb8\x97\xd1\xcd\x15V\x11\xed\xb1\x03"]);
  combos = utility::array_add(combos, ["\xa1t\x01\xa9\x9e8C\xdc\xec31\xcf\x9cRe\x93Q%2\xd8M*\xab\x8c|", "&\x02\xe6\xbf\\/\x90\x16\xeb\xd3\x0e~c\x88\x18\xf0\xf8\x04<\xa4\r\xa5\xbc,\xfd", "\xf1\xb1\xde\x91\x1c\xf9\x1f\xf2\xbaT[\xc7\xa6h\x1c\xb9\xe9s\xae\v\x86\xdb\xe3\x05\x82", "\xf1\xb1\xde\x91\x1c\xf9\x1f\xf2\xbaT[\xc7\xa6h\x1c\xb9\xe9s\xae\v\x86\xdb\xe3\x05\x82"]);
  codes = [ &"hash_18aee0a5c53d6140"];
  codes = utility::array_add(codes, &"hash_18aee1a5c53d62f3");
  codes = utility::array_add(codes, &"hash_18aee2a5c53d64a6");
  codes = utility::array_add(codes, &"hash_18aee3a5c53d6659");
  codes = utility::array_add(codes, &"hash_18aee4a5c53d680c");
  codes = utility::array_add(codes, &"hash_18aee5a5c53d69bf");
  codes = utility::array_add(codes, &"hash_18aee6a5c53d6b72");
  codes = utility::array_add(codes, &"hash_18aee7a5c53d6d25");
  codes = utility::array_add(codes, &"hash_18aee8a5c53d6ed8");
  codes = utility::array_add(codes, &"hash_18aee9a5c53d708b");
  codes = utility::array_add(codes, &"hash_2e8c2fae274ed159");
  codes = utility::array_add(codes, &"hash_2e8c2eae274ecfa6");
  codes = utility::array_add(codes, &"hash_2e8c2dae274ecdf3");
  codes = utility::array_add(codes, &"hash_2e8c2cae274ecc40");
  codes = utility::array_add(codes, &"hash_2e8c33ae274ed825");
  codes = utility::array_add(codes, &"hash_2e8c32ae274ed672");
  codes = utility::array_add(codes, &"hash_2e8c31ae274ed4bf");
  codes = utility::array_add(codes, &"hash_2e8c30ae274ed30c");
  codes = utility::array_add(codes, &"hash_2e8c37ae274edef1");
  codes = utility::array_add(codes, &"hash_2e8c36ae274edd3e");
  safe_idx = randomintrange(0, 19);
  self.safe_combo = combos[safe_idx];
  self.safe_code = codes[safe_idx];
}