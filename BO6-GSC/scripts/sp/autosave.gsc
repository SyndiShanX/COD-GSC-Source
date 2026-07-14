/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\autosave.gsc
**************************************/

#using script_3798db193e76a866;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\common\swim_common;
#using scripts\common\vehicle;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\debug;
#using scripts\sp\endmission;
#using scripts\sp\gameskill;
#using scripts\sp\player;
#using scripts\sp\save;
#using scripts\sp\utility;
#namespace autosave;

function main() {
  if(!utility::add_init_script("\x92|l\xde\x81t\xc34", &main)) {
    return;
  }

  level.autosave = spawnStruct();
  level.autosave.lastautosavetime = 0;
  utility::flag_set("\x9b2\xab\x88yvw\xcb");

  if(!isDefined(level.autosave.extra_autosave_checks)) {
    level.autosave.extra_autosave_checks = [];
  }

  function_3584bb5125846238();
  level.autosave.proximity_threat_func = &autosave_proximity_threat_func;
  level.autosave.enemydistcheck = 1;
  function_ed64cd2e034dc0ec();

  thread cheat_save();

  beginning_levelsave();
  endmission::function_619436c4b0c586f3(level.mapinfoname);
}

function function_3584bb5125846238() {
  if(!isDefined(level.gamemodebundle.autosavedata)) {
    return;
  }

  bundle = getscriptbundle("x\x0f\x8eT}\xab5\xe1:\rL3\x88" + level.gamemodebundle.autosavedata);
  setdvarifuninitialized(@ "hash_1fbf179e197540f3", istrue(bundle.showprints));
  level.autosave.allowedoffhands = [];

  if(isDefined(bundle.allowedoffhands)) {
    foreach(struct in bundle.allowedoffhands) {
      level.autosave.allowedoffhands[level.autosave.allowedoffhands.size] = struct.offhand;
    }
  }
}

function cheat_save() {
  wait 2;
  level.player endon("\x1e\xfd\xd1\xa2\a");
  setdvarifuninitialized(@ "hash_6e05061c38987036", "\xfe");

  while(true) {
    if(getdvarint(@ "hash_6e05061c38987036") > 0) {
      setDvar(@ "hash_6e05061c38987036", "\xfe");
      utility_sp::autosave_by_name("\ats\xe3i\xa4F\x12ZR");
      wait 1;
    }

    wait 0.05;
  }
}

function beginning_levelsave() {
  if(utility_sp::is_trials_level()) {
    return;
  }

  thread immediate_levelstart_save();
  thread beginning_levelsave_thread();
}

function immediate_levelstart_save() {
  if(istrue(level.var_b94f6845617a6aff)) {
    return;
  }

  servertime = endmission::level_settle_time_get(level.mapinfoname);

  if(!isDefined(servertime)) {
    servertime = 0;
  }

  servertime *= 0.05;
  clienttime = endmission::client_settle_time_get(level.mapinfoname);

  if(!isDefined(clienttime)) {
    clienttime = 0;
  }

  clienttime *= 0.001;
  wait clienttime + servertime + 0.15;
  exit = 0;

  if(isDefined(level.credits_active)) {
    autosave_print("Ng\x10d\xa5\xf2\x0f\xc3\xd2\xfc\xe21\x15\x976\x0f\xbff\xe45\x92\x13\x0f\xeb\xd2\xbb\xb6\xe2\x06\xe5\xe5\x1eN\xf7\xf9\x10\xf6\xc3_\x8e\x92?#\xf7u\x91", 0);
    exit = 1;
  } else if(level.missionfailed) {
    autosave_print("\x04\xa6U\x19\xce>\xa0\x1e;\xc4\xca\xa4\xa62\x17\xfb\xfb\xb4n\xc8w\x0f\xf4\xb4\x9er\xee\xaep\x06Pb\xde\xdb\xa5\x7fp\x9a\xe3\xd5:8", 0);
    exit = 1;
  } else if(utility::flag("\xd9\xcb\xad\xc9R\xe39#r\xd4E")) {
    autosave_print("K[[\xca\x91i\xc2\xa3\x95\xfa\xc6ev\x95\x8d\xb9\xe8X\xc9t}na\xd9YA%\x80)7\x80\x1d\xd0V\x80\xb5Z#\x19\xc6\xb2\x02\xdef\b\x85\xdc\xdb:CV\x93\x01\xb9,v\xb2\xb0\x02X\xc4o\x93\x8ei\xb9\x9d", 0);
    exit = 1;
  }

  if(exit) {
    utility::flag_set("\x05\x06\xae\xc3\xce\xfa\xcc\xbf\xfeX\xf9\xdf\xe2\x13\x1f\xc9\x98\xbb\xca\x17^h^");
    return;
  }

  utility::flag_set("\xd9\xcb\xad\xc9R\xe39#r\xd4E");

  if(!isalive(level.player)) {
    return;
  }

  imagename = "\xfc\x9a\b\t\xac\xda>\xaeO\x95\xe2\x1b0$s\xfcO\b\\\xb1\x80\xec\xdcT\xfd\xdd\fO\xad\xe80\x1f\xae" + level.script + "\xb6\xdb0\xcf\xe3\x9eZ\xb6kc]\xc3\x1ab\xbc";
  savegame("\xa5iTf^f\xf6\x04\x1e\x1b\xb5\x9b\xedL\x94{\xf8\xf5b", &"autosave/levelstart", imagename, 1);
  setDvar(@ "hash_228e280524e6d278", "\xfe");
  println("<dev string:x24>");
  level.player setplayeryolostate(0);
  autosave_print("\x84\xc1\x13\x9a$\xe3\x1b\x86y\xa4ow\xb3\xc1\xbb\x18\xec\x83\xe3\b\x1ao\xe9\f\x1d\xfa#\xa4|O-\xe3\xc2", 1);
  utility::flag_clear("\xd9\xcb\xad\xc9R\xe39#r\xd4E");
  utility::flag_set("\x05\x06\xae\xc3\xce\xfa\xcc\xbf\xfeX\xf9\xdf\xe2\x13\x1f\xc9\x98\xbb\xca\x17^h^");
}

