/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player\carrylinked.gsc
*********************************************/

#using script_758eb3e6844a19b3;
#using scripts\common\anim;
#using scripts\common\animbank;
#using scripts\common\system;
#using scripts\common\values;
#using scripts\common\weapon;
#using scripts\engine\hud_management;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\player;
#using scripts\sp\player_rig;
#using scripts\sp\utility;
#namespace carrylinked;

function private autoexec __init__system__() {
  system::register(#"carrylinked", undefined, undefined, &post_main);
}

function private post_main() {
  setdvarifuninitialized(@ "hash_fd7caa2c943ccc6b", 0);

  setdvarifuninitialized(@ "hash_f658223ce6bbaf98", (0, 0, 0));

  setdvarifuninitialized(@ "hash_17b26f736c51d168", (0, 0, 0));

  setdvarifuninitialized(@ "hash_c908557a5b521024", 0);

  setdvarifuninitialized(@ "hash_d95a4ea1693f2bcb", 0);

  level.carrylinkedcollisioncontents = physics_createcontents(["H\xe6\xe2\xa0\xf8\x8d\xd1\x84\xe4\xb8-\x99X\x884=\xd4\xe0$\xb8\xb9\xa5\xe9\xb7\f\xc9%\xca\xd8\xe4", "vr\xdd]2\xa6 2\v\x0e\xb3Cd\xf9\x8e\x90\x84\xd7r\xde^;CE\x82\xb3", "\xb3 c1\xa3\xab\x05/\x96c\xec\x02~5\a\xadz\xb9\xe6\xd8B", "Y\xa2\x89;`\x02\xd59\xb8t\xe8q\x92)\x89\xb8\x7f\x8a\n\xd0\xd0t", "M\xdb^{\xbe\x7fQ;\xe3\x1f\vB\xd5~\x8aE\xdc\x95\x02\xf3\xd1\xafc\xc9\xde\xdb\n"]);
  level.carrylinkedvals = ["\x86X7\x8c\xdc", "\xc1!\x88V\t\"DW\xfa\xac|\x1d\\", "\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", "\xe1P+\x1a \xe4\xd7-\xeel]", "\xf7~{\xb1\x14", "GX\xa9]\x82", "1x\xc5\xb4\xabx", "\x1d\xf5\x131\xf8", "\x05\xb1\x1c\x86\x11\xc7", "\xe7\x1aM\x85+z\x1b\x89\x0fU9", "\xac\x95\x19\x10S\x94uU\x8e\xc7", "\xa8&s\x87\x1b^\xb0\xff:", "\x9a\xe3\xe4\xff\x81%", "K\x80\xde\x10\xf9l\xa7u\xe0\xb3\x18\xd5\xe8\xd2\x83e\xfa(\xdd\xe9\xfe\xc3\xf4", "{\xe0U\x19:$\x9d\\RI\x9e\xb5\xea\x7fs\x81^t\x84\xba\x1ff.:", "\xaf\xd7\xe5h\xeb+", "mV\x8d+e", "\xdfv\xca\x10\xffSH\xd00S#\x9d\x12;7\x17C'\xbb", "\xde\xfe\xb2", "\x9ct\n\x94\t\x10", "\xbb\xca,8\xdbn\xf5\x9b\xdd-\x8ec\xd0\xd7c\xb1\x96\a", "/Z\xf4]&\x16\xc1\x9b7\x9d\x1a\xdb\xd9\x10\x81\x84", "y\xec\xfb2\x97\x904\xb9\xd7aMa\x1a"];
}

function begin(carrylinkedasset, entity, reloadgesture = "\xe8\xca\xdb\x92\f\x9a\x871;\x84\x8c\xa4\xed\xea\xcc\xb4\xce\x86\xa4", weaponswaps) {
  assert(isPlayer(self));
  assert(isstring(carrylinkedasset));
  assert(isent(entity));
  player = self;
  bundle = getscriptbundle("\x8b\xaf\x85\xd8\x1b\x03#h\xd6\xc3\v\x8b" + carrylinkedasset);
  player utility::ent_flag_set(carrylinkedasset);

  if(!isDefined(bundle)) {
    assertmsg(carrylinkedasset + "<dev string:x24>");
    return;
  }

  if(isDefined(player.carrylinked)) {
    player end();
  }

  player.carrylinked = spawnStruct();

  player.carrylinked.bundlename = carrylinkedasset;

  player.carrylinked.bundle = bundle;
  player.carrylinked.name = carrylinkedasset;
  player.carrylinked.animbank = [];
  player.carrylinked.animent = [];
  player.carrylinked.animent["\xf9\xcd\xc7A\x8e\x15"] = entity;
  player.carrylinked.animbank["\xf9\xcd\xc7A\x8e\x15"] = bundle.animbankobject;
  player.carrylinked.reloadgesture = reloadgesture;
  player.carrylinked.reloadspeedmult = bundle.reloadspeedmult ?? 1;
  player.carrylinked.weaponswaps = weaponswaps;
  player.carrylinked.var_8ccbc951cdcc0229 = bundle.var_8ccbc951cdcc0229 ?? 1;
  player.carrylinked.var_194575a63d866ad4 = getdvarfloat(@ "player_view_pitch_up");
  player.carrylinked.var_64c95ad29583215d = getdvarfloat(@ "player_view_pitch_down");
  player.var_831432b007ee9fbb = 48;

  if(isDefined(bundle.clamppitchmax)) {
    setsaveddvar(@ "player_view_pitch_up", bundle.clamppitchmax);
    setsaveddvar(@ "player_view_pitch_down", bundle.clamppitchmax);
  }

  if(isDefined(bundle.capturnrateyaw) && isDefined(bundle.capturnratepitch)) {
    player val::set("\xfd\x10\xa1gN\xf2`@\xa3\x14\xce", "\xe7\x92\xbf\x14\xb1\xdd\xdct\x03\x04\xb5\xb6\x1b", [bundle.capturnrateyaw, bundle.capturnratepitch]);
  }

  if(isDefined(bundle.suit)) {
    player setsuit(bundle.suit);
  }

  waittillframeend();

  if(istrue(bundle.playerrig)) {
    player.carrylinked.animent["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"] = namespace_6341d8b435bf1728::get_player_rig();
    player.carrylinked.animent["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"] show();
    player.carrylinked.animbank["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"] = bundle.animbankplayerrig;
  }

  foreach(entity in player.carrylinked.animent) {
    if(isDefined(entity)) {
      entity stopanimScripted();
    }
  }

  player link(1);
  player set_carrying(1, bundle.allowads);

  player thread function_bb3c7f14c2d2c08a();

  player anim_play("\x1d\x95S\xfd\xf0\xa8", undefined, 1, "\x1d\x95S\xfd\xf0\xa8");
  player thread anim_monitor();
}

function end(var_795d26a6bbde0b04, dropoverride, earlyragdoll, animlengthoverride, var_f9839a910737506b) {
  assert(isPlayer(self));
  player = self;
  player notify("\xcb\xd5\x19 \x16\xfd\xd7\x012\xb1\xd0\xbcks\xad1\xdfe\x9ds\\\xe3\x1c\x89\xdc");
  player.carrylinked.var_98484be3e8d5d1f = player.origin;
  waittillframeend();

  if(!isDefined(player.carrylinked)) {
    return;
  }

  bundle = player.carrylinked.bundle;
  var_c277eb503d9cc3e6 = undefined;
  player thread level_pitch(var_f9839a910737506b, bundle.clamppitchmax);

  if(!istrue(var_795d26a6bbde0b04)) {
    animbankname = isstring(dropoverride) ? dropoverride : "\x8e\f\xe4I";
    animlength = animlengthoverride ?? anim_length(animbankname);
    player thread anim_play(animbankname, undefined, 1, animbankname);
    objent = player.carrylinked.animent["\xf9\xcd\xc7A\x8e\x15"];

    if(isstruct(earlyragdoll)) {
      animinfo = animbank::function_fe721d46c085d273(player.carrylinked.animbank["\xf9\xcd\xc7A\x8e\x15"], animbankname, 0);
      earlyragdoll.entity thread check_anim_collisions(animinfo[0], earlyragdoll, animlength);
    }

    if(isDefined(animlengthoverride)) {
      riganimendtime = -1;
    } else {
      riganimendtime = gettime() + anim_length(animbankname, undefined, player.carrylinked.animent["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"]) * 1000;
    }

    objent utility::waittill_notify_or_timeout("\x9c\xad\xad6p\xa2\xb3\xe3&\xafu\x93j", animlength);
    player notify("\x8dhYc[\xd7\v\xe6im\xbe6{\xc6\xb1Z\xcdK\xdes7");
    var_c277eb503d9cc3e6 = max((riganimendtime - gettime()) * 0.001, 0);
  } else if(isstring(dropoverride)) {
    player thread anim_play(dropoverride, undefined, 1, dropoverride);
  }

  if(istrue(player.carrylinked.weapon_disable)) {
    if(!function_5b835778cf278882(self getcurrentweapon())) {
      if(isDefined(self.carrylinked.var_4ab675f787bf1fb)) {
        player thread gesture_stop(player.carrylinked.var_4ab675f787bf1fb);
      }
    }

    function_24fc34a7b32d8dae(player);
  }

  player.carrylinked.animent["\xf9\xcd\xc7A\x8e\x15"] unlinkfromplayerview(player);

  if(isDefined(bundle.gesture)) {
    weapon = player getcurrentprimaryweapon();

    if(weapon.basename != "\r+x5") {
      player stopgestureviewmodel(bundle.gesture);
    }
  }

  if(isDefined(bundle.suit)) {
    player setsuit(player_sp::function_228562272b598116());
  }

  if(isDefined(bundle.cinematicmotionoverride) || isDefined(bundle.cinematicmotionoverrideads)) {
    player clearcinematicmotionoverride();
  }

  if(istrue(bundle.playerrig) && isent(player.carrylinked.animent["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"])) {
    if(var_c277eb503d9cc3e6 > 0) {
      namespace_6341d8b435bf1728::get_player_rig() utility::delaycall(var_c277eb503d9cc3e6, &hide);
      namespace_6341d8b435bf1728::get_player_rig() utility::delaycall(var_c277eb503d9cc3e6, &unlinkfromplayerview, player);
    } else {
      namespace_6341d8b435bf1728::get_player_rig() unlinkfromplayerview(player);
      namespace_6341d8b435bf1728::get_player_rig() hide();
    }
  }

  player set_carrying(0, bundle.allowads);

  if(isarray(player.carrylinked.weaponswaps)) {
    player thread function_65d288752749c5b6(player.carrylinked.weaponswaps);
  }

  player utility::ent_flag_clear(player.carrylinked.name);
  player input_prompts::function_8b6d36feadeac3d3("\x91\xca\xcc\v\xab\xd8:", "\xfd\x10\xa1gN\xf2`@\xa3\x14\xce");
  player.carrylinked = undefined;
  player.var_831432b007ee9fbb = undefined;
}

function private function_65d288752749c5b6(weaponswaps) {
  self notify("\xc9\\L\x1c^\xae,\x01n\xee~\xc4\x9d\xacm)");
  self endon("\xc9\\L\x1c^\xae,\x01n\xee~\xc4\x9d\xacm)");
  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  giveuptime = gettime() + 1000;

  while(!player val::get("\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e")) {
    if(gettime() > giveuptime) {
      return;
    }

    waitframe();
  }

  if(isDefined(weaponswaps[0])) {
    player utility_sp::take_weapon(weaponswaps[0]);
  }

  if(isDefined(weaponswaps[1])) {
    player switchtoweaponimmediate(weaponswaps[1]);
  }
}

function private level_pitch(var_f9839a910737506b, clamppitchmax) {
  assert(isPlayer(self));
  player = self;

  if(isDefined(clamppitchmax)) {
    startup = player.carrylinked.var_194575a63d866ad4;
    startdown = player.carrylinked.var_64c95ad29583215d;

    if(!istrue(var_f9839a910737506b)) {
      abspitch = abs(level.player getplayerangles()[0]);

      if(isDefined(player.carrylinked.bundle.var_54563d91d036c0c1) && abspitch > player.carrylinked.bundle.var_54563d91d036c0c1) {
        rate = max((abspitch - player.carrylinked.bundle.var_54563d91d036c0c1) / 0.5, 10);
        setsaveddvar(@ "hash_5627a19bf41f45cf", rate);
        setsaveddvar(@ "player_view_pitch_up", player.carrylinked.bundle.var_54563d91d036c0c1);
        setsaveddvar(@ "player_view_pitch_down", player.carrylinked.bundle.var_54563d91d036c0c1);
        function_b94e3648ac933aa5("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2", "6a\xc99\xcb6\xa5\xdc\xb6V\xc8\xfa\x91'\xdep\xd7Xnim\xbec\xbdm\x83\x8d\xac:\xac", 0.5);
        setsaveddvar(@ "hash_5627a19bf41f45cf", 0);
      }
    }

    setsaveddvar(@ "player_view_pitch_up", startup);
    setsaveddvar(@ "player_view_pitch_down", startdown);
  }
}

function private function_b94e3648ac933aa5(note1, note2, dur) {
  self endon(note1);
  self endon(note2);
  wait dur;
}

function function_3ddcf99ca8b9668d(carriedentity) {
  return function_71e9a91fc42af817(carriedentity);
}

function allow_weapon(allowed, gesture, var_6e4af9876ea14e86, canceltransition, blendtime) {
  assert(isPlayer(self));
  player = self;

  if(!isDefined(player.carrylinked)) {
    return;
  }

  if(!allowed && !istrue(player.carrylinked.weapon_disable)) {
    player.carrylinked.weapon_disable = 1;

    if(!isDefined(gesture)) {
      gesture = player.carrylinked.reloadgesture;
    }

    player.carrylinked.var_4ab675f787bf1fb = gesture;
    player val::set("\x83\x164\xa2]\xc0l\x83$\r\xe1\xdd3e\xb7\xe5\xd5\xc6\xa5\xb8\xfeA\xc1v~\x80", "\xcciN\xca", 0);
    player val::set("\x83\x164\xa2]\xc0l\x83$\r\xe1\xdd3e\xb7\xe5\xd5\xc6\xa5\xb8\xfeA\xc1v~\x80", "\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", 0);

    if(!istrue(var_6e4af9876ea14e86) && !function_5b835778cf278882(player getcurrentweapon())) {
      player gesture_play(player.carrylinked.var_4ab675f787bf1fb, undefined, 1, blendtime, undefined, canceltransition, 1);
    }

    return;
  }

  if(allowed && istrue(player.carrylinked.weapon_disable)) {
    animlength = undefined;

    if(!function_5b835778cf278882(player getcurrentweapon())) {
      if(isDefined(gesture)) {
        player gesture_play(gesture, undefined, 1, blendtime, undefined, canceltransition, 1);
        player utility::delaythreadendon(0.25, "\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2", &function_24fc34a7b32d8dae, player);
        looptime = player getgesturestarttime(gesture, "\xd0\xce\x88\x9e");
        wait looptime;

        if(isDefined(player.carrylinked.bundle.gesture)) {
          weapon = player getcurrentweapon();

          if(weapon.basename != "\r+x5") {
            intime = player getgesturestarttime(player.carrylinked.bundle.gesture, "\xd0\xce\x88\x9e");
            player gesture_play(player.carrylinked.bundle.gesture, undefined, 1, blendtime, intime, canceltransition, 1);
          }
        }
      } else if(isDefined(player.carrylinked.var_4ab675f787bf1fb)) {
        animlength = player getgestureanimlength(player.carrylinked.var_4ab675f787bf1fb);
        player gesture_stop(player.carrylinked.var_4ab675f787bf1fb);
        player utility::delaythreadendon(0.25, "\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2", &function_24fc34a7b32d8dae, player);
        outtime = player getgesturestarttime(self.carrylinked.var_4ab675f787bf1fb, "\xb7C{");
        animlength = max(0, animlength - outtime - blendtime);
        wait animlength;

        if(isDefined(player.carrylinked.bundle.gesture)) {
          weapon = player getcurrentweapon();

          if(weapon.basename != "\r+x5") {
            intime = player getgesturestarttime(player.carrylinked.bundle.gesture, "\xd0\xce\x88\x9e");
            player gesture_play(player.carrylinked.bundle.gesture, undefined, 1, blendtime, intime, canceltransition, 1);
          }
        }
      } else {
        function_24fc34a7b32d8dae(player);
      }

      return;
    }

    function_24fc34a7b32d8dae(player);
  }
}

function function_a3ff6abe6c4553c9() {
  assert(isPlayer(self));
  var_7d1d04377f3ff980 = function_d6e3fcacd7c95239();
  thread function_3f593d48118c7a1e(var_7d1d04377f3ff980);
}

function function_d0e01d9052fc0974(carrylinkedasset) {
  assert(isPlayer(self));
  player = self;
  result = player function_d6e3fcacd7c95239();
  weaponswaps = undefined;
  currentweapon = self getcurrentweapon();

  if(!isDefined(result) || issubstr(result.basename, "\r+x5")) {
    result = undefined;

    foreach(weapon in player getweaponslistprimaries()) {
      if(istrue(weapon.ismelee) && issubstr(weapon.basename, "7X\xf8\xf4;K\xa7")) {
        result = weapon;
        break;
      }
    }

    if(result == currentweapon) {
      return weaponswaps;
    }

    weaponswaps = [undefined, currentweapon];
  }

  if(!isDefined(result)) {
    bundle = getscriptbundle("\x8b\xaf\x85\xd8\x1b\x03#h\xd6\xc3\v\x8b" + carrylinkedasset);
    result = utility_sp::make_weapon(bundle.fallbackweapon);

    if(!isDefined(result) || issubstr(result.basename, "\r+x5")) {
      return weaponswaps;
    }

    player utility_sp::give_weapon(result);
    weaponswaps = [result, currentweapon];
  }

  player thread function_3f593d48118c7a1e(result);
  return weaponswaps;
}

function private function_3f593d48118c7a1e(weapon) {
  assert(isPlayer(self));
  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  if(weapon != player getcurrentweapon()) {
    player switchtoweapon(weapon);
  }
}

function function_d6e3fcacd7c95239() {
  assert(isPlayer(self));
  currentweapon = self getcurrentweapon();

  if(!function_b8fd2623c64dd729(currentweapon) && !istrue(currentweapon.ismelee)) {
    return currentweapon;
  }

  result = undefined;
  resultammo = -1;

  foreach(weapon in self getweaponslistprimaries()) {
    if(weapon != currentweapon && !function_b8fd2623c64dd729(weapon) && !istrue(weapon.ismelee)) {
      weaponammo = self getweaponammoclip(weapon);

      if(!isDefined(result) || weaponammo > resultammo) {
        result = weapon;
        resultammo = weaponammo;
      }
    }
  }

  return result;
}

function gesture_play(gesture = "", target, ignore_state, blendtime, starttime, canceltrans, stopall) {
  if(isDefined(gesture)) {
    thread gesture_play_wait_weapon(gesture, target, ignore_state, blendtime, starttime, canceltrans, stopall);
    return;
  }

  iprintln("<dev string:x33>" + gesture + "<dev string:x4c>");
}

function gesture_stop(gesture, outtime, canceltrans) {
  if(!isDefined(gesture)) {
    return;
  }

  self notify(gesture + "\xe7\x9bO\xf3%");

  if(!isDefined(outtime)) {
    self stopgestureviewmodel(gesture);
    return;
  }

  self stopgestureviewmodel(gesture, outtime, canceltrans);
}

function function_7a757fd6e145f22e(demeanor = "+0a<s,") {
  assert(isPlayer(self));
  self notify("\xe7\x92\xbd\xb1\x85\xb9\xeat\x85\xc1\xa1\x1aS\x1d=\x1b5\a10\vRh\xfd\x0e\x10\xb3(4\x10x\x95\x1f\xe5\r");
  val::set("\xdc\xcb\x97\xedR\x87,\xd6\x13\xaa\b^\x95\x19\x13\xe5\x8b,\xc0y", "(\x15\xda\x106\xed_\x1a", demeanor);
}

function wait_to_revert_demeanor(exitgesture) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("\xe7\x92\xbd\xb1\x85\xb9\xeat\x85\xc1\xa1\x1aS\x1d=\x1b5\a10\vRh\xfd\x0e\x10\xb3(4\x10x\x95\x1f\xe5\r");

  if(isDefined(exitgesture)) {
    while(self isgestureplaying(exitgesture)) {
      waitframe();
    }
  }

  val::reset_all("\xdc\xcb\x97\xedR\x87,\xd6\x13\xaa\b^\x95\x19\x13\xe5\x8b,\xc0y");
}

