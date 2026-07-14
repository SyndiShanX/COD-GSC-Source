/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player\body_carry.gsc
********************************************/

#using script_3798db193e76a866;
#using script_758eb3e6844a19b3;
#using scripts\common\anim;
#using scripts\common\scene;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\player;
#using scripts\sp\player\carrylinked;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_rig;
#using scripts\sp\utility;
#using scripts\stealth\event;
#using scripts\stealth\manager;
#namespace body_carry;

function private autoexec __init__system__() {
  system::register(#"body_carry", #"val", undefined, &post_main);
}

function private post_main() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    return;
  }

  level.player val::set("L\xbdF\x97_\xd8\xc2'ry", "`&\xd9V\xf0rz\xd2\xe4\xc62\xd1\x816", 1);
  utility_sp::add_global_spawn_function("?\xb1\xc0\x9a", &function_5fc84bf0b7902aac);
  level.player.body_carry = spawnStruct();
  level.player.body_carry.collisioncontents = physics_createcontents(["H\xe6\xe2\xa0\xf8\x8d\xd1\x84\xe4\xb8-\x99X\x884=\xd4\xe0$\xb8\xb9\xa5\xe9\xb7\f\xc9%\xca\xd8\xe4", "Y\xa2\x89;`\x02\xd59\xb8t\xe8q\x92)\x89\xb8\x7f\x8a\n\xd0\xd0t", "\xce\xd8oGC\x8e\xf6\xde\x1b\xfe\x1f\xe5\xc0\x88-eADHGN", "vr\xdd]2\xa6 2\v\x0e\xb3Cd\xf9\x8e\x90\x84\xd7r\xde^;CE\x82\xb3", "\xb3 c1\xa3\xab\x05/\x96c\xec\x02~5\a\xadz\xb9\xe6\xd8B", "M\xdb^{\xbe\x7fQ;\xe3\x1f\vB\xd5~\x8aE\xdc\x95\x02\xf3\xd1\xafc\xc9\xde\xdb\n"]);
  level.player.body_carry.collisioncontentsstand = physics_createcontents(["vr\xdd]2\xa6 2\v\x0e\xb3Cd\xf9\x8e\x90\x84\xd7r\xde^;CE\x82\xb3", "Y\xa2\x89;`\x02\xd59\xb8t\xe8q\x92)\x89\xb8\x7f\x8a\n\xd0\xd0t"]);
  level.player.body_carry.transitionvals = ["\xc9\xca\x1boX\x8c", "6\xb5g\x16\xa9\xc9\xab\xc7/\x12", "`\x16\xae\xa2\xe4t\x187\xe7", "\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", "\\y\xb8\x8e\xd8K\xfd\v\v\xd8", "\xe4\xf1G"];
  level.player thread function_f9035443193b8925();
  level.player thread function_dbc04c42e62d2101();
  level.player thread function_526db695dd79cb34();
  setsaveddvar(@ "hash_fa30263c9b36fe1", 0);

  setdvarifuninitialized(@ "hash_86deb0b5d3f32a1d", 0);

  setdvarifuninitialized(@ "hash_c461dfd6a61235ac", 0);

  setdvarifuninitialized(@ "hash_b19cf4f3c6d1ae4e", 0);

  setdvarifuninitialized(@ "hash_9f4ba807d7f6a5e3", 0);
}

function corpseenable(prompt, noblood) {
  corpse = self;

  if(!isent(corpse)) {
    return;
  }

  if(!isactorcorpse(corpse) && corpse.classname == "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6") {
    corpseentnum = corpse getentitynumber();
    corpse function_e337281d967be705();
    corpse = getentbynum(corpseentnum);

    if(istrue(noblood) && isactorcorpse(corpse)) {
      corpse utility_sp::disable_blood_pool();
    }
  }

  corpse thread function_894ce154b969f17f(prompt);
  corpse thread function_ab8f41bca9afd463();
}

function delayedcorpseenable(noblood) {
  corpse = self;

  if(!isent(corpse)) {
    return;
  }

  if(istrue(corpse.nobodycarry)) {
    return;
  }

  if(isDefined(corpse) && !isai(corpse)) {
    corpse utility::delaythread(0.5, &corpseenable, undefined, noblood);
  }
}

function function_5fc84bf0b7902aac() {
  ai = self;

  if(!isai(ai)) {
    return;
  }

  ai thread body_carry_waitcorpse();
}

function function_4996366ef34df309(match_name, var_3d2ee267ec833003, var_12306e4f89171e0a = 500, var_8dca359d36c69bcd = 45) {
  if(!isDefined(match_name)) {
    hide_target = level.player.body_carry.var_f5ab879027c1ec9b;

    if(isDefined(hide_target) && isDefined(hide_target.var_40640366af4a329)) {
      hide_target.var_40640366af4a329 notify("H\x92d\xb2\xe7\xa3\x8d<\xd3\x17r\xafXL7\xbf\xd0qr\xc3\xfd\xbbB\xa6e\xe5");
      hide_target.var_40640366af4a329 cursor_hint::remove_cursor_hint();
      hide_target.var_40640366af4a329 = undefined;
    }

    level.player.body_carry.var_f5ab879027c1ec9b = undefined;
    return;
  }

  foreach(key, hide_target in level.player.body_carry.hide_target) {
    level.player function_da077d6f299f0e2f(key, hide_target, 0);

    if(isDefined(hide_target.script_parameters) && hide_target.script_parameters == match_name) {
      level.player.body_carry.var_f5ab879027c1ec9b = hide_target;
      level.player.body_carry.var_b636019628179f0f = key;
      level.player.body_carry.var_5c2cabafab68a1ed = var_3d2ee267ec833003;
      level.player.body_carry.var_db98d644788c6ba8 = var_12306e4f89171e0a;
      level.player.body_carry.var_34064421ce04dceb = var_8dca359d36c69bcd;
    }
  }

  assert(isDefined(level.player.body_carry.var_f5ab879027c1ec9b));
}