function beginning_levelsave_thread() {
  if(istrue(level.skipbeginningoflevelsave)) {
    return;
  }

  if(isDefined(level.beginningoflevelsavedelay)) {
    wait level.beginningoflevelsavedelay;
  } else {
    wait 2;
  }

  if(isDefined(level.credits_active)) {
    autosave_print("\xf7y\"\rAa\xdb\xbe\xc9\xe6,Uj\xb3\xb4\xf9\x9c\xa1],\xdbk\xd1\bnd/\x10\xcd\x9dM\xf3\x11.5>\x99\x15&\xc2\xba\n\xa1\xe8\xbc\x96W", 0);
    return;
  }

  if(level.missionfailed) {
    autosave_print("0(\x87\xc2 m`\xd8D_\xbb\xdc\xb9\xdd\xf5\r\x82,\x9c\x97\x95\xc6\x15U\xe9\xc7%\xa1JuF\xc2\xc3%\x7f\x95\xb4Xv[\x13\xaa\xbc", 0);
    return;
  }

  if(utility::flag("\xd9\xcb\xad\xc9R\xe39#r\xd4E")) {
    autosave_print("\xa0q3\xee\xd3\xb2\biM?\xa2\x13)\x10L\xfc\xa4n\x16cW\x02\x13GU\x05\x16\x06\xbc\xd5z\xc9\xf8l\x13=\x17\xc2\x06Ca\aF\x99\xacFy\xf8\x8cd\xc0m\xcef\x12W\v\a\xd6Xlok\x80\xd8M\xa7\xec", 0);
    return;
  }

  if(!utility::flag("\x05\x06\xae\xc3\xce\xfa\xcc\xbf\xfeX\xf9\xdf\xe2\x13\x1f\xc9\x98\xbb\xca\x17^h^")) {
    utility::flag_wait("\x05\x06\xae\xc3\xce\xfa\xcc\xbf\xfeX\xf9\xdf\xe2\x13\x1f\xc9\x98\xbb\xca\x17^h^");
    wait 1;
  }

  utility::flag_set("\xd9\xcb\xad\xc9R\xe39#r\xd4E");
  imagename = "\xfc\x9a\b\t\xac\xda>\xaeO\x95\xe2\x1b0$s\xfcO\b\\\xb1\x80\xec\xdcT\xfd\xdd\fO\xad\xe80\x1f\xae" + level.script + "\x17\xad\v\xde8";
  result = waitfortransientloading("\x02\x17`i\x1e\xf0\xbeKp\xd1d\x9c\x10^\xb3o\xc63~\x121\a;\xbe|\xaax*\xd5");

  if(!isDefined(result)) {
    autosave_print("\xc4\xac\xd9K\x9bs\xd2n\x9d\xf4\xccb+\xb3\xb2\x1b5\v\xcee\xbe:h\x9c\xcaXd\x14\xa4\x10\x16\x04\xcdV\xbbe9\x10\xcd,\xce\x95@\xee\x85n 6\v\xc6\x1bV\x91\\.\xb8", 0);
    utility::flag_clear("\xd9\xcb\xad\xc9R\xe39#r\xd4E");
    return;
  }

  if(!isalive(level.player)) {
    return;
  }

  savegame("\n\xd3\xcfY\b\x16\xc6\xe9\xbd:", &"autosave/levelstart", imagename, 1);
  setDvar(@ "hash_228e280524e6d278", "\xfe");
  println("<dev string:x43>");
  level.player setplayeryolostate(0);
  autosave_print("\xa3V\a2\x83E\x0fu\xde\xfc\xff\x93\xfbn\x89E\xef\t\xac\xb6\xc4W2\xb5\xbb'\x93\xc4'\xa9\xea\x80,_\xf3\x02\x90T\xdf\x87-\x06\xe9\xc24dE\x8c^(\"\x1b\xc0\x9b[*", 1);
  utility::flag_clear("\xd9\xcb\xad\xc9R\xe39#r\xd4E");
}

function function_b3826144c7b99297(trigger) {
  trigger waittill("\x91`\xb1\xe7T\x97>");
  utility_sp::autosave_silent();
}

function trigger_autosave_stealth(trigger) {
  trigger waittill("\x91`\xb1\xe7T\x97>");
  utility_sp::autosave_stealth();
}

function trigger_autosave_tactical(trigger) {
  trigger waittill("\x91`\xb1\xe7T\x97>");
  utility_sp::autosave_tactical();
}

function trigger_autosave(trigger) {
  thread function_57c110a583f5ca9e(trigger);
}

function function_57c110a583f5ca9e(trigger) {
  trigger endon("\x1e\xfd\xd1\xa2\a");
  wait 1;

  if(istrue(trigger.script_repeat)) {
    delay = 30;

    if(isDefined(trigger.script_delay)) {
      delay = trigger.script_delay;
    }

    while(true) {
      function_4b5ad838820f51a3(trigger);
      wait delay;
    }

    return;
  }

  function_4b5ad838820f51a3(trigger, 1);
}

function function_4b5ad838820f51a3(trigger, var_3346d49f6aeef414) {
  trigger waittill("\x91`\xb1\xe7T\x97>", other);
  name = undefined;

  if(isDefined(trigger.script_autosavename)) {
    name = trigger.script_autosavename;
  }

  utility_sp::autosave_by_name(name);

  if(isDefined(trigger) && istrue(var_3346d49f6aeef414)) {
    trigger delete();
  }
}

function autosave_print(msg, type, saveid) {
  if(!getdvarint(@ "hash_6af159684591cb79") && !getdvarint(@ "hash_1fbf179e197540f3")) {
    return;
  }

  if(!isDefined(type)) {
    type = -1;
  }

  prefix = "hr\xf9m\x10s?\xcc\xbdW";

  if(isDefined(saveid)) {
    prefix = prefix + "O" + saveid + "L";
  }

  prefix += "\xfd\x10w\xa4";

  if(type == 0) {
    msg = prefix + "\xbdr!;\x1a@\xc5Yy\xa1\x8f.\xfc\xb1`\xc6" + "1\xb7" + msg;
  } else if(type == 1) {
    msg = prefix + "r%$\xcf\xe5\xf4D\x11g\xe5.8\xe6\xc9\xd6\x9b" + "1\xb7" + msg;
  } else if(type == 2) {
    msg = prefix + "1\xb7" + msg;
  } else {
    msg = prefix + msg;
  }

  if(type == 0 || type == 1 || type == 2) {
    thread autosave_hudprint(msg);
  }

  if(getdvarint(@ "hash_6af159684591cb79")) {
    iprintln(msg);
    return;
  }

  println(msg);
}

function autosave_hudprint(msg) {
  version = getbuildversion();

  if(version == "gy\x8b\xd7") {
    return;
  }

  if(getdvarint(@ "loc_warningsaserrors")) {
    return;
  }

  if(!getdvarint(@ "hash_1fbf179e197540f3")) {
    return;
  }

  if(!isDefined(level.autosave.fail_huds)) {
    level.autosave.fail_huds = [];
  }

  if(level.autosave.fail_huds.size == 3) {
    oldhud = level.autosave.fail_huds[0];
    level.autosave.fail_huds = utility::array_remove_index(level.autosave.fail_huds, 0);
    autosave_hudfail_update();
    oldhud thread autosave_hudfail_destroy();
  }

  hud = newhudelem();
  hud.elemtype = "\xe5\xf7\xe5\"";
  hud.font = "\x91\xca\xcc\v\xab\xd8:";
  hud.fontscale = 0.7;
  hud.width = 0;
  hud.height = int(8.4);
  hud.horzalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  hud.vertalign = "?\xcbkk\xe0\x0f\xae\x12\xd2\xce";
  index = level.autosave.fail_huds.size;
  level.autosave.fail_huds[index] = hud;
  hud.foreground = 1;
  hud.sort = 20;
  hud.x = 130;
  hud.y = 5 + index * 8.4;
  hud.label = msg;
  hud.alpha = 0;
  hud fadeovertime(0.2);
  hud.alpha = 1;
  hud endon("\x1e\xfd\xd1\xa2\a");
  wait 5;
  level.autosave.fail_huds = arrayremove(level.autosave.fail_huds, hud);
  autosave_hudfail_update();
  hud thread autosave_hudfail_destroy();
}