function gesture_wait(ent, notification = "\x9fig\xd3\xb3\tC\x04\xc9\x91\x7f\xb1\x18Z") {
  self notify("\x87MZz\xaa\x01\xf4\xedg\"z p:");
  self endon("\x87MZz\xaa\x01\xf4\xedg\"z p:");
  player = self;

  if(!isDefined(ent)) {
    ent = player;
  }

  player val::set("\xaeZP:}~\xfdk\x91\xb4\x16\x14\xd5\xa6\x0fX\xd0R\xf5\xe1\rgVb", "\xcciN\xca", 0);
  player val::set("\xaeZP:}~\xfdk\x91\xb4\x16\x14\xd5\xa6\x0fX\xd0R\xf5\xe1\rgVb", "\x92J\xe8\xbf+\xcd@\x89\t\x9b\x9f'\x8e", 0);
  player function_aa569e74bdd591e1(ent, notification);
  player val::reset_all("\xaeZP:}~\xfdk\x91\xb4\x16\x14\xd5\xa6\x0fX\xd0R\xf5\xe1\rgVb");
}

function private function_aa569e74bdd591e1(ent, notification) {
  self notify("[\xd1~\xde\x17i\xae\xa0\xa1\xec\xe9\xbd\xa5\xa0\x8c\xa4");
  self endon("[\xd1~\xde\x17i\xae\xa0\xa1\xec\xe9\xbd\xa5\xa0\x8c\xa4");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("\xaeZP:}~\xfdk\x91\xb4\x16\x14\xd5\xa6\x0fX\xd0R\xf5\xe1\rgVb");
  ent waittill(notification, gesture, cancel);

  if(isstring(gesture)) {
    if(isDefined(cancel)) {
      self stopgestureviewmodel(gesture);
      return;
    }

    thread gesture_play(gesture);
  }
}