function private body_carry_waitcorpse() {
  entity = self;
  entity notify("3\xa6\xe3;\x98\x90\xd3\x8b\x01p{y\x88\x9e-\x95B\x02\xa2\xc6\xae");
  entity endon("3\xa6\xe3;\x98\x90\xd3\x8b\x01p{y\x88\x9e-\x95B\x02\xa2\xc6\xae");
  entity endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  entnum = entity getentitynumber();
  entity waittill("\xc4\x956{m+\xd7\xd8\xdeN\x0ene");

  if(istrue(entity.nobodycarry)) {
    return;
  }

  corpse = getentbynum(entnum);

  if(!isactorcorpse(corpse)) {
    return;
  }

  corpse utility_sp::disable_blood_pool();
  corpse delayedcorpseenable(1);
}

function private function_ab8f41bca9afd463() {
  corpse = self;
  trigger = corpse.trigger;
  assert(isent(trigger));

  while(isent(corpse) && !isai(corpse)) {
    waittime = 1;

    if(corpse isragdoll()) {
      origin = corpse utility_sp::get_corpse_origin();

      if(distancesquared(origin, corpse.origin) > 1) {
        corpse.origin = origin;
        trigger.origin = corpse.origin;
        waittime = 0.05;
      }
    }

    wait waittime;
  }

  if(isent(trigger)) {
    trigger delete();
  }
}

function private function_f9035443193b8925() {
  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player thread function_276e252636afa94f();

  while(true) {
    player waittill("D\x84\xc0tR\xe2\xbf\x13\x9a\x11x\xc7k\x9dF:", state, hide_target);

    switch (state) {
      case #"hash_8f423fc2ccb1c6be":
        assert(isDefined(player.body_carry.pickupcorpse));
        player utility::ent_flag_set("e\xf7\xa4\xf2\xa4X\xef\xee8_j\x96\xa8h\x8e\x9a\xa7");
        player val::set_array("bx\xd7\x11\xd0)\x8e\x1d\x1f\xb2\xde\xa9\xe96\xf0\xe9\xaa", level.player.body_carry.transitionvals, 0);
        player val::set_array("bx\xd7\x11\xd0)\x8e\x1d\x1f\xb2\xde\xa9\xe96\xf0\xe9\xaa", level.carrylinkedvals, 0);
        player carrylinked::function_7a757fd6e145f22e();
        player thread carrylinked::gesture_play("\x9e\xc7\x04\xef~\xcd\xc8 \xee\xf8\xfeAu\x89x\xc1\x03\x95\x15\x89?\x027\xcd");
        player thread body_carry_playerpickup(player.body_carry.pickupcorpse);
        break;
      case #"hash_8b8244c927d86e99":
        assert(isDefined(player.body_carry.body));
        player thread carrylinked::gesture_wait(namespace_6341d8b435bf1728::get_player_rig());
        player function_dd8ebd85f099bbc0(player.body_carry.body);
        player carrylinked::begin("M\x86\x81\x14\x0e\x9e\xaf\xaf\x9e|QG3\x84\x17\xf3\xf5", player.body_carry.body, "\xdf]9T9\\Z\xf9\xa1\xa3;\xe93;N\x1f\xde\x1dt\\t\xd9\x17D\xcd\xb4\x8f\x04\x18\xa9\x90", player.body_carry.weaponswaps);
        player notify("\xaeZP:}~\xfdk\x91\xb4\x16\x14\xd5\xa6\x0fX\xd0R\xf5\xe1\rgVb");
        player val::reset_all("bx\xd7\x11\xd0)\x8e\x1d\x1f\xb2\xde\xa9\xe96\xf0\xe9\xaa");
        player thread body_carry_playerwaitdrop();
        break;
      case #"hash_30b20a099c3735ec":
        player thread function_89ad2b291002b3cf();
        break;
      case #"hash_3368751dd5a1b941":
        assert(isDefined(hide_target));
        player thread function_89ad2b291002b3cf(hide_target);
        break;
      case #"hash_f5fa5f8ca986bee6":
        player thread function_89ad2b291002b3cf(undefined, 1);
        break;
      default:
        continue;
    }
  }
}

function private function_526db695dd79cb34() {
  self notify("\xe0\xa2\x94\xcb\xcf\xc7\xd6bP\xe3\x90\x98\xce\xaf\xe6");
  self endon("\xe0\xa2\x94\xcb\xcf\xc7\xd6bP\xe3\x90\x98\xce\xaf\xe6");
  player = self;
  player waittill("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  if(isDefined(player.body_carry.carrying)) {
    player function_dd8ebd85f099bbc0(undefined);
    player input_prompts::function_8b6d36feadeac3d3("\x91\xca\xcc\v\xab\xd8:", "L\xbdF\x97_\xd8\xc2'ry");
    player carrylinked::end(1);
    player.body_carry.carrying = undefined;
    player.body_carry.body startragdoll();
  }
}