function autosave_hudfail_destroy() {
  scale = 1;
  self endon("\x1e\xfd\xd1\xa2\a");
  self fadeovertime(0.1);
  self moveovertime(0.1);
  self.y -= 8.4;
  self.alpha = 0;
  wait 0.2;
  self destroy();
}

function autosave_hudfail_update() {
  level.autosave.fail_huds = utility::array_removeundefined(level.autosave.fail_huds);

  foreach(hud in level.autosave.fail_huds) {
    hud moveovertime(0.1);
    hud.y = 5 + index * 12 * 0.7;
  }
}

function _autosave_game_now(suppress_print, suppress_notify, var_3d8305e830b3fdb8) {
  if(utility_sp::is_trials_level()) {
    return 0;
  }

  autosave_print("?V8\xdf\x18\a\x8f\x8b\xe9\b\x97\x1b\xdc\x1b\x16\x18:\x14rT3\x1b\x8f\xc8HO\xf5\xb0\x94R", 2);

  if(gettime() < 3300) {
    autosave_print("Ru\xd1\xe8 \xee\n\x8d\x92\xd8\v\xa8\xf6\x1cL\x0e\x97c%K\\\xf4\xfb\b\xb1\x86\xb6F<$\x95\xed\x85X\xcc\xbb\xb5\xaa\x16\x89\xbd\x1e\xd4\x7f;?\x90\xd1\x15\x01\xc1t\x94\x15\xd0\x8b*\xd6\x02K\x13\xec\x91\xa5\xeb\xb4r\x85\xfc\x85I\xf3\a\x02+\x83\xe8h\x9f\xc7\xa3\xe0\xf0Y)\xcdi\x99\x06\xa7", 0);
    return;
  }

  if(isDefined(level.missionfailed) && level.missionfailed) {
    return 0;
  }

  if(!isDefined(suppress_notify) || !suppress_notify) {
    level notify("c\xa3\x10\x93?\xfcc\xf02i\xf2\xe4\x17K\x8c\xb26\xca\v");
  }

  if(utility::flag("\xd9\xcb\xad\xc9R\xe39#r\xd4E")) {
    autosave_print("\xf5,]t\xbd\x9b\x85\xecV\xd7\xce\xb0\xd6e\xfa\xb9\xf6\xbb\xa0J\x04\xce\x85k\xb2\xbe\xe6Xg\xd2s\xce\x01\xd27\x04\x0e9{g\xe4e7s\xb0\x10\xb0L\xder\xd1Zn\x9dq\\\\", 0);
    return 0;
  }

  utility::flag_set("\xd9\xcb\xad\xc9R\xe39#r\xd4E");
  result = waitfortransientloading("|\x1a\xbc\x0e\xa6\xf2\xf8>\x7f\x80\xd5e\xbb\x11Ll\xea \x10$");

  if(!isDefined(result)) {
    autosave_print("\xf6\x11\xcf\xa2\xa0\xf5\n\xbe\xf6u'\xf1\xa8\xe9\x9c\a\x01\xfa\xa2\xc7b\x160\xfd<\x87\xc7(\x1fzNq1\x81\xf3x\xb9\xf3f\xf5\xd9\xa5\xfbP@R\xf0", 0);
    utility::flag_clear("\xd9\xcb\xad\xc9R\xe39#r\xd4E");
    return 0;
  }

  for(i = 0; i < level.players.size; i++) {
    player = level.players[i];

    if(!isalive(player)) {
      return 0;
    }
  }

  filename = ";\x04\f\xc8\xb6\x19C\xa1";

  if(getdvarint(@ "map_reloading") != 0) {
    autosave_print("\x18\xdavD\xbfy\xd4H\x857m\xdd\x0e\xa7y\xec\xd8[\xe8\x13Me\xda\xa4\x04\xceK\xb9M\xf2\xfa\x98\xc4:\xf0H>\\\xbe", 0);
    return 0;
  }

  if(isDefined(level.nextmission)) {
    autosave_print("\xfa,W:\xed\x9ba\xce\xb2\xd7;X\xb5+}\xcd\xf6\xbb(J\bG\xc2\xad\x95 Kn \x9do\x96s\xce\x10\x1d\xed\x04\xe6Vx\xd1@\xad\xa5\xcd\xdc\xd2\xdb7", 0);
    return 0;
  }

  if(isDefined(suppress_print)) {
    saveid = savegamenocommit(filename, &"autosave/autosave", ")S,\x84\x94\xc8j_", 1);
  } else {
    saveid = savegamenocommit(filename, &"autosave/autosave");
  }

  autosave_print("!\x80p\x9eei\x82\x14SL|\\\x92\x95\f\x88r)\xf1H\x93\xcdp\x88\x8a$\x8c", undefined, saveid);
  level.var_82dc2bf2d2ab50ee = gettime();
  wait 0.05;

  if(issaverecentlyloaded()) {
    autosave_print("\xf1\x92\n5G#\xac\x04E\xdeJ4^r\x9d\x9c aB\xbc\x19\xe6#\x83\xc0^57\xe6Bt\xac\xe0\x82\x90k>ra\"\xc6\xed\xa5\x1d", 0);
    level.autosave.lastautosavetime = gettime();
    utility::flag_clear("\xd9\xcb\xad\xc9R\xe39#r\xd4E");
    return 0;
  }

  if(isloadinganytransients()) {
    autosave_print("\xbff\x0fj\xbe\xcce\x1e}\x97^\x8e(; \xb4\xbe\xed\x1a'\x9c\xc0k\xd4\xc7\x80\xfe6\xf4\xac\xbb\xb0\xa6Q\xf7>F\xe1\x13\xdb\x122\xa5\xad\x9a\xba\xef\x1b#\x17\xf7\x89\xcb\x8d7Y\x03e", 0);
    utility::flag_clear("\xd9\xcb\xad\xc9R\xe39#r\xd4E");
    return 0;
  }

  if(saveid < 0) {
    autosave_print("\xd4^\x0e\t6&a\x8b;\x87\xfc\x91\xcb\xe5@\xae\x82]\xc6\x05\x80t\xe6k\xfa\xce\xd5\b\x81\n\xf4", 0, saveid);
    utility::flag_clear("\xd9\xcb\xad\xc9R\xe39#r\xd4E");
    return 0;
  }

  if(!try_to_autosave_now(saveid)) {
    utility::flag_clear("\xd9\xcb\xad\xc9R\xe39#r\xd4E");
    return 0;
  }

  assert(!istrue(var_3d8305e830b3fdb8) || istrue(level.var_39850f92b12d70e0), "<dev string:x64>");

  if(istrue(var_3d8305e830b3fdb8) && istrue(level.var_39850f92b12d70e0)) {} else {
    wait 2;
  }

  utility::flag_clear("\xd9\xcb\xad\xc9R\xe39#r\xd4E");

  if(isloadinganytransients()) {
    autosave_print("\xf0\xdc\x8eD\xf0\x9b}\x17\x1e'\xe5\xfe\x9d\x01\xf4\xbay\xe6\xdb\xd2a\xc0\x7ft[7\x86\xf2\xcbd\x90tnL\xea\x17&{\b\f\x99\xce\xa0e\xb8\xdfqA\xac\xa8\xc171/XB\x0eA", 0);
    return 0;
  }

  if(!commitwouldbevalid(saveid)) {
    autosave_print("O\xe0\xf8\x8e\xa5!\x95x\xe0e\x86\xddFp%\xd8\xccL\xbad\xd7-\x95\xf8\xe0\xa4\xbd\xc5\x06\xea\xa06\xb4\x88\xd0*\x8d\xc1\xeep\xe0\x0e\xbaE \xd8\xbc\x8c\xda\xeeP\\\xcd\x1e\xdd`\xd8\x9c%\xb5\x9c@\xfa\x16\xb6@\xea\xb8U\xc5\x9ex\xd8\xe5\xde\xf7l\xb8t\x80\x04\x94\x90\xbc\x9d", 0, saveid);
    return 0;
  }

  if(try_to_autosave_now(saveid)) {
    autosave_print("N\r\xb7\xb1A\x1bF\x0f[\xf1e]\x82\b\xe4\xb9\f\xe9H\xc1:\x0fP\x94\x7f\xa4\xaf\x87`\x13", 1, saveid);
    commitsave(saveid);
    level.player setplayeryolostate(0);
    setDvar(@ "hash_228e280524e6d278", "\xfe");
    gameskill::auto_adjust_save_committed();
  }

  return 1;
}