function private function_24fc34a7b32d8dae(player, gesture) {
  assert(isPlayer(self));
  player = self;
  player val::reset_all("\x83\x164\xa2]\xc0l\x83$\r\xe1\xdd3e\xb7\xe5\xd5\xc6\xa5\xb8\xfeA\xc1v~\x80");

  if(isDefined(player.carrylinked)) {
    player.carrylinked.weapon_disable = undefined;
    player.carrylinked.var_4ab675f787bf1fb = undefined;
  }
}

function private set_carrying(carrying, adsallowed) {
  assert(isPlayer(self));
  player = self;

  if(istrue(carrying)) {
    player val::set("\xfd\x10\xa1gN\xf2`@\xa3\x14\xce", "\xe4\xf1G", istrue(adsallowed));
    player val::set("\xfd\x10\xa1gN\xf2`@\xa3\x14\xce", "\t\xe6\xac\xd08c\xc7\xf1v7\x85\xca\xab;Nb\xb9\xb6\x83\xb5\xa9", 2);
    player val::set_array("\xfd\x10\xa1gN\xf2`@\xa3\x14\xce", level.carrylinkedvals, 0);

    if((player.carrylinked.reloadspeedmult ?? 1) != 1) {
      player val::set("\xfd\x10\xa1gN\xf2`@\xa3\x14\xce", "[\xffR\b\v\x85\b\x8b\xe9\"\xf5\xf9", player.carrylinked.reloadspeedmult);
    }

    if((player.carrylinked.var_8ccbc951cdcc0229 ?? 1) != 1) {
      player val::set("\xfd\x10\xa1gN\xf2`@\xa3\x14\xce", "_d\x89\xf5\b(QU\xf5h\xf6\xdf\xe1\xed\x8b\x9fE\x95s", player.carrylinked.var_8ccbc951cdcc0229);
    }

    scale = min(player val::get("\ny\xb3\x0f\xed\xf447XI\xfa\xe70x\t\xbf"), 0.75);
    player val::set("\xfd\x10\xa1gN\xf2`@\xa3\x14\xce", "\ny\xb3\x0f\xed\xf447XI\xfa\xe70x\t\xbf", scale);
    player hud_management::function_170c03b36bf19328("\xfd\x10\xa1gN\xf2`@\xa3\x14\xce", "\xc0r@\xc9J\x8a\xda[\x01\x1b\xea", 1);
    setomnvar("\xea\xb4\xeb\x83\x8dX\xe5\x95\x9c}\x1b,9\xe4\xcb\xa5\xb9\xce\xebL{d\xf2", 1);
    return;
  }

  setomnvar("\xea\xb4\xeb\x83\x8dX\xe5\x95\x9c}\x1b,9\xe4\xcb\xa5\xb9\xce\xebL{d\xf2", 0);
  player val::reset_all("\xfd\x10\xa1gN\xf2`@\xa3\x14\xce");
  player hud_management::function_a4b07de99918f624("\xfd\x10\xa1gN\xf2`@\xa3\x14\xce");
}