function private function_da077d6f299f0e2f(key, hide_target, carrying, var_1d85ce0fc4874d5d, prompt_dist = 500, var_8dca359d36c69bcd = 45, prompt_string = &"hash_71484c832110f1d0") {
  player = self;
  distsq = distancesquared(player.origin, hide_target.origin);

  if(carrying && distsq <= var_1d85ce0fc4874d5d) {
    if(!isDefined(hide_target.var_40640366af4a329) && isDefined(hide_target.target)) {
      hide_target.var_40640366af4a329 = utility::getStruct(hide_target.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
      hide_target.var_40640366af4a329 cursor_hint::create_cursor_hint(undefined, undefined, prompt_string, undefined, prompt_dist, var_8dca359d36c69bcd, 0, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
      hide_target.var_40640366af4a329 thread body_carry_hidetriggerwait(key);
    }

    return;
  }

  if(isDefined(hide_target.var_40640366af4a329)) {
    hide_target.var_40640366af4a329 notify("H\x92d\xb2\xe7\xa3\x8d<\xd3\x17r\xafXL7\xbf\xd0qr\xc3\xfd\xbbB\xa6e\xe5");
    hide_target.var_40640366af4a329 cursor_hint::remove_cursor_hint();
    hide_target.var_40640366af4a329 = undefined;
  }
}

function private function_b374527eccccf4a3() {
  if(getdvarint(@ "hash_9f4ba807d7f6a5e3", 0)) {
    return true;
  }

  if(level.player utility::ent_flag("KJs\xdb\x1aFe\x17\xbf\xe1\x84\xa8y\xbe\x8d\x93\x99\x97\xab")) {
    return false;
  }

  return true;
}

function private function_dbc04c42e62d2101() {
  player = self;
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level.player.body_carry.hide_target = utility::getStructArray("\x01\xc0\x1a\xea\xfd\xe1\v\x82y\xa4Qo\x82\xa0\xf9", "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*");

  if(!isDefined(level.player.body_carry.hide_target)) {
    return;
  }

  var_1d85ce0fc4874d5d = 250000;

  while(level.player.body_carry.hide_target.size > 0) {
    carrying = isDefined(player.carrylinked) && function_b374527eccccf4a3() && !isDefined(player.takedown.body_shield);

    if(isDefined(player.body_carry.var_f5ab879027c1ec9b)) {
      distsq = level.player.body_carry.var_db98d644788c6ba8 * level.player.body_carry.var_db98d644788c6ba8;
      player function_da077d6f299f0e2f(player.body_carry.var_b636019628179f0f, player.body_carry.var_f5ab879027c1ec9b, carrying, distsq, level.player.body_carry.var_db98d644788c6ba8, level.player.body_carry.var_34064421ce04dceb, level.player.body_carry.var_5c2cabafab68a1ed);
    } else {
      foreach(hide_target in level.player.body_carry.hide_target) {
        if(isDefined(hide_target.script_parameters)) {
          continue;
        }

        player function_da077d6f299f0e2f(key, hide_target, carrying, var_1d85ce0fc4874d5d);
      }
    }

    waitframe();
  }
}

function private body_carry_hidetriggerwait(key) {
  var_40640366af4a329 = self;
  hide_target = level.player.body_carry.hide_target[key];
  var_40640366af4a329 endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  var_40640366af4a329 endon("H\x92d\xb2\xe7\xa3\x8d<\xd3\x17r\xafXL7\xbf\xd0qr\xc3\xfd\xbbB\xa6e\xe5");
  var_40640366af4a329 waittill("\x91`\xb1\xe7T\x97>");
  level.player notify("\x12;\x81\xd7q\x1dur\xf14<h5xX\xa7Z_wRk\xb8\xb9\x11\xdep\xe1D");
  level.player notify("\xb6\xf3\x91\xbc\x06\xf8\xf6x\xed\x03\xfe\x031\xad\xfc\xc8\xa3\xabP7\x0e\xc1\xcb\rr");
  level.player notify("D\x84\xc0tR\xe2\xbf\x13\x9a\x11x\xc7k\x9dF:", "\x8ep-^\t\x167\xf1e", hide_target);
  level.player.body_carry.hide_target[key] = undefined;
  var_40640366af4a329 cursor_hint::remove_cursor_hint();
  hide_target.var_40640366af4a329 = undefined;
}

function private function_894ce154b969f17f(prompt) {
  corpse = self;

  if(!isDefined(prompt)) {
    prompt = &"hash_447e4cdcf7eeda6";
  }

  corpse.trigger = spawn("\nT\xe9\xf5\xd06\xad6\x7f\xac\xeb\x96\xe1I", corpse.origin, 0, 20, 10);
  corpse.prompt = prompt;
  corpse thread body_carry_corpsetriggerwait();
}

function private function_5d42476355606f04() {
  player = self;

  if(getdvarint(@ "hash_9f4ba807d7f6a5e3", 0)) {
    return true;
  }

  if(!isDefined(level.stealth)) {
    function_3bd5b3c577a032ec("<dev string:x24>", 1);

    return false;
  }

  if(player stealth_manager::anyone_in_combat()) {
    function_3bd5b3c577a032ec("<dev string:x42>", 1);

    return false;
  }

  if(!function_b374527eccccf4a3()) {
    function_3bd5b3c577a032ec("<dev string:x65>", 1);

    return false;
  }

  if(!player val::get("\x86X7\x8c\xdc")) {
    function_3bd5b3c577a032ec("<dev string:x87>", 1);

    return false;
  }

  if(player ismeleeing()) {
    function_3bd5b3c577a032ec("<dev string:xa1>", 1);

    return false;
  }

  if(utility_sp::isriotshield(player getcurrentweapon())) {
    function_3bd5b3c577a032ec("<dev string:xb6>", 1);

    return false;
  }

  if(player isoffhandweaponreadytothrow()) {
    function_3bd5b3c577a032ec("<dev string:xcd>", 1);

    return false;
  }

  if(player isparachuting() || player isskydiving() || !player isonground() || player isonladder() || player isjumping() || player isonascender() || player isswimming() || player getstance() == "GX\xa9]\x82" || !player player_sp::canstand(level.player.body_carry.collisioncontentsstand) || player killstreaks::getkillstreakinuse()) {
    function_3bd5b3c577a032ec("<dev string:xf1>", 1);

    return false;
  }

  if(istrue(player.var_20f6e2ea824baab9)) {
    function_3bd5b3c577a032ec("<dev string:x110>", 1);

    return false;
  }

  if(player isreloading()) {
    function_3bd5b3c577a032ec("<dev string:x133>", 1);

    return false;
  }

  if(player playerads() > 0) {
    function_3bd5b3c577a032ec("<dev string:x14a>", 1);

    return false;
  }

  return true;
}

function private function_273ff14f391f0cdc(group, prompt) {
  level.player notify("\xa5\xcdp\xd5G}\xe0r\xedm\xc1:\xebn\xae\x1bl\xca7s");
}

function private function_62ba5419d642a788(enable, corpse, prompt) {
  player = self;

  if(enable) {
    assert(isDefined(corpse));

    if(!isDefined(prompt)) {
      prompt = &"hash_447e4cdcf7eeda6";
    }

    player input_prompts::function_e1ed844222decdfd("\x91\xca\xcc\v\xab\xd8:", "L\xbdF\x97_\xd8\xc2'ry", prompt, 0.25, 1, 0, 1, &function_273ff14f391f0cdc);
    player.body_carry.prompt_corpse = corpse;
    player val::set("\xc0\x93\xf0\x12Y\t*\xc8\t\xd47\xcc\x868\x98K\x1d", "\xc9\xca\x1boX\x8c", 0);
    player val::set("\xc0\x93\xf0\x12Y\t*\xc8\t\xd47\xcc\x868\x98K\x1d", "`\x16\xae\xa2\xe4t\x187\xe7", 0);
    player thread body_carry_playerpickupwaitinput(1);
  } else {
    player notify(".\xb7q+\x9f\xa9\xc0\x1b\x13(\x06\x88\xc2\xd3\xa3w\xa2g\xb3B\xe330\x97g\xb0\x9by\xaa\x89=\xbb");
    player input_prompts::function_8b6d36feadeac3d3("\x91\xca\xcc\v\xab\xd8:", "L\xbdF\x97_\xd8\xc2'ry");
    player val::reset_all("\xc0\x93\xf0\x12Y\t*\xc8\t\xd47\xcc\x868\x98K\x1d");
    player.body_carry.prompt_corpse = undefined;
  }

  return enable;
}

function private function_276e252636afa94f() {
  self notify("\xdf\x140.\xfb#\xf8#-\xf6W\xc50\xbd\x82\xc1");
  self endon("\xdf\x140.\xfb#\xf8#-\xf6W\xc50\xbd\x82\xc1");
  player = self;
  player.body_carry.var_44cd9847e5b700ce = [];
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player.body_carry.prompt_enabled = 0;

  while(true) {
    closest_corpse = undefined;
    closest_dist = 0;

    foreach(var_7b87964e226fe1e4 in player.body_carry.var_44cd9847e5b700ce) {
      if(isent(var_7b87964e226fe1e4)) {
        distsq = distancesquared(var_7b87964e226fe1e4.origin, player.origin);

        if(distsq <= closest_dist || !isDefined(closest_corpse)) {
          closest_corpse = var_7b87964e226fe1e4;
          closest_dist = distsq;
        }
      }
    }

    if(isDefined(closest_corpse)) {
      if(!player.body_carry.prompt_enabled || !isDefined(player.body_carry.prompt_corpse) || player.body_carry.prompt_corpse != closest_corpse) {
        if(player.body_carry.prompt_enabled) {
          player.body_carry.prompt_enabled = player function_62ba5419d642a788(0);
        }

        player.body_carry.prompt_enabled = player function_62ba5419d642a788(1, closest_corpse, closest_corpse.prompt);
      }
    } else if(player.body_carry.prompt_enabled) {
      player.body_carry.prompt_enabled = player function_62ba5419d642a788(0);
    }

    waitframe();
  }
}

function private function_624b9d8c8fab3b0f(corpse, remove) {
  player = self;

  if(!istrue(remove)) {
    foreach(var_7b87964e226fe1e4 in player.body_carry.var_44cd9847e5b700ce) {
      if(corpse == var_7b87964e226fe1e4) {
        assert(0);
        return;
      }
    }

    element = corpse;
    player.body_carry.var_44cd9847e5b700ce[corpse getentitynumber()] = element;
    return;
  }

  foreach(var_7b87964e226fe1e4 in player.body_carry.var_44cd9847e5b700ce) {
    if(corpse == var_7b87964e226fe1e4) {
      player.body_carry.var_44cd9847e5b700ce[key] = undefined;
      return;
    }
  }

  assert(0);
}

function private body_carry_corpsetriggerwait() {
  assert(isent(self));
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self endon("\x13o#^\xf5\x1ba\x9c\xe4\xf2\xfa6\xb7\x9c\a\x9be\xa8\xe4\xa5\xd9\xceY\x9c\xae\xb0\xd2\xe8");
  self.trigger endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  level.player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  while(true) {
    self.trigger waittill("\x91`\xb1\xe7T\x97>", player);
    function_f88abc3cfbed9d86(player);
  }
}

function private function_f88abc3cfbed9d86(player) {
  corpse = self;
  assert(isPlayer(player));
  trigger = corpse.trigger;
  var_f0cab9febb4acbe2 = 0;

  while(isent(trigger) && player istouching(trigger)) {
    if(!player function_5d42476355606f04()) {
      if(istrue(var_f0cab9febb4acbe2)) {
        player function_624b9d8c8fab3b0f(corpse, 1);
        var_f0cab9febb4acbe2 = 0;
      }
    } else {
      playereye = player getEye();
      dircorpse = vectorNormalize(corpse.origin - playereye);
      playerlookdir = anglesToForward(player getplayerangles());

      if(vectordot(playerlookdir, dircorpse) > 0.8) {
        if(!istrue(var_f0cab9febb4acbe2)) {
          player function_624b9d8c8fab3b0f(corpse);
          var_f0cab9febb4acbe2 = 1;
        }
      } else if(istrue(var_f0cab9febb4acbe2)) {
        player function_624b9d8c8fab3b0f(corpse, 1);
        var_f0cab9febb4acbe2 = 0;
      }
    }

    waitframe();
  }

  if(istrue(var_f0cab9febb4acbe2)) {
    player function_624b9d8c8fab3b0f(corpse, 1);
  }
}

function private body_carry_playerpickupwaitinput(enabled) {
  self notify("\xb7\xd5\x99\xb8H\xae\xfe\x80A\xc3M\x84gVa\x0f");
  self endon("\xb7\xd5\x99\xb8H\xae\xfe\x80A\xc3M\x84gVa\x0f");
  player = self;
  assert(isDefined(player.body_carry));
  player endon(".\xb7q+\x9f\xa9\xc0\x1b\x13(\x06\x88\xc2\xd3\xa3w\xa2g\xb3B\xe330\x97g\xb0\x9by\xaa\x89=\xbb");
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player waittill("\xa5\xcdp\xd5G}\xe0r\xedm\xc1:\xebn\xae\x1bl\xca7s");
  assert(isDefined(player.body_carry.prompt_corpse));
  player.body_carry.pickupcorpse = player.body_carry.prompt_corpse;

  if(!player function_5d42476355606f04()) {
    return;
  }

  player function_624b9d8c8fab3b0f(player.body_carry.prompt_corpse, 1);
  player.body_carry.pickupcorpse notify("\x13o#^\xf5\x1ba\x9c\xe4\xf2\xfa6\xb7\x9c\a\x9be\xa8\xe4\xa5\xd9\xceY\x9c\xae\xb0\xd2\xe8");
  player notify("D\x84\xc0tR\xe2\xbf\x13\x9a\x11x\xc7k\x9dF:", "\x86\xa03\x80\xb7\xd6\xf8>f\xff\xd1[");
  player notify(".\xb7q+\x9f\xa9\xc0\x1b\x13(\x06\x88\xc2\xd3\xa3w\xa2g\xb3B\xe330\x97g\xb0\x9by\xaa\x89=\xbb");
}

function private function_4dfa35000c7424f(corpse_origin, body_model) {
  player = self;
  assert(isDefined(player.body_carry));
  assert(isDefined(player.body_carry.body));
  scene_root = spawnStruct();
  body_origin = corpse_origin;
  start_origin = player.origin;
  scene_root.origin = vectorlerp(player.origin, body_origin, 0.5);
  scene_root.origin = (scene_root.origin[0], scene_root.origin[1], player.origin[2]);
  scene_root.angles = (0, player.angles[1], 0);
  scene_name = "\x91z\xe7\xe9\xd6\xbf5(p\xba_12b\x1a\xd5\x7fH\x0f.<\x9de6\x19\x0e\x9b";
  z_dist = corpse_origin[2] - player.origin[2];

  if(z_dist >= 20) {
    scene_name = "u\xd4\xb5\xf4u\x8c\xbc\x8b\xf2\xe8\a\xaa\x82\x15\x89\xa7\x1b:b\x19\x1e$\xf8\xc8\xb4\x83\xa9`Ag0\xbc";
  }

  namespace_6341d8b435bf1728::get_player_rig() utility_sp::anim_stopanimScripted();
  body_model utility_sp::anim_stopanimScripted();
  scene_root scene::play([player, body_model], undefined, scene_name);
  player player_sp::function_a9a4c8a5f556afa7(start_origin, undefined, [player, body_model]);

  if(getdvarint(@ "hash_c461dfd6a61235ac", 0)) {
    iprintln("<dev string:x162>" + scene_name + "<dev string:x174>" + z_dist);
  }

  player.body_carry.pickupcorpse delete();
  player.body_carry.pickupcorpse = undefined;
  body_model show();
}

function private body_carry_playerpickup(corpse) {
  player = self;
  player.body_carry.weaponswaps = player carrylinked::function_d0e01d9052fc0974("M\x86\x81\x14\x0e\x9e\xaf\xaf\x9e|QG3\x84\x17\xf3\xf5");
  corpse_origin = corpse utility_sp::get_corpse_origin();
  player.body_carry.body = player carrylinked::function_3ddcf99ca8b9668d(corpse);
  player.body_carry.body hide();
  player.body_carry.carrying = 1;
  player function_4dfa35000c7424f(corpse_origin, player.body_carry.body);
  player notify("D\x84\xc0tR\xe2\xbf\x13\x9a\x11x\xc7k\x9dF:", "\x9a\xa5\x12\xb0\xfc\"\xf4\xbe\x98\xfa\x17\x87\b");
}

function private function_fa37d79d223260c1(command, enabled) {
  player = self;

  if(istrue(enabled)) {
    player notifyonplayercommand(command, "\x1b\xe8=\xd7,d\x1b\xef\x9e<");
    player notifyonplayercommand(command, "\x9cK\xa0pRY\xa6C$");
    return;
  }

  player notifyonplayercommandremove(command, "\x1b\xe8=\xd7,d\x1b\xef\x9e<");
  player notifyonplayercommandremove(command, "\x9cK\xa0pRY\xa6C$");
}

function private function_7199d0277038a52a(body_model, var_9bbce72add11d31a) {
  player = self;
  assert(isDefined(var_9bbce72add11d31a));
  body_props = [];
  var_60d53eef41befb2c = player;
  body_props[body_props.size] = var_60d53eef41befb2c;
  var_ca6a9ae8af13f4ed = body_model;
  var_ca6a9ae8af13f4ed.animname = "\xc4j&\r\xd2V\xee\xa8W";
  body_props[body_props.size] = var_ca6a9ae8af13f4ed;
  var_9bbce72add11d31a scene::play(body_props, "\x19b\xc2y", var_9bbce72add11d31a.script_scenescriptbundle);
}

function private body_carry_playerwaitdrop() {
  player = self;
  assert(isDefined(player.body_carry));
  player endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  player endon("\xb6\xf3\x91\xbc\x06\xf8\xf6x\xed\x03\xfe\x031\xad\xfc\xc8\xa3\xabP7\x0e\xc1\xcb\rr");
  player thread body_carry_playermonitordrop();
  player.body_carry.droplocationvalid = undefined;

  while(true) {
    reason = player utility::waittill_any_return("\xa5\xcdp\xd5G}\xe0r\xedm\xc1:\xebn\xae\x1bl\xca7s", "\x02\xeb\x11\xc1\x14Z\xf9\xf5V\x87MP\x85\xf8\xe7\xae\xa4", "\x8bw\xc1\xd1\xeb\x1d\x0e\x04\xad!{\xcb\xf7");

    if(isDefined(level.player getplayeruseentity())) {
      continue;
    }

    if(!istrue(player.body_carry.droplocationvalid) && reason == "\xa5\xcdp\xd5G}\xe0r\xedm\xc1:\xebn\xae\x1bl\xca7s") {
      continue;
    }

    player notify("\x12;\x81\xd7q\x1dur\xf14<h5xX\xa7Z_wRk\xb8\xb9\x11\xdep\xe1D");
    player input_prompts::function_8b6d36feadeac3d3("\x91\xca\xcc\v\xab\xd8:", "L\xbdF\x97_\xd8\xc2'ry");
    player notify("D\x84\xc0tR\xe2\xbf\x13\x9a\x11x\xc7k\x9dF:", "\x8e\f\xe4I");

    if(getdvarint(@ "hash_86deb0b5d3f32a1d", 0)) {
      player function_725e607a6b602c1b(undefined, 1000);
    }

    break;
  }
}

function private function_e7cda7cbd3855bbd() {
  player = self;
  forward = anglesToForward(player.angles);
  rotatedoffset = rotatevector((2, 7, -9), player.angles);
  start = player getvieworigin() + rotatedoffset;
  end = start + forward * 15;
  end = (end[0], end[1], end[2] + 0);
  return trace::sphere_trace(start, end, 22, [player], level.player.body_carry.collisioncontents);
}

function private function_82b4924932518aed() {
  player = self;

  if(!function_b374527eccccf4a3()) {
    return true;
  }

  if(player isparachuting() || player isskydiving() || player isonladder() || player isswimming() || player isonascender()) {
    return true;
  }

  return false;
}

function private body_carry_playermonitordrop() {
  player = self;
  player notify("\x12;\x81\xd7q\x1dur\xf14<h5xX\xa7Z_wRk\xb8\xb9\x11\xdep\xe1D");
  player endon("\x12;\x81\xd7q\x1dur\xf14<h5xX\xa7Z_wRk\xb8\xb9\x11\xdep\xe1D");

  while(true) {
    waitframe();

    if(player function_82b4924932518aed()) {
      player input_prompts::function_8b6d36feadeac3d3("\x91\xca\xcc\v\xab\xd8:", "L\xbdF\x97_\xd8\xc2'ry");
      player notify("D\x84\xc0tR\xe2\xbf\x13\x9a\x11x\xc7k\x9dF:", "KW'9|?\xd3cB\nJ\xb1\xd6\x9d");
      player notify("\xb6\xf3\x91\xbc\x06\xf8\xf6x\xed\x03\xfe\x031\xad\xfc\xc8\xa3\xabP7\x0e\xc1\xcb\rr");
      player notify("\x12;\x81\xd7q\x1dur\xf14<h5xX\xa7Z_wRk\xb8\xb9\x11\xdep\xe1D");
      continue;
    }

    usableent = level.player getplayeruseentity();

    if(isDefined(usableent) || isDefined(level.player.body_carry.var_f5ab879027c1ec9b)) {
      player input_prompts::function_8b6d36feadeac3d3("\x91\xca\xcc\v\xab\xd8:", "L\xbdF\x97_\xd8\xc2'ry");
      continue;
    }

    player.body_carry.droplocationvalid = undefined;
    player.body_carry.droplocationvalid = 1;
    player input_prompts::function_e1ed844222decdfd("\x91\xca\xcc\v\xab\xd8:", "L\xbdF\x97_\xd8\xc2'ry", &"hash_24447d4fa54cf4da", 0, 1, 1, 1, &function_273ff14f391f0cdc);

    if(getdvarint(@ "hash_b19cf4f3c6d1ae4e", 0)) {
      player function_95860f8bf1b19fce();
    }
  }
}

function private function_89ad2b291002b3cf(var_9bbce72add11d31a, immediate_drop) {
  player = self;
  assert(isDefined(player.body_carry));
  player val::set_array("[\x99\x9b;\xe3\xb8D64t\xe9\x90u\xc7\x96", level.player.body_carry.transitionvals, 0);
  player val::set_array("[\x99\x9b;\xe3\xb8D64t\xe9\x90u\xc7\x96", level.carrylinkedvals, 0);
  exitgesture = "\xb3\x95\xdc\xf5\xd9\xd6_c\x16r\xc9/\xd7\x89o\x8c/\xeb\x1b\x96\xdc\xb6\xac#\xaf\x8c\xc9\xf68";
  var_795d26a6bbde0b04 = istrue(immediate_drop);
  earlyragdoll = undefined;
  dropanim = "\x8e\f\xe4I";
  lerptime = undefined;
  lerpmodel = undefined;
  var_f9839a910737506b = undefined;

  if(isDefined(var_9bbce72add11d31a)) {
    val::set("[\x99\x9b;\xe3\xb8D64t\xe9\x90u\xc7\x96", " \x8e\\\x7f\xf9\x9cH\x86\b\xc2Wkz[", 1);
    val::set("[\x99\x9b;\xe3\xb8D64t\xe9\x90u\xc7\x96", "\xd2s\x01\xd5\xe6\xf1\xa8\xb6t\xba&\xc4\x98\x9b\xa1:8\xe1\xb7\xdd\xa4\xc4Y;", 1);
    exitgesture = "\x86\xe3/R\xfb\xcc\xf6\xfc\x96*\xa1\xe1#Z?7\xba";
    dropanim = "\x8ep-^\t\x167\xf1e";
    lerptime = 0.5;
    var_f9839a910737506b = 1;
    lerpmodel = player function_82ad78e1a11621e2(var_9bbce72add11d31a, lerptime);
    player thread carrylinked::gesture_play(exitgesture);
    player thread carrylinked::gesture_wait(player, "\xacQi\x0e@\xa3?[\xa9k\xc6g\xfd(Q`\xec\xc6^\x95q");
  } else if(!var_795d26a6bbde0b04) {
    earlyragdoll = spawnStruct();
    earlyragdoll.entity = player.body_carry.body;
    earlyragdoll.collision_tags = ["\xc1\xaf\x82\xc1\t\xf9", "\xa7>4.\x83\x91\xac\x10", "\f\xf4\x8e\xbeZ\x98i0"];
    earlyragdoll.collision_radius = 5;
    earlyragdoll.groundclearance = 16;
    player thread carrylinked::gesture_play(exitgesture);
    player thread carrylinked::gesture_wait(namespace_6341d8b435bf1728::get_player_rig(), "\xacQi\x0e@\xa3?[\xa9k\xc6g\xfd(Q`\xec\xc6^\x95q");
  }

  event::event_broadcast_axis_by_tacsight("\xc2\x99.K\xdd\x9fBw>]\x8e", level.player, level.player.origin, 128, 0);
  player carrylinked::end(var_795d26a6bbde0b04, dropanim, earlyragdoll, lerptime, var_f9839a910737506b);
  player function_dd8ebd85f099bbc0(undefined);
  player.body_carry.carrying = undefined;

  if(isDefined(var_9bbce72add11d31a)) {
    if(isDefined(lerpmodel)) {
      lerpmodel delete();
    }

    player function_7199d0277038a52a(player.body_carry.body, var_9bbce72add11d31a);
  }

  player val::reset_all("[\x99\x9b;\xe3\xb8D64t\xe9\x90u\xc7\x96");
  player thread carrylinked::wait_to_revert_demeanor(exitgesture);
  function_4996366ef34df309();
  player utility::ent_flag_clear("e\xf7\xa4\xf2\xa4X\xef\xee8_j\x96\xa8h\x8e\x9a\xa7");

  if(istrue(player.var_3fc971ea4fc59e87)) {
    player notify(exitgesture + "\xe7\x9bO\xf3%");
    player.var_3fc971ea4fc59e87 = undefined;
  }

  player notify("\xc4oF\x97}6X\xe4r/\xafF\xe4o8_\x1b\xb7\xad8cVG\xb2");

  if(!isDefined(var_9bbce72add11d31a)) {
    player.body_carry.body startragdoll();
    player.body_carry.body thread body_carry_waitcorpse();
    player.body_carry.body function_e337281d967be705();
    return;
  }

  player notify("&\xbd2\x97\xf5\xd8,\xc9\xe4\xcb\xbe\x86\xd2F#\xacn");

  if(isDefined(player.body_carry.body)) {
    player.body_carry.body delete();
    player.body_carry.body = undefined;
  }
}

function private function_82ad78e1a11621e2(var_9bbce72add11d31a, time) {
  player = self;
  assert(isstring(var_9bbce72add11d31a.script_scenescriptbundle));
  xanims = var_9bbce72add11d31a scene::function_979b54d9d4c16e5f(0, 0, var_9bbce72add11d31a.script_scenescriptbundle);
  assert(isDefined(xanims) && xanims.size > 0);
  var_2866e1cb7148d2e6 = getstartorigin(var_9bbce72add11d31a.origin, var_9bbce72add11d31a.angles, xanims[0]);
  lerpmodel = utility::spawn_model("\xec\xbfK|\au\xcd\xc2\x19<", var_2866e1cb7148d2e6, getstartangles(var_9bbce72add11d31a.origin, var_9bbce72add11d31a.angles, xanims[0]));
  acceldeceltime = time * 0.5;
  player playerlinktoblend(lerpmodel, "\xec\xbfK|\au\xcd\xc2\x19<", time, acceldeceltime, acceldeceltime);
  lerpmodel hide(1);
  return lerpmodel;
}

function private function_3bd5b3c577a032ec(msg, failure) {
  if(!getdvarint(@ "hash_c461dfd6a61235ac", 0)) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  entry = spawnStruct();
  entry.failure = failure;
  entry.msg = "<dev string:x181>" + msg;
  thread function_64fcb567c6e187ad(entry);
}

function private function_64fcb567c6e187ad(entry) {
  self notify("<dev string:x190>");
  self endon("<dev string:x190>");
  self endon("<dev string:x1ac>");

  if(isDefined(entry)) {
    waittillframeend();
    color = (1, 1, 1);

    if(isDefined(entry.failure)) {
      color = (1, 0, 0);
    }

    textelem = newhudelem();
    textelem.x = 0;
    textelem.y = 80;
    textelem.alignx = "<dev string:x1b5>";
    textelem.aligny = "<dev string:x1bd>";
    textelem.font = "<dev string:x1c4>";
    textelem.fontscale = 0.75;
    textelem.alpha = 1;
    textelem settext(entry.msg);
    textelem.color = color;
    waitframe();
    textelem destroy();
  }
}

function private function_95860f8bf1b19fce() {
  player = self;
  scriptbundlename = "<dev string:x1d0>";
  assert(isstring(scriptbundlename));
  var_6a65c1941177b623 = "<dev string:x1e7>";
  scene_root = spawnStruct();
  scene_root.origin = player.origin;
  scene_root.angles = player.angles;
  body_model = player.body_carry.body;
  xanims = scene_root scene::function_979b54d9d4c16e5f("<dev string:x1fe>", 0, scriptbundlename);

  if(!isDefined(xanims) || xanims.size <= 0) {
    return;
  }

  earlyragdollnotetracks = getnotetracktimes(xanims[0], "<dev string:x1e7>");

  if(!isDefined(earlyragdollnotetracks)) {
    return 0;
  }

  var_9ce2b6b45f4f2af2 = 1;
  startragdollnotetracks = getnotetracktimes(xanims[0], "<dev string:x20b>");

  if(startragdollnotetracks.size > 0) {
    var_9ce2b6b45f4f2af2 = startragdollnotetracks[0];
  }

  tags = ["<dev string:x21c>", "<dev string:x226>", "<dev string:x232>"];
  collision_radius = 5;
  ignoreentities = [player];
  originviewmodel = player getvieworigin();

  foreach(bonetag in tags) {
    var_219b57da3ecc8078 = body_model gettagorigin(bonetag);
    result_frame1 = body_model animation::function_3cf2092e487b2640(xanims[0], bonetag, 0, body_model.origin, scene_root.angles);
    result_start = body_model animation::function_3cf2092e487b2640(xanims[0], bonetag, earlyragdollnotetracks[0], body_model.origin, scene_root.angles);
    result_end = body_model animation::function_3cf2092e487b2640(xanims[0], bonetag, var_9ce2b6b45f4f2af2, body_model.origin, scene_root.angles);
    sphere(var_219b57da3ecc8078, 5, (1, 1, 1));
    sphere(result_frame1["<dev string:x23e>"], 5, (1, 0, 0));

    if(!(isDefined(result_start) && isDefined(result_end))) {
      continue;
    }

    trace = trace::sphere_trace(result_start["<dev string:x23e>"], result_end["<dev string:x23e>"], collision_radius, ignoreentities, undefined, 0);

    if(trace["<dev string:x248>"] < 1) {
      trace::draw_trace(trace, (1, 0, 0), 1, 1);
      break;
    }

    trace::draw_trace(trace, (1, 1, 0), 1, 1);
  }
}

function private function_725e607a6b602c1b(trace, draw_time) {
  player = self;

  if(!isDefined(trace)) {
    trace = player function_e7cda7cbd3855bbd();
  }

  var_822f725fb10a2ea2 = trace["<dev string:x248>"] < 1;
  sphere_color = (1, 1, 1);

  if(istrue(var_822f725fb10a2ea2)) {
    sphere_color = (1, 0, 0);
  }

  trace::draw_trace(trace, sphere_color, 1, draw_time);
}

# /