function autosave_now_trigger(trigger) {
  trigger waittill("\x91`\xb1\xe7T\x97>");
  utility_sp::autosave_now();
}

function try_to_autosave_now(saveid) {
  if(!issavesuccessful()) {
    return false;
  }

  if(!level.player check_health(saveid)) {
    return false;
  }

  if(!utility::flag("\x9b2\xab\x88yvw\xcb")) {
    autosave_print("\xca \xf9'\\oPu\xd2f\xb4&\x92\x9c;\x9btA\xbf\f\x13\x16u", 0, saveid);
    return false;
  }

  return true;
}

function tryautosave(name, description, image, timeout, var_318d7c85ec606d03, suppress_print, tryonce) {
  if(utility_sp::is_trials_level()) {
    return 0;
  }

  if(!isDefined(level.autosavecount)) {
    level.autosavecount = 0;
  }

  autosave_print("T_\xf6>\x83\xdd)\xdf/\x1d<F\xc1z\xc8\xe1\x94Q^1Ni\xcc\x9e<\x03!\xfd" + name, 2);

  if(gettime() < 3300) {
    autosave_print("qK\x06\x97\x1fL\xb4\x147)iK\x17\x92*(\xe8\xdae\xdaJ0PFqLM\x9f\xa0\x05\xca@\x14\xca\xc6\xe9\xbe\x1c\x14#\xb1\x94\xd1\x9f\xc3\x06\xeaIH\xda\xc7\xfa\x1e\xc9u5@\x109\xdee\xd6.0@Z\x06e/\x8d\xa8U\xd1$\xc9\x1e\xea\xc5\xda)\x18\x1b\xc6", 0);
    return;
  }

  if(utility::flag("Y\xa6\xfc>`H\xdaL\xe5\x0fK\x9f\a\xe7\x05\x1d\xa7")) {
    autosave_print("\xc7q[\t8\x8dE\b\xc0\\\x9c\x8f\x0f\x0e\xa1DD\xad\x9b\x01\xd9\x96A\xd5\xc4[\xf7<\xcdj\xe5\x80", 0);
    return 0;
  }

  level endon("Bd2\xaa\xa2}2\xb13\xf4\xf5");
  level.player endon("\x1e\xfd\xd1\xa2\a");

  if(utility::flag("\xd9\xcb\xad\xc9R\xe39#r\xd4E")) {
    autosave_print("c3\xb09#U\xb7/\xdf\xbd\xf5\xbe\x19\"\xf9^\xadI)\xb3\xba\xacS\xd3\xcfy\xab\xe2\xc8H\xe3U\xb7\x03+{\xd3\xa9\xd9\xf7\xc3\xff\xce\x8b\xc9s\xa9\x9dmp", 0);
    return 0;
  }

  level notify("c\xa3\x10\x93?\xfcc\xf02i\xf2\xe4\x17K\x8c\xb26\xca\v");

  if(isDefined(level.nextmission)) {
    return 0;
  }

  time0 = 0.05;
  time1 = 1.25;
  time2 = 1.25;

  if(isDefined(timeout) && timeout < time0 + time1 + time2) {
    assertmsg("<dev string:x94>" + time0 + time1 + time2 + "<dev string:xda>");
  }

  if(!isDefined(suppress_print)) {
    suppress_print = 0;
  }

  if(!isDefined(image)) {
    image = ")S,\x84\x94\xc8j_";
  }

  if(!isDefined(var_318d7c85ec606d03)) {
    var_318d7c85ec606d03 = 0;
  }

  utility::flag_set("\xd9\xcb\xad\xc9R\xe39#r\xd4E");
  var_def149d15b49fc6a = gettime();
  trycount = 0;
  result = 0;
  timeout_time = undefined;

  if(isDefined(timeout)) {
    timeout_time = gettime() + timeout * 1000;
  }

  while(true) {
    if(utility::flag("Y\xa6\xfc>`H\xdaL\xe5\x0fK\x9f\a\xe7\x05\x1d\xa7")) {
      autosave_print("\xeb87xA\x941\x92Ce\x9b\x02\xceT\xb9\x9d^\x8b\xa2\xa8j\xecY\x85d6x\xd1\xe3\xa7\xa7~\\\x94j\xb3", 0);
      break;
    }

    if(istrue(tryonce) && trycount > 0) {
      autosave_print("\xab\x15\xfe\xcfa\xc5X\xac\x9b\xb6\x9c\n\xe4\x8a\xd4}\xdc\xf3\xdf\xa6?\x04\xe9{\x19'\x82P\xa0rs\xf1\xefyg", 0);
      break;
    }

    if(isDefined(timeout_time) && gettime() > timeout_time) {
      autosave_print("E\x03\xbe5vD\xb4\x11\xdc\xd0\xcf\xf8q\xbbO\xf3o\xc3\x8f\xb7\v\xddQ\xae=\xf3.2.\xfa\xa5AH\xe6\x9c[\x1fW|" + gettime() - var_def149d15b49fc6a + "\x06\xb4-\n@d\xb7\xeb\"\x1fU\xb3T", 0);
      break;
    }

    trycount++;

    if(autosave_check(undefined, var_318d7c85ec606d03, undefined)) {
      waitfortransientloading("U\xbfAC\xc1A7.\xbbh\x8c\xeeq");

      if(getdvarint(@ "map_reloading") != 0) {
        autosave_print("t\x9f6\x1d\x95\a\xa3\xc2\xce\xd6\x1d\x82e\xc14\x04\xa4\x84\x90\xff\xee\xe0\xd8\x0f56lV\xb8L\x88w", 0);
        break;
      }

      if(isDefined(level.nextmission)) {
        autosave_print("/w\xacdV\xd6H\xef\xbf\v\x86\x81\xda.rX\x14\xdd\x83\b\xde\xdcGuO\xd0\xce\xe0e]\xed\xea\xef\xb3\a\xc9\x8e.\x80\xe5\xbe\x12!", 0);
        break;
      }

      if(extra_autosave_checks_failed()) {
        if(isDefined(timeout_time) && gettime() > timeout_time) {
          autosave_print("E\x03\xbe5vD\xb4\x11\xdc\xd0\xcf\xf8q\xbbO\xf3o\xc3\x8f\xb7\v\xddQ\xae=\xf3.2.\xfa\xa5AH\xe6\x9c[\x1fW|" + gettime() - var_def149d15b49fc6a + "\x06\xb4-\n@d\xb7\xeb\"\x1fU\xb3T", 0);
          break;
        }

        autosave_print("s\x01i\xd9[\xd8\x95:5\xc4\x9f\ta9V\xe0\\!y\x1ec\xf84\xb28\x12)\xecE\x80\xf0O\xa0\xb9\xa2\xdet=\t|\xbf\x17", 0);
        wait time1;
        continue;
      }

      saveid = savegamenocommit(level.autosavecount, &"autosave/autosave", image, suppress_print);
      autosave_print("\x8e\xc9\x97\x14u\x1d\xde5avV\x05)\x04\xa6a\xb3\xa5s\xd9\x04\xdc\xb7\b\x8d\xf6k\xadZ\xd1", 2, saveid);
      level.var_82dc2bf2d2ab50ee = gettime();

      if(saveid < 0) {
        autosave_print("\xabt\x91\xd9\x18}\xd7\x9f+Ri\rf(\xa4n\xaaD\xc8O\xe5|\xc3\xdf", 0, saveid);
        break;
      }

      wait time0;

      if(isDefined(timeout_time) && gettime() > timeout_time) {
        autosave_print("E\x03\xbe5vD\xb4\x11\xdc\xd0\xcf\xf8q\xbbO\xf3o\xc3\x8f\xb7\v\xddQ\xae=\xf3.2.\xfa\xa5AH\xe6\x9c[\x1fW|" + gettime() - var_def149d15b49fc6a + "\x06\xb4-\n@d\xb7\xeb\"\x1fU\xb3T", 0);
        break;
      }

      if(issaverecentlyloaded()) {
        autosave_print("Vdz\xbb\x95c\xaf\xed\xf8\xae\x11\x94\x87_\x7f\xe5\xe458>\xd9$\xd1w\x9d\xb4y\xdd\x9d\x8a\x88\r\x15DE\xb4\x1b", 0);
        level.autosave.lastautosavetime = gettime();
        break;
      }

      if(isloadinganytransients()) {
        autosave_print("\xf7\xe7\xc0\xe3\xe6C\x87q\xc0P6\x9e\xd58\xaeb)\x13\xbd\xfd\xaf4T\x87`\xfc4Z\x7f\x7f\x02\xd1Q@FY\x95\x14RW1\xf2\x06o4z\xf4\xdam\x01P", 0);
        continue;
      }

      wait time1;

      if(isDefined(timeout_time) && gettime() > timeout_time) {
        autosave_print("E\x03\xbe5vD\xb4\x11\xdc\xd0\xcf\xf8q\xbbO\xf3o\xc3\x8f\xb7\v\xddQ\xae=\xf3.2.\xfa\xa5AH\xe6\x9c[\x1fW|" + gettime() - var_def149d15b49fc6a + "\x06\xb4-\n@d\xb7\xeb\"\x1fU\xb3T", 0);
        break;
      }

      if(isloadinganytransients()) {
        autosave_print("A\xd7\x02\xdd\xe6\xa5Y\x19+\xae\xfd\xc3\xda\xf0%\xa0\x01\xcc\xab\r\n\x9c\xb72:\xfb\xff\xcb\xf5\x04q\xf0\xdd\xa3g`6h\x88'\xd3\x12c_\bR\xe5K7J\x9e", 0);
        continue;
      }

      if(extra_autosave_checks_failed(saveid)) {
        continue;
      }

      if(!autosave_check(undefined, var_318d7c85ec606d03, saveid)) {
        autosave_print("\x12Q*\xbe\xbe\x1e9f\x0eR\xf9+i[\xe4\xcc\xd0 \xc1\x83\x8d\x8f\xc7\xaca\x05KG\xc6\xe3\x98_KU\xfa\xdcS;\xcaGA\f.\x06\xbbD\xe7\xb3\xd6\x93\xf4\x86\xad\x88\xa4\x8a", 0, saveid);
        continue;
      }

      wait time2;

      if(isDefined(timeout_time) && gettime() > timeout_time) {
        autosave_print("E\x03\xbe5vD\xb4\x11\xdc\xd0\xcf\xf8q\xbbO\xf3o\xc3\x8f\xb7\v\xddQ\xae=\xf3.2.\xfa\xa5AH\xe6\x9c[\x1fW|" + gettime() - var_def149d15b49fc6a + "\x06\xb4-\n@d\xb7\xeb\"\x1fU\xb3T", 0);
        break;
      }

      if(isloadinganytransients()) {
        autosave_print("\xe89^(u\x8e\xdb5\v\xd9e\x14%\b\x1dNXn7\xd2e\x9b: \x96\xdc\x02c\xf6\xb0F\x96s;a\x01\x9c\xb2\x1d\xc9\xf2\xa5\xcdg\x80\xa0\x99R\\.\xb8", 0);
        continue;
      }

      if(!function_212fb9608d564b14(saveid)) {
        autosave_print(",_\xb1&\xc5u\np%g\xf8S'\x13\xe6O\xf6\xac\x1e\x18@\xe6t\v!\x91\xfa9\xb8\xf3\xa0\xecG\xd9\xed\x90\x95\xfa)\x12\xc4\xa6\n\xcc:N\x99\x7f\xc6\xa6\xda\x10\x88g\xeb", 0, saveid);
        continue;
      }

      if(!utility::flag("\x9b2\xab\x88yvw\xcb")) {
        autosave_print("\x9f1Q\xa7\xcd\xc2o\x1d\x1cs\x99\x8a^2%\xd2\x18\xa8lQ\x8b\b\x97\xc7\x8d\x16\xfa$\xf3\xb8\x02\"` \x88\xd3\x12", 0, saveid);
        break;
      }

      if(!commitwouldbevalid(saveid)) {
        autosave_print("\xc7\xe8\xe6\xf9\xa9\x89\xddM\xfa\xf9\xbc\xf1\xbfn!\xb3MA\x89\xd0t\xa7\x9d\xae\x80\xc3\xf1\x8dO\xb4o\x9a\tl\x94@O\x9e\xd0|~\x9b\x0evk\x97L\x7f\xe3a!Y|\v\x85\xd2\xc8+z\x048\x1b\xafu\xb9\xdb\xc0\x1a\xd4\x1f\xbaF\xef\xfbT\xe9KO", 0, saveid);
        utility::flag_clear("\xd9\xcb\xad\xc9R\xe39#r\xd4E");
        return 0;
      }

      if(utility::flag("Y\xa6\xfc>`H\xdaL\xe5\x0fK\x9f\a\xe7\x05\x1d\xa7")) {
        autosave_print("\xa2\f\xa4\xf8t\xb8A?\x10H\xe1k\xc0\xfcKj\xfa`1\"\xf30\x80\xdcJ^/c\x06KM\xe2\xee\x06\xbc\xab", 0);
        break;
      }

      result = 1;
      autosave_print("Z\"\xd3\xfa2\x0f\xcf\xad\xf75\xebc\xa2\xe4\xcb\xc3\rt\xecciv\x86", 1, saveid);
      commitsave(saveid);
      level.player setplayeryolostate(0);
      level.lastsavetime = gettime();
      setDvar(@ "hash_228e280524e6d278", "\xfe");
      gameskill::auto_adjust_save_committed();
      break;
    }

    wait 0.25;
  }

  utility::flag_clear("\xd9\xcb\xad\xc9R\xe39#r\xd4E");

  if(isDefined(result) && result) {
    level.autosavecount++;
  }

  return result;
}