#using_animtree("*xmG4\x1e\x14\xb1\xc2u_!\xf5");

function private function_71e9a91fc42af817(carriedentity) {
  attachments = [];

  for(i = 0; i < carriedentity getattachsize(); i++) {
    attachments[attachments.size] = [carriedentity getattachmodelname(i), carriedentity getattachtagname(i)];
  }

  newobject = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", (0, 0, 0));
  newobject setModel(carriedentity.model);
  newobject useanimtree(#animtree);
  newobject notsolid();

  foreach(attachment in attachments) {
    newobject attach(attachment[0], attachment[1], 1);
  }

  return newobject;
}

function private function_4b4b8bf7be38f4a9(animbankanimname, optionalsuffix) {
  var_ebe4f0e5c6533392 = animbankanimname + (isDefined(optionalsuffix) ? optionalsuffix : "");
  player = self;

  foreach(key, entity in player.carrylinked.animent) {
    if(isDefined(player.carrylinked.animbank[key])) {
      if(animbank::check(player.carrylinked.animbank[key], var_ebe4f0e5c6533392)) {
        animbankanimname = var_ebe4f0e5c6533392;
        break;
      }
    }
  }

  return animbankanimname;
}

function private check_anim_collisions(xanim, earlyragdoll, animlength) {
  self notify("\x16q\x1f\xb3\x9fs*pZH~\x9a\xf17\x13P");
  self endon("\x16q\x1f\xb3\x9fs*pZH~\x9a\xf17\x13P");
  victim = self;
  player = level.player;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player endon("\x8dhYc[\xd7\v\xe6im\xbe6{\xc6\xb1Z\xcdK\xdes7");
  var_98484be3e8d5d1f = player.carrylinked.var_98484be3e8d5d1f;
  var_dc7a6d2df856f9e7 = getnotetracktimes(xanim, "A\x04\xfeL\x80\x8e\x9fO\x98~\xefI\xda\xd8ZBz\x873");
  var_a5f6fdd9e28c90bd = var_dc7a6d2df856f9e7.size > 0 ? var_dc7a6d2df856f9e7[0] : undefined;
  startragdolldelaytimes = getnotetracktimes(xanim, "\x9c\xad\xad6p\xa2\xb3\xe3&\xafu\x93j");
  startragdolldelay = startragdolldelaytimes.size > 0 ? startragdolldelaytimes[0] : undefined;
  ignorelist = [player, victim];
  var_67b80d8a3711bab5 = isDefined(startragdolldelay);

  if(isDefined(var_a5f6fdd9e28c90bd)) {
    var_a5f6fdd9e28c90bd *= animlength;
    wait var_a5f6fdd9e28c90bd;
    var_10df1971ad9e707 = player.origin;
    player player_sp::function_a9a4c8a5f556afa7(var_98484be3e8d5d1f, 1, ignorelist, level.carrylinkedcollisioncontents, earlyragdoll.groundclearance);

    if(lengthsquared(var_10df1971ad9e707 - player.origin) > 0.02) {
      nudge_vector = player.origin - var_10df1971ad9e707;
      victim.origin += nudge_vector;

      if(getdvarint(@ "hash_fd7caa2c943ccc6b", 0)) {
        iprintln("<dev string:x52>");
      }
    }

    startragdolldelay = isDefined(startragdolldelay) ? startragdolldelay * animlength : animlength;
    ragdollstarttime = gettime() + (startragdolldelay - var_a5f6fdd9e28c90bd) * 1000;

    do {
      if(!victim anim_sp::function_82ecf17b8bd03eff(victim.origin, victim.angles, xanim, earlyragdoll.collision_tags, ignorelist, earlyragdoll.collision_radius, level.carrylinkedcollisioncontents)) {
        if(getdvarint(@ "hash_fd7caa2c943ccc6b", 0)) {
          iprintln("<dev string:x8f>");
        }

        victim notify("\x9c\xad\xad6p\xa2\xb3\xe3&\xafu\x93j");
        return;
      }

      waitframe();
    }
    while(gettime() < ragdollstarttime);
  } else if(var_67b80d8a3711bab5) {
    wait startragdolldelay * animlength;
  }

  if(var_67b80d8a3711bab5) {
    victim startragdoll();
    victim notify("\x9c\xad\xad6p\xa2\xb3\xe3&\xafu\x93j");
  }
}

function private anim_play(animbankanimname, optionalsuffix, forcerestart, notifyname) {
  assert(isPlayer(self));
  player = self;
  animbankanimname = player function_4b4b8bf7be38f4a9(animbankanimname, optionalsuffix);

  if(!istrue(forcerestart) && player.carrylinked.animbankanimname == animbankanimname) {
    return;
  }

  if(isDefined(player.carrylinked.animbankanimname)) {
    player anim_stop(player.carrylinked.animbankanimname);
  }

  player.carrylinked.animbankanimname = animbankanimname;
  animlength = anim_length(animbankanimname);
  index = -1;

  foreach(key, entity in player.carrylinked.animent) {
    if(isDefined(entity) && isDefined(player.carrylinked.animbank[key])) {
      if(index < 0) {
        index = entity animbank::choose_index(player.carrylinked.animbank[key], animbankanimname);
      }

      entity thread animbank::play(player.carrylinked.animbank[key], animbankanimname, index, notifyname);
    }
  }

  if(animlength > 0) {
    wait animlength;
  }
}

function private anim_length(animbankanimname, optionalsuffix, entitymatch) {
  assert(isPlayer(self));
  player = self;
  animbankanimname = player function_4b4b8bf7be38f4a9(animbankanimname, optionalsuffix);
  animlength = 0;

  foreach(key, entity in player.carrylinked.animent) {
    if(isDefined(player.carrylinked.animbank[key]) && (!isDefined(entitymatch) || entity == entitymatch)) {
      animbankanimlength = animbank::get_length(player.carrylinked.animbank[key], animbankanimname);
      animlength = max(animlength, animbankanimlength);
    }
  }

  return animlength;
}

function private anim_stop(animbankanimname) {
  assert(isPlayer(self));
  player = self;

  foreach(key, entity in player.carrylinked.animent) {
    if(isDefined(entity) && isDefined(player.carrylinked.animbank[key])) {
      entity thread animbank::stop(player.carrylinked.animbank[key], animbankanimname);
    }
  }

  if(player.carrylinked.animbankanimname == animbankanimname) {
    player.carrylinked.animbankanimname = undefined;
  }
}

function private function_310ff38680cfc0ab() {
  assert(isPlayer(self));
  player = self;
  player endon("\xcb\xd5\x19 \x16\xfd\xd7\x012\xb1\xd0\xbcks\xad1\xdfe\x9ds\\\xe3\x1c\x89\xdc");
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  while(true) {
    player waittill("\xae\x15\xd7V\x9c\xca\xc3\xd4&)\xf7\xf7\x11");
    player.carrylinked.paintime = gettime();
    waitframe();
  }
}

function private anim_monitor() {
  assert(isPlayer(self));
  player = self;
  player notify("\xcb\xd5\x19 \x16\xfd\xd7\x012\xb1\xd0\xbcks\xad1\xdfe\x9ds\\\xe3\x1c\x89\xdc");
  player endon("\xcb\xd5\x19 \x16\xfd\xd7\x012\xb1\xd0\xbcks\xad1\xdfe\x9ds\\\xe3\x1c\x89\xdc");
  player endon("\x1e\xfd\xd1\xa2\a");
  bundle = player.carrylinked.bundle;
  painstarttime = 0;
  painendtime = 0;
  player thread function_310ff38680cfc0ab();

  while(isDefined(player.carrylinked)) {
    weapon = player getcurrentweapon();
    movement = player getnormalizedmovement(0.1, 0.1);
    forcerestart = 0;
    prefix = "\x91\x88\xc2*";
    suffix = "";

    if(abs(movement[0]) > 0 || abs(movement[1]) > 0) {
      prefix = "\x82}\xeb\x93";
    }

    adspressed = player adsButtonPressed();
    forcerestart = player ads_set(adspressed);

    if(forcerestart) {
      if(player.carrylinked.in_ads) {
        prefix = "b\xd8\x05g8";
      } else {
        prefix = "0\xb0\xc0\xda";
        suffix = "\x93S\xa9]";
      }
    }

    if(adspressed) {
      suffix = "\x93S\xa9]";

      if(isDefined(player.carrylinked.bundle.cinematicmotionoverrideads)) {
        player setcinematicmotionoverride(player.carrylinked.bundle.cinematicmotionoverrideads);
      }
    } else if(isDefined(player.carrylinked.bundle.cinematicmotionoverride)) {
      player setcinematicmotionoverride(player.carrylinked.bundle.cinematicmotionoverride);
    }

    if(isDefined(player.carrylinked.paintime) && player.carrylinked.paintime > 0) {
      prefix = "\x80\xb5\xc7J";

      if(player.carrylinked.paintime > painstarttime + 350) {
        forcerestart = 1;
        painendtime = player.carrylinked.paintime + (player anim_length(prefix, suffix) - level.framedurationseconds * 2) * 1000;
        painstarttime = player.carrylinked.paintime;
      }

      if(gettime() >= painendtime) {
        player.carrylinked.paintime = undefined;
      }
    }

    player thread anim_play(prefix, suffix, forcerestart);

    if(weapon.basename != "\r+x5") {
      if(player isreloading() && isDefined(bundle.gesturereloading)) {
        player forceplaygestureviewmodel(bundle.gesturereloading);
      } else {
        player forceplaygestureviewmodel(bundle.gesture);
      }
    }

    if(istrue(player.carrylinked.showreload) && !istrue(player.carrylinked.weapon_disable)) {
      player input_prompts::function_e1ed844222decdfd("\x91\xca\xcc\v\xab\xd8:", "\xfd\x10\xa1gN\xf2`@\xa3\x14\xce", &"hash_4fa49181af888526");
    } else {
      player input_prompts::function_8b6d36feadeac3d3("\x91\xca\xcc\v\xab\xd8:", "\xfd\x10\xa1gN\xf2`@\xa3\x14\xce");
    }

    if(getdvarint(@ "hash_c908557a5b521024", 0)) {
      player function_3dee6a4cd526702f(player.carrylinked.animent["<dev string:xba>"]);
    }

    waitframe();
  }
}

function private link(linked) {
  assert(isPlayer(self));
  player = self;

  if(!isDefined(player.carrylinked)) {
    return;
  }

  foreach(entity in player.carrylinked.animent) {
    if(!isDefined(entity)) {
      continue;
    }

    if(istrue(linked)) {
      bundle = player.carrylinked.bundle;
      linktag = bundle.linktag ?? "\xec\xbfK|\au\xcd\xc2\x19<";
      linkoffsetposition = (0, 0, 0);

      if(isDefined(bundle.linkoffsetposition)) {
        linkoffsetposition = (bundle.linkoffsetposition.x ?? 0, bundle.linkoffsetposition.y ?? 0, bundle.linkoffsetposition.z ?? 0);
      }

      linkoffsetangles = (0, 0, 0);

      if(isDefined(bundle.linkoffsetangles)) {
        linkoffsetangles = (bundle.linkoffsetangles.x ?? 0, bundle.linkoffsetangles.y ?? 0, bundle.linkoffsetangles.z ?? 0);
      }

      viewmodelsort = bundle.viewmodelsort ?? 1;
      proceduralmotion = bundle.proceduralmotion ?? "\r+x5";
      entity linktoplayerview(player, linktag, linkoffsetposition, linkoffsetangles, viewmodelsort, proceduralmotion);
      entity show();
      continue;
    }

    entity unlinkfromplayerview(player);
  }
}

function private function_b8fd2623c64dd729(weapon) {
  if(!isweapon(weapon)) {
    return true;
  }

  if(istrue(weaponisboltaction(weapon))) {
    return true;
  }

  if(istrue(weapon.isgrenadeweapon)) {
    return true;
  }

  if(weapon::isakimbo(weapon)) {
    return true;
  }

  if(utility_sp::isriotshield(weapon)) {
    return true;
  }

  switch (weapon.classname) {
    case #"hash_6191aaef9f922f96":
    case #"hash_61e969dacaaf9881":
    case #"hash_924e034e98c9dc46":
    case #"hash_fa24dff6bd60a12d":
      return true;
  }

  return false;
}

function private gesture_play_wait_weapon(gesture, target, ignore_state, blendtime, starttime, canceltrans, stopall) {
  self notify("\xe2VW\xda\xe0\x84o\xfcfp\x1f\t\xc1~\x88@s\xf8\xbc\xb6\x03U\xf3U");
  self endon("\xe2VW\xda\xe0\x84o\xfcfp\x1f\t\xc1~\x88@s\xf8\xbc\xb6\x03U\xf3U");
  self endon(gesture + "\xe7\x9bO\xf3%");
  var_3cc20e6f1405e1a0 = undefined;

  if(istrue(self.takedown.var_496d1d8e94a2cda2)) {
    self.takedown.var_496d1d8e94a2cda2 = undefined;
  }

  while(!self isweaponsenabled()) {
    var_3cc20e6f1405e1a0 = 1;
    self.var_3fc971ea4fc59e87 = 1;
    waitframe();
  }

  self.var_3fc971ea4fc59e87 = undefined;

  if(istrue(var_3cc20e6f1405e1a0)) {
    waitframe();
  }

  self forceplaygestureviewmodel(gesture, target, blendtime, starttime, stopall, canceltrans);
}

function private function_5b835778cf278882(weapon) {
  if(!isweapon(weapon)) {
    return false;
  }

  if(istrue(weapon.ismelee) || istrue(weaponisboltaction(weapon))) {
    return true;
  }

  return false;
}

function ads_set(enabled, force) {
  assert(isPlayer(self));
  player = self;
  var_79483af02071ac55 = istrue(player.carrylinked.in_ads);
  var_996753f9323b32d9 = istrue(enabled);
  returnval = 0;

  if(var_996753f9323b32d9 && !var_79483af02071ac55) {
    player.carrylinked.in_ads = 1;
    returnval = 1;
  } else if(!var_996753f9323b32d9 && var_79483af02071ac55 || istrue(force)) {
    player.carrylinked.in_ads = 0;
    returnval = 1;
  }

  return returnval;
}

function private function_b640ef1a3510e47e(weapon) {
  assert(isPlayer(self));
  player = self;
  player allow_weapon(0, undefined, undefined, 1, 0.2);
  var_18b8da3128eb335f = self getweaponammostock(weapon);
  ammo_in_clip = self getweaponammoclip(weapon);
  wait 0.5;
  sound = "";
  wait_time = 0.5;

  switch (weapon.classname) {
    case #"hash_719417cb1de832b6":
      sound = "\x99\xce\xc6\xf9\x96\xe1\xffh\xaa\x8caK-?\x14<$z\xff\x82gy\x90J6\xdcL\x01";
      break;
    case #"hash_900cb96c552c5e8e":
      sound = "\x92\xf6\xcc\x8f\xe8\xfe\f\x80\x81od\xc9`\x14OX\xdaEAVV\xcf\xb3\x1f\x10";
      wait_time = 0.7;
      break;
    case #"hash_8cdaf2e4ecfe5b51":
      sound = "\xdaP \x94\x88\xef\x15S\xb2\x19\xb5\xdf\xca\xfcE\n{\xe5\v\xc6\xf5Q\xa7\x1f\xdd_\x81";
      wait_time = 0.7;
      break;
    case #"hash_6191aaef9f922f96":
      sound = "\x92\xf6\xcc\x8f\xe8\xfe\f\x80\x81od\xc9`\x14OX\xdaEAVV\xcf\xb3\x1f\x10";
      wait_time = 1;
      break;
    case #"hash_23209741b93850b5":
      sound = "\x01-\xef\xc5kF+\xa5oZo\xddD\xb4>\xb6\xf8\x86\xe1\xf6r\xe3\xc5\x05\xaa\x81G#\xee";
      wait_time = 1;
      break;
    default:
      sound = "D\x7ft/d%?\x8d5,}m\x1d<\xbc\x82\xf7x0\x11p\xa7\xad\xc4l";
      wait_time = 2;
      break;
  }

  if(soundexists(sound)) {
    player playSound(sound);
  }

  wait wait_time;
  delta = min(var_18b8da3128eb335f, weapon.clipsize - ammo_in_clip);

  if(self hasweapon(weapon)) {
    self setweaponammoclip(weapon, int(ammo_in_clip + delta));
    self setweaponammostock(weapon, int(var_18b8da3128eb335f - delta));
  }

  allow_weapon(1, undefined, undefined, 1, 0.2);
}

function function_bb3c7f14c2d2c08a() {
  assert(isPlayer(self));
  player = self;
  player notify("<dev string:xc4>");
  player endon("<dev string:xc4>");

  while(true) {
    wait 0.25;

    if(!isDefined(player.carrylinked)) {
      return;
    }

    if(!getdvarint(@ "hash_d95a4ea1693f2bcb", 0)) {
      continue;
    }

    player.carrylinked.bundle = getscriptbundle("<dev string:xdd>" + player.carrylinked.bundlename);
    player link(0);
    player link(1);
  }
}

function private function_3dee6a4cd526702f(victim, animbankname) {
  if(!isDefined(animbankname)) {
    animbankname = "<dev string:xed>";
  }

  player = self;
  scriptbundlename = "<dev string:xf5>";
  assert(isstring(scriptbundlename));
  var_6a65c1941177b623 = "<dev string:x10c>";
  scene_root = spawnStruct();
  scene_root.origin = victim.origin;
  scene_root.angles = victim.angles;
  objent = player.carrylinked.animent["<dev string:xba>"];
  animinfo = animbank::function_fe721d46c085d273(player.carrylinked.animbank["<dev string:xba>"], animbankname, 0);

  if(animinfo.size == 0) {
    animinfo = animbank::function_fe721d46c085d273(player.carrylinked.animbank["<dev string:xba>"], "<dev string:x123>", 0);

    if(animinfo.size == 0) {
      return;
    }
  }

  earlyragdollnotetracks = getnotetracktimes(animinfo[0], "<dev string:x10c>");

  if(!isDefined(earlyragdollnotetracks)) {
    return 0;
  }

  var_9ce2b6b45f4f2af2 = 1;
  startragdollnotetracks = getnotetracktimes(animinfo[0], "<dev string:x135>");

  if(startragdollnotetracks.size > 0) {
    var_9ce2b6b45f4f2af2 = startragdollnotetracks[0];
  }

  tags = ["<dev string:x146>", "<dev string:x150>", "<dev string:x15c>"];
  collision_radius = 5;
  ignoreentities = [player];
  originviewmodel = player getvieworigin();

  foreach(bonetag in tags) {
    var_219b57da3ecc8078 = victim gettagorigin(bonetag);
    result_frame1 = victim animation::function_3cf2092e487b2640(animinfo[0], bonetag, 0, scene_root.origin, scene_root.angles);
    result_start = victim animation::function_3cf2092e487b2640(animinfo[0], bonetag, earlyragdollnotetracks[0], scene_root.origin, scene_root.angles);
    result_end = victim animation::function_3cf2092e487b2640(animinfo[0], bonetag, var_9ce2b6b45f4f2af2, scene_root.origin, scene_root.angles);
    sphere(var_219b57da3ecc8078, 5, (1, 1, 1));
    sphere(result_frame1["<dev string:x168>"], 5, (0, 0, 1));

    if(!(isDefined(result_start) && isDefined(result_end))) {
      continue;
    }

    trace = trace::sphere_trace(result_start["<dev string:x168>"], result_end["<dev string:x168>"], collision_radius, ignoreentities, level.carrylinkedcollisioncontents, 0);

    if(trace["<dev string:x172>"] < 1) {
      trace::draw_trace(trace, (1, 0, 0), 1, 1);
    }

    trace::draw_trace(trace, (1, 1, 0), 1, 1);
  }
}

# /