function isprogressionlevel(mapinfoname) {
  levelindex = endmission::getlevelindex(mapinfoname);
  return isDefined(levelindex);
}

function waitfortransientloading(prefix) {
  level endon("c\xa3\x10\x93?\xfcc\xf02i\xf2\xe4\x17K\x8c\xb26\xca\v");
  nextprinttime = 0;

  if(waspreloadzonesstarted()) {
    while(!ispreloadzonescomplete()) {
      if(gettime() > nextprinttime) {
        autosave_print(prefix + " \xd5\x16\x96\x8e\xa5s; \xcc\xdeN\x04P'+co\xc2#@\x1d\xbd\x10\xc6o\xb5\x1c6+GY\x8b\xc5\x8b", undefined);
        nextprinttime = gettime() + 2000;
      }

      wait 0.05;
    }
  }

  while(isloadinganytransients()) {
    if(gettime() > nextprinttime) {
      autosave_print(prefix + "\x80\xea,\x96GZ\xcdv\x04f{\x93\x01\xd1rXs7Z\xb2\xcd:\x80\xd1\xed\x016\xf6\xc2F\xe2\xb8\\", undefined);
      nextprinttime = gettime() + 2000;
    }

    wait 0.05;
  }

  return true;
}

function extra_autosave_checks_failed(saveid) {
  foreach(func in level.autosave.extra_autosave_checks) {
    if(![[func["\xccu\xcd\xc6"]]]()) {
      autosave_print("i\a\xed\xd0\xa7x\x02\x88\x88\xc2.\xc5s\xdf\xa0\xed\xdd\x17\xfcT\xd6\xb9" + func["\xd5\xc0\xe9"] + "", 0, saveid);
      return true;
    }
  }

  return false;
}

function function_212fb9608d564b14(saveid) {
  return autosave_check(0, 0, saveid);
}

function autosave_check(var_e47be37c8d7a2950, var_318d7c85ec606d03, saveid) {
  if(isDefined(level.autosave_check_override)) {
    autosavecheckparams = spawnStruct();
    autosavecheckparams.var_e47be37c8d7a2950 = var_e47be37c8d7a2950;
    autosavecheckparams.var_318d7c85ec606d03 = var_318d7c85ec606d03;
    autosavecheckparams.saveid = saveid;
    return [[level.autosave_check_override]](autosavecheckparams);
  }

  if(isDefined(level.special_autosavecondition) && ![[level.special_autosavecondition]]()) {
    autosave_print(";\xfd\xd3\xb16\xf9\xa5\x16\x15\xb9\xb8\xb5\xb1TD\x1c\xb2\xf4\xf5\xf1\xe5\xb9Q\v\x04\x83[\xcb\x11q\xfb9:\xc9\x90(\xe3[\xbb\x03\xb3\tY\xa5\xa1\xd4\xda9", 0);
    return 0;
  }

  if(level.missionfailed) {
    return 0;
  }

  if(!isDefined(var_e47be37c8d7a2950)) {
    var_e47be37c8d7a2950 = level.dopickyautosavechecks;
  }

  if(!isDefined(var_318d7c85ec606d03)) {
    var_318d7c85ec606d03 = 0;
  }

  if(var_318d7c85ec606d03) {
    if(![[level.global_callbacks["\x90\x9b\x95]\xe5\xbdwU\x18MB(G\x88}\xce\x0f{b\xc9\ne"]]]()) {
      return 0;
    }
  }

  if(!level.player check_health(saveid)) {
    return 0;
  }

  if(var_e47be37c8d7a2950 && !level.player check_ammo(saveid)) {
    return 0;
  }

  if(level.autosave_threat_check_enabled) {
    if(!function_960a16afd8552af4(var_e47be37c8d7a2950, saveid)) {
      return 0;
    }
  }

  if(!level.player check_player(var_e47be37c8d7a2950, saveid)) {
    return 0;
  }

  if(!level.player check_friendlyfire(saveid)) {
    return 0;
  }

  if(level.player function_6be668d1abc9d2e9()) {
    return 0;
  }

  if(level.player killstreaks::getkillstreakinuse()) {
    autosave_print("8Tu\ak\x19\xaf\xfdj?\xd8\x031\xa8\x15J\x9b\xa6\x9e@o\xfc:T=?,W)@\xe3\xc2\xff\xe8\x1e\xd4\xc4S\x8a\xf6#\xce\x8b\x9bY", 0);
    return 0;
  }

  if(!issavesuccessful()) {
    autosave_print("\x04Y{pe\a\xd8\xcdydi\x8f3z\xc0}6\xea\xcb\x18\xf3\xdf\xc3\xcb\xcf\xe2\x18n\xb0\x82\xf6\xfb\x1a\xd2\x9f\xaa\xb7\x14\x82\"\xcc\xc0", 0, saveid);
    return 0;
  }

  return 1;
}

function check_player(var_e47be37c8d7a2950, saveid) {
  assert(isPlayer(self));

  if(self ismeleeing() && var_e47be37c8d7a2950) {
    autosave_print("@FM4z\xba+\xceF^\n)\xb3\\+\x1b\xec\xad", 0, saveid);
    return false;
  }

  if(istrue(self.in_melee_death)) {
    autosave_print("1\v\xb2\xc10R3lv\x03T\x87d2\x87\x0f\x15-\xfeQd\xf5>ud\x1e", 0, saveid);
    return false;
  }

  if(!function_77377fc7e9431cec()) {
    autosave_print("W\x02\x05!\x88g\xbdn)\xe1\x94\x15Y\xa0\xa1\x8e\xd2\xc1\x11%\x1f~\xe5NC\xf1 \xac", 0, saveid);
    return false;
  }

  if(isDefined(self.shellshocked) && self.shellshocked) {
    autosave_print("Ib\xbf4K5\xa5\x05\xeb\x9f\xbe\xa0-R\x14\xfd~\x8f\"*0\xf4\x86", 0, saveid);
    return false;
  }

  if(utility::isflashed()) {
    autosave_print("E\x100hwz\x1b0\x11[\x8fl\xb0\xb1\x14l\\\f\xb4ux", 0, saveid);
    return false;
  }

  if(self isswimming()) {
    if(swim_common::isbreathcritical()) {
      autosave_print("oKm\x9e8 ~\xde\x12dF\xd1(\xba\xb3\x97\xcex\n\x93\xb4~[\xf0el\xa0\x8a\x9eA\xa3[g\x11\x9f$\xf0>", 0, saveid);
      return false;
    }
  } else if(!self islinked() && !self isonground()) {
    if(trace::_bullet_trace_passed(level.player.origin + (0, 0, 5), level.player.origin + (0, 0, -200), 0, self)) {
      autosave_print("#\xf0'\x96\x1b\xe8\x8c\xe7\x16|{\xeb\x8b\x13\xd9\x8asvk\x84\x82\xf9U\x85-2\xebOmv{\xf1b", 0, saveid);
      return false;
    }
  }

  return true;
}

function function_77377fc7e9431cec() {
  if(!self isthrowinggrenade()) {
    return true;
  }

  offhand = self getheldoffhand();

  foreach(allowed_offhand in level.autosave.allowedoffhands) {
    if(offhand.basenamehash == allowed_offhand) {
      return true;
    }
  }

  return false;
}

function function_6be668d1abc9d2e9() {
  currtime = gettime();

  if(isDefined(self.last_unresolved_collision_time) && currtime - self.last_unresolved_collision_time < 500) {
    return true;
  }

  return false;
}

function check_friendlyfire(saveid) {
  nades = getEntArray(",\xe1\x93So\x98\r", #classname);

  if(nades.size == 0) {
    return true;
  }

  playernades = [];

  foreach(nade in nades) {
    if(isvalidmissile(nade) && isPlayer(getmissileowner(nade))) {
      playernades[playernades.size] = nade;
    }
  }

  if(playernades.size == 0) {
    return true;
  }

  if(function_af9e95c26220b02e(playernades)) {
    return true;
  }

  allies = getaiarray("O\x15\x1b\xad\x9ff");

  foreach(ally in allies) {
    foreach(playernade in playernades) {
      if(distancesquared(ally.origin, playernade.origin) < 6400) {
        autosave_print("\v\xf8\xd7\"\xd6\xc1\xb1\xd2\xba%\x90\x10z\xdb\xdbH\xef\xfa\x17{\xd3\x90\xc7\x12\x1fbH\xb9\xf1\xd6\xf9HK\x98S\x12\x93!\xcbv[5\x993Z\xb4\xd2Kj\xbb5{\xb8s\xb6v\xba!\x80\x10\x02\xd5\xdb\n\x8b8", 0, saveid);
        return false;
      }
    }
  }

  return true;
}

function function_af9e95c26220b02e(grenades) {
  foreach(nade in grenades) {
    if(utility_sp::offhand_is_dangerous(nade)) {
      return false;
    }
  }

  return true;
}

function check_ammo(saveid) {
  assert(isPlayer(self));
  weapons = self getweaponslistprimaries();

  if(weapons.size == 0) {
    return true;
  }

  var_f6adff1b44cfc42d = 1;
  highestfrac = 0;
  classname = "";

  foreach(weapon in weapons) {
    if(isnullweapon(weapon)) {
      continue;
    }

    if(weaponmaxammo(weapon) > 0) {
      var_f6adff1b44cfc42d = 0;
    }

    myclip = self getweaponammoclip(weapon);
    maxclip = weaponclipsize(weapon);
    mystock = self getweaponammostock(weapon);
    maxstock = weaponmaxammo(weapon);
    myammo = myclip + mystock;
    maxammo = maxclip + maxstock;

    if(maxammo <= 0) {
      continue;
    }

    myfraction = myammo / maxammo;
    fractioncompare = level.autosave.var_ca19dc257040899a;

    if(myfraction > highestfrac) {
      highestfrac = myfraction;
      classname = weapon.classname;

      if(weapon.classname == ",\xe1\x93So\x98\r" || weapon.classname == "\x03\xb0\xa1\xa9\x04\xac\x88\x82\x88\x18\xb6\xed\xe1\x82") {
        fractioncompare = 0.5;
        classname = "g%\x0f\x95\xc3\xea\b\xae\xfd";
      }
    }

    if(myfraction >= fractioncompare) {
      return true;
    }
  }

  if(var_f6adff1b44cfc42d) {
    return true;
  }

  autosave_print("\x1ccW[\xb3\x01\x1a>\v\x96d\xd0^}\x0f\xb4lz\xc4\x11|\x10\xadO$:x\x80\xc3\xdb\x10\xee\xe5\xfb" + highestfrac + "\xbew\xd2hZ" + classname + "\xc4\xdcBL_ %'r\xc4\xd0y\x97\xcav\xc1\v\xc1\x80\xb7\xb1m8\x8fv", 0, saveid);
  return false;
}

function function_60160e4aaeaa172f(frac) {
  level.autosave.var_ca19dc257040899a = frac;
}

function function_ed64cd2e034dc0ec() {
  level.autosave.var_ca19dc257040899a = 0.0714286;
}

function check_health(saveid) {
  assert(isPlayer(self));

  if(player_sp::belowcriticalhealththreshold()) {
    autosave_print("\x7f\x97\x8a\xef!A\x9e\xbf\xd5\x94v\xe0\x11/\x96>N_\x1f\f\x7fx`\xa8j\xd3\x84\xedu\xc3\xc0\x0f?T\xa7\x1d\x01i^\xa9\xa2", 0, saveid);
    return false;
  }

  if(istrue(self.damage.firedamage)) {
    autosave_print("a\xc5\xce(\xe3\xb4\x7f\xdb\xd8AZd\xd7\xb1\x1d\xb4RI", 0, saveid);
    return false;
  }

  if(self isonladder()) {
    autosave_print("kd\xd0\x7f2\x9eM_'\xcdh\x12\x19\x8cV:8J\x84\x1e\x1b\x85\x18.\x1alV\xa2\xb6\xd1", 0, saveid);
    return false;
  }

  return true;
}

function function_960a16afd8552af4(var_e47be37c8d7a2950, saveid) {
  enemies = getaiunittypearray("\x9a\x1f\x83\x1bs=\x13\xf8", "\xc0\xc6J");

  foreach(enemy in enemies) {
    if(isDefined(level.player.stealth) && isDefined(enemy.stealth) && enemy getthreatsight(level.player) > 0) {
      autosave_print("\x06\xfe\xb6\xbf" + enemy getentitynumber() + "\x8c>&\x97\xee0\x16v\"G\xc5\x1e\x14F+\xc4\x04;W\xd1\x1e\xc5\a\xa6\"\x96I\b\xd77\x1e\x0e9\x1eG\x86", 0, saveid);
      return false;
    }

    if(!isalive(enemy.enemy)) {
      continue;
    }

    if(!isPlayer(enemy.enemy)) {
      if(level.autosave.enemydistcheck && enemy function_65092551c3fafd5c()) {
        autosave_print("G\xa6\x7f1\xa3\xe3Bs[j\xaa%\x1d\f\x86o\xba0-\xb5R\x91$\xa0O\x03", 0, saveid);

        if(getdvarint(@ "hash_6af159684591cb79")) {
          enemy thread debug::function_7d08b29d5c99f310("<dev string:x110>", (0, 0, 85), 0.8);
        }

        return false;
      }

      continue;
    }

    if(enemy.in_melee && isDefined(enemy.meleetarget) && isPlayer(enemy.meleetarget)) {
      autosave_print("\x06\xfe\xb6\xbf" + enemy getentitynumber() + "\\sB\xd5\xdd\x83\xb1\x8d\xd1\x9c\x97\xc5\xdd\xa7\n&\xc6", 0, saveid);
      return false;
    }

    proximity_threat = [[level.autosave.proximity_threat_func]](enemy);

    if(proximity_threat == "\xca\xf8\xc0\xa1`\x9d\xf7\x1ebuA\xfd\xa1@\xbd\x94\xcf\xd0\xef\xeb\xe3\xe1t\x8aa\xbc\xfa") {
      autosave_print("\x06\xfe\xb6\xbf" + enemy getentitynumber() + "\xd8\xc3.\xbeh]\xe7\x83\xa0y\x1d9\xb5\x0eg\x13 \x89\xf6c\xc6^\x81\xdf\xb8`\xdc\xaf\xff\\\xfa\a\xce_P\xce\xd7k\xc5\x94\x91\xbc\xcc\x1a7\xa1\x95\x9c\x1c\x9bm\x13\xfe6\xe7n\x8cs\x1c", 0, saveid);
      return false;
    }

    if(enemy.baseaccuracy < 0.1) {
      if(getdvarint(@ "hash_6af159684591cb79")) {
        enemy thread debug::function_7d08b29d5c99f310("<dev string:x12c>", (0, 0, 85), 0.8);
      }

      continue;
    }

    if(proximity_threat == "\r+x5") {
      if(getdvarint(@ "hash_6af159684591cb79")) {
        enemy thread debug::function_7d08b29d5c99f310("<dev string:x138>", (0, 0, 85), 0.8, (0, 1, 0));
      }

      continue;
    }

    canshootandsee = undefined;
    shotrecently = enemy._blackboard.shootparams_lastshoottime > gettime() - 1500;

    if(shotrecently) {
      canshootandsee = enemy function_be412989018fe750();

      if(canshootandsee) {
        if(getdvarint(@ "hash_6af159684591cb79")) {
          enemy thread debug::function_7d08b29d5c99f310("<dev string:x143>", (0, 0, 85), 0.8, (1, 0, 0));
        }

        autosave_print("\x06\xfe\xb6\xbf" + enemy getentitynumber() + "\xc0\xe9y\xd0\x87\x87\xce@r\xd7\xe0\xa85\xeb\xec:\xed\x89", 0, saveid);
        return false;
      }
    }

    if(!isDefined(canshootandsee)) {
      canshootandsee = enemy function_be412989018fe750();
    }

    if(canshootandsee && isDefined(enemy.asmtrackasm)) {
      if(enemy asm::asm_currentstatehasflag(enemy.asmtrackasm, "\xb5\x10\xb9")) {
        if(getdvarint(@ "hash_6af159684591cb79")) {
          enemy thread debug::function_7d08b29d5c99f310("<dev string:x159>", (0, 0, 85), 0.8, (1, 0, 0));
        }

        autosave_print("\x06\xfe\xb6\xbf" + enemy getentitynumber() + "\x9f\x9a\xfe^\xaaRJ\xd3\xda?\xec\"m\xbaP_\a\b", 0, saveid);
        return false;
      } else if(enemy asm::asm_currentstatehasflag(enemy.asmtrackasm, "\x1e\x97\x86\xd0\xf5\xda\xaf\xf9\xdb\xf7\xc5'")) {
        if(getdvarint(@ "hash_6af159684591cb79")) {
          enemy thread debug::function_7d08b29d5c99f310("<dev string:x173>", (0, 0, 85), 0.8, (1, 0, 0));
        }

        autosave_print("\x06\xfe\xb6\xbf" + enemy getentitynumber() + "\x8b\x7fS\xb0 o !\x83\xc0\xa8\xa8\xf4\x14\x93v\x1a\x89\xe7a\xfcr\xeb\x0f", 0, saveid);
        return false;
      }
    }

    if(getdvarint(@ "hash_6af159684591cb79")) {
      enemy thread debug::function_7d08b29d5c99f310("<dev string:x193>", (0, 0, 85), 0.8, (0, 1, 0));
    }
  }

  if(utility_sp::player_is_near_live_offhand(1)) {
    return false;
  }

  if(isDefined(level.phys_barrels)) {
    foreach(barrel in level.phys_barrels) {
      if(!isDefined(barrel.onfire)) {
        continue;
      }

      if(barrel.subtype == "\x1e\xab\xe8\x92\x01\xc9\x9b\x1c") {
        continue;
      }

      if(distancesquared(barrel.origin, level.player.origin) < 122500) {
        autosave_print(barrel.subtype + "z+\xef\xc0M\xc3%L\x8a-\xbc\x86A}I\xba\xbe\x06jL\x97\x90\xfa\x1eH\xcc|d\x86Qo\x9f\xb8\xc5\xe5\x16'\xed\xa9\x98v", 0, saveid);
        return false;
      }
    }
  }

  vehicles = getEntArray("X\xf2Z\x1b\xc3\x03\xb9\xee\xd1\x95", #code_classname);

  foreach(vehicle in vehicles) {
    if(!isDefined(vehicle.destructible_type) || vehicle.destructible_type != "\xb3VC-\xc6c\xb2") {
      continue;
    }

    if(!isDefined(vehicle.onfire)) {
      continue;
    }

    if(distancesquared(vehicle.origin, level.player.origin) < 160000) {
      autosave_print("^-\x9a\xf6\xf9\xe3D\xb9\xabcp$\x94g\xda\xcd\xdf|y\xbe\xd6\xef\x95-(\x11m\x9d\xa6\xc6G", 0, saveid);
      return false;
    }
  }

  return true;
}

function function_65092551c3fafd5c() {
  if(self.enemy vehicle::is_vehicle()) {
    return false;
  }

  if(distancesquared(self.enemy.origin, level.player.origin) < 4900) {
    return true;
  }

  if(self cansee(level.player)) {
    disttoenemy = distancesquared(self.enemy.origin, self.origin);
    disttoplayer = distancesquared(level.player.origin, self.origin);

    if(disttoplayer <= disttoenemy + 10000) {
      return true;
    }
  }

  return false;
}

function function_be412989018fe750() {
  return utility_common::canseeenemy(0) && self canshootenemy(0);
}

function autosave_proximity_threat_func(enemy) {
  foreach(player in level.players) {
    dist = distancesquared(enemy.origin, player.origin);

    if(dist < 10000) {
      return "\xca\xf8\xc0\xa1`\x9d\xf7\x1ebuA\xfd\xa1@\xbd\x94\xcf\xd0\xef\xeb\xe3\xe1t\x8aa\xbc\xfa";
    }

    if(dist < 129600) {
      return "\\\x1c\x17\xaa'!";
    }

    if(dist < 1000000) {
      return "\x8e\x02\xb4\xc0\x0e\xa33\xc0\xf5be\xe9\x10";
    }
  }

  return "\r+x5";
}

function function_49fdd89300af9173() {
  setdevdvarifuninitialized(@ "hash_625a91d4e43b3929", 0);
  setdevdvarifuninitialized(@ "hash_ddef8331337d5977", 0);
  wait 1;
  adddebugcommand("<dev string:x1a0>");
  adddebugcommand("<dev string:x1df>");

  while(true) {
    if(getdvarint(@ "hash_ddef8331337d5977", 0)) {
      thread save::clear_all();
      waittillframeend();
      setDvar(@ "hash_ddef8331337d5977", 0);
    }

    if(getdvarint(@ "hash_625a91d4e43b3929", 0)) {
      setDvar(@ "hash_625a91d4e43b3929", 0);
      thread utility_sp::autosave_now();
    }

    waitframe();
  }
}

# /